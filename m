Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A5DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3019920869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJGGPRg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3019920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJRXTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:19:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbeJRXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:19:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id d23-v6so1027881pls.11;
        Thu, 18 Oct 2018 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMGvyeeniSDVR9+QNXwjukJas0L2n5ZiWm7WS/f5lRo=;
        b=oJGGPRg9GqNdDYDchc9OcHsfjZ4i3AhhrZUMfTyHErb+D31dko1pcvlkfl85qWf8Hx
         /HiRMJufPsFar+pW092BlXumaQNfWJp5ucCZrRWXLJk0SgykTDho27hawE2rhwOtIzGy
         /jJ9FYMUQIsph25yqiyhk5IUF1t0gWcNWKkb+gOxdrMECJCJAKgsDbDFJ/0Xwis2DyvR
         4Z4MrSi96q75OljUhTr+cSkcyucYzIMLM6tf9oNmDP1rZaaPe7yF1Z2ydukcbwm+VGuK
         oDJtpE7xfIXDTpntkArP7aHZzBxVy4zc4D6hPKw7l7FJYQDr6Jk4q8GbmGx9DgbtpU+p
         0kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMGvyeeniSDVR9+QNXwjukJas0L2n5ZiWm7WS/f5lRo=;
        b=ukWrwEmAzJb/6VBl6lJN/De8ertHNaaj0CHmhqHjjo7F+LKYf6DU/dGZQ3S0fVJ6OG
         d2fVwfPQ3REnJuKvZFlVoTEs9Y1bForAooN5dfVWgK3KKcPHep5gPxIkITAw/nbMkj0b
         TpT/Fma2CX1MPwB7ma5fmzCivvkpEILRTm/7votv3IZyi5H5IVyMEYBN0+pLVHaxq2dF
         FLHsYqfSOI1rHydmKc3EKNdIih0ZIJRtbpEv90c2W5DK/ahOByQHPUhJxxYnN/UG+vu9
         JWg4wylYbvKrps2I19O0QQ7ViH5Pi7+g8V0XsM78spsRACO5a6HB71JoKwH+mJyM8Jbz
         lHLA==
X-Gm-Message-State: ABuFfojQvOSKQQb0TKVvV4oBz11JMLu2bege7TDDSRTv0qwlE1Rq67j0
        jnO9DuvJjFHMKkMjbz09jXg=
X-Google-Smtp-Source: ACcGV61ouhQC1OOiHfggjksFCL12l5j00tb7Osc8/fKNxDFUyiJJNywzZUwwDHi4Y4GThphvYz0Tvw==
X-Received: by 2002:a17:902:b58c:: with SMTP id a12-v6mr29568134pls.226.1539875856808;
        Thu, 18 Oct 2018 08:17:36 -0700 (PDT)
Received: from anarsoul-thinkpad.localnet (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id f1-v6sm31391740pgc.4.2018.10.18.08.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 08:17:36 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Icenowy Zheng <icenowy@aosc.io>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 7/9] arm64: allwinner: a64: enable ANX6345 bridge on Pinebook
Date:   Thu, 18 Oct 2018 08:17:35 -0700
Message-ID: <10486569.ZhsSaQbvn5@anarsoul-thinkpad>
In-Reply-To: <20181018073327.64942-8-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io> <20181018073327.64942-8-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Thursday, October 18, 2018 12:33:25 AM PDT Icenowy Zheng wrote:
> Pinebook has an ANX6345 bridge connected to the RGB666 LCD output, and
> the I2C controlling signals are connected to R_I2C bus.
> 
> Enable it in the device tree, and add a usable EDID from the panel's
> datasheet (at least 14" Pinebook used a panel without EDID).

There's no EDID in dts and 14" Pinebook uses a panel with EDID. Is it leftover 
of old comment?

Regards,
Vasily

> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts index
> 77fac84797e9..d7c14d0d61f9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -66,6 +66,10 @@
>  	};
>  };
> 
> +&de {
> +	status = "okay";
> +};
> +
>  &ehci0 {
>  	phys = <&usbphy 0>;
>  	phy-names = "usb";
> @@ -76,6 +80,10 @@
>  	status = "okay";
>  };
> 
> +&mixer0 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -127,6 +135,27 @@
>  	status = "okay";
>  };
> 
> +&r_i2c {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&r_i2c_pins_a>;
> +	status = "okay";
> +
> +	anx6345: anx6345@38 {
> +		compatible = "analogix,anx6345";
> +		reg = <0x38>;
> +		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +		panel-supply = <&reg_dc1sw>;
> +		dvdd25-supply = <&reg_dldo2>;
> +		dvdd12-supply = <&reg_fldo1>;
> +
> +		port {
> +			anx6345_in: endpoint {
> +				remote-endpoint = <&tcon0_out_anx6345>;
> +			};
> +		};
> +	};
> +};
> +
>  &r_rsb {
>  	status = "okay";
> 
> @@ -267,6 +296,20 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&tcon0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcd_rgb666_pins>;
> +
> +	status = "okay";
> +};
> +
> +&tcon0_out {
> +	tcon0_out_anx6345: endpoint@0 {
> +		reg = <0>;
> +		remote-endpoint = <&anx6345_in>;
> +	};
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;




