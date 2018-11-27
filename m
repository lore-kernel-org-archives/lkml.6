Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAAB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpsWjEtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAAB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeK0Lpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:45:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35939 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeK0Lpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:45:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so20493984wmh.1;
        Mon, 26 Nov 2018 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GwF79H+zVKBhtp+7hLQKsVpwJ7/oFe/Vc3sBuCRXKg0=;
        b=BpsWjEtpPsEjm7hF7RVLtCptXqY6Z8EkVN6Pspo6BhFSTaTKrGOOG2/c6/8vqz0rol
         UObqIOf8Jqtqkh86AU55xBC/I43iqtC+RAUaRGdapGEd/Z68mkOtQl1IN0zieBYNPB1y
         4+PoVqr+EtENLaaNxubm7sFVtjnVDAp/glvwH3unJV4Eyk8QOcB3b0lSlgJabz+aqxfk
         0A4R4aTbQywhnr6Q2HwaZH1AdGQYGR/oRdTMo+6vXAeihSv7NmZXKue5jzeNtACpWOwx
         kr8OADl+FfO9bFVbEFxJM3qiKAJ8yKQfPWMMl9ytC23EkwpJJ6W7K3QS9RjnJyr4SLXU
         ZJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GwF79H+zVKBhtp+7hLQKsVpwJ7/oFe/Vc3sBuCRXKg0=;
        b=XXSHAfng4fS0BWdUGzjJKe4DLPAwodQ8Rq0LxpGftdncDBfG6V4z3cv+8o22wm3B4x
         mY3DP5DsfKDhZwiTuGhLQjtDNlfNqeHEBjH+RG7Eg4MIsQITSmhvdaGvJIxOhqJJrz0A
         UVZbgTp/gfvnwUr8DAAV72+zLO/Hf7lNvprYSAV3q2gWaiOgJ8KEVRcPLTFGVtam1qHg
         qSs2UYFxmw7HOKjBq38ezfWdv0MatBWOH3/ZTlrFjY7CUwyEIWFDXaA8TGOz5/LzNTy0
         9LGWdVV6zASlgXAvk4gHPCrfMxITjeGzMajn4AUKRqyYKnum+Ua8cm3G4Qz3BYs/TqPT
         HvAQ==
X-Gm-Message-State: AGRZ1gIJPiIVm1CdzC2PhaeWX4Qh+tl/UhPUQuHApp+MyrMG6f+mFgkJ
        Hgjga6Y8BG1d5Z1hzhtLAo0Il+EjZsAqk+Rk2m7d48euUZs=
X-Google-Smtp-Source: AJdET5ddsPRILCmFZa0YpB+WN2UuUTeg0ZCdAHlSUFpruCLOJJ4RQldY/nvPyvxOi9i0NF4CENdN75FCaadTAB5+Gb8=
X-Received: by 2002:a1c:6508:: with SMTP id z8mr25862197wmb.28.1543279769930;
 Mon, 26 Nov 2018 16:49:29 -0800 (PST)
MIME-Version: 1.0
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
 <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com>
 <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de> <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
In-Reply-To: <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
From:   =?UTF-8?Q?Ren=C3=A9_Kjellerup?= <rk.katana.steel@gmail.com>
Date:   Mon, 26 Nov 2018 16:49:18 -0800
Message-ID: <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
Subject: Re: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To the broadcom kernel maintainers, (for BCM4708 CPUs)

I just want to add a little attention to this patch again...
let me know if there's any concerns and I will try to address highlighted i=
ssues
as soon as possible.

I've been running the development builds of OpenWrt kernels, where
this patch has
been included, on my Linksys EA6500v2 router for the past months,
updating as new
builds are available. With only the on board BCM4360 chip (5GHz WiFi) is be=
ing
disabled, has so far been stable for my use case.

thank you for the consideration
Rene (aka Katana_Steel)

