Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65938C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LhYxhcxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfAKNky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:40:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54375 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbfAKNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:40:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2426138wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rZvM6AGLXmUr5fPKn5eYC16tJhXhQxqc+a0po0UH4Wg=;
        b=LhYxhcxlB0EEHQ5dNSzGCQnyilJ9O78UnI82rqKrVdiT/rtCGn7QtRDS4SEKFsfGAP
         fOccq9NkqxWcIgHJsJwgwySejvsDDPq+M4YWMz6hv66CaovIwlNzvWZ5724h5bP446wK
         wb5qGZ+pHD25wy6JJ0I9hE6e9WV0ycpvRGAmjm68KDhecNBNTczs/jJsVYqYS6CS1wgf
         9jseUsX8eDZKUBA0N/df4sl32qjEj5vvgJhnN399Cu/v663RcgEPrPSmT1U6S9lQC+Cv
         +JiuCVF+O6h9aRbHhWQdiZC1YwzbNdYmZX6UH2F8TeMiwBxDDg4SKtAY+IiG/LIFdAdH
         ZdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rZvM6AGLXmUr5fPKn5eYC16tJhXhQxqc+a0po0UH4Wg=;
        b=GMYS9l+eqZe9JYzlMlzXIvHRTaS8pDH3j/ZvlFGRrYEEqJPRdZ5n+S5Xwi8lIGidxu
         ahop194h9C7OH5WM20SGD2qRHpTJVJcThhkATilPBztVtvpu3MvIJN1XlqrQbISPSo6y
         4RS3iSc08Wgb2RAby0ttGVYmYSAvZn3pjdx2WzZ6HxUA8vWLYqr+nmVdmllc8ecAYnI2
         K2V20sLplyfyOI9iXsofzn6mHU9Av0HmH+sCD4sK1dKuAsJs9acVWhFbNJWBEvTnYRFr
         h23vK2oB3VOtWhrUyOLnufGtgnmXtyYZpAp47skuzwRToGe6XZwxK5wX9mJPc7RocKOf
         7HJA==
X-Gm-Message-State: AJcUukdBXUgTHOqRMoHAp4gGZ8RGfucpRiHWudCah9ggaL0hEi6FHwJ2
        gCw3GBJ1rD1rWJBsoExaIhpSUA==
X-Google-Smtp-Source: ALg8bN6df0mMuC1VxzZFFQ4hCtQI4gb19CCTq5ZYvDxsD4pUhe1FBYXhBxGLKZUROI0X/+YW5lIfbQ==
X-Received: by 2002:a1c:aad2:: with SMTP id t201mr2313044wme.148.1547214050715;
        Fri, 11 Jan 2019 05:40:50 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t5sm13254870wmg.43.2019.01.11.05.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 05:40:49 -0800 (PST)
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator
 warning
To:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190111092235.28161-1-linux.amoon@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com>
Date:   Fri, 11 Jan 2019 14:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111092235.28161-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 11/01/2019 10:22, Anand Moon wrote:
> Add missing vin-supply 5V regulator node on usb_phy nodes needed
> to power usb bus ports. Override the dr_mode from "host" to "peripheral"
> for initialization of dwc2 usb0 phy node,changes fix the below
> warning for usb initialization.

I would have switch the dr_mode to peripheral in another patch,
fix the regulator issue in this patch only.

Neil

