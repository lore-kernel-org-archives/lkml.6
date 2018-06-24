Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9DC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D5324F05
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGU4D761"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D5324F05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeFXN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeFXN2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:28:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A922324F04;
        Sun, 24 Jun 2018 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529846891;
        bh=/sYV0d9k8xQNIyCZFF9Abl7T6xVnLTdBQ2dQY8bFPrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGU4D761kozeA6vFhl7u2/k9myKFlVFHh12/97itgQn1dmhKDlExodp4lLTyx+Hns
         SSjwu/Y0BFUnJiGg7LGy0YUaAIFB8LhrP8bqa8oG6gc0tk2UgR0bJsYJJGYKmmSEH4
         wBlbPMxF5ls8cmTH+xdKUWb41PZfAEICcMMDMtJE=
Date:   Sun, 24 Jun 2018 14:28:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, freeman.liu@spreadtrum.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs
 ADC controller documentation
Message-ID: <20180624142804.06ea3433@archlinux>
In-Reply-To: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 11:14:04 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the binding documentation for Spreadtrum SC27XX series
> PMICs ADC controller device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes since v2:
>  - Add reviewed tag from Rob.
> 
> Changes since v1:
>  - No updates.
> ---
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> new file mode 100644
> index 0000000..8aad960
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> @@ -0,0 +1,36 @@
> +Spreadtrum SC27XX series PMICs ADC binding
> +
> +Required properties:
> +- compatible: Should be one of the following.
> +	"sprd,sc2720-adc"
> +	"sprd,sc2721-adc"
> +	"sprd,sc2723-adc"
> +	"sprd,sc2730-adc"
> +	"sprd,sc2731-adc"
> +- reg: The address offset of ADC controller.
> +- interrupt-parent: The interrupt controller.
> +- interrupts: The interrupt number for the ADC device.
> +- #io-channel-cells: Number of cells in an IIO specifier.
> +- hwlocks: Reference to a phandle of a hwlock provider node.
> +
> +Example:
> +
> +	sc2731_pmic: pmic@0 {
> +		compatible = "sprd,sc2731";
> +		reg = <0>;
> +		spi-max-frequency = <26000000>;
> +		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmic_adc: adc@480 {
> +			compatible = "sprd,sc2731-adc";
> +			reg = <0x480>;
> +			interrupt-parent = <&sc2731_pmic>;
> +			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +			#io-channel-cells = <1>;
> +			hwlocks = <&hwlock 4>;
> +		};
> +	};

