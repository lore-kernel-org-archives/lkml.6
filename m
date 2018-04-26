Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeDZFdD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:33:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46045 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeDZFc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:32:58 -0400
X-Google-Smtp-Source: AIpwx49KMhGX9/6tNPl7Q9cUeOMXDKuelgSL10YCB3eaJmMBU8Mnoj9Pq7tMP3EVvUkfNPNxdsGbyw==
Date: Thu, 26 Apr 2018 11:02:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>, thomas.petazzoni@bootlin.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roland Stigge <stigge@antcom.de>, Stefan Roese <sr@denx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] dt-bindings: staging: remove a couple of ADC bindings
Message-ID: <20180426053255.75jg5bsdu4h624jo@vireshk-i7>
References: <20180426015754.26605-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426015754.26605-1-robh@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Thomas: Do you guys use this ?

On 25-04-18, 20:57, Rob Herring wrote:
> Remove LPC32xx and SPEAr ADC bindings in staging. They have not been
> touched since 2012.
> 
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Move these out of staging please or they are going to be removed.
> 
>  .../bindings/staging/iio/adc/lpc32xx-adc.txt       | 16 -------------
>  .../bindings/staging/iio/adc/spear-adc.txt         | 26 ----------------------
>  2 files changed, 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
> deleted file mode 100644
> index b3629d3a9adf..000000000000
> --- a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -* NXP LPC32xx SoC ADC controller
> -
> -Required properties:
> -- compatible: must be "nxp,lpc3220-adc"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- interrupts: The ADC interrupt
> -
> -Example:
> -
> -	adc@40048000 {
> -		compatible = "nxp,lpc3220-adc";
> -		reg = <0x40048000 0x1000>;
> -		interrupt-parent = <&mic>;
> -		interrupts = <39 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> deleted file mode 100644
> index 02ea23a63f20..000000000000
> --- a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -* ST SPEAr ADC device driver
> -
> -Required properties:
> -- compatible: Should be "st,spear600-adc"
> -- reg: Address and length of the register set for the device
> -- interrupt-parent: Should be the phandle for the interrupt controller
> -  that services interrupts for this device
> -- interrupts: Should contain the ADC interrupt
> -- sampling-frequency: Default sampling frequency
> -
> -Optional properties:
> -- vref-external: External voltage reference in milli-volts. If omitted
> -  the internal voltage reference will be used.
> -- average-samples: Number of samples to generate an average value. If
> -  omitted, single data conversion will be used.
> -
> -Examples:
> -
> -	adc: adc@d8200000 {
> -		compatible = "st,spear600-adc";
> -		reg = <0xd8200000 0x1000>;
> -		interrupt-parent = <&vic1>;
> -		interrupts = <6>;
> -		sampling-frequency = <5000000>;
> -		vref-external = <2500>;	/* 2.5V VRef */
> -	};
> -- 
> 2.14.1

-- 
viresh
