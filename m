Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA8C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3995920870
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYFL0Du/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3995920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeIWU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:29:59 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37148 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeIWU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:29:58 -0400
Received: by mail-oi0-f67.google.com with SMTP id n1-v6so2416287oic.4;
        Sun, 23 Sep 2018 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3f5oCQfzD+EgnDO5imzf8N1gHtF8K93TqtSaSO1Ik/s=;
        b=VYFL0Du/JvLvxEajc+GvIyjbvHO27JV4ms68Zd+rpEKtFO8eivCWAOMIKO2IG4yxmS
         DxVAnmor+O5YzMGrIxwtQ5CvADETcFbN7UXmoc/+4M2cImSEJuwWwFmu9MtQUlrwI8rj
         NAZqxWs5SPumwnq01sEkg/B4ZB8v+3uxE3hseP6chBoQzAnKDQxTyx4c9At7TsHTHlS9
         tuFdbUFCJjfcI/2AR8RUler3awqn+BQLm63U4qTqzZtAPpTogH3OkpWLyNYIfTrdhw7U
         fngmKHch/2KolKH5qrP7cT4FySKiSzKzn0aAX5Yg6Gq8TFnQfbJmrLPEZBeqfCqUIOjC
         DvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3f5oCQfzD+EgnDO5imzf8N1gHtF8K93TqtSaSO1Ik/s=;
        b=ESqhfB8Ua2BUuhgjHag2eIYzMHvVHnViWCrH3Dmjpx6MtCYEh7Pob5UASLmT7wkG1z
         +/f0O0N0pWLBPQGriMGHavmanvk2D9XKlXGC4r1Qjjyzvr1LlX525kpnmUB48KvUbu1p
         ecVPxsZi1ItqIgCxEL4/aBnQnjDNkKYBH2b9R8COTlnloxYGFpZEHoeweIyGhWwGNX8T
         gKY0D3GvA/BHAQzUV/NfFR4jYggvDzECABwpFCzBnUcKMQT+vKCwKOiU+/4WuZw5KAXH
         UI4tnLS6mbDPyu0aEnX1cfyQS8eO6bKQr02RgD4E+aE5Mbywsuqim4rryORdUVLj/f+1
         5HQA==
X-Gm-Message-State: APzg51CdRMynvje34yXASVCtaQk6lttKq4QQOrUZUG8F831HbSubksNd
        JpGuidK8eVzHtAqS5CPyDunAfR6xaU9nMoOA0xunCeU7
X-Google-Smtp-Source: ANB0VdYOiiEjm74k2XXpOeRkJJyuvXNkFN8eUazem+V14u5OIO7mY3CFXLKDt8D6ZnmlbGiJpMN3jFoLOYln54inH8s=
X-Received: by 2002:aca:3d83:: with SMTP id k125-v6mr3138853oia.86.1537713137948;
 Sun, 23 Sep 2018 07:32:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d28:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 07:32:17
 -0700 (PDT)
