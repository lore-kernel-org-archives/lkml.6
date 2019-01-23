Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F64C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9181A2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MkFYpkYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfAWQuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:50:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfAWQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:50:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so47031wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MsjGYbxSdxohzPgNJOgdJcG5Xj2r796U0cFued0EXik=;
        b=MkFYpkYcy4oZXYly9/PLBg0jVdJIwt2EkEgfCCBs4OgSLnZ1m7i0I/Re8efOfK1XBu
         KDs6M2KBa8KkT9/n0UFf85qJBXTgKnwAnJsoJf6TlN7pKUN+PXqTg4wvcwJKoM6PgIKO
         o0jyfroMpUlrGomUOztBa2EkmPO8f7JS9W1FpNSKFTskZrv2K0+0eBX7nRxk49zwf+aJ
         6RAJbpXuwCu6e6LECVBVvJUvVsCUivaVlhqev87+Og09ADRjZHacvR+D/eBHcbXd4BOK
         Tx498HcF/WhITEgMKO8Rvnxr92jSYcFdniqPXZhfBRqyBaW19LmSbqh5aLLZQcWzIb6r
         xRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MsjGYbxSdxohzPgNJOgdJcG5Xj2r796U0cFued0EXik=;
        b=G6i9+YZ/4uLCggtByznHcJlOlxA9kTWGeV7GXwlsykMxsPVQlzbWT/E/WeSQii2gyg
         KnmGKd9BP5xJLPMaAGAmcDhGNWPcYNwer5gC59KtvGUlSCiUPDin4RPfcDR73ZnFcB1P
         lAqSA46O5u6TP2cJ6MPXE+at6xUV3MS6eiatlJORmxbb8Tn6PF56opfaf19O4lR5x3wL
         GAEKPI5n7JLLPaX+tQvDH1kuKlJiMr7J/wXFdvzSAywkI2frO8/diQ1zNh1x3ldSjHH+
         1TkKu9HkNLq4tu5dZuhDxZm3F1PrJjVH5sTQv/G20VfLueHVJ3jCeqDTLWz/aO6lI2MF
         fWPA==
X-Gm-Message-State: AJcUukdu9DPKCYb7iUA+bkYVTz69aNOc2BXk9ebNSincyRJ59S7s4ytd
        +JFV/bIAVE/1hJtWyuB5Z+EQZA==
X-Google-Smtp-Source: ALg8bN76rDDh7Px17wGR3jvzg2ppwIBh0L0vXaAN8wCsbgjUfITkZQkDQLkP35IkeNSZGCxoQNH0vg==
X-Received: by 2002:a1c:43:: with SMTP id 64mr3612223wma.72.1548262201461;
        Wed, 23 Jan 2019 08:50:01 -0800 (PST)
Received: from localhost (aputeaux-684-1-20-21.w90-86.abo.wanadoo.fr. [90.86.223.21])
        by smtp.googlemail.com with ESMTPSA id w80sm82727567wme.38.2019.01.23.08.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 08:50:00 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
In-Reply-To: <20190113181808.5768-1-linux.amoon@gmail.com>
References: <20190113181808.5768-1-linux.amoon@gmail.com>
Date:   Wed, 23 Jan 2019 08:49:59 -0800
Message-ID: <7hef93mi88.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand Moon <linux.amoon@gmail.com> writes:

> Add missing vbus-supply link to phy controller for usb_phy0
> and usb_phy1 nodes, this changes fixed the power issue
> on usb ports usb, changes help fix usb reset warning.
>
> [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch

As requested, dropping this series from the fixes branch pending further
debug and testing.

Kevin

> [alarm@archl-c1t ~]$ lsusb -t
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> [alarm@archl-c1t ~]$
> [alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
> Couldn't open device, some information will be missing
> Bus 001 Device 003: ID 1b71:0056 Fushicai
>     MaxPower              500mA
> Couldn't open device, some information will be missing
> Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
>     MaxPower               30mA
> Couldn't open device, some information will be missing
> Couldn't open device, some information will be missing
> Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
>     MaxPower              100mA
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     MaxPower                0mA
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 0f0a46ddf3ff..a49a8509b288 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -83,6 +83,19 @@
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> +	usb_vbus: regulator-usb-vbus {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "USB_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		vin-supply = <&p5v0>;
> +
> +		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	tflash_vdd: regulator-tflash_vdd {
>  		/*
>  		 * signal name from schematics: TFLASH_VDD_EN
> @@ -293,8 +306,18 @@
>  	pinctrl-names = "default";
>  };
>  
> +&usb0_phy {
> +	status = "okay";
> +	vbus-supply = <&usb_vbus>;
> +};
> +
>  &usb1_phy {
>  	status = "okay";
> +	vbus-supply = <&usb_vbus>;
> +};
> +
> +&usb0 {
> +	status = "okay";
>  };
>  
>  &usb1 {
> -- 
> 2.20.1
