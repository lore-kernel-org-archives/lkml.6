Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeEaD6L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:58:11 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39592 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbeEaD6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:58:08 -0400
X-Google-Smtp-Source: ADUXVKJW0GQ7HTspEvZPV8GU9Hcu14omNfssmWlBAMSzX5z8MHxnWkb8AEKF5cjCUuwg2F/FwO/dKw==
Date: Wed, 30 May 2018 22:58:05 -0500
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: gnss: add u-blox binding
Message-ID: <20180531035805.GA16906@rob-hp-laptop>
References: <20180530103242.20773-1-johan@kernel.org>
 <20180530103242.20773-5-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530103242.20773-5-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:32:38PM +0200, Johan Hovold wrote:
> Add binding for u-blox GNSS receivers.
> 
> Note that the u-blox product names encodes form factor (e.g. "neo"),
> chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
> chipset is used for the compatible strings (for now).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  .../devicetree/bindings/gnss/u-blox.txt       | 44 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
> new file mode 100644
> index 000000000000..caef9ace0b0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
> @@ -0,0 +1,44 @@
> +u-blox GNSS Receiver DT binding
> +
> +The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible 	: Must be one of

mixture of space and tab here.

> +
> +			"u-blox,neo-8"
> +			"u-blox,neo-m8"
> +
> +- vcc-supply	: Main voltage regulator
> +
> +Required properties (DDC):
> +- reg		: DDC (I2C) slave address
> +
> +Required properties (SPI):
> +- reg		: SPI chip select address
> +
> +Required properties (USB):
> +- reg		: Number of the USB hub port or the USB host-controller port
> +                  to which this device is attached
> +
> +Optional properties:
> +
> +- timepulse-gpios	: Time pulse GPIO
> +- u-blox,extint-gpios	: External interrupt GPIO

This should be interrupts property instead of a gpio.

> +- v-bckp-supply	: Backup voltage regulator
> +
> +Example:
> +
> +serial@1234 {
> +	compatible = "ns16550a";
> +
> +	gnss {
> +		compatible = "u-blox,neo-8";
> +
> +		v-bckp-supply = <&gnss_v_bckp_reg>;
> +		vcc-supply = <&gnss_vcc_reg>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index b5f978a4cac6..2128dfdf73f1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -374,6 +374,7 @@ tronsmart	Tronsmart
>  truly	Truly Semiconductors Limited
>  tsd	Theobroma Systems Design und Consulting GmbH
>  tyan	Tyan Computer Corporation
> +u-blox	u-blox
>  ucrobotics	uCRobotics
>  ubnt	Ubiquiti Networks
>  udoo	Udoo
> -- 
> 2.17.0
> 
