Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05066C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B651320851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B651320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeLCKZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:25:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41580 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeLCKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:25:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so10220978edi.8;
        Mon, 03 Dec 2018 02:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCWM0usXHMZ510hOwcbi6aXdkoyepRwcwnMM+MoSlmM=;
        b=Gw8rkB6wBJUgcbWqJO4WNOYvZL+h2hvcb4ZvHsGWo8cCBFfiP/iuMNk5XvonQfApX9
         0OLUQSnrGOdA8a/sVEi+EjtxzBmb/eg+TkQFTCro1Zx28mmFpjM5pH1B1VyneAzEqL+E
         ZkZVS49035AjHLdl6t0F/wNjDk9OnFdLD1V+X7iQXgKRjBimZM40qApGQvJ+v9adVBjq
         y0J+6zUZBBnR08/MvwvsKyxbILPkp1vKwxU4/taNWIy8/uh5SFV2vssp5LFK36I3HZEs
         5tmy7m8w7tP1pYDuVnKjh6YWEv4i+7MJfQsw/q4nX91Gg8pFTD8s2P6gOv6m7KJvjcIW
         4Zkg==
X-Gm-Message-State: AA+aEWbGgMCF1E7mWCEGF6Wo+m6KP0nrjl2Qr9pq2EjY5FviMbW2GuSN
        mA6DPRn6amHa5IJRrLUc5utPiswe8Yc=
X-Google-Smtp-Source: AFSGD/WDNkYotvTioYL5tYNjMSwSe2EiSnS8lMZg9e+p2HkdojfTytg9Y0rVJReww+SHlEaGy7dwGQ==
X-Received: by 2002:a50:92bc:: with SMTP id k57mr14139644eda.73.1543832705354;
        Mon, 03 Dec 2018 02:25:05 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id gk8-v6sm2163134ejb.42.2018.12.03.02.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:25:04 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id 96so11549948wrb.2;
        Mon, 03 Dec 2018 02:25:04 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr13984973wrv.188.1543832704129;
 Mon, 03 Dec 2018 02:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20181203100747.16442-1-jagan@amarulasolutions.com> <20181203100747.16442-6-jagan@amarulasolutions.com>
In-Reply-To: <20181203100747.16442-6-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 18:24:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v6441wV7PM6q=vF2cpJtP9BGdYjQQqNU54rqELNJ5YcmdQ@mail.gmail.com>
Message-ID: <CAGb2v6441wV7PM6q=vF2cpJtP9BGdYjQQqNU54rqELNJ5YcmdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: a64-amarula-relic: Add OV5640
 camera node
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Amarula A64-Relic board by default bound with OV5640 camera,
> so add support for it with below pin information.
>
> - PE13, PE12 via i2c-gpio bitbanging
> - CLK_CSI_MCLK as external clock
> - PE1 as external clock pin muxing
> - DLDO3 as vcc-csi supply
> - DLDO3 as AVDD supply
> - ALDO1 as DOVDD supply
> - ELDO3 as DVDD supply
> - PE14 gpio for reset pin
> - PE15 gpio for powerdown pin
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../allwinner/sun50i-a64-amarula-relic.dts    | 54 +++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  5 ++
>  2 files changed, 59 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 6cb2b7f0c817..9ac6d773188b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -22,6 +22,41 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       i2c-csi {
> +               compatible = "i2c-gpio";
> +               sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +               scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

FYI our hardware doesn't do open drain.

> +               i2c-gpio,delay-us = <5>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ov5640: camera@3c {
> +                       compatible = "ovti,ov5640";
> +                       reg = <0x3c>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&csi_mclk_pin>;
> +                       clocks = <&ccu CLK_CSI_MCLK>;
> +                       clock-names = "xclk";
> +
> +                       AVDD-supply = <&reg_dldo3>;
> +                       DOVDD-supply = <&reg_aldo1>;

DOVDD is the supply for I/O. You say it is ALDO1 here.

> +                       DVDD-supply = <&reg_eldo3>;
> +                       reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
> +                       powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
> +
> +                       port {
> +                               ov5640_ep: endpoint {
> +                                       remote-endpoint = <&csi_ep>;
> +                                       bus-width = <8>;
> +                                       hsync-active = <1>; /* Active high */
> +                                       vsync-active = <0>; /* Active low */
> +                                       data-active = <1>;  /* Active high */
> +                                       pclk-sample = <1>;  /* Rising */
> +                               };
> +                       };
> +               };
> +       };
> +
>         wifi_pwrseq: wifi-pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 clocks = <&rtc 1>;
> @@ -30,6 +65,25 @@
>         };
>  };
>
> +&csi {
> +       vcc-csi-supply = <&reg_dldo3>;

But here you say the SoC-side pins are driven from DLDO3.

This is a somewhat odd mismatch.

Regardless, the ov5640 driver enables all three regulators at probe time.
Shouldn't that be enough to get the I2C bus working? The pin voltage
supply does not belong here.

> +       status = "okay";
> +
> +       port {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               csi_ep: endpoint {
> +                       remote-endpoint = <&ov5640_ep>;
> +                       bus-width = <8>;
> +                       hsync-active = <1>; /* Active high */
> +                       vsync-active = <0>; /* Active low */
> +                       data-active = <1>;  /* Active high */
> +                       pclk-sample = <1>;  /* Rising */
> +               };
> +       };
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index d32ff694ac5c..844bb44a78af 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -538,6 +538,11 @@
>                                 function = "csi0";
>                         };
>
> +                       csi_mclk_pin: csi-mclk {
> +                               pins = "PE1";
> +                               function = "csi0";
> +                       };
> +

This should be a separate patch.

ChenYu

>                         i2c0_pins: i2c0_pins {
>                                 pins = "PH0", "PH1";
>                                 function = "i2c0";
> --
> 2.18.0.321.gffc6fa0e3
>
