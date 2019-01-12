Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA139C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796C42086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547318770;
	bh=wJk1MKco9NoCtJuJwpczKYid25YeZJixg96f/ubymmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yrbyxvm5C3QSZTsRlke7T8zIbI+Ali/wiemX1nfs0/UR4hMUKwc/seAB+oYA3uBTE
	 rkqZI0thV5WBbx1wkhBJuQZbs0IHbJ6W+iLrVcwYJfCk702Pzk5o8euBXNUPNsz21i
	 cH7or4N1Y9Zt5aUvQNSMy8I3nYI7ekusRQ9mMPVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfALSqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfALSqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:46:09 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1C4B206B6;
        Sat, 12 Jan 2019 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547318768;
        bh=wJk1MKco9NoCtJuJwpczKYid25YeZJixg96f/ubymmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A5s3iw2frFyRXPcnOV+vTAbdLS5r+nkhpOx3oYxwKELhRUBjhHlvDFzwwNBw+udKQ
         lbiBtKTyPvcJ9e8fn4LP6jza5p7XYSubH7XCtCimEJkHrShRFKnWCW/1EERBugmrvQ
         77BVKX02n3o9BirhxvdiP4Wik5bxdeQyzMmYtqEc=
Date:   Sat, 12 Jan 2019 18:46:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: iio: add NPCM ADC documentation
Message-ID: <20190112184602.3d3dc364@archlinux>
In-Reply-To: <20190109164343.164205-2-tmaimon77@gmail.com>
References: <20190109164343.164205-1-tmaimon77@gmail.com>
        <20190109164343.164205-2-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 18:43:42 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Added device tree binding documentation for Nuvoton BMC
> NPCM Analog-to-Digital Converter(ADC).
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
This looks fine to me, but I would like Rob's confirmation that
he is happy with the reset part in particular.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/nuvoton,npcm-adc.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> new file mode 100644
> index 000000000000..1b8132cd9060
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> @@ -0,0 +1,35 @@
> +Nuvoton NPCM Analog to Digital Converter (ADC)
> +
> +The NPCM ADC is a 10-bit converter for eight channel inputs.
> +
> +Required properties:
> +- compatible: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
> +- reg: specifies physical base address and size of the registers.
> +- interrupts: Contain the ADC interrupt with flags for falling edge.
> +
> +Optional properties:
> +- clocks: phandle of ADC reference clock, in case the clock is not
> +		  added the ADC will use the default ADC sample rate.
> +- vref-supply: The regulator supply ADC reference voltage, in case the
> +			   vref-supply is not added the ADC will use internal voltage
> +			   reference.
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

