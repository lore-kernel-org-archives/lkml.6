Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6EC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7F20E20
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdcAUuza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E7F20E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeHSUPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:15:35 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3CC208C3;
        Sun, 19 Aug 2018 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534698207;
        bh=3YRUEg5x16PBA5mPE0Fn7tibUwCJ228I7jdTOAvSON8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rdcAUuzakyy4K6f+JhdQm6ylq1SvfLVD2j4ArlSjQZI0KHP2oZpSZgIS6xgp5Z81f
         4aUuimlegq//jUDQrj15aE/+gc5bp+Jc1S/SXJFcKuMWBlweA5zrC5ehYM0cpe/bk8
         lnCgQuNqw+Dj2HfU+pD6FTvFVGWkibLGQva9XnLM=
Date:   Sun, 19 Aug 2018 18:03:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180819180322.2bbd3f0c@archlinux>
In-Reply-To: <1533890783-13456-3-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
        <1533890783-13456-3-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 11:46:19 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> new file mode 100644
> index 0000000..9409984
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -0,0 +1,22 @@
> +Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> +
> +http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
> +
> +Required properties:
> + - compatible : should be "adi,adxl372"
> + - reg: SPI chip select number for the device
> + - spi-max-frequency: Max SPI frequency to use
> +
> +Optional properties:
> + - interrupts: interrupt mapping for IRQ as documented in
> +   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +
> +	accelerometer@0 {
> +		compatible = "adi,adxl372";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ba47bb..c8dd09c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/accel/adxl372.c
> +F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
>  
>  AF9013 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>

