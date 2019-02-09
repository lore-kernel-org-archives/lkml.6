Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FAC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E0B21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549726740;
	bh=dTpsnJ7QkR1x0QA899tm1goJoEQCx6UEJHFPePAXSGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EBSoEza0dSQJiq0DSbK0JcGvNktmPYCbvmBCH6WePMKRoN5fGDRdYY6tahEWPF1Zt
	 zO8spepMUGQXIlpWIF6lxGpPyf2VY0puOGUnwtT216okmCNk+lIUvtS4ziNWoYfOnM
	 86cG3nDnjRnmDfK4fp8WNUYrxO7Fq/Zwbrv2Frms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBIPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfBIPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:38:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F60021773;
        Sat,  9 Feb 2019 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549726735;
        bh=dTpsnJ7QkR1x0QA899tm1goJoEQCx6UEJHFPePAXSGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmO6QDaz+bMEwqCgcB8BOb8yAqwTk1JoFkAKH5WiQ8BTJMIvn1wjZHkfxAL04ZYcg
         J7kQIE/L5PqMs4iNoVBLqg8AasTUDyyetDNQEcPr5mjFjfjoS+Zq/5JfOngomnQoTh
         gCkiEYQnIQKAmyrOzIMxem4ko/UUbeTknFChwEcA=
Date:   Sat, 9 Feb 2019 15:38:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio/adc: Add docs for Ingenic
 JZ47xx SoCs ADC.
Message-ID: <20190209153850.567c29ca@archlinux>
In-Reply-To: <20190204001514.29891-1-contact@artur-rojek.eu>
References: <20190204001514.29891-1-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 01:15:12 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Add documentation for the ADC controller on JZ47xx SoCs,
> used by the ingenic-adc driver.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Hi,

This one seems simple enough and entirely standard that I'll take
it without a dt review.  As ever one is welcome, but feels like
it would be wasting Rob / Mark or anyone elses time!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  Changes:
> 
>  v2: change a typo ',' into ';' in battery example
> 
>  .../bindings/iio/adc/ingenic,adc.txt          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> new file mode 100644
> index 000000000000..f01159f20d87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> @@ -0,0 +1,48 @@
> +* Ingenic JZ47xx ADC controller IIO bindings
> +
> +Required properties:
> +
> +- compatible: Should be one of:
> +  * ingenic,jz4725b-adc
> +  * ingenic,jz4740-adc
> +- reg: ADC controller registers location and length.
> +- clocks: phandle to the SoC's ADC clock.
> +- clock-names: Must be set to "adc".
> +- #io-channel-cells: Must be set to <1> to indicate channels are selected
> +  by index.
> +
> +ADC clients must use the format described in iio-bindings.txt, giving
> +a phandle and IIO specifier pair ("io-channels") to the ADC controller.
> +
> +Example:
> +
> +#include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +adc: adc@10070000 {
> +	compatible = "ingenic,jz4740-adc";
> +	#io-channel-cells = <1>;
> +
> +	reg = <0x10070000 0x30>;
> +
> +	clocks = <&cgu JZ4740_CLK_ADC>;
> +	clock-names = "adc";
> +
> +	interrupt-parent = <&intc>;
> +	interrupts = <18>;
> +};
> +
> +adc-keys {
> +	...
> +	compatible = "adc-keys";
> +	io-channels = <&adc INGENIC_ADC_AUX>;
> +	io-channel-names = "buttons";
> +	...
> +};
> +
> +battery {
> +	...
> +	compatible = "ingenic,jz4740-battery";
> +	io-channels = <&adc INGENIC_ADC_BATTERY>;
> +	io-channel-names = "battery";
> +	...
> +};

