Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA5BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3282084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbV6n+Xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3282084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGMStX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:49:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39366 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:49:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so63924184oib.6;
        Fri, 13 Jul 2018 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GpswY0Iv3BnpjscCP2wG9wDgW2lIYeY+fRwizmvpG58=;
        b=LbV6n+XeRjKr1BF7hFtz3h05OTKdmuAz4h1HVjG4VeYXY39kqLqC18NPq3rMIkm2UE
         XLd6a4+Z6mbn3BXEsJTV/Bi9/UthdNJnIxMOezcJV/lobJWvuQv3AA3HmtvPWzuSRtpb
         Ej2KoItvFzPMqD9LUtgqmeqjBK7PEYrKx/8hPC2Rm/xZEPzjuw1UOY7G/C4k7AQlHUQt
         Q+B3P8IbDASZWT/kY9+ZkcqvclaNFy2yM9WTsPbjTJGTembbBmJjPGju6TcYRDadHRbJ
         BoyA7up1U7N+xRJx8o74T/bfo2BRkpm6ylz0loxTlvzZmuxwj6oZGtwhlWPiQQpYHGJx
         VSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GpswY0Iv3BnpjscCP2wG9wDgW2lIYeY+fRwizmvpG58=;
        b=ATiFtzX7bFF8vrvz/9gAwPGPXILJkGRsq1pOn3plmNv2PpQj9mOZfYZgQC682RXgg1
         75kDZ1a/DX15kPx1/yrCgU9KhqG4p5LlbwAz679G6TKfwMRPB3ZM9CcuzqHTJ8yMhVzI
         SG9FFkwaofI/af+hjVwIuyNOdGyAoz2lEIJdtMYNA//PUO4Mh8rekNoVqRhOcZioAb40
         7OGq8X6X2aIMv0Ay9YaNrtvqVJRX7POhfw8e6rdEqf3ueHO7iX3P/RYjX1JJJ8+pSwO/
         LC0T3vtXpysDHBQ3A1mud9Yk+0P1JnxIi/0wM4BH3Bjyl1za+VgeEk5NNibyCE8ug66j
         X/mw==
X-Gm-Message-State: AOUpUlEVScBGVq2tL7pIXh4GOX6atk5O4reOgcpqxuxnIqBAtnISpJma
        xYM5dXT9eg7fY5TlypZ4OgwVM50hcNmmSc/jA7c=
X-Google-Smtp-Source: AAOMgpd3FO43AfOJFdR7O5UFe9+r/ydwUkPu/VMVIxOzPn/bWjYTKC1Ut+Xs8F9cXnCnCV70fJ3OMEfwRtFOd1yfnkg=
X-Received: by 2002:aca:45d6:: with SMTP id s205-v6mr8927174oia.147.1531506815106;
 Fri, 13 Jul 2018 11:33:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:33:34
 -0700 (PDT)
In-Reply-To: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 15:33:34 -0300
Message-ID: <CAOMZO5BSt4jdLWmXjNmTDAegGwtRWjbMuVAwdrnRyHWvSBuU5A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add power management support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, Jul 10, 2018 at 4:48 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> GPIO registers could lose context on some i.MX SoCs,
> like on i.MX7D, when enter LPSR mode, the whole SoC

After further reviewing this patchI have a question: here you say that
i.MX7D needs to save some registers.

> will be powered off except LPSR domain, GPIO banks
> will lose context in this case, need to restore
> the context after resume from LPSR mode.
>
> This patch adds GPIO save/restore for those necessary
> registers, and put the save/restore operations in noirq
> suspend/resume phase, since GPIO is fundamental module
> which could be used by other peripherals' resume phase.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/gpio/gpio-mxc.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 2f28299..0fc52d8 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -45,6 +45,15 @@ struct mxc_gpio_hwdata {
>         unsigned fall_edge;
>  };
>
> +struct mxc_gpio_reg_saved {
> +       u32 icr1;
> +       u32 icr2;
> +       u32 imr;
> +       u32 gdir;
> +       u32 edge_sel;
> +       u32 dr;
> +};
> +
>  struct mxc_gpio_port {
>         struct list_head node;
>         void __iomem *base;
> @@ -55,6 +64,7 @@ struct mxc_gpio_port {
>         struct gpio_chip gc;
>         struct device *dev;
>         u32 both_edges;
> +       struct mxc_gpio_reg_saved gpio_saved_reg;
>  };
>
>  static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
> @@ -497,6 +507,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>
>         list_add_tail(&port->node, &mxc_gpio_ports);
>
> +       platform_set_drvdata(pdev, port);
> +
>         return 0;
>
>  out_irqdomain_remove:
> @@ -507,11 +519,67 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>         return err;
>  }
>
> +static void mxc_gpio_save_regs(struct mxc_gpio_port *port)
> +{
> +       if (mxc_gpio_hwtype == IMX21_GPIO)
> +               return;

but here you only block IMX21_GPIO.

This means that mx31/mx35/mx51/mx53/mx6 will execute this code too
now. Is this always safe?

Shouldn't it this save/restore be executed only on mx7d?

Please clarify.
