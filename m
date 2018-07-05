Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8097C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3072406E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3072406E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeGEXcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:32:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42254 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeGEXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:32:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so20087848oib.9;
        Thu, 05 Jul 2018 16:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxpSkUTtNJ5FwVEIkeCYW8irymcF+zjObZMI2ZLb+o8=;
        b=CULMtqpEm+1EdChJryrTcDTALypRYX6uov6kIb4By3qxDO/YYVVHzvHSTRJ8tyeZbg
         C855AFPs9W/9/QzFka0z7qANlNA8DbI67o22lMxncqnjHbEwWPuIzicnXIaoY1zW0p0b
         XuaKJTAkmpHhRUXGDTGt4AIY6wJ86af7CVApUbIvcogGGQLrM4P8ZUyXIMFDXNTNLJqF
         4GhgCwtUMkNrcmFUWpLqiad/3dNVUWJ1s8CH/9RjmWPOskOHTDGm5QVm/vYJtJg9lhDo
         jfDjuOtmrDyoD2WAIkyArEtDcDHbZAePTgWSca+Kil5rvS0jezQikV9ZPOaSta0M2pzt
         TtXA==
X-Gm-Message-State: APt69E1DRlNwtsZ1smGBkEaPIVJABVGfmTomUM+Hn1xAqOJNCG6m/dTv
        p3xJnFw2FejpvlfZ12QkPKCe+54=
X-Google-Smtp-Source: AAOMgpdaja/PmsjdYSeODQrlMspJrbYKRYBWWJXbPMcIXcfasrs86aquxEOoiBX/AI/zwYo3FofCzg==
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr9475507oix.74.1530833567356;
        Thu, 05 Jul 2018 16:32:47 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id a74-v6sm6106447oih.14.2018.07.05.16.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:32:46 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:32:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
Subject: Re: [PATCH v3 1/4] dt-bindings: w1: document generic onewire and
 DS2760 bindings
Message-ID: <20180705233245.GA16422@rob-hp-laptop>
References: <20180704044411.2693-1-daniel@zonque.org>
 <20180704044411.2693-2-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704044411.2693-2-daniel@zonque.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 06:44:08AM +0200, Daniel Mack wrote:
> This patch adds a generic w1 bindings document that merely describes how
> slave deviceses are grouped under master nodes. It also adds a specific
> binding for the ds2760 battery monitor.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../bindings/power/supply/maxim,ds2760.txt    | 29 +++++++++++++++++++

This has grown enough now, you should probably make it a separate 
patch.

>  .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++--
>  Documentation/devicetree/bindings/w1/w1.txt   | 25 ++++++++++++++++
>  3 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
>  create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
> new file mode 100644
> index 000000000000..a39d1ada48f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
> @@ -0,0 +1,29 @@
> +Devicetree bindings for Maxim DS2760
> +====================================
> +
> +The ds2760 is a w1 slave device and must hence have its sub-node in DT
> +under a w1 bus master node.
> +
> +The device exposes a power supply, so the details described in
> +Documentation/devicetree/bindings/power/supply/power_supply.txt apply.
> +
> +Required properties:
> +- compatible: must be "maxim,ds2760"
> +
> +Optional properties:
> +- power-supplies:	Refers to one or more power supplies connected to
> +			this battery.
> +- maxim,pmod-enabled:	This boolean property enables the DS2760 to enter
> +			sleep mode when the DQ line goes low for greater
> +			than 2 seconds and leave sleep Mode when the DQ
> +			line goes high.
> +- maxim,cache-time:	Time im milliseconds to cache the data for. When

Add unit suffix as defined in property-units.txt.

> +			this time expires, the values are read again from
> +			the hardware. Defaults to 1000.
> +- maxim,rated-capacity:	The rated capacity of the battery, in mAh.

Seems like this should be common.

> +			If not specified, the value stored in the
> +			non-volatile chip memory is used.
> +- maxim,current-accumulator:
> +			The current accumulator value in mAh.
> +			If not specified, the value stored in the
> +			non-volatile chip memory is used.

This would be updated periodically while running and then restored after 
a power cycle or reboot to maintain the battery level across power 
cycle? I don't think that belongs in DT as we don't really define 
whether a DT can be updated persistently.
 
> diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> index 6e09c35d9f1a..3d6554eac240 100644
> --- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
> +++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> @@ -13,10 +13,15 @@ Optional properties:
>   - linux,open-drain: if specified, the data pin is considered in
>  		     open-drain mode.
>  
> +Also refer to the generic w1.txt document.
> +
>  Examples:
>  
> -	onewire@0 {
> +	onewire {
>  		compatible = "w1-gpio";
> -		gpios = <&gpio 126 0>, <&gpio 105 0>;
> -	};
> +		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
>  
> +		battery {
> +			// ...
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
> new file mode 100644
> index 000000000000..bee18f7070ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/w1.txt
> @@ -0,0 +1,25 @@
> +Generic devicetree bindings for onewire (w1) busses
> +===================================================
> +
> +Onewire busses are described through nodes of their master bus controller.
> +Slave devices are listed as sub-nodes of such master devices. For now, only
> +one slave is allowed per bus master.
> +
> +
> +Example:
> +
> +	charger: charger {
> +		compatible = "gpio-charger";
> +		charger-type = "mains";
> +		gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	onewire@0 {

Drop the unit-address.

> +		compatible = "w1-gpio";
> +		gpios = <&gpio 100 0>, <&gpio 101 0>;
> +
> +		battery {
> +			compatible = "maxim,ds2760";
> +			power-supplies = <&charger>;
> +		};
> +	};
> -- 
> 2.17.1
> 
