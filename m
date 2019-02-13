Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FEC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760C21872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550090919;
	bh=bXL7PCFw4D5soQn+lnlsB+ERPqWpmBOTIyfm86bEMns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ABXNnk0dQj9Frh/AH1eySsOgKcBN1qAc71ctAX8Abzd2TduHmYFPlqb35BA7/To0n
	 e66wn2X+WRmclTICpju37aSXssh0MGMTgqXTU+DBQEGyinVOTkE9UxB/VI1tLmjdEh
	 IYzr6ukGZ76UVg7caC7M50BnnQUUNXSJGu35DguU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbfBMUsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:48:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46212 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfBMUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:48:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so6633350otm.13;
        Wed, 13 Feb 2019 12:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=chAIdv9XRgSqkiZWL5ylS2lh5mtEFMhl0DpeAwJbBWc=;
        b=RWSJ1F58zFFf33RVCkAKg/yY1NUmws+cAum3JtPxIwAPj4BFvteFwlAFAjx9mqs+vR
         9PGDe5sTKwi+9BHlO8r92AF6+SvuHYgko1g4Hu/s8NqXrFBlPmBBukfrCWI+VzD6Nq8o
         zk75Ux5ZaEJmiY96M/qk4y83UjrcQmAjKXWMlJ2pTlobvmujNHV2QbCkNQzhXPvKhOjX
         UkHiULuc99q+5v5abAAOazOHTGoBmMHEdJtpiJzomylU7lJslJmATergSMiVS/pDm0Ru
         AJH+lQd5UvgdIPismreowjYzxJnarPIO90XchbtZcy0IPmPJzkBVs0eHSvzjhSVEHVVe
         by1g==
X-Gm-Message-State: AHQUAuZQgnDFw8PnMdrw6whqcecsVUTHHXdRrXA+ksGA9goyJaF2e3pn
        AviF22zlbcoXYp4zsJ5Wxw==
X-Google-Smtp-Source: AHgI3IZGONFOMkfw/Zx3fEeZPLkMkYco02FXCaGbkpJGrHHimzR3kqAka2sE0/g4O/fNUwaILP77pA==
X-Received: by 2002:aca:51cb:: with SMTP id f194mr78624oib.6.1550090915886;
        Wed, 13 Feb 2019 12:48:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a68sm155746oih.28.2019.02.13.12.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:48:34 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:48:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Message-ID: <20190213204834.GA31342@bogus>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:43:26PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the battery charger module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> new file mode 100644
> index 000000000000..16e24173c80e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,27 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- min-input-voltage:	Minimum CHGIN regulation voltage (in microvolts). Must be
> +			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
> +			4500000, 4600000, 4700000.
> +- current-limit:	CHGIN input current limit (in microamps). Must be one of:
> +			95000, 190000, 285000, 380000, 475000.

Unit suffix? Really, these should be common properties. We have 
some I think. Charger bindings are a mess though...

> +
> +Example:
> +--------
> +
> +	charger {
> +		compatible = "maxim,max77650-charger";
> +		maxim,vchgin-min = <4200000>;
> +		maxim,ichgin-lim = <285000>;

Doesn't match above.

> +	};
> -- 
> 2.20.1
> 
