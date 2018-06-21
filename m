Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A04C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4473208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOrZLCJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4473208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeFUPOQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:14:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44070 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933256AbeFUPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:14:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so1854326plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=rzZk8awudFzUIWe4LiopDGmeSZknqxbGAU+n77Y7Eso=;
        b=FOrZLCJ6tlLdXue8R6uCu87XZaF7IQzKsSXba89Tvhr/7DfDHMDcWPVzlDnnpJTt6k
         x67tUDFGhrC+Ktpf5YR7QyaaQGeOb52CYS5uCbvg62TwSCkESjD8UXEgbtPFuX1IYEV/
         NyFLNxTzRB8uJVfrzfkzzTStn3GkeuQQWy5hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=rzZk8awudFzUIWe4LiopDGmeSZknqxbGAU+n77Y7Eso=;
        b=eR3h9yAZn/xEWZUH4xTgVcgbOwPbx4h3Fxfr5/YDXBo7JhtrcFH01jlAmIxcD63em6
         xUbGFbdoiSC+ZrH2GG2SZMg9dqatPB34fCrY8DSR73taJwxliQdjt5eMPQUyeKtfvpFs
         rSOaSrgsdeNOzTk6r0yu0/MEPkVzrH6h4LfmVrfSdxQO5CLrOrUyQRQwWL0tmQEPrJGr
         mPOqTnvh+MfE0rkDYNsQ9yDx8reqrRb22Wk+L0HWIqm9jiXLMlF5pAvqiPPJRXMot2lm
         /GJ/Zv6/exFHatQuCfeWD6h5EiriiJe9pM+CbVdF2ZLs5Y+1gib5j08E/Vm1glwzWlm3
         LZiA==
X-Gm-Message-State: APt69E1LGZNVg3J/FBkWb5VXOurKinc+ONwzBCO8xbu9pbqXOloRqTGg
        PGDAP+HtcCh9QXMlow3DK31D6dLJyIE=
X-Google-Smtp-Source: ADUXVKLroh5iN4VC+TgG/en9cz4Ssayi9hfGyDw5kLEToGQEfa/YZrGK3pJ3t7b9KoU1nMaM20Uwpg==
X-Received: by 2002:a17:902:7604:: with SMTP id k4-v6mr28395760pll.13.1529594053781;
        Thu, 21 Jun 2018 08:14:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a11-v6sm7059136pgq.32.2018.06.21.08.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:14:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180620064509.GL15126@tuxbook-pro>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-2-swboyd@chromium.org>
 <20180620064509.GL15126@tuxbook-pro>
Message-ID: <152959405220.16708.279861218299564639@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent
 latching
Date:   Thu, 21 Jun 2018 08:14:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-06-19 23:45:09)
> On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> > @@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
> >       raw_spin_lock_irqsave(&pctrl->lock, flags);
> >  =

> >       val =3D readl(pctrl->regs + g->intr_cfg_reg);
> > +     if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> > +             val |=3D BIT(g->intr_raw_status_bit);
> > +             writel(val, pctrl->regs + g->intr_cfg_reg);
> > +     }
> >       val |=3D BIT(g->intr_enable_bit);
> >       writel(val, pctrl->regs + g->intr_cfg_reg);
> =

> I looked at the TLMM documentation, which states that the status bit
> should be cleared after handling the interrupt and this driver used to
> do this.

Nice!

> =

> But Timur managed to hit the race where we lost edge triggered
> interrupts with this behavior, so we changed it in the following commit:
> =

> a6566710adaa ("pinctrl: qcom: Don't clear status bit on irq_unmask")
> =

> =

> But the reason that I had this in the driver originally is that msm-3.10
> does this (clear status bit in unmask), so perhaps the appropriate way
> to solve is to follow the documentation and the downstream driver and
> ack the interrupt in unmask - but do so only for level triggered
> interrupts?
> =


Clearing the status bit (basically acking the gpio irq) can be done in
unmask for level triggered interrupts. That works and as you say it's
even documented.

I didn't implement that because it felt better to prevent the status
from latching in the hardware while the interrupt is masked. My
understanding of irq mask semantics is that the interrupt shouldn't be
"pending" during the time between mask and unmask and clearing the raw
status allows us to do that properly without messing with the status bit
on the unmask path. It also means that the ack operation really does ack
the irq status bit and cause it to go away. I suppose there is one case
where I'm wrong though, and that is when the irq is unmasked on irq
startup where we don't want to see a spurious latched level interrupt
that occurred before we booted.

That problem may be possible with bad bootloaders that are leaving some
status bit latched in there, but also we would want to fix that for edge
type interrupts too, so we would need to clear the status bit regardless
of the level on irq startup and hope an edge isn't lost on startup.

