Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF1C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6770B2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544957561;
	bh=j7SOKjdkPJGSB4XdLAvHVf6f/MeylomyxUVpu4NUrx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X3jR+VlwaqEDk3HyG1SiLsINHZPhG2EFAkmUV/Elvl0E5oJRKslawLkmJqf1I5siI
	 dJ/TN0JST53GudX5xH57Lhc8Z4WKvz1bWqfWfv+X1Wpm5DwDRskHxxfOFbApGcx+Zb
	 ghRxEBw0i92jSDagJZun+I8T1aNUrexZ6ICmLVcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeLPKwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbeLPKwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:52:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49D42086C;
        Sun, 16 Dec 2018 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544957559;
        bh=j7SOKjdkPJGSB4XdLAvHVf6f/MeylomyxUVpu4NUrx4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x/XRBRotatyu1gMfP1lf64x0X+wEzOXoVU/J8/irvhJ3SptbyqHrBbduLHTquhK/s
         +/zDvaaNJTlqUm/6OrSRWXimIhegJn1VwvqrWoJWBijplrSYXyuYx3A6HnR6mF1gup
         zYkgHDsumux89vb/bFDBzxtOw/YkrJY6bWIBkrjw=
Date:   Sun, 16 Dec 2018 10:52:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] iio: ti-ads124s08: Add DT binding documentation
Message-ID: <20181216105235.6069abf1@archlinux>
In-Reply-To: <20181211191207.21900-1-dmurphy@ti.com>
References: <20181211191207.21900-1-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 13:12:04 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Adding binding documentation for Texas Instruments ADS124S08
> and ADS124S06 ADC.
> 
> S08 is a 12 channel ADC
> S06 is a 6 channel ADC
> 
> Datesheet can be found here:
> http://www.ti.com/lit/gpn/ads124s08
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Fixed incorrect compatible example and removed vref-supply - https://lore.kernel.org/patchwork/patch/1021047/

There is a reasonable argument to put the binding in there even if
not currently used.   However, I see it actually has multiple
power supplies, so perhaps this needs more thought first.

One other thing inline that I 'might' 'fix' depending on what is later
in the series.

> 
>  .../bindings/iio/adc/ti-ads124s08.txt         | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> new file mode 100644
> index 000000000000..6993e76e61c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> @@ -0,0 +1,23 @@
> +* Texas Instruments' ads124s08 and ads124s06 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,ads124s08" or "ti,ads124s06"
One per line.
- compatible: Should be one of
	"ti..."
	"ti..."

It's easier to add other parts with out having to rewrite the sentence
to cover the now more than 2 case.

If that's all I find in the series, I'll just fix it up when applying.

Jonathan
> + - reg: spi chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> + - spi-cpha: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional properties:
> + - reset-gpios: GPIO pin used to reset the device.
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads124s08";
> +	reg = <0>;
> +	spi-max-frequency = <1000000>;
> +	spi-cpha;
> +	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +};

