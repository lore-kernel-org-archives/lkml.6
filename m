Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5AFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0163820879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe4uCC1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfAVPTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:19:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43650 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfAVPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:19:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so17644886oie.10;
        Tue, 22 Jan 2019 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2T84Tfc/ZuRQBZY1S8DPTdz+esS77Fl4v/tE2CDlTA=;
        b=pe4uCC1CDIj7U6wC6lglbLU9O8yOVv7KeO0yLqQgh+TB1/UJAd8bBtiHY/75CznAzR
         Vhe5T6zdYXzY+RZkZ+I7JI9Vpzwks2A+X9waTG98OOEZJjLkAsOw4MDe0WrkTkS44kGC
         bCZwuyXvNBe9DcLOtgho6TrqtoCT4jBo6WSHyIOfIRwSIV6dwEFVGNrKf6wAj6pKWbSi
         TDE31VmhhCpvonqkMn7xh9STCnYYsYgCfVvgHDDcb/U1aObzThS3x3FflDbERLN5G4Yv
         xSTKVD+G6NN/+242BaDSZtOxC/1ZYUaDsnmm49eB5eRxsZTu8Tgz8rD3XzLw1TyG5jna
         0x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2T84Tfc/ZuRQBZY1S8DPTdz+esS77Fl4v/tE2CDlTA=;
        b=EpcDd6n7+fF0Xlp2JR/mkow3z5cgdgfWiBT3bhXjlX6B623bFgAkOIj6SmU+L0YEl3
         lHovBdrUQ6ps3FMi5+zk+UDIZPXlxWYuQssWMaQRye5imjo86Ak0OW3TO1Wn35FniVCX
         n+fdq0YY4MCzDfTWTBUBx+FaAwvi+ORHqDYx9CWKEoR9S0fbszuM1kHjrpDEGLERW3VF
         xXmKcV4MH0CfHIS/q8ylYRAHNoJXHw+GkjOEkU9CHf9nki4xWYOl+oud+AgR8Z8tIOpf
         S6sSbkaioRKbRy3l7NRqI8vAk3dS8BICzk5YcY6NpK/vef98FpbMm4gWdu3XLn3x1s8G
         GZDA==
X-Gm-Message-State: AJcUukdEb8WMgO+9g7nmCPCfyEDs5MtTyYRJ5RgCA7CXL/3OTN4Md6SF
        BO8Vi1go4M+webqXfPGE84DKmReX0Cza98iq56Y=
X-Google-Smtp-Source: ALg8bN6toZ8jCBNh4tMWTuyjtgGFXn0+QGP0sDTTgzgORD2MEn1csrNenITQZX+Xmqhw4zEXUlYtl1p8Bq2aXNdohws=
X-Received: by 2002:aca:6155:: with SMTP id v82mr8785678oib.259.1548170362828;
 Tue, 22 Jan 2019 07:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20190122140705.4918-1-aford173@gmail.com>
In-Reply-To: <20190122140705.4918-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Jan 2019 13:19:17 -0200
Message-ID: <CAOMZO5D1bNjBkRbVukDCgXYOO6wqAEiBgj17dmW22Zstcj3e7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Jan 22, 2019 at 12:07 PM Adam Ford <aford173@gmail.com> wrote:

> +       reg_audio: regulator-audio {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_reg_audio>;
> +               compatible = "regulator-fixed";
> +               regulator-name = "3v3_aud";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

It seems that the 'regulator-always-on' property is not needed in this case.

> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       clock-frequency = <400000>;
> +       status = "okay";
> +
> +       codec: wm8962@1a {

Node name should be generic and label name should be specific, so:

wm8962: codec@1a {

> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       memory@10000000 {

Need to pass device_type = "memory";

> +               reg = <0x10000000 0x80000000>;
> +       };
> +
> +       reg_wl18xx_vmmc: regulator-wl18xx {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vwl1837";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> +               startup-delay-us = <70000>;
> +               enable-active-high;
> +       };
> +

No need for this blank line.

> +};

> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       pmic: pfuze100@8 {

pfuze100: pmic@8

> +       tmp102_0: tmp102@4a {

generic node name, please.

> +               compatible = "ti,tmp102";
> +               reg = <0x4a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_tempsense>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       tmp102_1: tmp102@49 {

Ditto

> +               compatible = "ti,tmp102";
> +               reg = <0x49>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       at24c64_mfg: at24@51 {

Ditto

> +               compatible = "atmel,24c64";
> +               pagesize = <32>;
> +               read-only;      /* Manufacturing EEPROM programmed at factory */
> +               reg = <0x51>;
> +       };
> +
> +       at24c64_usr: at24@52 {

Ditto

> +       panel-lvds0 {
> +               compatible = "ampire,am800480b3tmqw";

Could not found this compatible documented.

> +&i2c1 {
> +       ili_touch: ilitouch@26 {

Generic node name, please.

> +               compatible = "ili,ili2117a";

Could not found this compatible documented.
