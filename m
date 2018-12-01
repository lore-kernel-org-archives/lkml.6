Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294DC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FEF2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm2lhcR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FEF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLAR6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:58:05 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41647 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLAR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:58:05 -0500
Received: by mail-io1-f65.google.com with SMTP id s22so6378377ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noTZA4X+BEJByoCR5446aCQfY+yzsXJBgY5BerEY/Ls=;
        b=Cm2lhcR3mtokjnw+kM3GihJiDcRlKsfdZCfPYk7uJrGBgzOnnsAyIhnZtK6FeFoOJ8
         hJDbQPQYqlJ9QNv+wzvcUENLScU/b8q3DXDCpnQV7B7GC6QLd35J9Kf6MH1ei2+TrVAt
         P6eykmMxG2G3CY+pfPXhKJcZlxeDfRQ+r98VfDDnJMjN45KRnubR1x3oIBBd6WjO2fRQ
         mhpT0Bf0q8Uf2n/OcGYPoe3wgAzuughEeAHsCSSF197LGLVOarwmugIcy9VFHccjkDsn
         gA02mmoP5NbQ7zYBQRw+lvaTa0XbQaGsLzHcikmDGerUzuN1Hoh5sENrhHiQylWtAVRo
         Guhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noTZA4X+BEJByoCR5446aCQfY+yzsXJBgY5BerEY/Ls=;
        b=kxqblt0lkSTkW0xr0hBVZDi6KmhmWtZbvJOajX5mCWL3DZdy5DmrBblhEp6b9ZjGjP
         tM5jAQcmnAcv5QFJPjJRzrU8tu3brNabCvE9poWLnmR94xcgzWFA6elTMaQC/q694/ta
         HM/8/M25eQGQMa1ZChZzKshFZ2y6OtoqQx5lWYkHZo+aeTV6Trh0TVW8/cXEJyXHOqqB
         xrdizFv32qAXfD8mBHmhXIhE14UZYimyBLporINlOGorvv6rLM/W+otraxSvfqNGT0LY
         SxXbUHKVxD6xElIzNNqVurMmrpqADciAEzjt2eyRhgPrBzuIdtjZCxx0D21n/Xeh6a4G
         I2Sw==
X-Gm-Message-State: AA+aEWY37iTZCHrwpBF+KBd/k2N52UKHzkltXQU9ap/TZkyrwWtp7FDX
        rQRB0q/OXkmHfJl2xDas1pYDYJqZtVCgsbHR7U4=
X-Google-Smtp-Source: AFSGD/XVelpM/Q1kq0nXSrBpe5V5SOEpj8tmglVS+Ko+csthAKObZciF2kHglc35ejsWboKrs1Y/CSkWqx/sdzgNXIw=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr6985413iom.7.1543646775038;
 Fri, 30 Nov 2018 22:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20181126143326.31300-1-tiny.windzz@gmail.com> <20181130183627.GG2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181130183627.GG2509588@devbig004.ftw2.facebook.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 1 Dec 2018 14:46:44 +0800
Message-ID: <CAEExFWv57CU=FHWxAKby4HmzZ9+8GAt2SniaUinvDdLgc3TKOQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: remove some duplicated includes
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the trivial tree has not been maintained for some time.
Are there aother tree to choose?

MBR,
Yangtao
On Sat, Dec 1, 2018 at 2:36 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Nov 26, 2018 at 09:33:26AM -0500, Yangtao Li wrote:
> > workqueue.h and kthread.h are included twice.It's unnecessary.
> > hence just remove them.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Can you route this through the trivial tree?
>
> Thanks.
>
> --
> tejun
