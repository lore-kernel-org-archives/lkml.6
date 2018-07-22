Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF757C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C56420875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td5t2k69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C56420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeGVJHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeGVJHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:07:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA792086A;
        Sun, 22 Jul 2018 08:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532247075;
        bh=29vFKyFmPXatN4VdL9ctUMuwT0jbdGdlefxhHNRLbPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Td5t2k69zE0QyURvjOI6/zYSqSXC5LdyB18vuxudV3h0pFnEv7qYKInDJV6D4OYnA
         Wfu4Hsz7bwRDqFI8IA2Z63Zq3U8r8MSCCl4SvSSc5yLsXs9klln/qvomIAGU7OBXBS
         kqL9hffY12eFuzWwc75F/Duqdv/LpOiwFUJpNSRw=
Date:   Sun, 22 Jul 2018 09:11:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180722091111.6c55602f@archlinux>
In-Reply-To: <20180721195923.7610-2-marcus.folkesson@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
        <20180721195923.7610-2-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 21:59:22 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> ---
>  .../devicetree/bindings/iio/adc/mcp3911.txt        | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> new file mode 100644
> index 000000000000..e233ee94ad96
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> @@ -0,0 +1,33 @@
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
> + - device-addr: Device address when multiple MCP3911 chips are present on the
> +	same SPI bus. Valid values are 0-3. Defaults to 0.
> + - external-clock: Use external clock instead of crystal oscillator.
As mentioned, in the code, can we use the standard fixed clock bindings here.
We don't actually care what the value is, but it might be nice to be able to
power down the clock if we are suspending or something..

> + - external-vref: Use external voltage reference
> + - vref-supply:	Phandle to the external reference voltage supply. (only valid in combination with `external-vref`)

Just use the optional regulator stuff and get rid of the bool.

> + - ch0-width: width for channel0. Valid widths are 16 and 24bits.
> + - ch1-width: width for channel1. Valid widths are 16 and 24bits.

As I asked in the code, are these a function of the wiring etc or are
they something we should really be leaving up to userspace (with a sensible
default).

> +
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3911";
> +	reg = <0>;
> +	spi-max-frequency = <20000000>;
> +	device-addr = <0>;
> +	ch0-width = <16>;
> +	ch1-width = <24>;
> +	external-clock;
> +	external-vref;
> +	vref-supply = <&vref_reg>;
> +};

