Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B7B2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550865074;
	bh=WxljANhfLq8F7v0pPNNFMM4P/8SIaOV42rh0IHbRD7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f/q8SFDAuAwGgSyS6q0vVHs8bAmU1FPo8tSOr4iZVVDSeaqOXIFiFf6w5z3/s0ZI5
	 VlCCHCETY3+Vwu/mofjYPv//3BhVIjJglmcZMAKBEtymFpQiSbGMMPkDphC9eiAcCQ
	 ZsfCLb/VWo/+xMz3OeSvCGpAMp9LkdDssr6SoBfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBVTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:51:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39038 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:51:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id b4so2655387oif.6;
        Fri, 22 Feb 2019 11:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TSFIG56rRaaFfYgbdNZzBbOmDSAD7TjsHwVZFadjdx4=;
        b=OvoD7nsXQGmwkPfdUEosayu/0JuSRu3L2UW6f4l9d6eCldGo3hvyJ9xUsKkeWLtnfb
         nl/c+L60+GOXJNjlWkgWquhfdobV3q3WblrgxCGdQZeBAiKOz3YSfNfUGn8DKGimA/Dy
         oX/Tsn8V/Snj6xVxqcPYv22aFJ31Usg5Go24adCbsJUqT0k/Qx0j5rnFnx7LH1U5zd2y
         jMIQdgMz9iiX1AkQMDQRiXtbRVZ4+GyF2IIxrZPkiRKBbLG1dK8SnSG4Z0wWBqOonUAM
         chKATPQZf4WzDbwX1h4/uItNFcmtR3tmo7byR4dUONKDvXeoFMxr/4JldwIt0NQTQ/2E
         9eSg==
X-Gm-Message-State: AHQUAub2e8gC3JsDNm1YfPACguAp8g3sHh4LlYb+uYZrKHMNM0TGiGo7
        Uozte+1lR6bvk1Vc4pjRB+pA9Jk=
X-Google-Smtp-Source: AHgI3Ib5QB9sUqWKJ4hxH0pZ5cJnnIE5sDA3QvAJ8WCHqErgBGesZ8rKJvh9AauGidqSxgvYiozCuQ==
X-Received: by 2002:aca:ed81:: with SMTP id l123mr3400240oih.139.1550865070695;
        Fri, 22 Feb 2019 11:51:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h67sm950667otb.36.2019.02.22.11.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:51:10 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:51:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: leds: Add binding for axp20x-led
 device driver
Message-ID: <20190222195109.GA17753@bogus>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-4-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215115013.11098-4-stefan@olimex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:50:08PM +0200, Stefan Mavrodiev wrote:
> This adds the devicetree bindings for charge led indicator found
> on most of X-Powers AXP20X PMICs.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
> new file mode 100644
> index 000000000000..5a83ad06796d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
> @@ -0,0 +1,74 @@
> +Device Tree Bindings for LED support on X-Powers PMIC
> +
> +Most of the X-Powers PMICs have integrated battery charger with LED indicator.
> +The output is open-drain, so the state is either high-Z or output-low. The
> +driver is a subnode of AXP20X MFD driver, since it uses shared bus with all
> +other cells.
> +The LED can be controlled either manually or automatically. Then in automatic
> +(controlled by the charger) there are two indication modes:
> +
> +Mode-A
> +======
> +- output-low:		Charging
> +- high-Z		Not charging
> +- 1Hz flashing:		Abnormal alarm
> +- 4Hz flashing		Overvoltage alarm
> +
> +Mode-B
> +======
> +- output-low:		Battery full
> +- high-Z		Not charging
> +- 1Hz flashing:		Charging
> +- 4Hz flashing		Overvoltage or abnormal alarm
> +
> +The control and the mode can be changed from sysfs.
> +
> +For AXP20X MFD bindings see:
> +Documentation/devicetree/bindings/mfd/axp20x.txt
> +
> +Required properties:
> +- compatible : Must be "x-powers,axp20x-led"
> +
> +Supported common LED properties, see ./common.txt for more informationn
> +- label : See Documentation/devicetree/bindings/leds/common.txt
> +- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
> +- default-state: See Documentation/devicetree/bindings/leds/common.txt
> +
> +Optional properties:
> +- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
> +			 If omitted, then the control is set to manual mode.
> +			 On invalid value, Mode-A is used.
> +
> +
> +Example:
> +
> +	axp803: pmic@3a3 {
> +		compatible = "x-powers,axp803";
> +
> +		...
> +
> +		led@0 {

What's the 0 for? A unit address without a reg property is not valid.

> +			compatible = "x-powers,axp20x-led";
> +			status = "okay";
> +
> +			label = "axp20x:yellow:chgled";
> +			linux,default-trigger = "timer";
> +			default-state = "on";
> +		};
> +	};
> +
> +or
> +
> +	axp803: pmic@3a3 {
> +		compatible = "x-powers,axp803";
> +
> +		...
> +
> +		led@0 {
> +			compatible = "x-powers,axp20x-led";
> +			status = "okay";
> +
> +			label = "axp20x:yellow:chgled";
> +			x-powers,charger-mode = <1>;
> +		};
> +	};
> -- 
> 2.17.1
> 
