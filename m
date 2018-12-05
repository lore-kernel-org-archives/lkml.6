Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC4CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0783B213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i55Gn+qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0783B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeLEMPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:15:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38154 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeLEMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:15:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so17295070oii.5;
        Wed, 05 Dec 2018 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBUSQk2PdOZFKYA6A63N18LCzBPvNkM379cJypVZDM0=;
        b=i55Gn+qUZw8+y65bQTAfeP94ZFm+9BnhUqA1rKpcXN+YUuwcM8lU+960a4gEL154j9
         Fr1ZRP1UBpmy621uTAI1JDeOuwuKWDWkZLizqrXy6GrXhrM1dgnkeJVHPoE0GuBxQmSL
         6vHK8WsnyA7pvvHwPHSjtALMyCGZ/vCZB+AHqnvpxIPVTW0CG67qNUs5F+GPtXLlwa3O
         jiYGw4fr8FdoDp2/R4gpUhqdNFyOLP703ijyOzqQM7KOHetJC10iKwK2i1bus++/y+sR
         bbcGPfMbxJBgjqQKByMABjGmQXbaX31BGR116/3nwON2vCqHKMCgDLQZ23Cvy7sfY05h
         Heqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBUSQk2PdOZFKYA6A63N18LCzBPvNkM379cJypVZDM0=;
        b=m20f5aaqzfKpRGFNXD7OvP0hdgyMXI8Z2D9JB5vYbWuqjcJWpp5915u93kxjIkOEPk
         zaZyA7kLWBGWJTfEtRWu3AA3Pz6OoEWUwX67m8pn5b4u5p9Ue4jcjTp1wJo033FSnsZt
         VDWSSiwBuD0VPquVKm9pE4wj7xXO6rziHUSX6G3oa+d2iYapK6quGBuwQMqM0Pub1IQ0
         CXlFmT11s4gOXBdKfDWftzEDip39W5AMQ0XmoU0KE13pGif3Vyor5fF/gYHBt0k8/ubJ
         N2Tv/SUOJRlEunlHh27b5/86LmoXd/zfhBy1L8Wfp6MCds/nC4Dh9p9Rhf7VmUJ/ZAMJ
         3tOg==
X-Gm-Message-State: AA+aEWYjzp/KNILsD4X2KdLU7RtckUihz58fxQ+HxKz626OrjijlP0z1
        bxRkhyQR4GrzALTg9MuzhT+nc/u/B90ZNv08x8prhAbD
X-Google-Smtp-Source: AFSGD/X1JcPRDrP2vleoUg4EqcCzdoBIbgHS1sqhjpYkrt6Bo4J6K5ZKLzrijF+TP2vgoy+wbnJI5XL6MJaqSHArHvc=
X-Received: by 2002:aca:4d47:: with SMTP id a68mr13926177oib.43.1544012102512;
 Wed, 05 Dec 2018 04:15:02 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 10:15:06 -0200
Message-ID: <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Dec 5, 2018 at 7:20 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add isl29023 light sensor support on i2c3 bus, the light
> sensor's power is controlled by a fixed regulator, since
> the isl29023 driver and most of other sensors on same
> board like mag3110 and mma8451 do NOT support regulator
> operation currently, they are all controlled by this
> regulator, so this patch also adds the fixed regulator
> support and make it always on.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index d7389b5..f96ae54 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -62,6 +62,19 @@
>                         gpio = <&gpio3 19 0>;
>                         enable-active-high;
>                 };
> +
> +               reg_sensor: regulator@4 {

I know that you followed the existing pattern for regulators in this
file, but it is not recommended to put regulators under "simple-bus".

I would suggest you to make a first patch of the series that removes
all of the existing regulators from "simple-bus", then you add this
series on top.

Then this regulator becomes:

reg_light_sensor: regulator-light-sensor {

> +                       compatible = "regulator-fixed";
> +                       reg = <4>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_sensor_reg>;

pinctrl_sensor_reg is too generic. You could use pinctrl_light_sensor_reg

> +                       regulator-name = "sensor-supply";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
> +                       enable-active-high;
> +                       regulator-always-on;
> +               };
>         };
>
>         gpio-keys {
> @@ -420,6 +433,15 @@
>                 interrupts = <7 2>;
>                 wakeup-gpios = <&gpio6 7 0>;
>         };
> +
> +       isl29023@44 {

Node names should be generic, so: light-sensor@44