In-Reply-To: <20180921152726.31742-1-lukma@denx.de>
References: <20180921152726.31742-1-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 23 Sep 2018 11:32:17 -0300
Message-ID: <CAOMZO5DPnWNJ_UVdE9Lvh05R84seP8VPP=35eEUaor4-pppXGQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Add support for Liebherr's BK4 device (vf610 based)
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:27 PM, Lukasz Majewski <lukma@denx.de> wrote:
> This commit adds DTS support for BK4 device from Liebherr. It
> uses vf610 SoC from NXP.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/Makefile      |   1 +
>  arch/arm/boot/dts/vf610-bk4.dts | 504 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 505 insertions(+)
>  create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..e6f159895fa9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_LS1021A) += \
>         ls1021a-twr.dtb
>  dtb-$(CONFIG_SOC_VF610) += \
>         vf500-colibri-eval-v3.dtb \
> +       vf610-bk4.dtb \
>         vf610-colibri-eval-v3.dtb \
>         vf610m4-colibri.dtb \
>         vf610-cosmic.dtb \
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
> new file mode 100644
> index 000000000000..4ad7e739a0ad
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "vf610.dtsi"
> +
> +/ {
> +       model = "Liebherr BK4 controller";
> +       compatible = "lwn,bk4", "fsl,vf610";
> +
> +       chosen {
> +               bootargs = "console=ttyLP1,115200";

You could pass stdout-path instead.

> +       };
> +
> +       memory@80000000 {
> +               reg = <0x80000000 0x8000000>;
> +       };
> +
> +       audio_ext: mclk_osc {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24576000>;
> +       };

This seems to be unused.

> +
> +       enet_ext: eth_osc {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <50000000>;
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +               /* LED D5 */
> +               led0: heartbeat {
> +                       label = "heartbeat";
> +                       gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +                       default-state = "on";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_3p3v: regulator@0 {

Please move all regulators outside of the simple-bus container and use
this naming convention:

reg_3p3v: regulator-3p3v {

> +&dspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_dspi3>;
> +       bus-num = <3>;
> +       status = "okay";
> +
> +       spidev3@0 {
> +               compatible = "fsl,vf610-dspi";
> +               spi-max-frequency = <30000000>;
> +               reg = <0>;
> +               fsl,spi-slave-mode;

Such property does not exist.

I also thought that spidev nodes in dt were not recommended.

> +&iomuxc {

Like Stefan mentioned it is common practice on imx dts files to place
the iomuxc node as the last one.


> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_bk4_common>;

This seems to be not called from any driver.

We usually use a hog group for such purpose.

> +
> +       pinctrl_bk4_common: commongrp {
> +               fsl,pins = <
> +                       /* One_Wire_PSU_EN */
> +                       VF610_PAD_PTC29__GPIO_102               0x1183
> +                       /* SPI */
> +                       VF610_PAD_PTB26__GPIO_96                0x1183
> +                       VF610_PAD_PTE14__GPIO_119               0x1183
> +                       VF610_PAD_PTE4__GPIO_109                0x1181
> +                       /* Feedback_Lines */
> +                       VF610_PAD_PTC31__GPIO_104               0x1181
> +                       VF610_PAD_PTA7__GPIO_134                0x1181
> +                       VF610_PAD_PTD9__GPIO_88         0x1181
> +                       VF610_PAD_PTE1__GPIO_106                0x1183
> +                       VF610_PAD_PTB2__GPIO_24         0x1181
> +                       VF610_PAD_PTB3__GPIO_25         0x1181
> +                       VF610_PAD_PTB1__GPIO_23         0x1181
> +                       /* SDHC */
> +                       VF610_PAD_PTE19__GPIO_124               0x1183
> +                       VF610_PAD_PTB23__GPIO_93                0x1181

If they are related to SDHC they should be better placed under the sdhc nodes.


> +                       /* GPI */
> +                       VF610_PAD_PTE2__GPIO_107                0x1181
> +                       VF610_PAD_PTE3__GPIO_108                0x1181
> +                       VF610_PAD_PTE5__GPIO_110                0x1181
> +                       VF610_PAD_PTE6__GPIO_111                0x1181
> +                       /* GPO */
> +                       VF610_PAD_PTE0__GPIO_105                0x1183
> +                       VF610_PAD_PTE7__GPIO_112                0x1183
> +                       /* RS485 */
> +                       VF610_PAD_PTB8__GPIO_30         0x1183
> +                       VF610_PAD_PTB9__GPIO_31         0x1183
> +                       VF610_PAD_PTE8__GPIO_113                0x1183
> +                       /* MPBUS MPB_EN */
> +                       VF610_PAD_PTE28__GPIO_133               0x1183
> +                       /* LEDS */
> +                       VF610_PAD_PTE15__GPIO_120               0x1183
> +                       VF610_PAD_PTA12__GPIO_5         0x1183
> +                       VF610_PAD_PTA16__GPIO_6         0x1183
> +                       VF610_PAD_PTE9__GPIO_114                0x1183
> +                       VF610_PAD_PTE20__GPIO_125               0x1183
> +                       VF610_PAD_PTE23__GPIO_128               0x1183
> +                       VF610_PAD_PTE16__GPIO_121               0x1183
> +                       /* MISC */
> +                       VF610_PAD_PTE10__GPIO_115               0x1183
> +                       VF610_PAD_PTE11__GPIO_116               0x1183
> +                       VF610_PAD_PTE17__GPIO_122               0x1183
> +                       VF610_PAD_PTC30__GPIO_103               0x1183
> +                       VF610_PAD_PTB0__GPIO_22         0x1181
> +                       /* RESETINFO */
> +                       VF610_PAD_PTE26__GPIO_131               0x1183
> +                       VF610_PAD_PTD6__GPIO_85         0x1181
> +                       VF610_PAD_PTE27__GPIO_132               0x1181
> +                       VF610_PAD_PTE13__GPIO_118               0x1181
> +                       VF610_PAD_PTE21__GPIO_126               0x1181
> +                       VF610_PAD_PTE22__GPIO_127               0x1181
> +                       /* EE_5V_EN */
> +                       VF610_PAD_PTE18__GPIO_123               0x1183
> +                       /* EE_5V_OC_N */
> +                       VF610_PAD_PTE25__GPIO_130               0x1181

Seems like a long list of pins without any driver associated.

Please review such list carefully and assign to nodes that have a
driver associated, such as rs485,LEDS, etc.

> +
> +&usbphy0 {
> +       status = "okay";
> +};
> +
> +&usbphy1 {
> +       status = "okay";
> +};
> +
> +&qspi0 {

This is not placed in alphabetical order.
