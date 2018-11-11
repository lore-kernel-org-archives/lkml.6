Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB631C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696D021104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxio7MSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696D021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeKKXSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeKKXSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:18:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E938020866;
        Sun, 11 Nov 2018 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541942973;
        bh=Q8utXhP/WzHSvezrKJTCe1Ldz2aBPLHPCGKBufFNQVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxio7MSPpFKuhR99PT/gLCajxDTzLnDAvFNa0EuzdM9i9QX4JQ4yWzkxdLRUnz3jA
         bmFT8QhjbGHepOp5QM8Fx3yJOHg1xmOZlU5Yp9SHnryVuQxibpk0BC5Xl//r88T/zL
         WgCWepVsVyZDMsl+4mvxxT7v5MMSsueQV3dQGKBQ=
Date:   Sun, 11 Nov 2018 13:29:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v7 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20181111132928.218d0811@archlinux>
In-Reply-To: <20181107170821.1171886-2-pn@denx.de>
References: <20181107170821.1171886-1-pn@denx.de>
        <20181107170821.1171886-2-pn@denx.de>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 18:08:21 +0100
Parthiban Nallathambi <pn@denx.de> wrote:

> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied. Thanks,

Jonathan

> ---
> 
> Notes:
>     Changelog in v4:
>     - commit message fix
>     - same indexing/space in binding
>     
>     Changelog in v3:
>     - removed interrupt-parent property reference in documentation
>     - renamed vcnl4035 to light-sensor
> 
>  .../devicetree/bindings/iio/light/vcnl4035.txt | 18 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt    |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> new file mode 100644
> index 000000000000..c07c7f052556
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> @@ -0,0 +1,18 @@
> +VISHAY VCNL4035 -  Ambient Light and proximity sensor
> +
> +Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> +
> +Required properties:
> +
> +	-compatible: should be "vishay,vcnl4035"
> +	-reg: I2C address of the sensor, should be 0x60
> +	-interrupts: interrupt mapping for GPIO IRQ (level active low)
> +
> +Example:
> +
> +light-sensor@60 {
> +	compatible = "vishay,vcnl4035";
> +	reg = <0x60>;
> +	interrupt-parent = <&gpio4>;
> +	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8fcc16..3c5e0c6f6cee 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -415,6 +415,7 @@ vamrs	Vamrs Ltd.
>  variscite	Variscite Ltd.
>  via	VIA Technologies, Inc.
>  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> +vishay	Vishay Intertechnology, Inc
>  vitesse	Vitesse Semiconductor Corporation
>  vivante	Vivante Corporation
>  vocore VoCore Studio

