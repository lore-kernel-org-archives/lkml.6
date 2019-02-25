Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551112903;
	bh=8lfru9+P4ixO0alUZNLhBYm7PQxkDCD/rbkxw0B8KsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yl2jrYXiM5b/dGrmxXg1nphCi9WHarn8JICVypnRDsaJgIrKykN0+uBNjwSySOR0H
	 nie/r8X27qYQoGuEPVip0aWUsgN4BBh65e9AZlsKYkIQ55igST5mUgqSwC1xsO0UUh
	 ni57JZDkSIa9lZt9SOpOhpvAg2GVq0cu87ijE8tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfBYQll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:41:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35297 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfBYQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:41:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so8417578otm.2;
        Mon, 25 Feb 2019 08:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JrGhBqPCMyc1oEbLSssbJ9lzWX8nPvhEwCX90aVGl6s=;
        b=kiCYy7nTcYWIcQs4MJEQ2kf1vPYAoggDM9NrJHM77lqa7V7jdz7pHq3jVPgId6RI+C
         ym8jKs5d0OOFDLxUJwzVmBzE/E5NR0nl+HfX8UZgGaAbCZFEeELZ4Rul36Zbiu7rmMK2
         1UCBvQW2s2tu+gA7XVIBFlW5ywfJ8DdoQvt4kGfuUNc0iLZTug4ImXdSMSvJSLMGvJd9
         lXKMUIdKOkH0mkQRjMRytRKNykfT8cwqtbMIPFq+qwJIpXHaLJ+AuEg/YdG1P9HLogdc
         chqQxosqGOiD72upQcYw+OgcaAzTcZurFC8A4df4RdvnsEe53OX5SRBw1HIH43x0bmuJ
         VZyg==
X-Gm-Message-State: AHQUAuZTSiEN2MIA5uDmvPEg7mWjVvwmAIx+lErSLoT6/bvcnFaJHzLp
        llZoZWaQ4k/0k2GqvO2lUw==
X-Google-Smtp-Source: AHgI3IYauMJdnKOJYGxjapt79ke2z0eId/XO7/vtEhlfguj/hxRZ+K3JQSI4PBwex5Iy2/LOoLMnvw==
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr6917825otf.124.1551112900391;
        Mon, 25 Feb 2019 08:41:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm4348351otb.54.2019.02.25.08.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:41:39 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:41:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: phy: Add bindings for the SMSC USB333x
 ULPI USB PHY
Message-ID: <20190225164139.GA10291@bogus>
References: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
 <20190130155023.4495-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130155023.4495-2-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:50:21PM +0100, Paul Kocialkowski wrote:
> Introduce the device-tree bindings for this ULPI USB PHY.
> Optional bindings that are not prefixed with the vendor may be
> relevant to other ULPI USB PHYs since they match generic ULPI
> registers.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/phy/smsc-usb333x.txt  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/smsc-usb333x.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/smsc-usb333x.txt b/Documentation/devicetree/bindings/phy/smsc-usb333x.txt
> new file mode 100644
> index 000000000000..50d500d67b2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/smsc-usb333x.txt
> @@ -0,0 +1,50 @@
> +Device tree bindings for SMSC USB333x ULPI USB PHY
> +
> +Required properties:
> +- compatible: Should be "smsc,usb333x".
> +
> +Optional properties:
> +- reset-gpios: GPIO to reset the PHY.
> +- clocks: Reference clock that feeds the PHY's PLL.
> +- clock-names: Should be "refclk" for the reference clock.

> +- extvbus-passthru: Enable EXTVBUS signal pass-through to assert the VbusValid
> +  signal internally. This is useful when no VBUS line is connected to the PHY.
> +- auto-resume: Enable automatic transmission resume (in host mode).
> +- chrg-vbus: Enable internal VBUS pull-up to 3.3 V during OTG SRP.
> +- dischrg-vbus: Enable internal VBUS pull-down during OTG SRP.
> +- id-pull-up: Enable internal ID pull-up tp 3.3 V.

These all need smsc prefix.

> +- smsc,varisense: Squelch detector threshold register field value, as described
> +  in the datasheet.
> +- smsc,phyboost: Output voltage change register field value, as described in the
> +  datasheet.

Please give a range of values at least so we can write constraints.

> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> +Refer to usb/ulpi.txt for the parent ULPI bus binding required for this PHY.
> +
> +Example:
> +
> +&usb0 {
> +	compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
> +	clocks = <&clkc 28>;
> +	interrupt-parent = <&intc>;
> +	interrupts = <0 21 4>;
> +	reg = <0xe0002000 0x1000>;
> +	dr_mode = "peripheral";
> +	phys = <&usb_phy0>;
> +	phy-names = "usb-phy";
> +	phy_type = "ulpi";
> +
> +	ulpi {
> +		usb_phy0: usb-phy0 {
> +			#phy-cells = <0>;
> +			compatible = "smsc,usb333x";
> +			reset-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +			clocks = <&usb_phy_clk>;
> +			clock-names = "refclk";
> +			smsc,varisense = <1>;
> +			smsc,phyboost = <5>;
> +			extvbus-passthru;
> +			chrg-vbus;
> +		};
> +	};
> +};
> -- 
> 2.20.1
> 
