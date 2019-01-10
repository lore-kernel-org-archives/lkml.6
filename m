Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB1C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D43214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AX1ubFKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfAJJRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:17:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40179 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:17:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so9307479oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOmLRyZtj3/sPUbQ1xP8RMBb2GJ7QUphf2etkaln8Io=;
        b=AX1ubFKNApW1qErnFf1wV3nJ9mDVaM4RGgqIWpo/y5PARBmwz1P+xiB6lJA3qY0gTS
         go7N2O2wVkLFxCaE8eUN1o6Uro3eqE64ifoBRMADsL5yRttX5xr296laPIdlarf11mCK
         iEmMzsRyclIZBwMw0Bi3JeDGfm3sYpD2QAsH8+qvT+0D7Gkxd0+bBFRFX6u7gIZG9cgl
         Mal7D8mCHU8Yqb/7Y99CiybMyvuq0/rgVLBrysoKcFS8De5SRbAYlg8FPEcqBi9QKYmK
         Tm2M7Ue+vPNxLSC1E8wFShh0AEnaVAVicMu6OllykmT4Us+PcDIpgksVq/YR2SJ9NwkU
         wK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOmLRyZtj3/sPUbQ1xP8RMBb2GJ7QUphf2etkaln8Io=;
        b=dgcyLxYtmu1NzPkjkk1pZSV588Iq9CsihlVsS4ndnNl6noMS84bIW3Ppnj8LlHBZjZ
         s6GZFFSLsFWMvEMpT0jkqDCOVyXMfv3PvRW2loLCeA6ZcAYYBKzmmXnKWAnw1+oGKHmy
         9TttOEpDdQw0HKxPf+6VtsHjUqz2NuXOrRt7UGVUdbZ+gZI/4zXDmhBom1GXvPGnhp+u
         ZJaOCg81W1zWlSb3twDbpL/FuXn6RY8jqQwXgE5x6UOFjeY7YUqOv7s+On9yUfyeU5Yx
         vVRnqwhTbmHnoZCnPOEhrcP8AR8avDgTAJlBgw9Rm1A02n1E5IHrf2b8pSo3jGSBSqrF
         EO1A==
X-Gm-Message-State: AJcUukfca+mJGVL2LS68QQoz/GTphLf9pWm8K++5By8zF5WuK26PlrWz
        VmAm3zP9qPNBfZFtJSaLnqyeOGo2n4BH1AJ4ldHz5w==
X-Google-Smtp-Source: ALg8bN73ejpJWLpEa0S2nRW6jvS1CFmKrZSQY2alLzyv7roSK3hHYIu/VMHVcGHqWNMYaBNP6GZRctXJuHTxqxLbo3M=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr5815134otj.301.1547111863804;
 Thu, 10 Jan 2019 01:17:43 -0800 (PST)
MIME-Version: 1.0
References: <1547025084-16999-1-git-send-email-rogerq@ti.com>
In-Reply-To: <1547025084-16999-1-git-send-email-rogerq@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 10 Jan 2019 10:17:33 +0100
Message-ID: <CAMpxmJUx+LGUDoQQrAp6inWohFzM4W1E2gwWdQ2=O_wHAt164A@mail.gmail.com>
Subject: Re: [PATCH] gpio: pcf857x: Fix interrupts on multiple instances
To:     Roger Quadros <rogerq@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 9 sty 2019 o 10:11 Roger Quadros <rogerq@ti.com> napisa=C5=82(a):
>
> When multiple instances of pcf857x chips are present, a fix up
> message [1] is printed during the probe of the 2nd and later
> instances.
>
> The issue is that the driver is using the same irq_chip data
> structure between multiple instances.
>
> Fix this by allocating the irq_chip data structure per instance.
>
> [1] fix up message addressed by this patch
> [    1.212100] gpio gpiochip9: (pcf8575): detected irqchip that is shared=
 with multiple gpiochips: please fix the driver.
>
> Cc: Stable <stable@vger.kernel.org> # 4.20+
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/gpio/gpio-pcf857x.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
> index adf72dd..68a35b6 100644
> --- a/drivers/gpio/gpio-pcf857x.c
> +++ b/drivers/gpio/gpio-pcf857x.c
> @@ -84,6 +84,7 @@ MODULE_DEVICE_TABLE(of, pcf857x_of_table);
>   */
>  struct pcf857x {
>         struct gpio_chip        chip;
> +       struct irq_chip         irqchip;
>         struct i2c_client       *client;
>         struct mutex            lock;           /* protect 'out' */
>         unsigned                out;            /* software latch */
> @@ -252,18 +253,6 @@ static void pcf857x_irq_bus_sync_unlock(struct irq_d=
ata *data)
>         mutex_unlock(&gpio->lock);
>  }
>
> -static struct irq_chip pcf857x_irq_chip =3D {
> -       .name           =3D "pcf857x",
> -       .irq_enable     =3D pcf857x_irq_enable,
> -       .irq_disable    =3D pcf857x_irq_disable,
> -       .irq_ack        =3D noop,
> -       .irq_mask       =3D noop,
> -       .irq_unmask     =3D noop,
> -       .irq_set_wake   =3D pcf857x_irq_set_wake,
> -       .irq_bus_lock           =3D pcf857x_irq_bus_lock,
> -       .irq_bus_sync_unlock    =3D pcf857x_irq_bus_sync_unlock,
> -};
> -
>  /*----------------------------------------------------------------------=
---*/
>
>  static int pcf857x_probe(struct i2c_client *client,
> @@ -376,8 +365,17 @@ static int pcf857x_probe(struct i2c_client *client,
>
>         /* Enable irqchip if we have an interrupt */
>         if (client->irq) {
> +               gpio->irqchip.name =3D "pcf857x",
> +               gpio->irqchip.irq_enable =3D pcf857x_irq_enable,
> +               gpio->irqchip.irq_disable =3D pcf857x_irq_disable,
> +               gpio->irqchip.irq_ack =3D noop,
> +               gpio->irqchip.irq_mask =3D noop,
> +               gpio->irqchip.irq_unmask =3D noop,
> +               gpio->irqchip.irq_set_wake =3D pcf857x_irq_set_wake,
> +               gpio->irqchip.irq_bus_lock =3D pcf857x_irq_bus_lock,
> +               gpio->irqchip.irq_bus_sync_unlock =3D pcf857x_irq_bus_syn=
c_unlock,
>                 status =3D gpiochip_irqchip_add_nested(&gpio->chip,
> -                                                    &pcf857x_irq_chip,
> +                                                    &gpio->irqchip,
>                                                      0, handle_level_irq,
>                                                      IRQ_TYPE_NONE);
>                 if (status) {
> @@ -392,7 +390,7 @@ static int pcf857x_probe(struct i2c_client *client,
>                 if (status)
>                         goto fail;
>
> -               gpiochip_set_nested_irqchip(&gpio->chip, &pcf857x_irq_chi=
p,
> +               gpiochip_set_nested_irqchip(&gpio->chip, &gpio->irqchip,
>                                             client->irq);
>                 gpio->irq_parent =3D client->irq;
>         }
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>

Applied to fixes. Thanks!

Bart
