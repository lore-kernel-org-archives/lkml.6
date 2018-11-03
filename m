Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D849C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 11:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1504220833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW3/oSw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1504220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeKCVJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeKCVJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:09:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEFF2082D;
        Sat,  3 Nov 2018 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541246304;
        bh=fpqGIecUZtchkQPGlokSVVCU/dDdLAkgTfv2UAUA6OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SW3/oSw6Cx9lUXMGOR7s1duaXKzDejjwamlmuBZ3ExX3EVTKfLiVbLETn+ezkRZYS
         4Jq/G7TJRsTPOM51EB5u9iCIRnvzwmxPmMZwEopk6JuavLFIr26Pxd+6PeTn2H0W0h
         HfydU4ZZx/suMOOAh6daO8yUe47UgNxXtaUnTsrU=
Date:   Sat, 3 Nov 2018 11:58:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181103115819.1aa65a6c@archlinux>
In-Reply-To: <20181030205615.GA13185@bogus>
References: <1540831170-3150-1-git-send-email-stefan.popa@analog.com>
        <20181030205615.GA13185@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 15:56:15 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Oct 29, 2018 at 06:39:30PM +0200, Stefan Popa wrote:
> > Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
> >=20
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> > Changes in v2:
> > 	- Nothing changed.
> > Changes in v3:
> > 	- Removed the "adi,channels" property.
> > 	- Used the "reg" property to get the channel number and "adi,diff-chan=
nels"
> > 	  for the differential pins. The "adi,channel-number" property was rem=
oved.
> > 	- adi,bipolar is of boolean type.
> >=20
> >  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 90 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad712=
4.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b=
/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> > new file mode 100644
> > index 0000000..46a9b71
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> > @@ -0,0 +1,90 @@
> > +Analog Devices AD7124 ADC device driver
> > +
> > +Required properties for the AD7124:
> > +	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
> > +	- reg: SPI chip select number for the device
> > +	- spi-max-frequency: Max SPI frequency to use
> > +		see: Documentation/devicetree/bindings/spi/spi-bus.txt
> > +	- clocks: phandle to the master clock (mclk)
> > +		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +	- clock-names: Must be "mclk".
> > +	- interrupts: IRQ line for the ADC
> > +		see: Documentation/devicetree/bindings/interrupt-controller/interrup=
ts.txt
> > +
> > +	  Required properties:
> > +		* #address-cells: Must be 1.
> > +		* #size-cells: Must be 0.
> > +
> > +	  Subnode(s) represent the external channels which are connected to t=
he ADC.
> > +	  Each subnode represents one channel and has the following propertie=
s:
> > +		Required properties:
> > +			* reg: The channel number. It can have up to 4 channels on ad7124-4
> > +			  and 8 channels on ad7124-8, numbered from 0 to 15.
> > +			* adi,diff-channels: Pins the channel is connected to. The first va=
lue
> > +			  specifies the positive input pin, the second value the negative i=
nput pin.
> > +
> > +		Optional properties:
> > +			* adi,bipolar: Boolean, if set the channel is used in bipolar mode.=
 =20
>=20
> Both this and Xilinx AMS which I just reviewed are defining a bipolar=20
> property. Can we come up with a common property please.
Sometimes it's implicit given particular channel selects but agreed
for this particular simple case, lets just put it in the generic
binding as

bipolar.

Now the tricky question ;).. Where to document it. Only really applies to
ADCs but we don't have a specific adc.txt binding doc. I guess we'll need
one to start defining properties.

This also doesn't actually obey the documented naming for channels
in the top level binding.  I'm not adverse to changing that (as it's
not actually user visible and we don't enforce it anyway) but we should
discuss that in a separate thread so as to get more eyes on it.

>=20
> > +			* adi,reference-select: Select the reference source to use when
> > +			  converting on the the specific channel. Valid values are:
> > +			  0: REFIN1(+)/REFIN1(=E2=88=92).
> > +			  1: REFIN2(+)/REFIN2(=E2=88=92).
> > +			  3: AVDD
> > +			  If this field is left empty, internal reference is selected.
> > +			* adi,gain: Select the gain when converting on the specific channel.
> > +			  Valid values are: 1, 2, 4, 8, 16, 32, 64, 128.
> > +			  If this field is left empty, gain of 1 is selected.
> > +			* adi,odr-hz: The output data rate can be programmed from:
> > +			  9 to 19200 for full power mode (when the master clock is 614.4 kH=
z)
> > +			  2 to 4800 for mid power mode (when the master clock is 153.6 kHz)
> > +			  1 to 2400 for low power mode (when the master clock is 76.8 kHz)
> > +			  If this field is left empty, odr of 9 is selected.
> > +
> > +Optional properties:
> > +	- refin1-supply: refin1 supply can be used as reference for conversio=
n.
> > +	- refin2-supply: refin2 supply can be used as reference for conversio=
n.
> > +	- avdd-supply: avdd supply can be used as reference for conversion.
> > +
> > +Example:
> > +	adc@0 {
> > +		compatible =3D "adi,ad7124-4";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <5000000>;
> > +		interrupts =3D <25 2>;
> > +		interrupt-parent =3D <&gpio>;
> > +		refin1-supply =3D <&adc_vref>;
> > +		clocks =3D <&ad7124_mclk>;
> > +		clock-names =3D "mclk";
> > +
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		channel@0 {
> > +			reg =3D <0>;
> > +			adi,diff-channels =3D <0 1>;
> > +			adi,reference-select =3D <0>;
> > +			adi,gain =3D <2>;
> > +			adi,odr-hz =3D <10>;
> > +		};
> > +
> > +		channel@1 {
> > +			reg =3D <1>;
> > +			adi,bipolar;
> > +			adi,diff-channels =3D <2 3>;
> > +			adi,reference-select =3D <0>;
> > +			adi,gain =3D <4>;
> > +			adi,odr-hz =3D <50>;
> > +		};
> > +
> > +		channel@2 {
> > +			reg =3D <2>;
> > +			adi,diff-channels =3D <4 5>;
> > +			adi,gain =3D <128>;
> > +			adi,odr-hz =3D <19200>;
> > +		};
> > +
> > +		channel@3 {
> > +			reg =3D <3>;
> > +			adi,diff-channels =3D <6 7>;
> > +		};
> > +	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a1bfcb..f2fa508 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
> >  W:	http://ez.analog.com/community/linux-device-drivers
> >  S:	Supported
> >  F:	drivers/iio/adc/ad7124.c
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> > =20
> >  ANALOG DEVICES INC AD9389B DRIVER
> >  M:	Hans Verkuil <hans.verkuil@cisco.com>
> > --=20
> > 2.7.4
> >  =20