On Mon, Oct 8, 2018 at 9:34 AM Ren=C3=A9 Kjellerup <rk.katana.steel@gmail.c=
om> wrote:
>
> Hi Hauke,
>
> Updated the file header per your suggestion.
>
> From e97c15ef78d2535c23f32ebbec43bced72b5eaf7 Mon Sep 17 00:00:00 2001
> From: Rene Kjellerup <rk.katana.steel@gmail.com>
> Date: Mon, 1 Oct 2018 14:11:56 -0700
> Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2
>
> It's wireless home router based on BCM4708A0 with BCM4360 + BCM4331
> wireless chipsets. The 5GHz chip currently isn't supported only due
> to missing compatible firmware.
>
> the DTS here was based on the Linksys EA6300 V1 DTS, only changing
> the model strings
>
> Signed-off-by: Rene Kjellerup <rk.katana.steel@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts | 47 +++++++++++++++++++=
++++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..adf8f28f5e44 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -88,6 +88,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) +=3D \
>      bcm4708-asus-rt-ac68u.dtb \
>      bcm4708-buffalo-wzr-1750dhp.dtb \
>      bcm4708-linksys-ea6300-v1.dtb \
> +    bcm4708-linksys-ea6500-v2.dtb \
>      bcm4708-luxul-xap-1510.dtb \
>      bcm4708-luxul-xwc-1000.dtb \
>      bcm4708-netgear-r6250.dtb \
> diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
> b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
> new file mode 100644
> index 000000000000..8a434d2a4b72
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> + * Copyright (C) 2018 Rene Kjellerup <rk.katana.steel@gmail.com>
> + *
> + * this DTS was originally based on bcm4708-linksys-ea6300-v1.dts
> + */
> +
> +/dts-v1/;
> +
> +#include "bcm4708.dtsi"
> +#include "bcm5301x-nand-cs0-bch8.dtsi"
> +
> +/ {
> +    compatible =3D "linksys,ea6500-v2", "brcm,bcm4708";
> +    model =3D "Linksys EA6500 V2";
> +
> +    chosen {
> +        bootargs =3D "console=3DttyS0,115200";
> +    };
> +
> +    memory {
> +        reg =3D <0x00000000 0x08000000>;
> +    };
> +
> +    gpio-keys {
> +        compatible =3D "gpio-keys";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        wps {
> +            label =3D "WPS";
> +            linux,code =3D <KEY_WPS_BUTTON>;
> +            gpios =3D <&chipcommon 7 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        restart {
> +            label =3D "Reset";
> +            linux,code =3D <KEY_RESTART>;
> +            gpios =3D <&chipcommon 11 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +};
> +
> +&usb3_phy {
> +    status =3D "okay";
> +};
> --
> 2.16.4
>
> On Sun, Oct 7, 2018 at 2:08 PM Hauke Mehrtens <hauke@hauke-m.de> wrote:
> >
> > On 10/04/2018 11:08 PM, Ren=C3=A9 Kjellerup wrote:
> > > Hi Hauke,
> > >
> > > thank you for suggesting adding the dts patch to mainline kernel,
> > > so here it is.
> > > I feel Rafal technically still have the copyrights, this is pretty
> > > much just a few string updates for the ea6500v2. However with this
> > > dts in latest OpenWrt 18.06 loads and installs on my device.
> > >
> > > I will be available to do more testing should it be required.
> > >
> > > Regrads
> > > Rene Kjellerup
> > > --
> > > -- as life grows older, I gain experience.
> > > -- http://www.alchemiestick.net/
> > >
> >
> > Hi Rene,
> >
> > Please send you patch inline in the mail and not as an attachment, I
> > would suggest to use "git send-email" for sending the patch.
> >
> > Adding Rafal as copyright owner is ok, like you did it now. You could
> > mention in the file header on which dts file this is based.
> >
> > Hauke
> >
>
>
> --
> -- as life grows older, I gain experience.
> -- http://www.alchemiestick.net/apps/
