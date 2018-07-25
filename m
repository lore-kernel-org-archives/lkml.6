Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEA420844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTaAzCHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEA420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeGYURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:17:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbeGYURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:17:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so7600208ljy.8;
        Wed, 25 Jul 2018 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MIREDpTtSJqXJVcEurieseFPP0NbThQkhytIVKp4ATk=;
        b=CTaAzCHkM/Crcs9n0jmTgQi5ZkXelk4kna33TfPyNWz/ZeX+0jmo0YS31q6+Efi7Mp
         zb/hYI0S9rFgLd9c/wkr+AOYL85h678UkJ+USVgLHHaba2cVDhSY6/NimaLuaPLkevS1
         AAghgpqoRIQOjQTvwSvAeUpuvCpVL7qsgEltbC8ftw5TlTb+ffDpRZ76+KNNK9azCsaI
         yJGCDlQJ6yFJxWVCIfuLlCXzNfXCpvD2DeCUrR/+84yjm2tIxqW5aJz0jSqlHlTRV2Qt
         5G7xyJNWtyRRbMDU9Y4ximiWco3uzup5OWYAM3MfxZQpT7+7NeVeuUbQ1ealHgU0WcEf
         5Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MIREDpTtSJqXJVcEurieseFPP0NbThQkhytIVKp4ATk=;
        b=FeLSi2sTpuK3+BSviuufujDA3256eKmSy/fF/oJmK5A6H7zjk8VplT8iXFFE3am3yp
         zPBsyg765D4mTG93y0LWdNr5H7Cu3yBA6BgDbqC2Pt0x7K0AiWnFFekkLRNj0SqAd5nr
         YAq8v83Ctg6bf7VcNXgR9V2un1fBJfgVS75+zkLynQ8VP1tO7NGxhr3wk+XOsn453SGv
         qNMPBwC6aROP7fQDlM6kLqePkFgVZUWVAHbvaYdJT7iV1EZ7+AKO6FuhBNfTruldqAY9
         MRraZfgSs+s1SsDQxg0NEb9d7r8GpIcwWGzf3VqNZySq8+K9CpRzoazIVh+L8fdjLp9r
         s/Gw==
X-Gm-Message-State: AOUpUlHx2qNpkVj8q+ou+iG0LTejt4iDXk0kPhxqHigQyAj2X9aOtMIJ
        yVP6FiIC4QlKRu8LIQJX2uc=
X-Google-Smtp-Source: AAOMgpfH4rYND+795ec5biRPuKG17Guvd6ooAOx4dDO4A5DinvFcvPBIKmY1Tv/gTt/5BNuRuPycRQ==
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr6948215lji.10.1532545476381;
        Wed, 25 Jul 2018 12:04:36 -0700 (PDT)
Received: from gmail.com (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2935728ljw.60.2018.07.25.12.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:04:35 -0700 (PDT)
Date:   Wed, 25 Jul 2018 21:04:41 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180725190441.GA3373@gmail.com>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
 <20180724183004.20279-2-marcus.folkesson@gmail.com>
 <20180725175117.GA825@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20180725175117.GA825@rob-hp-laptop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

Thank you for the review.

On Wed, Jul 25, 2018 at 11:51:17AM -0600, Rob Herring wrote:
> On Tue, Jul 24, 2018 at 08:30:03PM +0200, Marcus Folkesson wrote:
> > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > ---
> >=20
> > Notes:
> >     v2:
> >     	- drop channel width
> >     	- drop `external_vref`
> >     	- replace `external-clock` with proper clock bindings
> >=20
> >  .../devicetree/bindings/iio/adc/mcp3911.txt        | 28 ++++++++++++++=
++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.t=
xt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Do=
cumentation/devicetree/bindings/iio/adc/mcp3911.txt
> > new file mode 100644
> > index 000000000000..af5472f51a84
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > @@ -0,0 +1,28 @@
> > +* Microchip MCP3911 Dual channel analog front end (ADC)
> > +
> > +Required properties:
> > + - compatible: Should be "microchip,mcp3911"
> > + - reg: SPI chip select number for the device
> > +
> > +Recommended properties:
> > + - spi-max-frequency: Definition as per
> > +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> > +	 Max frequency for this chip is 20MHz.
> > +
> > +Optional properties:
> > + - device-addr: Device address when multiple MCP3911 chips are present=
 on the
> > +	same SPI bus. Valid values are 0-3. Defaults to 0.
>=20
> Isn't this the reg value?
>=20

The reg value defines which chip select the chip hangs on.
The chip has support to connect up to four chips on the same SPI bus,
including the same chip select signal.

The chips are separated by the device-addr as it is part of the
communication protocol.

When reading the description for device-addr, I agree that it fits well
for the reg property as well..


> > + - vref-supply: Phandle to the external reference voltage supply.
> > + - clocks: Phandle and clock identifier (see clock-names)
> > + - clock-names: "adc_clk" for the ADC (sampling) clock
>=20
> Datasheet calls this clki (or mclk internally). Or just drop clock-names=
=20
> as it is pointless=20
> when there is only 1 clock.=20

I will drop the clock-names, thanks!

>=20
> Also DR handling as an IRQ is missing.

I have considered using the DR signal, but as we not support buffering
yet I did not see any point in using it.

=46rom the datasheet, section 7.1 ::

	These registers [channel registers] are latched when an
	ADC read communication occurs. When a data ready
	event occurs during a read communication, the most
	current ADC data is also latched to avoid data
	corruption issues. The three bytes of each channel are
	updated synchronously at a DRCLK rate. The three
	bytes can be accessed separately if needed but are
	refreshed synchronously.

So it should be safe to read the values independently of the DR signal.
Or maybe I'm missing something.


Best regards
Marcus Folkesson

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltYycQACgkQiIBOb1ld
UjJHZw/8CMIIsAbrC+kAnKC22Si3zdJ0wI2utMTjCdlmdRwDSKxUdw1kNM0+vlDR
Er66pJ6okfPp1Y7+kXTYa8QKcoXwAp6+wIeCoAGRZ1gP6ZeK2IPIED0d/tPa62xO
4f/Z68+P936iQp1avmY0ncgu2JtGIxmQDC+wa1aPqATgMm/RGrGjnDJnU9NCNAHx
l3JhP/4Gd0WCZOfZu+UaAF1tU4ZCbr/FR3u8XVOJeg6c7cnMA7YeUtGnjv1pi7du
Yqy2mPLqdVdux3SwXZ60UzZ06G+AgswkOvGcVcNHPTn4fawkrbeZ0staPd2FkGCn
LTQ07nnGc717C6O16axSqmnC1Bk/tzFXQYazruhTQ3pJ+I0fzLovdUN0rBHnSJ/e
jzqGcDKRTp41XiNaUHGo1GgCILxoSvCMWT8Ja5zNW2Zmn38jK8cqv4wA/sqVAUXj
2K8HMmL3GNNy5IysRKSnofWc5347u76cF2SowwsXz0CH9lT2qkk7p7Fdy+pFEJVl
6nGrzY5+MS0MJwkFb7iWDiC6rBA5Saw5xOo5ZECvMv0u9v0oo6i9qOQhpyS4Ezdl
Rqt3CXEfkZhebNA+Mekqafie832Z6U3Ai8Gri6ZNjdEPxzEppRufovvXmI8CB1xT
v3+tzULwxbJ1blSUhzp9kfJECzcK1ia9yCHpbCCw0EIDUqxgwes=
=xhv2
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
