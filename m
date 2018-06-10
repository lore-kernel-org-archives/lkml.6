Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +g91IscuHVtOIwAAmS7hNA
	; Sun, 10 Jun 2018 13:59:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6D889607A4; Sun, 10 Jun 2018 13:59:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk75Jksw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B856F601C3;
	Sun, 10 Jun 2018 13:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B856F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeFJN7c (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753509AbeFJN73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:59:29 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D51520858;
        Sun, 10 Jun 2018 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528639169;
        bh=STmvehvPBPxPZllugB+SeL85rYNLUSw9cBUgAI90BCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mk75JkswXV3+trbrHntaC3o6ENg114fCpKhDULM8WvPsdvjyUrAhIcWxxda+8xrjs
         JTqnsboIAofIXeZTa+JX7g3RNIfNNnWdDuHGXKRQWOK2f5e+rrSbMYsMpgiCxhVz1C
         iGMkXPWCNlqYWqaB32vjEGMDBNfSeezto3M8Bq3U=
Date: Sun, 10 Jun 2018 14:59:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180610145923.3b767ad4@archlinux>
In-Reply-To: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
References: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018 16:11:05 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hmm. The first part number I've ever googled where the top hit has
been a flight number.=20
Rio de Janeiro to Campinas is apparently on time today.

> ---
> Changes in v2:
> 	- Nothing changed, just to follow the patch set version.
>=20
>  .../devicetree/bindings/iio/dac/ad5758.txt         | 84 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Docum=
entation/devicetree/bindings/iio/dac/ad5758.txt
> new file mode 100644
> index 0000000..75fff6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> @@ -0,0 +1,84 @@
> +Analog Devices AD5758 DAC device driver
> +
> +Required properties for the AD5758:
> +	- compatible: Must be "adi,ad5758"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use (< 50000000)
> +	- spi-cpha: is the only mode that is supported
> +
> +Optional properties:
> +
> + - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
> +		   The following values are currently supported:
> +		   	* 0: DC-to-DC converter powered off
> +			* 1: DPC current mode
Perhaps expand those acronyms?
Dynamic Power Control  and perhaps a bit of explanation so people
who are ready DT files don't have to go find the data sheet to have
some idea of what these are?

Otherwise, binding is fine.

> +			* 2: DPC voltage mode
> +			* 3: PPC current mode
> +
> + - adi,dc-dc-ilim: The dc-to-dc converter current limit
> +		   The following values are currently supported [mA]:
Unit should be in the name.
adi,dc-dc-ilim_ma
> +		   	* 150
> +			* 200
> +			* 250
> +			* 300
> +			* 350
> +			* 400
> +
> + - adi,slew: Array of slewrate settings should contain 3 fields:
> +	1: Should be either 0 or 1 in order to enable or disable slewrate.

If it is disabled, why not just detect that as the 'not here' version
and then you can drop this element?

> +	2: Slew rate clock:
> +		Valid values for the slew rate update frequency [Hz]:
> +		* 240000
> +		* 200000
> +		* 150000
> +		* 128000
> +		* 64000
> +		* 32000
> +		* 16000
> +		* 8000
> +		* 4000
> +		* 2000
> +		* 1000
> +		* 512
> +		* 256
> +		* 128
> +		* 64
> +		* 16
> +	3: Slew rate step:
> +		Defines by how much the output value changes at each update.
> +		Valid values for the step size LSBs:
> +		* 4
> +		* 12
> +		* 64
> +		* 120
> +		* 256
> +		* 500
> +		* 1820
> +		* 2048

I think these last two are kind of separate parameters, would be interested
to hear if Rob thinks this should be separate or not.  They are both
related to slew rate, but different elements that add up to it.

> +
> + - adi,range: The output range
> +	      The following values are currently supported:
> +	      	* 0: 0 V to 5 V voltage range
> +		* 1: 0 V to 10 V voltage range
> +		* 2: =C2=B15 V voltage range
> +		* 3: =C2=B110 V voltage range
> +		* 8: 0 mA to 20 mA current range
> +		* 9: 0 mA to 24 mA current range
> +		* 10: 4 mA to 20 mA current range
> +		* 11: =C2=B120 mA current range
> +		* 12: =C2=B124 mA current range
> +		* 13: =E2=88=921 mA to +22 mA current range

Not sure if we can't represent this better.  It's either
a current or voltage output device.

adi,voltage_output or something like that or use

adi,voltage_range_v =3D <0 5>
adi,current_range_ma =3D <-1 22> etc
with it only being valid to specify one or the other.

I much prefer DT elements that don't require looking
at the docs where possible.

Again, Rob's input on this would be good.

> +
> +AD5758 Example:
> +
> +	ad5758@0 {
> +		compatible =3D "adi,ad5758";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +		spi-cpha;
> +
> +		adi,dc-dc-mode =3D <2>;
> +		adi,dc-dc-ilim =3D <200>;
> +		adi,slew =3D <1 200000 12>;
> +		adi,range =3D <1>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1993779..f640146 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -808,6 +808,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/dac/ad5758.c
> +F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
> =20
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
