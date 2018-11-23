Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B71EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7D320820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEQib+A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7D320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408068AbeKWO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 09:57:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38180 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbeKWO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 09:57:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so2508559pgc.5;
        Thu, 22 Nov 2018 20:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4k09qdtFyiTTYunnTUnCvaYW+UWFZWyol9195V5NaA=;
        b=vEQib+A9Ysg/4QH8s4qWxNHE/FtKEBn/G67m0svNSOeH0VObB2I2kfFB3sWmYQXpWl
         xq2kCSUgsjA+3SQfJyrFTnJrZq2R9NbmR+eYTw2GShzJTYSqire4oOl9FDs9dybr6ZbB
         7rQ2rl8gkDOzu28XvBn6dBMb0TY6h8vz9j6mJnDYIi3v/GmtpDnLF1BexuiyCdwk1blb
         HiN3Z+pHaglbWsqY2AY28NoEXZwrdfAErLmfpwHs0oX7eOrCz/Ox27vGfKgYdH+C9Gl/
         iwZGb5I/FmHuFjj48c2zjO/d54G6sZkOVXISqQqub2BsOkMWf3j4BrVYcRvY6LKeTVZM
         ICfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4k09qdtFyiTTYunnTUnCvaYW+UWFZWyol9195V5NaA=;
        b=fEIKuPMThqksPqZP5qtpK8Flxma+L6cspuuNnWXTYiUX7E8uOxemLXjO91RC5YgR3W
         FWabMoHpSPepiLbuGMlvaU6TXxVx7KP3lrkgNQI9JHT6oKCGP/ZFLl8DCH05pWkx1R30
         5MKyMW9/OqG64bMIMwsiGoa7PT/+l4eKGmQoTCTc2U78Doln9eDtbvCbmn3Lk33TkOwV
         /1O1vxL+ooHnfDdXftu2m3k/8AAlW4iO65oGMJDzu0XVUKE4UN+0u2sOWnfPMhkd+8R5
         GafaN40ZacMuyed9yyZGnsXg9iavFR7mjRKamuIcrJpeYAd/NJVt6VVJ/Bd4uws53ugR
         sIVg==
X-Gm-Message-State: AA+aEWaN1QWFNxUJ78cKbE+7ihGw+/Miwmhkjm4dpOPAIY3wigmLERIG
        HyBYad+nCK2vBVkZDqkFFLVIPSYS
X-Google-Smtp-Source: AFSGD/Xa3vmayaL4wdY1FctLBH80jC3ZI4/6wFg170DIPlaWx/iM59Vs3s6hUKEFErfXx6ZLuBBdrw==
X-Received: by 2002:a63:604f:: with SMTP id u76mr9484467pgb.401.1542946503600;
        Thu, 22 Nov 2018 20:15:03 -0800 (PST)
Received: from anarsoul-thinkpad.localnet (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id r8sm52349337pgr.48.2018.11.22.20.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 20:15:03 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 8/8] arm64: dts: allwinner: a64: enable sound on Pinebook
Date:   Thu, 22 Nov 2018 20:15:02 -0800
Message-ID: <4447541.czlqnMh8c9@anarsoul-thinkpad>
In-Reply-To: <20181122102325.29495-9-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org> <20181122102325.29495-9-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 22, 2018 2:23:25 AM PST Chen-Yu Tsai wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> The Pinebook has a headphone jack tied to the HP headphone output of
> the SoC, and internal speakers connected to the LINEOUT of the SoC,
> through a standalone amplifier.
> 
> This commit enables I2S, digital and analog parts of audio codec on
> Pinebook, along with a device node for the external amplifier.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> [wens@csie.org: dropped headphone_amp; added headphone amp regulator supply;
> fixed speaker_amp node name and sound-name-prefix name]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts index
> ec537c529726..b6d0b926a2ff 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -74,6 +74,32 @@
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
> +
> +	speaker_amp: audio-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		/*
> +		 * TODO This is actually a fixed regulator controlled by
> +		 * the GPIO line on the PMIC. This should be corrected
> +		 * once GPIO support is added for this PMIC.
> +		 */
> +		VCC-supply = <&reg_ldo_io0>;
> +		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +		sound-name-prefix = "Speaker Amp";
> +	};
> +
> +};
> +
> +&codec {
> +	hpvcc-supply = <&reg_eldo1>;

It should be a property of codec_analog, not codec

> +	status = "okay";
> +};
> +
> +&codec_analog {
> +	status = "okay";
> +};
> +
> +&dai {
> +	status = "okay";
>  };
> 
>  &ehci0 {
> @@ -277,6 +303,29 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&sound {
> +	status = "okay";
> +	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> +	simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +				    "Microphone", "Internal Microphone Right",
> +				    "Headphone", "Headphone Jack",
> +				    "Speaker", "Internal Speaker";
> +	simple-audio-card,routing =
> +			"Left DAC", "AIF1 Slot 0 Left",
> +			"Right DAC", "AIF1 Slot 0 Right",
> +			"Speaker Amp INL", "LINEOUT",
> +			"Speaker Amp INR", "LINEOUT",
> +			"Internal Speaker", "Speaker Amp OUTL",
> +			"Internal Speaker", "Speaker Amp OUTR",
> +			"Headphone Jack", "HP",
> +			"AIF1 Slot 0 Left ADC", "Left ADC",
> +			"AIF1 Slot 0 Right ADC", "Right ADC",
> +			"Internal Microphone Left", "MBIAS",
> +			"MIC1", "Internal Microphone Left",
> +			"Internal Microphone Right", "HBIAS",
> +			"MIC2", "Internal Microphone Right";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;




