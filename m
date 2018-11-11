Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD00C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863B421479
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3yXwfOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863B421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeKKVhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKVhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:37:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1183A20866;
        Sun, 11 Nov 2018 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541936934;
        bh=EgN4fWcY1wL7m5PyWEo4qb0ogZSCXVDnMBvtzAbieGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O3yXwfOxE7J14vE6EiwZiEes5FU4unZhUrWzJpR0mPriWh6wlvWZEt9c9w/lMAqW/
         r3nuFMAbkk5Qz+eWwTGSh5L9Kdi27KiLyjvdzXqb+3DGXQKUMWyCdIXBBx05+WEA30
         PS5JUi1XklkxJb0M9y+56BsF48eNKlWlcK6bAy2s=
Date:   Sun, 11 Nov 2018 11:48:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com,
        broonie@kernel.org
Subject: Re: [PATCH 4/6] dt-bindings:iio:resolver: Add docs for ad2s90
Message-ID: <20181111114848.266d3937@archlinux>
In-Reply-To: <20181109220044.24843-5-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
        <20181109220044.24843-5-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 20:00:42 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds the device tree binding documentation for the ad2s90
> resolver-to-digital converter.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  .../bindings/iio/resolver/ad2s90.txt          | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> new file mode 100644
> index 000000000000..b42cc7752ffd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> @@ -0,0 +1,26 @@
> +Analog Devices AD2S90 Resolver-to-Digital Converter
> +
> +https://www.analog.com/en/products/ad2s90.html
> +
> +Required properties:
> +  - compatible : should be "adi,ad2s90"
> +  - reg : SPI chip select number for the device
> +  - spi-max-frequency : set maximum clock frequency, must be 830000
> +  - spi-cpol and spi-cpha : must be defined to enable SPI mode 3

As the part only works in mode 3, my gut feeling is that this belongs
in the driver, not here.  Rob, what do you think?

> +
> +Note about max frequency:
> +    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
> +    delay is expected between the application of a logic LO to CS and the
> +    application of SCLK, as also specified. And since the delay is not
> +    implemented in the spi code, to satisfy it, SCLK's period should be at most
> +    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
> +    roughly 830000Hz.
> +
> +Example:
> +resolver@0 {
> +	compatible = "adi,ad2s90";
> +	reg = <0>;
> +	spi-max-frequency = <830000>;
> +	spi-cpol;
> +	spi-cpha;
> +};

