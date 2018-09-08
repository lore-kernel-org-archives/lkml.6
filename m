Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F81CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090A22086D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyBQID4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090A22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIHTRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeIHTRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:17:00 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F8B2086B;
        Sat,  8 Sep 2018 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536417060;
        bh=hAz4g3xUknBVcFOra9Y3cl2crW8SE/n818PGTAmv2n4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UyBQID4D3HqxIwDp8/MwS6LqCMlA+zexyVFiibOLxDv6bcksWvYnLvRHp9wxpge2Q
         H31BwgVOHeOLUNt7pmCx7JNjrOq7S9RtC/8Al+3ABqusCr21eiKaVRgO+WUTHsrsJj
         wLI1qGgfq7Js9J9+znr8A5sfLO7/0ekWMv858DkY=
Date:   Sat, 8 Sep 2018 15:30:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: adxl372: Document the adxl372 I2C
 bindings
Message-ID: <20180908153055.401efbec@archlinux>
In-Reply-To: <1536070394-5679-1-git-send-email-stefan.popa@analog.com>
References: <1536070394-5679-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 17:13:14 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The adxl372 is designed to communicate in either SPI or I2C protocol.
> This patch adds the documentation of device tree bindings for adxl372
> I2C.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/accel/adxl372.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> index 9409984..a289964 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -4,14 +4,25 @@ http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
>  
>  Required properties:
>   - compatible : should be "adi,adxl372"
> - - reg: SPI chip select number for the device
> + - reg: the I2C address or SPI chip select number for the device
> +
> +Required properties for SPI bus usage:
>   - spi-max-frequency: Max SPI frequency to use
>  
>  Optional properties:
>   - interrupts: interrupt mapping for IRQ as documented in
>     Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
> -Example:
> +Example for a I2C device node:
> +
> +	accelerometer@53 {
> +		compatible = "adi,adxl372";
> +		reg = <0x53>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +Example for a SPI device node:
>  
>  	accelerometer@0 {
>  		compatible = "adi,adxl372";

