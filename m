Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FBCC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CAD218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549728238;
	bh=FAK3Arn+dWh3DVlgEvmI+956ODQ0Wj03m+5yv59+AI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iVxAIzmATy8LQivKJ/9/AoubysNyW8IiNj2yE5IIuS1blRFpADPh8aFUt2n2hfAaI
	 Ht5LUGsSapkDyPWJuWzMNzeFhuZ3JLpPap/O/oViilQdNZiW3KQ+rKhNfavTPPPuZk
	 pPNniFKObDwzzK33VW6ks6SzHWns//pWX2/NMK3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBIQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfBIQD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:03:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE5920863;
        Sat,  9 Feb 2019 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549728235;
        bh=FAK3Arn+dWh3DVlgEvmI+956ODQ0Wj03m+5yv59+AI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbvjDpJL882Nm98wDAxpwngLSe0jWqLy0lrSYfjRqZcacPBsBRAZ+1vnwOPdXXD3i
         x3m/+fjXj7iH6iEiEq0GHZiP5auzyR2UY7A/crx9kpNhui4KBFaWnaNkpbqlZBIyfP
         GP58DX8xS7vt0o3jbMDwvdStji591MwBpn1n4z6E=
Date:   Sat, 9 Feb 2019 16:03:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio:dac:dac7612: device tree bindings
Message-ID: <20190209160351.5654f4d1@archlinux>
In-Reply-To: <20190204124833.18779-2-ricardo@ribalda.com>
References: <20190204124833.18779-1-ricardo@ribalda.com>
        <20190204124833.18779-2-ricardo@ribalda.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 13:48:33 +0100
Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:

> Bindings for dac7612.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
Simple binding so I'm happy to take with out a DT review unless someone
feels like giving one.  Seems to have answered Rob's previous comments.

Applied to the togreg branch of iio.git with the tiny tweak of dropping
the extra blank line at the end of the file.

Thanks,

Jonathan
> ---
> v4 Changelog by Rob Herring <robh@kernel.org>
> 
> -Add ti, prefix to gpio
> -Fix example da@1
> -Fix partname
> 
>  .../bindings/iio/dac/ti,dac7612.txt           | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> new file mode 100644
> index 000000000000..14a66c0dcdaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> @@ -0,0 +1,29 @@
> +* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
> +
> +The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
> +12-bit monotonicity performance over the industrial temperature range.
> +Is is programmable through an SPI interface.
> +
> +The internal DACs are loaded when the LOADDACS pin is pulled down.
> +
> +http://www.ti.com/lit/ds/sbas106/sbas106.pdf
> +
> +Required Properties:
> +- compatible: Should be one of:
> +		"ti,dac7612"
> +		"ti,dac7612u"
> +		"ti,dac7612ub"
> +- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional Properties:
> +- ti,loaddacs-gpios: GPIO descriptor for the LOADDACS pin.
> +- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +	dac@1 {
> +		compatible = "ti,dac7612";
> +		reg = <0x1>;
> +		ti,loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
> +	};
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30ba5435906b..e28e5afaae16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14882,6 +14882,7 @@ M:	Ricardo Ribalda <ricardo@ribalda.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/dac/ti-dac7612.c
> +F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
>  
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>

