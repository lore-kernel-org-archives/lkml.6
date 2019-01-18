Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161CC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDFF2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLOqi8qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfARVTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:19:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41125 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbfARVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:19:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so15648932otk.8;
        Fri, 18 Jan 2019 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5esMmal+EyiJjppc4XekprtxYgx+syUq4ePbtc3GRY=;
        b=DLOqi8qGJPYy2B9LlOD7twGId6dll2zgIvXdBe+v5IOpB6af94v96wZrlQbHmcKMBy
         HGwwuWDfeOXAYLUhk+mRRBNWfQxih4sp1P15kATLZU655N13CgbZ1w7WOjmbsJY6AlMo
         DX9dvq4Wnhqs6+tuRF2A9L0pPNik1E/ajl/1g0Vx3tBR0ORwBj0vqzoWZC5b/iLxQsRL
         k+BmhzpPdbHcExA9GoiadGa4Og9RnLrnnkTXBUO3sAkGCKs+4bZMFU6WuaHqwu9Uu/xp
         d3jNKOGhp+l2besos3Wcy8dEmQ0o5cJqoMU1bgFddWt4joNO9yIF0z6+6oOYsf5OUZmp
         5/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5esMmal+EyiJjppc4XekprtxYgx+syUq4ePbtc3GRY=;
        b=jEbcqRVYuX+aQmPgOmimkbqpaijSlosEvJ5q6ymvwg8ANivHxONTWjCaxkLRzNH+Ds
         lozRYNDihsRTtr4iDxGoeIG3DEI8gUZN2ZcPtPMRYDiHRoz3EQoL3VMBk4vPignkrw6I
         SW1TMqgmatxyaBm1fSm3b9hOxcsyNPHNMuZoV9fTNZGiDqDJFcpjssi6VhZVkpigpEz4
         YCpuP0jqhA/bpPu9lzPVW1HUfnNzL17MaI2/rSsHfxoBoLncGgraMslShnXoRP39xLAZ
         Cxw78O/T1KeQCzDHpcjTRI0yWySZeWzj7pd6PxYx40PyZ2iEJbRwEzyd6QcV9xxsuQuT
         /zEg==
X-Gm-Message-State: AJcUukckeRPpPYdHJwpwryprWTVhiVFjChZEe3AJirNSWyElD286IqiK
        4/5KQ/LZZ13TBhenxZd2INa+447pXVfB/1ewh0Q=
X-Google-Smtp-Source: ALg8bN7yEDzZ/ik19/gC/B8WysQYlH9TYZjk95Wutj03C66M7F0hKU3UY5v8rkjW9jyqjmwyCU/rqYBtw/uEUaIsJvY=
X-Received: by 2002:a9d:5d2:: with SMTP id 76mr12517903otd.78.1547846346709;
 Fri, 18 Jan 2019 13:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20190118194812.3319-1-martyn.welch@collabora.com> <20190118194812.3319-2-martyn.welch@collabora.com>
In-Reply-To: <20190118194812.3319-2-martyn.welch@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 19:18:55 -0200
Message-ID: <CAOMZO5ASTUDfKkghXq5FftM8-XNztXCYpmdOU9CVfyX3pgKxxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD
 i.MX6UL Segin
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Stefan_Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Christian Hemp <c.hemp@phytec.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martyn,

On Fri, Jan 18, 2019 at 5:49 PM Martyn Welch <martyn.welch@collabora.com> wrote:

> +       /*
> +        * Set the minimum memory size here and
> +        * let the bootloader set the real size.
> +        */
> +       memory {

Need to pass device_type = "memory";

> +               reg = <0x80000000 0x8000000>;
> +       };
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +       status = "okay";
> +};
> +
> +&iomuxc {
> +       pinctrl-names = "default";

Uneeded line.

> +
> +       pinctrl_enet1: enet1grp {
> +&iomuxc {
> +       pinctrl_gpio_keys: gpio_keysgrp {
> +               fsl,pins = <
> +                       MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x79
> +               >;
> +       };
> +
> +       pinctrl_user_leds: user_ledsgrp {
> +               fsl,pins = <
> +                       MX6UL_PAD_JTAG_MOD__GPIO1_IO10          0x79
> +                       MX6UL_PAD_GPIO1_IO01__GPIO1_IO01        0x79
> +               >;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> new file mode 100644
> index 000000000000..83cdf4fa10c0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +/dts-v1/;
> +#include "imx6ul-phytec-pcl063.dtsi"
> +#include "imx6ul-phytec-phyboard-segin.dtsi"
> +#include "imx6ul-phytec-peb-eval-01.dtsi"
> +
> +/ {
> +       model = "Phytec phyBOARD-Segin i.MX6 UltraLite Full Featured";
> +       compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063",
> +                    "fsl,imx6ul";

Better keep it in a single line?

> +&ecspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi3>;
> +       cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +
> +       spidev@0 {
> +               compatible = "spidev";

Doesn't the kernel complain about spidev dts nodes?

> +};
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
> new file mode 100644
> index 000000000000..bccabb84c9f6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +/ {
> +       model = "Phytec phyBOARD-Segin i.MX6 UltraLite";
> +       compatible = "phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063",
> +                    "fsl,imx6ul";

Single line?

> +&i2c1 {
> +       codec: tlv320@18 {

Node names should be generic and label names specific, so:

 tlv320: codec@18

> +               compatible = "ti,tlv320aic3007";
> +               #sound-dai-cells = <0>;
> +               reg = <0x18>;
> +               AVDD-supply = <&reg_sound_3v3>;
> +               IOVDD-supply = <&reg_sound_3v3>;
> +               DRVDD-supply = <&reg_sound_3v3>;
> +               DVDD-supply = <&reg_sound_1v8>;
> +               status = "disabled";
> +       };
> +
> +       stmpe: stmpe@44 {

touchscreen@44
