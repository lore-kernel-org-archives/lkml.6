Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76324223
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbNtKB14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B76324223
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934552AbeGCSbr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:31:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46227 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeGCSbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:31:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id s11-v6so2922178wra.13;
        Tue, 03 Jul 2018 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZSqYGyngzuHzfznIWOmDAxK4i2T3KP8/Osn+lRHHeA=;
        b=QbNtKB14cEtSSihr+U1Y4kshLp4prIJPkvOeaEXIBhdpJCMavQ+/29qyy7FPU6ZKjU
         q9OV4fX4RyqiUY5uPUhzj/3qLy/pyBEoyQt2VXNB2BPX2mKUNhhnI5cVkjn3iZiaSrgW
         4UvkrABdhqP7RzSbUStt6of9TE9+v5VhH99fV8wVERBz0ckGqJb3R/Xpqf/jYM8D8+4e
         vtgkWKMHoOy4elI+xeab2dBftJs3c1hRwC2Ei+lsQHtuMyyeOC+NXxAfcRPhWXdfEbY0
         u7EQ6o57SYREe64OhV665TNbnEDJYmTjK+XhbQYewIO8U+wCZtn3s+UmMHBfivuF2yBF
         +ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZSqYGyngzuHzfznIWOmDAxK4i2T3KP8/Osn+lRHHeA=;
        b=f3OdrsVEfJ51t4zEe6CoYx9Wy1XKPq79L7YbK+BKG6Pv78dSuo4a4MFw4XWCl2V/8W
         zl9Hrh0+fG9g4povQ/tWWEsb51LsJMkkqwpZ4chDRQriHfGuGcYeH+YkqSsY6oPGXucZ
         afiupXR69VSVQJ+xkAmQuxCsQUeugYkyv2EbnTHdJIa67u0xBG+Sgm/PV9JGBkZZfARg
         fA/Vnqh+oagd6zhv1el67CxykOpsk67jGKQWdMJJQ+9q3eoELNSErjL2aYGRtVpgAaMy
         dXN9l7sDqJ7j0mqCFLPE7rrGAun+0La+4NpfoQJPenXxz0U1eoXK7XV9x0SARBGPijpr
         xE6Q==
X-Gm-Message-State: APt69E3rai/Vja+2A2v20QitAAAScD+s6YQe/6TJO48Gyd5SiIF2fNh9
        MJUdDJTxJWy8k/lrmvemCUu4grVCGzoB8PwZFgk+qA==
X-Google-Smtp-Source: AAOMgpeD54j01xSF/3ugjJ11au5r7EuwlJ2qfHE9+E/FaQEsMNDjYTqtkrSZHAjgL5UiKdwfuqnVo+j4EQi10ElW6u4=
X-Received: by 2002:adf:9527:: with SMTP id 36-v6mr3228103wrs.99.1530642703980;
 Tue, 03 Jul 2018 11:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
In-Reply-To: <20180703084516.GT112168@atomide.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Tue, 3 Jul 2018 20:31:32 +0200
Message-ID: <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, Jul 3, 2018 at 10:45 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Belisko Marek <marek.belisko@gmail.com> [180620 09:40]:
> > Hello,
> >
> > I'm trying to fix warning (for omap5 board) produced by recent change
> > to avoid using IRQ_TYPE_NONE like:
> > [    1.818666] WARNING: CPU: 1 PID: 778 at
> > drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
> > [    1.828839] Modules linked in:
> >
> > I did look to other commit which did update and without deep knowledge
> > I just simply do this small change:
> > diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
> > b/arch/arm/boot/dts/omap5-board-common.dtsi
> > index 218892b..ab2df8c 100644
> > --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> > +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> > @@ -393,7 +393,7 @@
> >
> >         palmas: palmas@48 {
> >                 compatible = "ti,palmas";
> > -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
> > +               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
> >                 reg = <0x48>;
> >                 interrupt-controller;
> >                 #interrupt-cells = <2>;
> >
> > and it looks board boots fine. Only issue is that gpadc driver is not
> > working (at least not getting interrupts at all ADC fails with
> > timeout). I did look to gpadc driver and driver is not using
> > interrupts defined in dts but request interrupt directly from palmas
> > mfd module. Any ideas what needs to be changed to have gpadc again
> > working with mentioned patch?
>
> Can you try with IRQF_TRIGGER_HIGH added also to the flags to
> regmap_add_irq_chip() in drivers/mfd/palmas.c?
Nope issue is till present also after this change like:
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
b/arch/arm/boot/dts/omap5-board-common.dtsi
index 218892b..6912769 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -393,7 +393,7 @@

        palmas: palmas@48 {
                compatible = "ti,palmas";
-               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
+               interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N */
                reg = <0x48>;
                interrupt-controller;
                #interrupt-cells = <2>;
@@ -432,9 +432,9 @@

                gpadc: gpadc {
                        compatible = "ti,palmas-gpadc";
-                       interrupts = <18 0
-                                     16 0
-                                     17 0>;
+                       interrupts = <18 IRQ_TYPE_LEVEL_HIGH
+                                     16 IRQ_TYPE_LEVEL_HIGH
+                                     17 IRQ_TYPE_LEVEL_HIGH>;
                        #io-channel-cells = <1>;
                        ti,channel0-current-microamp = <5>;
                        ti,channel3-current-microamp = <10>;
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 663a239..15d23db 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -601,7 +601,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
        regmap_write(palmas->regmap[slave], addr, reg);

        ret = regmap_add_irq_chip(palmas->regmap[slave], palmas->irq,
-                                 IRQF_ONESHOT | pdata->irq_flags, 0,
+                                 IRQF_ONESHOT | IRQF_TRIGGER_HIGH |
pdata->irq_flags, 0,
                                  driver_data->irq_chip, &palmas->irq_data);
        if (ret < 0)
                goto err_i2c;

>
> Regards,
>
> Tony

BR,

marek
