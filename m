Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E57C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F1E2675E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PiWw//0g";
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="rma2LdSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F1E2675E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeF0HRm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:17:42 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:59913 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932090AbeF0HRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:17:41 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 03:17:40 EDT
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 353765107B3F;
        Wed, 27 Jun 2018 10:11:58 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id diPrHM236e-BtZK6625;
        Wed, 27 Jun 2018 10:11:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1530083518;
        bh=zmDunjUWOoOsyDE9CPEopUfvjw+pUOA2UI7Dy1TVPwM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=PiWw//0guh6CDH4vDSovuBjf7YEraG9vK74BgmKPrcA66Q2q2JpdIZ2cbNUDl6XDh
         d103sZ/sG7c+TTw93uv5fWj2txfBRb7SebJCons75qCsW/fQCHwwgzsz+I60Pv+uZ5
         keC6i00osPsdkQjDSGyVgpwMxPFzflnEq8fQ2rGI=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id e4V0jpXYoG-BhcefBwp;
        Wed, 27 Jun 2018 10:11:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1530083507;
        bh=zmDunjUWOoOsyDE9CPEopUfvjw+pUOA2UI7Dy1TVPwM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=rma2LdSUATHrpYbcRoBlxFCxDgC2h9OJlh9I6yKXXLfoTmMLIMOBUnb3GfR9D1JNW
         UyKocbbwth39yHPa24L2xH0OXysp2F0tRJfRH/wAv9Zi2DjFKtwlJd4NIx3bMRtPno
         qkrX3ne/ieaaNV5vb/VYU/luiKcYCAetdi9YdKdo=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@yandex.ru
Subject: Re: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, cphealy@gmail.com,
        andrew.smirnov@gmail.com, l.stach@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
From:   Nikita Yushchenko <nikita.yoush@yandex.ru>
Message-ID: <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
Date:   Wed, 27 Jun 2018 10:11:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	i2c_gpio: i2c-gpio {
> +		compatible = "i2c-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_swi2c>;
> +		i2c-gpio,delay-us = <50>;
> +		status = "okay";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};

You add i2c-gpio node to dtsi file without defining gpios, with reference
to pinctrl not defined inside your dtsi file or it's includes, and without
any usage inside dtsi file.

Saving several text lines that way is a bad idea. Please move it to where
it is fully defined and used.

> +&usb_vbus {
> +	regulator-always-on;

usb_vbus is regilator-fixed, what for is this?

> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};

In your further patches you include this and then revert by marking &uart2 as
disabled. Better to enable it in dts for boards that have it.

Same with ecspi2, ipu and maybe more.

> -	flash@1 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "atmel,at45db642d", "atmel,at45", "atmel,dataflash";
> -		spi-max-frequency = <25000000>;
> -		reg = <1>;
> -	};

> +	flash@1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "atmel,at45", "atmel,dataflash";
> +		spi-max-frequency = <25000000>;
> +		reg = <1>;
> +	};

Lost a compatible key?

> -			sysled0@3 {
> -				reg = <3>;
> -				label = "system:green:status";
> -				linux,default-trigger = "default-on";
> -			};

> +			sysled3: led3@3 {
> +				reg = <3>;
> +				label = "system:red:power";
> +				linux,default-trigger = "default-on";
> +			};

> +&sysled3 {
> +	label = "system:green:status";
 
What for this label games?
Maybe just define things for boards that use it?

