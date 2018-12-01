Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4037C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FF12081C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUEwAEy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FF12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLAR6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:58:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34326 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLAR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:58:33 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so3733853itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 22:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkc/po1y39Ssly1+0cuhmMlGw4yudNki7NzlFBC7AZA=;
        b=OUEwAEy2pD1NNwJByDlAvrqjV5O/yrkdmANS0jauIidrLzWynjEVbi0m/ksR84pixc
         8DgmSbZF9MtHh3LLELojlgUiDXutxEfH6O/jtAmyUEpvT+O1Ies8sQbNiiQCVrNx8zuD
         2pnlAjZza7x6CpL3wceZSMhRhIOPNsk2YUbuE9nxl3w3UUrbyWtz0mHcwnsHyztMijpI
         DcZPh4GdogGp5fY0bJvCyoc6f2yr1DRB71bYXX+eDQ02bQNoYgQBKuX9ZiqmkbjG/S/k
         ou0NMMN6WSPuQ0l7qPnol2xCpC3KLD8MaB4mFgFWnzWbuMflGre11Zz+qYJB60XwqqXN
         HuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkc/po1y39Ssly1+0cuhmMlGw4yudNki7NzlFBC7AZA=;
        b=VgGqhx/jvalfkp8iR+uagTRFB7NLOWHPM2BooKaCgPUibBtoz184T4USr/4LrAhVeN
         PA0uwph4i985qEKF6QDttc/n2Za3jy3mLU9Jh49M/8Y3EaqcBopeicgAuiQupSzAnWiV
         ZDON6VmTKPnhVjLzzMmJNH76ZcuUca/u3kQ1Lci8ChS8j3rC9+YwKI0i7ZtKe/udO2O2
         kriUkKdJvIrSQ59oTFArstTsIekBp6PaCD1HzhqB6zaWlv9bt464nXll0YILVfSmrLm0
         ePaC+Xb8ORffu6Hob79IigHa+rzy2DtunapU8mkdfw2vQHJMrRGu7k2GSRwhT4FHsLzO
         wEJg==
X-Gm-Message-State: AA+aEWZFyFwg8D4qrNh3r9oQguXpIR3yNunZYs6bguP0rwuGlJ8wFtpa
        ZbspxZ2YPdeP8VKwto0Rqbeyfwz89mK8DuHs+Df6DQrU5KY=
X-Google-Smtp-Source: AFSGD/VxogKz/mI0U2eKwdoEGSHWbnd7qg2rNjzwdo0dtsjTqBcAODzFR3aiVwXMYgZcmixaOVKXbphI1ffDsWBcOj0=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr1403602itc.37.1543646803304;
 Fri, 30 Nov 2018 22:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20181126143710.31409-1-tiny.windzz@gmail.com> <20181130183707.GH2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181130183707.GH2509588@devbig004.ftw2.facebook.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 1 Dec 2018 14:47:12 +0800
Message-ID: <CAEExFWtYPNsWdS+YuDB6XtuXdLxDRWUV=J_rPBAfsmWURfqgKQ@mail.gmail.com>
Subject: Re: [PATCH] async: remove some duplicated includes
To:     tj@kernel.org
Cc:     akpm@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 2:37 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Nov 26, 2018 at 09:37:10AM -0500, Yangtao Li wrote:
> > we include workqueue.h twice.It's unnecessary,so
> > just remove them.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Ditto.  Please route through the trivial tree.
It seems that the trivial tree has not been maintained for some time.
Are there aother tree to choose?

--Yangtao
>
> Thanks.
>
> --
> tejun
