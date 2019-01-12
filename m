Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A9C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2E2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547318460;
	bh=u7U5Q+TmVgXWUZYfnXFRLv/vFcJuVBuJDcnOAjnk4GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H/0n1mpyvHp5hkgQ7KcWwXH7Ui6Oren/QSSugpvB2x7SM8BOQDPtxfU4uAG5th/Ra
	 0MNN58rNa5kI/Ck5NJABRJ2tYm4iUcYEG+oSJLkI+z571aerf6iJLvGN2nj/JsjSJW
	 4yJe2tVs2hUTAijbPSibd0oarVq+bO+jaJOM6A6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfALSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:40:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfALSk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:40:59 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CCC2084C;
        Sat, 12 Jan 2019 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547318458;
        bh=u7U5Q+TmVgXWUZYfnXFRLv/vFcJuVBuJDcnOAjnk4GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GHnF0Qw/ApOxL6d+kUst54tVd5w5NehXnHw6eyFnh5xluWnHXhr7zYFG95AZUo/Tl
         4FyRTbew1lALjYMDvqnijYxIOKrf3/hCRTJK6A1yryUHjRmJGLFLNstHUipo7r75QN
         /eYvO+pZzbVLzQ4jdjAKMGieJzmEyU8n0mkyZNg0=
Date:   Sat, 12 Jan 2019 18:40:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: ti-ads124s08: Add DT binding documentation
Message-ID: <20190112184054.62bc65dc@archlinux>
In-Reply-To: <20190111195707.2086-1-dmurphy@ti.com>
References: <20190111195707.2086-1-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 13:57:05 -0600
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
Hopefully I haven't missed anything and this one is as trivial as I think.
Applied to the togreg branch of iio.git and pushed out as testing.

Comments still welcome. I'll push this out as a non rebasing tree
later in the week.

Thanks,

Jonathan

> ---
> 
> v3 - Fixed the compatible made the colon spacing consistent - https://lore.kernel.org/patchwork/patch/1023969/
> v2 - Fixed incorrect compatible example and removed vref-supply - https://lore.kernel.org/patchwork/patch/1021047/
> 
>  .../bindings/iio/adc/ti-ads124s08.txt         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> new file mode 100644
> index 000000000000..ecf807bb32f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> @@ -0,0 +1,25 @@
> +* Texas Instruments' ads124s08 and ads124s06 ADC chip
> +
> +Required properties:
> + - compatible :
> +	"ti,ads124s08"
> +	"ti,ads124s06"
> + - reg : spi chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency : Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> + - spi-cpha : Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional properties:
> + - reset-gpios : GPIO pin used to reset the device.
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads124s08";
> +	reg = <0>;
> +	spi-max-frequency = <1000000>;
> +	spi-cpha;
> +	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +};

