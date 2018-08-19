Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C137C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467AD20C0F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Nv84g+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467AD20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeHSWQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSWQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:16:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0F2208FE;
        Sun, 19 Aug 2018 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534705447;
        bh=UpFJliSuXZdLHVJOD2JsPKjXd9mPgiSNh1vquC5oWX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Nv84g+WBfS1NuLKmzb0G9V5rUWGfjIurE3YOkQNh2T6M5b3nMC1GtrYAQuQksUQK
         W5Rf1c4t/Mf+JdrHrP154y1wwxzYKYz0ph9gAKCgWynGev7fHABoF/RQRaSigrPukb
         7ukzCakomSdMQ6vDrQzI7vhGQ6gGyYBc18OEibv8=
Date:   Sun, 19 Aug 2018 20:04:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180819200402.1d3897be@archlinux>
In-Reply-To: <20180808080917.2427-2-marcus.folkesson@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
        <20180808080917.2427-2-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Aug 2018 10:09:16 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> 
> Co-Developed-by: Kent Gustavsson <kent@minoris.se>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan
> ---
> 
> Notes:
>     v4:
>     	- remove reference to Documentation/.../interrupts.txt
>     	- add Kent as co-developer
>     v3:
>     	- add bindings for interrupt
>     	- prefix device-addr with `microchip`
>     	- drop `clock-names`
>     v2:
>     	- drop channel width
>     	- drop `external_vref`
>     	- replace `external-clock` with proper clock bindings
> 
>  .../devicetree/bindings/iio/adc/mcp3911.txt        | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> new file mode 100644
> index 000000000000..3071f48fb30b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> @@ -0,0 +1,30 @@
> +* Microchip MCP3911 Dual channel analog front end (ADC)
> +
> +Required properties:
> + - compatible: Should be "microchip,mcp3911"
> + - reg: SPI chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> +	 Max frequency for this chip is 20MHz.
> +
> +Optional properties:
> + - clocks: Phandle and clock identifier for sampling clock
> + - interrupt-parent: Phandle to the parent interrupt controller
> + - interrupts: IRQ line for the ADC
> + - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
> +	same SPI bus. Valid values are 0-3. Defaults to 0.
> + - vref-supply: Phandle to the external reference voltage supply.
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3911";
> +	reg = <0>;
> +	interrupt-parent = <&gpio5>;
> +	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +	spi-max-frequency = <20000000>;
> +	microchip,device-addr = <0>;
> +	vref-supply = <&vref_reg>;
> +	clocks = <&xtal>;
> +};