> 
> [    1.203900] phy phy-c0000000.phy.0: USB ID detect failed!
> [    1.208048] phy phy-c0000000.phy.0: phy poweron failed --> -22
> [    1.213877] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> [    1.222953] Modules linked in:
> [    1.225976] CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.0.0-rc1-xc2ml #3
> [    1.232872] Hardware name: Hardkernel ODROID-C2 (DT)
> [    1.237794] Workqueue: events deferred_probe_work_func
> [    1.242878] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    1.247623] pc : _regulator_put.part.11+0xf0/0xf8
> [    1.252280] lr : regulator_put+0x34/0x48
> [    1.256159] sp : ffff00001176bb00
> [    1.259437] x29: ffff00001176bb00 x28: 0000000000000000
> [    1.264698] x27: ffff80007f31beb8 x26: ffff000010eeb7e0
> [    1.269959] x25: 0000000000000000 x24: 0000000000000009
> [    1.275220] x23: ffff00001176bbc8 x22: ffff80007ed9d500
> [    1.280482] x21: ffff0000111bd6c8 x20: ffff80007ed9d700
> [    1.285743] x19: ffff80007ed9d700 x18: 000000000000006f
> [    1.291004] x17: 0000000000000000 x16: 0000000000000000
> [    1.296265] x15: 0000000000000400 x14: 0000000000000400
> [    1.301527] x13: ff00000000000000 x12: ffffffffffffffff
> [    1.306788] x11: 0000000000000038 x10: 0000000000000040
> [    1.312049] x9 : ffff0000111d58b0 x8 : ffff0000111d58a8
> [    1.317310] x7 : ffff80007ed9db00 x6 : ffff80007ec21b00
> [    1.322571] x5 : ffff80007f400248 x4 : ffff80007fba9b00
> [    1.327833] x3 : ffff0000112d9eb8 x2 : ffff80007ec21b00
> [    1.333094] x1 : 0000000000000000 x0 : 0000000000000001
> [    1.338356] Call trace:
> [    1.340773]  _regulator_put.part.11+0xf0/0xf8
> [    1.345085]  regulator_put+0x34/0x48
> [    1.348621]  regulator_bulk_free+0x30/0x50
> [    1.352675]  devm_regulator_bulk_release+0x18/0x20
> [    1.357421]  release_nodes+0x1b0/0x220
> [    1.361127]  devres_release_all+0x34/0x50
> [    1.365094]  really_probe+0xec/0x290
> [    1.368630]  driver_probe_device+0x54/0xe8
> [    1.372684]  __device_attach_driver+0xb8/0xe8
> [    1.376997]  bus_for_each_drv+0x78/0xc8
> [    1.380792]  __device_attach+0xd4/0x130
> [    1.384587]  device_initial_probe+0x10/0x18
> [    1.388727]  bus_probe_device+0x90/0x98
> [    1.392522]  deferred_probe_work_func+0x6c/0xa0
> [    1.397010]  process_one_work+0x1e0/0x318
> [    1.400975]  worker_thread+0x228/0x428
> [    1.404684]  kthread+0x124/0x128
> [    1.407876]  ret_from_fork+0x10/0x18
> [    1.411410] ---[ end trace de5fd1b262c1f56a ]---
> [    1.416055] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> [    1.425123] Modules linked in:
> [    1.428144] CPU: 1 PID: 44 Comm: kworker/1:1 Tainted: G        W         5.0.0-rc1-xc2ml #3
> [    1.436422] Hardware name: Hardkernel ODROID-C2 (DT)
> [    1.441340] Workqueue: events deferred_probe_work_func
> 
> Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fix the following power issue with usb device
> 
> [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> 
> [alarm@archl-c2m ~]$ lsusb -t
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 2: Dev 5, If 3, Class=Audio, Driver=, 480M
>         |__ Port 2: Dev 5, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 2: Dev 5, If 2, Class=Audio, Driver=, 480M
>         |__ Port 2: Dev 5, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 0, Class=Vendor Specific Class, Driver=, 480M
> 
> Similar Fix is need for Odroid C1+ to power on the phy nodes
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 2e1cd5e3a246..b4e14ff614c4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -28,6 +28,13 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
>  
> +	p5v0: regulator-p5v0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "P5V0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
>  	usb_otg_pwr: regulator-usb-pwrs {
>  		compatible = "regulator-fixed";
>  
> @@ -36,6 +43,8 @@
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
>  
> +		vin-supply = <&p5v0>;
> +
>  		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> @@ -303,6 +312,7 @@
>  
>  &usb0 {
>  	status = "okay";
> +	dr_mode = "peripheral";
>  };
>  
>  &usb1 {
> 

