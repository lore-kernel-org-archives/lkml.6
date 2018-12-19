Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005DFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE53F218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545239757;
	bh=NdofntJAOd0id56kjXOqeMCorcq0a0A7yrjTlG9aCTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sIT6cBXBdoToHwWGXsBI7+2fHC2zVicRgLn3Ba/Jbmn4tBxHLTrRn+P4zjzm0qeJf
	 7ai0arzE/t2cFdWqHgZBe5gLoPY7gb/KvTPmLjWAzVk9zdxxHFAQa8Gxp2a8FnqVEs
	 5nzFgSToXmIgqu5DKDc4KCMs3YPXbDp5uEcNjSBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeLSRP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:15:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41990 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLSRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:15:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so2203732oiw.9;
        Wed, 19 Dec 2018 09:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=38zg1ySHg8r8hcUFP3N/sjZMuc4d9iymHQ3Ww1VAzxA=;
        b=Rvb2x0f9wKVMI2p1cvu5T1xDJNmjJkQsA6PNiyn01Egh/hbN/Tdxtir1n/bdT2ZDzl
         PKPZSJ8Yw8ro34byZSeqbqVx00BTZ79Sok0tUlFGPNooSE5aSxXialYT4c6Av8gh3Nxb
         QFKVaH7hdZ0qAHdROQ8AOwzIfG2HjQOuyUm7Q5vYf+9r1NDr+SEWOkY6sTXOpPgL+inK
         t2wxzwZ2xd/aJj8wmi6moy3X9pstWTYVo0GxOaoMoPyAN17eRIv1pndl3i7toMpLUDGA
         iPQ6wneiT2oQUwbd/sIcu9LYsZ/0P8+N9VR+Ko6LL7iOSMv7sPJieNI+522Psb8gU8Jq
         Omiw==
X-Gm-Message-State: AA+aEWZ3AL62RI9QxjDmlE0+KjsqFUwccXg4puocPFamVj3rKT5nvvck
        S7OBk3ufvMe2cM8a0Hn0oQ==
X-Google-Smtp-Source: AFSGD/Wd26Y+hZF7YjKOSsbt9p1CcYMaWM/e2a6ibBbZgH85dtrxX4PJ7b81j/6XvFhh5Y43mBjP0Q==
X-Received: by 2002:aca:a86:: with SMTP id k6mr1665337oiy.334.1545239755156;
        Wed, 19 Dec 2018 09:15:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e128sm9125798oia.5.2018.12.19.09.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:15:54 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:15:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 7/9] dt-bindings: input: touchscreen: goodix: Add GT5663
 compatible
Message-ID: <20181219171553.GA4469@bogus>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203101547.16835-7-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:45:45PM +0530, Jagan Teki wrote:
> GT5663 is capacitive touch controller with customized smart wakeup gestures,
> the existing goodix driver will work by phandle vcc-supply regulator.
> 
> So, document compatible and example node for the same.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt           | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 604766e347ce..1898d3dde8e1 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
>  Required properties:
>  
>   - compatible		: Should be "goodix,gt1151"
> +				 or "goodix,gt5663"
>  				 or "goodix,gt911"
>  				 or "goodix,gt9110"
>  				 or "goodix,gt912"
> @@ -42,3 +43,15 @@ Example:
>  
>  		/* ... */
>  	};
> +
> +	touchscreen@5d {
> +		compatible = "goodix,gt5663";

Just a new compatible doesn't warrant a new example.

> +		reg = <0x5d>;
> +		vcc-supply = <&reg_ldo_io0>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
> +		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
> +		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +	};
> -- 
> 2.18.0.321.gffc6fa0e3
> 
