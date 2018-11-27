Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A068AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9B020873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mxn0RFf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9B020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeK0RxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:53:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39236 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeK0RxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:53:14 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so296470itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3UADMeLM1DJU5/BwQNbOsMVRPkD1xWOmjiCs0TtELE=;
        b=mxn0RFf0wzVk7c6cq4kGXJbbmdVBT8hKf9rhRBM/2BLoMop9pBVeBlG6XMSIwO6P7+
         jnI2tzoLdPyRW2+w0ggVyrpZkc6gcdshzWoQaGxvGVl5wA38AIafu2tBourN+pVUCPDk
         A+Sn1omignGGD4OIgeL66QWu2YMAhzbSLLH2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3UADMeLM1DJU5/BwQNbOsMVRPkD1xWOmjiCs0TtELE=;
        b=iOGOx2SKVt8Ye1VcbCSXzNWBgoxRjXag6LVIOXI6Z+7w83bSWMNVoiDBLmJRjDWdsR
         kdcE7xdalSZNpXZA8mi3jxsq38BMWstrbt+mURBXmXtthFusGHd+rld59yNgLtjtKhoQ
         4rZZ6TWAP5ABr9y5oyPwiBgnVYbmWTQV6q6QBk0ZKdZDUr2B8HkIpakTmhkzG/My44MG
         k245WxdsIIeBwdU77hC8moabtDwPh0tf1buLwKeFPzBfr33tyo6LFKFhgixSWCEOjRpm
         bFSfL/tBABQNI17WzM0yZFAbqVcijwiojC4qb94shAl6t4+IFQQGPkg8BLFRqyYO4q1n
         XWEw==
X-Gm-Message-State: AA+aEWYLRSFspcpF5IkhmtIWrHouqsfr0XTFF6I5KB6vRRnc2H8thxdb
        PfNB1kmoLFbjBbmweDsdS2aOcY+cozDged1Xe3xhxg==
X-Google-Smtp-Source: AFSGD/X/ai6allvzBRGsf9bXIDaHd5MeuzlUxRKEmui4sAMOGKLlUVyhuwEYkLX5sLEz0cfsJLMWxQaq4POLRaj5Aos=
X-Received: by 2002:a24:5411:: with SMTP id t17mr903179ita.32.1543301781022;
 Mon, 26 Nov 2018 22:56:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <12093630fdd7d8b43ebcb0340691e0f2200e26c6.1542097288.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <12093630fdd7d8b43ebcb0340691e0f2200e26c6.1542097288.git-series.maxime.ripard@bootlin.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 27 Nov 2018 12:26:09 +0530
Message-ID: <CAMty3ZBO6B=vgduv5u28zC8P1DOm1TYGFAVjDtJOpU8dozrk=A@mail.gmail.com>
Subject: Re: [PATCH 5/5] DO NOT MERGE: ARM: dts: bananapi: Add Camera support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        laurent.pinchart@ideasonboard.com,
        linux-media <linux-media@vger.kernel.org>, a.hajda@samsung.com,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 1:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 98 +++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index 70dfc4ac0bb5..18dbff9f1ce9 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -54,6 +54,9 @@
>         compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
>
>         aliases {
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
>                 serial0 = &uart0;
>                 serial1 = &uart3;
>                 serial2 = &uart7;
> @@ -63,6 +66,41 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       reg_cam: cam {
> +               compatible = "regulator-fixed";
> +               regulator-name = "cam";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&reg_vcc5v0>;
> +               gpio = <&pio 7 16 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +        reg_cam_avdd: cam-avdd {
> +                compatible = "regulator-fixed";
> +                regulator-name = "cam500b-avdd";
> +                regulator-min-microvolt = <2800000>;
> +                regulator-max-microvolt = <2800000>;
> +                vin-supply = <&reg_cam>;
> +        };
> +
> +        reg_cam_dovdd: cam-dovdd {
> +                compatible = "regulator-fixed";
> +                regulator-name = "cam500b-dovdd";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +                vin-supply = <&reg_cam>;
> +        };
> +
> +        reg_cam_dvdd: cam-dvdd {
> +                compatible = "regulator-fixed";
> +                regulator-name = "cam500b-dvdd";
> +                regulator-min-microvolt = <1500000>;
> +                regulator-max-microvolt = <1500000>;
> +                vin-supply = <&reg_cam>;
> +        };
> +
>         hdmi-connector {
>                 compatible = "hdmi-connector";
>                 type = "a";
> @@ -120,6 +158,27 @@
>                 >;
>  };
>
> +&csi0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&csi0_pins_a>;
> +       status = "okay";
> +
> +       port {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               csi_from_ov5640: endpoint {
> +                        remote-endpoint = <&ov5640_to_csi>;
> +                        bus-width = <8>;
> +                        data-shift = <2>;
> +                        hsync-active = <1>; /* Active high */
> +                        vsync-active = <0>; /* Active low */
> +                        data-active = <1>;  /* Active high */
> +                        pclk-sample = <1>;  /* Rising */
> +                };
> +       };
> +};
> +
>  &de {
>         status = "okay";
>  };
> @@ -167,6 +226,39 @@
>         };
>  };
>
> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c1_pins_a>;
> +       status = "okay";
> +
> +       camera: camera@21 {
> +               compatible = "ovti,ov5640";
> +               reg = <0x21>;
> +                clocks = <&ccu CLK_CSI0>;
> +                clock-names = "xclk";
> +               assigned-clocks = <&ccu CLK_CSI0>;
> +               assigned-clock-rates = <24000000>;
> +
> +                reset-gpios = <&pio 7 14 GPIO_ACTIVE_LOW>;
> +                powerdown-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>;
> +                AVDD-supply = <&reg_cam_avdd>;
> +                DOVDD-supply = <&reg_cam_dovdd>;
> +                DVDD-supply = <&reg_cam_dvdd>;
> +
> +                port {
> +                        ov5640_to_csi: endpoint {
> +                                remote-endpoint = <&csi_from_ov5640>;
> +                                bus-width = <8>;
> +                                data-shift = <2>;
> +                                hsync-active = <1>; /* Active high */
> +                                vsync-active = <0>; /* Active low */
> +                                data-active = <1>;  /* Active high */
> +                                pclk-sample = <1>;  /* Rising */
> +                        };
> +                };
> +       };

Does ov5640 need any further patches, wrt linux-next? I'm trying to
test this on top of linux-next but the slave id seems not detecting.

[    2.304711] ov5640 1-0021: Linked as a consumer to regulator.5
[    2.310639] ov5640 1-0021: Linked as a consumer to regulator.6
[    2.316592] ov5640 1-0021: Linked as a consumer to regulator.4
[    2.351540] ov5640 1-0021: ov5640_init_slave_id: failed with -6
[    2.357543] ov5640 1-0021: Dropping the link to regulator.5
[    2.363224] ov5640 1-0021: Dropping the link to regulator.6
[    2.368829] ov5640 1-0021: Dropping the link to regulator.4

Here is the full log [1], please let me know if I miss anything, I
even tried to remove MCLK pin

[1] https://paste.ubuntu.com/p/yfy5cvs32x/
