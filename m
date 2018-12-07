Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08615C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13D720892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ff0DHpCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13D720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLGM5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:57:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44356 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLGM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:57:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2934217lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAC8T3W94WaSrAWhKPxZJSzrxAvBCk+r+Dgr46Tunx4=;
        b=Ff0DHpCDqJ9Oj+vThCJo5HPd+PY7UU/5VlJzMbjpcY7fSWPCBbYQXiTSB9qjUU4yW5
         IEvZEc5mGCNB5NU1dQtioJvmqsYjRyKBKzBFEFlOWL1VvAn9apg8gMeC+/HNaMY214Jh
         pDJiyyF9vkaIuHQGwngQoOIGYBMn0mYTCMRfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAC8T3W94WaSrAWhKPxZJSzrxAvBCk+r+Dgr46Tunx4=;
        b=BlGSArS6Q5ZD0cfRVnBFu9yDq2+NrdGbikD4OIZ6XdBUm6cbyRMMtnsE9NQHeZVTJW
         E/OcWTXsyKOwvzAbGrYiu4zXkOscHCmaF6eS5nQQw20nryNmSmLdBB3YbMP+8Xv+x3Bc
         LnEP/DJXnSat/nVltJHl6QHnPUkq74L7mUSuKLjlMcyT39o42RIqlKWvgiTo8yBUgLpS
         xF+EkMqbjXb8K3Bt4EkyEmyny5EDM447qvBDpe9X8C3poovwtARVf0hYRjaM/S99md5X
         6WOt+xvViafEizSNhs7FZrtJl/S644/IMZIM2C8XI1pa1VkotQ4Sa5uYxJzr6P71XkvH
         9mng==
X-Gm-Message-State: AA+aEWagc+Eub1oFY3ktIGMTGvMYwT5k9fW7wEFz97udGLFS7MVcm8A/
        7xviz1cgKUVj/dOJqHQawJk8uscRu60I5Drx8lFVfQ==
X-Google-Smtp-Source: AFSGD/Wt8dB9zmF9EOj502p0PQc8un5uSTsntJNOpEM0ItdNO5EBsRYV4piSZvc3rUEFUxtbC2ctCENAsrCMwGEWEKA=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1357816lfb.96.1544187457069;
 Fri, 07 Dec 2018 04:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20181129133119.29387-1-linus.walleij@linaro.org>
 <CACRpkdbKrpWQJkL=FFis39PiHxvx5zOL0gYHuYa80yYMdP8bqw@mail.gmail.com> <alpine.DEB.2.21.1812071143480.14498@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1812071143480.14498@nanos.tec.linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:57:25 +0100
Message-ID: <CACRpkdaRs5=Yt6fuSypeJpqdrUApFxxeBqm5sxsw+BdG=jbfBA@mail.gmail.com>
Subject: Re: [PATCH] irq: Request and release resources for chained IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 12:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> > > This irqchip is in drivers/pinctrl/qcom/pinctrl-msm.c and known
> > > as TLMM.
>
> TLMM == Totally Lost Manufacturer Mess?

It's pretty OK for the most part actually.

> You cannot invoke those callbacks from __irq_do_set_handler() as that is
> holding the irq descriptor lock with interrupts disabled.

How typical. Hm I wonder how to fix this properly then.

> Needs more thought. Btw, the uninstall path does not invoke irq_deactive()
> either.... I so hate that chained handler mess....

I think it is just extremely uncommon to remove a chained handler
(I don't know if anything exercises that path even) that is why we
don't see any fallout from it. It's probably just untested code.

Do you see that chained handlers have any merit at all or should
they all be moved to nested? The question needs asking, but IIUC
there are performance benefits with chaining as opposed to
nesting. :/

Yours,
Linus Walleij
