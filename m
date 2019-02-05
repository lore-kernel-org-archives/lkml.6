Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876DDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E447217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKG9l6QP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfBESUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:20:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbfBESUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:20:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so1828711pfd.12;
        Tue, 05 Feb 2019 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0GXltpti/eaY6hq3EFn9GGfxvJ0N845kizel6A8I3I=;
        b=CKG9l6QP6zu4OJaVNO0YyJIdQzEJ+2wQwMf5OTstt00qyJzrMUN8IiB0hayZFB7+H3
         FY/PjylgHdc7adqFt8OGciQaFoXNo6U2awBXJehfLBSkgQrDdXVRVpSlCSYAb37sD3zn
         IUmLGBm+cITW5FxrW5/+F9cjcz5CEDDWl7os8ER8kAKcRhFfbHTTCsQlft7XjaCFwue0
         RSr7rYgGepimxDE0GpGv1taCJa75Up2J+i3Y52vY+hA/cJtxnmIdvaVOSyXZevySsD36
         F+9JazPBvgpIf1s0P2sUdBNd298ZGUIoILuom9mpqi01UiWS6bn9kLP3ZKnXq6DfEdZC
         WqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0GXltpti/eaY6hq3EFn9GGfxvJ0N845kizel6A8I3I=;
        b=f1pNGQmhVNKF5nBDS7YeMnqexa9QhR5tWQqIYEvKXGXq/qxLtUbQpw18kTJkm0uENq
         Sc1LB65C+tcRaXExXPwMDbvxrgQ9+n6Jsgn7TAoI7aZ/RFJlyeZleMWDd66MLkJqh8TU
         uMAyORyBJEO6ugEctzeoq9NMyZlKwmCOMAN0AIp+t4eLrCOnCCPNvItR0pYJhr+3wxnN
         PL7i0M+d2TbTelakflSMpWauMdYtOdWfs6ZcNf2BWCbsTDehdA6gnPPh9jC37UiG2iRM
         oZ2+8Zqm3U2NQawDJV8X0i4Oz4MZ2F5jIjOUyLKGntvMvCy8Z75qjw6A20xGedglZHos
         hdgA==
X-Gm-Message-State: AHQUAualSdeWS4XYr9zBPXLrXwpm44SnrjuSSbO5o4UOcSGqpTC0wjJk
        E3DrAzfXaxzngWixCoDGs9bJH/rPNJv/tzLBnkg=
X-Google-Smtp-Source: AHgI3IZbqTcN0/+ppTc+l6XJ6WX3KwB6myJ4yfliamsDAVJ+Dlkd9WDTqdvIk2Vt8r8EnrDT60yTnE7FJM+afdh7fNI=
X-Received: by 2002:a65:6116:: with SMTP id z22mr5636991pgu.265.1549390804556;
 Tue, 05 Feb 2019 10:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20190203094233.12177-1-hdegoede@redhat.com>
In-Reply-To: <20190203094233.12177-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 20:19:53 +0200
Message-ID: <CAHp75Veb-QarB-9mQtNWcrL5qr0-ZeXwgscBeS-O-=cgpOjE_w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Only implement
 irq_set_wake on Bay Trail
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 11:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit c3b8e884defa ("platform/x86: intel_int0002_vgpio: Implement
> irq_set_wake"), was written to fix some wakeup issues on Bay Trail (BYT)
> devices.
>
> We've received a bug report that this causes a suspend regression on some
> Cherry Trail (CHT) based devices.
>
> To fix the issues this causes on CHT devices, this commit modifies the
> irq_set_wake support so that we only implement irq_set_wake on BYT devices,
>

Pushed to my review and testing queue, thanks!

> Fixes: c3b8e884defa ("platform/x86: intel_int0002_vgpio: ... irq_set_wake")
> Reported-and-tested-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel_int0002_vgpio.c | 32 ++++++++++++++++++----
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index 4b8f7305fc8a..78787934b572 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -51,11 +51,14 @@
>  #define GPE0A_STS_PORT                 0x420
>  #define GPE0A_EN_PORT                  0x428
>
> -#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> +#define BAYTRAIL                       0x01
> +#define CHERRYTRAIL                    0x02
> +
> +#define ICPU(model, data) { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, data}
>
>  static const struct x86_cpu_id int0002_cpu_ids[] = {
> -       ICPU(INTEL_FAM6_ATOM_SILVERMONT),       /* Valleyview, Bay Trail  */
> -       ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
> +       ICPU(INTEL_FAM6_ATOM_SILVERMONT, BAYTRAIL), /* Valleyview, Bay Trail  */
> +       ICPU(INTEL_FAM6_ATOM_AIRMONT, CHERRYTRAIL), /* Braswell, Cherry Trail */
>         {}
>  };
>
> @@ -135,7 +138,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
>         return IRQ_HANDLED;
>  }
>
> -static struct irq_chip int0002_irqchip = {
> +static struct irq_chip int0002_byt_irqchip = {
>         .name                   = DRV_NAME,
>         .irq_ack                = int0002_irq_ack,
>         .irq_mask               = int0002_irq_mask,
> @@ -143,10 +146,22 @@ static struct irq_chip int0002_irqchip = {
>         .irq_set_wake           = int0002_irq_set_wake,
>  };
>
> +static struct irq_chip int0002_cht_irqchip = {
> +       .name                   = DRV_NAME,
> +       .irq_ack                = int0002_irq_ack,
> +       .irq_mask               = int0002_irq_mask,
> +       .irq_unmask             = int0002_irq_unmask,
> +       /*
> +        * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
> +        * and we don't want to mess with the ACPI SCI irq settings.
> +        */
> +};
> +
>  static int int0002_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         const struct x86_cpu_id *cpu_id;
> +       struct irq_chip *irq_chip;
>         struct gpio_chip *chip;
>         int irq, ret;
>
> @@ -195,14 +210,19 @@ static int int0002_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       ret = gpiochip_irqchip_add(chip, &int0002_irqchip, 0, handle_edge_irq,
> +       if (cpu_id->driver_data == BAYTRAIL)
> +               irq_chip = &int0002_byt_irqchip;
> +       else
> +               irq_chip = &int0002_cht_irqchip;
> +
> +       ret = gpiochip_irqchip_add(chip, irq_chip, 0, handle_edge_irq,
>                                    IRQ_TYPE_NONE);
>         if (ret) {
>                 dev_err(dev, "Error adding irqchip: %d\n", ret);
>                 return ret;
>         }
>
> -       gpiochip_set_chained_irqchip(chip, &int0002_irqchip, irq, NULL);
> +       gpiochip_set_chained_irqchip(chip, irq_chip, irq, NULL);
>
>         return 0;
>  }
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
