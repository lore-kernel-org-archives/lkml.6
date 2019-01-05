Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A938FC43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A66C2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546707443;
	bh=5lF3HYnV1dbErhBabpg8zFcL7pAi15r7pVu3uoILwRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DFLKVfgJUYzg4lmrHBGxrW1BpFVbUFGPDqXx9Jd4JcdfxZdHHoBxSzr+6oJbXkNoR
	 wCv8F6HWg1YC3wVp26rbnjnuy2HAa0H2FyCFMfhE+ZfU7SVEum4GWSA7tBsCFUyLSZ
	 PXyC2Yjxpof2bTRmLZn1N9c0Q5TrTKTAOeTCJfkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfAEQ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAEQ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:57:22 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2E12070C;
        Sat,  5 Jan 2019 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546707441;
        bh=5lF3HYnV1dbErhBabpg8zFcL7pAi15r7pVu3uoILwRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WMz94ruxD3WBElJgA6rHCPZq3bjjYn0xFpaXATeZYji4z0n4ZX12NtwdVWY551R6o
         rYdN7PhhL5f2X2XUmODDcTJlnc4iILsmwcvvvlc0//Fof5iZD5ekPyDeHzkZMcqDN/
         nL3o1zFLB5rTZUajUmjACPYOkQ8o8+qh4c7XDCNg=
Date:   Sat, 5 Jan 2019 16:57:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-binding: iio: add NPCM ADC documentation
Message-ID: <20190105165715.1d4d270a@archlinux>
In-Reply-To: <20181224164755.286932-2-tmaimon77@gmail.com>
References: <20181224164755.286932-1-tmaimon77@gmail.com>
        <20181224164755.286932-2-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 18:47:54 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Added device tree binding documentation for Nuvoton BMC
> NPCM Analog-to-Digital Converter(ADC).
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/iio/adc/nuvoton,npcm-adc.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> new file mode 100644
> index 000000000000..6f0843d837cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> @@ -0,0 +1,35 @@
> +Nuvoton NPCM Analog to Digital Converter (ADC)
> +
> +The NPCM ADC is a 10-bit converter for eight channel inputs.
> +
> +Required properties:
> +- compatible	: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
> +- reg			: specifies physical base address and size of the registers.
Something a bit crazy with the indentation here!

> +- interrupts	: Contain the ADC interrupt with flags for falling edge.
> +
> +Optional properties:
> +- clocks		: phandle of ADC reference clock, in case the clock is not
> +				  added the ADC will use the default ADC sample rate.
> +- vref-supply	: The regulator supply ADC reference voltage, in case the
> +				  vref-supply is not added the ADC will use internal voltage
> +				  reference.
> +
> +Required Node in the NPCM7xx BMC:
> +An additional register is present in the NPCM7xx SOC which is
> +assumed to be in the same device tree, with and marked as
> +compatible with "nuvoton,npcm750-rst".
> +
> +Example:
> +
> +adc: adc@f000c000 {
> +	compatible = "nuvoton,npcm750-adc";
> +	reg = <0xf000c000 0x8>;
> +	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clk NPCM7XX_CLK_ADC>;
> +};
> +
> +rst: rst@f0801000 {
> +	compatible = "nuvoton,npcm750-rst", "syscon",
> +	"simple-mfd";
> +	reg = <0xf0801000 0x6C>;
> +};

