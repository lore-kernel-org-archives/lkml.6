Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F06C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C6D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF6DpZda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C6D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJ1Uwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 16:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeJ1Uwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 16:52:32 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738C720665;
        Sun, 28 Oct 2018 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540728483;
        bh=8YPxzz9MZVyznzW730HgQdLJpPWFuIR4+wfaDMLqUFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IF6DpZda5tePHQoxmg+pge3TbXcMm6j+fkCh8Zpc0VFzTJHW9V14rAvxq3jEK4rBx
         /TZOwtRvAZAUUgwLSFTv5XlDsM5YXGIhQe5wYFTHUSjCSivieNomJSjOdcGg5xOmJd
         3WaFHQ6m760oQkD624142UR5PzanGhQsDX2Zm3UQ=
Date:   Sun, 28 Oct 2018 12:07:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181028120758.376da9aa@archlinux>
In-Reply-To: <20181025184326.GA9995@bogus>
References: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
        <20181025184326.GA9995@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 13:43:26 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, Oct 18, 2018 at 12:12:36PM +0300, Stefan Popa wrote:
> > Document support for AD7606 Analog to Digital Converter.
> >=20
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 51 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad760=
6.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b=
/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> > new file mode 100644
> > index 0000000..dede581
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> > @@ -0,0 +1,51 @@
> > +Analog Devices AD7606 Simultaneous Sampling ADC
> > +
> > +Required properties for the AD7606:
> > +
> > + - compatible: Must be one of "adi,ad7605-4", "adi,ad7606-8", "adi,ad7=
606-6" or
> > + 	       "adi,ad7606-4". =20
>=20
> Format as one per line please.
>=20
> > + - reg: SPI chip select number for the device
> > + - spi-max-frequency: Max SPI frequency to use
> > + 	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> > + - spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> > + - avcc-supply: phandle to the Avcc power supply
> > + - interrupts: IRQ line for the ADC
> > + 	see: Documentation/devicetree/bindings/interrupt-controller/interrup=
ts.txt
> > + - conversion-start-gpio: must be the device tree identifier of the CO=
NVST pin.
> > +			  This logic input is used to initiate conversions on
> > +			  the analog input channels. =20
>=20
> Doesn't IIO have trigger GPIOs?

Wrong way around.  Those are for when you want to use a GPIO to tell the OS
to grab data now.  This one is a 'capture now' pin used to cause the hardwa=
re
to start capturing.  We might be able to do something a little generic arou=
nd
this type, but I don't think we would gain much doing it.

The more interesting point is that the real reason devices have these is ei=
ther:
1) To capture synchronized data cross a bank of ADCs
2) To capture data under control of device not visible to the OS (some sort
of external controller).

Neither of these cases is terribly well handled at the moment. However, no
one has yet really expressed a desire to do so, hence maybe it's not actual=
ly
done...

The first option would need a 'hardware' trigger path which isn't something
we really do as yet in general.  We have individual drivers doing it but no=
rmally
only when it's routing a pulse signal to cause the hardware to fill a fifo =
and
the OS only gets involved occasionally.

Ah well, if anyone cares we'll figure out how to do it ;)=20

>=20
> > +
> > +Optional properties:
> > +
> > + - reset-gpio: must be the device tree identifier of the RESET pin. If=
 specified,
> > + 	       it will be asserted during driver probe. =20
>=20
> -gpios is the preferred form: reset-gpios
>=20
> And state the active state
>=20
> > + - first-data-gpio: must be the device tree identifier of the FRSTDATA=
 pin.
> > + 		    The FRSTDATA output indicates when the first channel, V1, is
> > +		    being read back on either the parallel, byte or serial interface.
> > +- standby-gpio: must be the device tree identifier of the STBY pin. Th=
is pin is used
> > +		to place the AD7606 into one of two power-down modes, Standby mode or
> > +		Shutdown mode.
> > +- range-gpio: must be the device tree identifier of the RANGE pin. The=
 polarity on
> > +	      this pin determines the input range of the analog input channel=
s. If
> > +	      this pin is tied to a logic high, the analog input range is =C2=
=B110V for
> > +	      allchannels. If this pin is tied to a logic low, the analog inp=
ut range =20
>=20
> s/allchannels/all channels/
>=20
> > +	      is =C2=B15V for all channels. =20
>=20
> conversion-start-gpio, first-data-gpio, and range-gpio should all have=20
> vendor prefix (in addition to -gpios).
Gah, I should have spotted all of that.  Thanks Rob!

Jonathan
>=20
> > +
> > +Example:
> > +
> > +	adc@0 {
> > +		compatible =3D "adi,ad7606-8";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <1000000>;
> > +		spi-cpol;
> > +
> > +		avcc-supply =3D <&adc_vref>;
> > +
> > +		interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> > +		interrupt-parent =3D <&gpio>;
> > +
> > +		conversion-start-gpio =3D <&gpio 17 0>;
> > +		reset-gpio =3D <&gpio 27 0>;
> > +		first-data-gpio =3D <&gpio 22 0>;
> > +		standby-gpio =3D <&gpio 24 0>;
> > +	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 843545d..6d63db4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
> >  W:	http://ez.analog.com/community/linux-device-drivers
> >  S:	Supported
> >  F:	drivers/iio/adc/ad7606.c
> > +F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
> > =20
> >  ANALOG DEVICES INC AD9389B DRIVER
> >  M:	Hans Verkuil <hans.verkuil@cisco.com>
> > --=20
> > 2.7.4
> >  =20

