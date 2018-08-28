Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60138C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061EB20671
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leHmohEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061EB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeH1Qjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:39:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41363 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeH1Qjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:39:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so1462446wrb.8;
        Tue, 28 Aug 2018 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxuZhYAaqUx6YU3YVGYy8ZMUdTBOC1bDjoQSAjbQKUQ=;
        b=leHmohEm0h3Az5c8RZDxtpR1xa9vUJ6ydshpF8uKm6bnWxZ6KCjVsugR8fOi8c2TK2
         OEox/UZgYurGKUFUqFwZxmhfVwN9N9BEYGyZwvQx1aF3FP2s1YQku1ZR7C8nbZcsj/uX
         z62REHzHDKumtTShzln1gDFGego8+dIJDaZdCpVaKQVx+k0sab1GQ3CibvCDRupdvBAN
         xYlB0N28m63yrgc9scoedhKxId5ppDQ87byH7CtDdlnOqFJzk8p/L1+21CpTs634i4H5
         gEyupLiLtBWYpAWmlZf54OaJN3+iUCFm8wQvdaTMSG+62PyfU+TEdAEfmS+fvcAer1iL
         y59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxuZhYAaqUx6YU3YVGYy8ZMUdTBOC1bDjoQSAjbQKUQ=;
        b=anRcQE1L+WFT75uqubAytpSslx8pMGCtgtqR28Gj0FH9XyKZQZLOiobwwwheVF3eoX
         bOcGsf5mp6wX/dsh9xBARm7DoUpHDY2gH1fBlNSDmzEbtTTZV5pbnszJZvb7rYR8BY1s
         JBIomGkqaszh+t7341wBqQkxRzJfNeXgEOK89hQ0BqeoS1AlAD/XEhHp92k4aGTNVgIb
         v+/bmHJ9MFO0Wk9jJfqSr0efLq/rvihZxt6LP1mbFRk6KuDq5VeqxfYxSNLRHpikGh7X
         yFn1Ol3VAsytSlr+grV8lLDfqA9haxJMpCK6XF94r25X0j+Ns2+xKEzFzY8axHP+z8k6
         d5dQ==
X-Gm-Message-State: APzg51C6AAH4bBtd8eei0m053QFN5gmAQfapeobyLN5ydRaWcoq4t/ZA
        KOTy0Fp7IkwTEwIIXSCZGVRnQZtHv6FQtb97HWM=
X-Google-Smtp-Source: ANB0Vdbj4HkekkSVyvn/N1VyPh5lfqXrS7TfjHHvxrm/t24rKai6KKQyQY91DCEHkjmypmzlrczxqUxi8pv3FobeTLA=
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr1127937wrh.65.1535460480096;
 Tue, 28 Aug 2018 05:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com> <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
In-Reply-To: <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:17:48 +0530
Message-ID: <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Aleksey Makarov <amakarov@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Aleksey Makarov <amakarov@marvell.com>
> >
> > This patch adds mailbox support infrastructure APIs.
> > Each RVU device has a dedicated 64KB mailbox region
> > shared with it's peer for communication. RVU AF has
> > a separate mailbox region shared with each of RVU PFs
> > and a RVU PF has a separate region shared with each of
> > it's VF.
> >
> > These set of APIs are used by this driver (RVU AF) and
> > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> >
> > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
>
> Why does this driver not use the drivers/mailbox/ infrastructure?
>
>        Arnd

This is a common administrative software driver which will be handling requests
from kernel drivers and as well as drivers in userspace applications.
We had to keep
mailbox communication infrastructure same across all usages.

Thanks,
Sunil.
