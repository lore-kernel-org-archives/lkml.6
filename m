Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FDFECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D121476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC0YDLab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeIPSWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbeIPSWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:22:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EA62087B;
        Sun, 16 Sep 2018 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537102797;
        bh=B0aiaPyHKkqOuFjq58jYrPi7ATISIQwkKrl7SHAEfOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uC0YDLabMzyIhnJKvGjXgKyKhMCAHkLQ6vGq05jQLVmRQY/8zlxXDRTJSq/r1olgf
         LnGzN2VVHVnbKZ3R/utRmvz7jkqRJjuFwDJbKfWG5yFDEnV68+sjxNsiEFsavsceXH
         v1XkGC0HYHtKIqndbErCZa3j1hhmIrSvwju8Ev4Q=
Date:   Sun, 16 Sep 2018 13:59:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: fxas21002c: Document the fxas21002c
 I2C bindings
Message-ID: <20180916135953.4247fe8d@archlinux>
In-Reply-To: <20180911150011.31964-3-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
        <20180911150011.31964-3-afonsobordado@az8.co>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 16:00:09 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> Add documentation for the fxas21002c I2C bindings.
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..9e5cdf0c0b69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> @@ -0,0 +1,33 @@
> +* Freescale FXAS21002C Digital Angular Rate Gyroscope
> +
> +Required properties:
> +
> +  - compatible: must be "fsl,fxas21002c"
> +  - reg : the I2C address of the sensor
> +
> +Optional properties:
> +
> +  - interrupts		: The first interrupt listed must be the one
> +			  connected to the INT1 pin, the second interrupt
> +			  listed must be the one connected to the INT2 pin.
> +			  The interrupts can be triggered on rising or falling
> +			  edges alike.
> +			  see interrupt-controller/interrupts.txt
> +  - vdd-supply		: The main voltage regulator
> +  - iovdd-supply	: The IO voltage regulator
> +			  see regulator/regulator.txt
> +  - reset-gpios		: GPIO used to reset the device.
> +			  see gpio/gpio.txt.
> +  - mount-matrix	: see iio/mount-matrix.txt

This last one could do with a very brief introduction to what
it is (as well as the cross reference).
This is particularly true as it isn't clear whether it is
necessary or optional.  The below doesn't have it there for
example.

> +
> +Example:
> +gyroscope@20 {
> +	compatible = "fsl,fxas21002c";
> +	reg = <0x20>;
> +	reset-gpios = <&gpio0 2 0>;
> +	vdd-supply = <&vref>;
> +	iovdd-supply = <&vref2>;
> +	interrupt-parent = <&foo>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
> +		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
Perhaps keep these in the same order as in the description above.

> +};

