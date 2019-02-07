Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A918C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A7C218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBGO23 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:28:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45278 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBGO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:28:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id t6so7890092edw.12;
        Thu, 07 Feb 2019 06:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w9xKQ32ph7UtzCcF4cmYK0+JplXRCzoSm/i8W1X1Cq4=;
        b=AQ/n2Vb8p7wzJhvDTXkHlWWb1+coXE2LPtCHn1ATQhZ8kcFWTghyHp1vXgSG5YlLQl
         nvlXHmhtVaMxJLjcq+YtzYl1kJVcXvYQJG0GQanywmCf9oYZRTlCeNxaEiJc5RH5f852
         LuZG5ZgpRK2LNlHhUoOzhpikzH0TGALf54gkbhbwhP91wKBK7vFJplmtQiJdXUjx9yd0
         Gh5ezx08s03dT8VyyODg/wdU9jvYzQQlIViy44VhmRd9ux0QjttS6fTl6cQtZCniHJQj
         jJINMMzU1sSyAXMmcEWRMBV8+BBP6+8EDGJY0l+gC+51sFgKSk0C81AZvFaYTP46Zqy1
         aFLg==
X-Gm-Message-State: AHQUAuZT3jriTRY0wTKL0A0IA3DgAYsGu7aew87iMr6NWkIfMgV6+Lx0
        pvlsPKtcZsW4mKOtGdP/XeHDtUU7OUw=
X-Google-Smtp-Source: AHgI3IbJKHNAiealI4BpK/wPv8gjxWHhK8rARfyixJW1dewiMXGmWQp6JDB2IbNTOjg8TKRDLbE4UA==
X-Received: by 2002:a50:be44:: with SMTP id b4mr12009441edi.41.1549549705996;
        Thu, 07 Feb 2019 06:28:25 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id f38sm2073603edd.97.2019.02.07.06.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:28:25 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id y185so4510199wmd.1;
        Thu, 07 Feb 2019 06:28:25 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr7967974wmc.116.1549549705221;
 Thu, 07 Feb 2019 06:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20190207064535.9226-1-wens@csie.org> <20190207064535.9226-8-wens@csie.org>
 <20190207110247.GE20638@dell>
In-Reply-To: <20190207110247.GE20638@dell>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 7 Feb 2019 22:28:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
Message-ID: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to AXP813
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:02 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 07 Feb 2019, Chen-Yu Tsai wrote:
>
> > From: Quentin Schulz <quentin.schulz@bootlin.com>
> >
> > The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> > supports this variant, we can add an mfd cell for it to use it.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > [wens@csie.org: add commit message]
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/mfd/axp20x.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index 3c97f2c0fdfe..17b115845993 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
> >       DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> >  };
> >
> > +/* AXP803 and AXP813/AXP818 share the same interrupts */
> > +static struct resource axp803_usb_power_supply_resources[] = {
> > +     DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> > +     DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>
> Nit: Why 2 spaces here?                              ^

2 spaces? I'm only seeing one.

> With that fixed, you can add my:
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
