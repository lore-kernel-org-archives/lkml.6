Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bP3HCAZzGVvdVAAAmS7hNA
	; Thu, 07 Jun 2018 18:20:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 61521606FA; Thu,  7 Jun 2018 18:20:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D642C605A2;
	Thu,  7 Jun 2018 18:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D642C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeFGSU1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:20:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42446 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752235AbeFGSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:20:26 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQzWK-0005lV-8w; Thu, 07 Jun 2018 19:20:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQzWI-0008Pq-Vg; Thu, 07 Jun 2018 19:20:22 +0100
Message-ID: <10ae263892588639ddc1614dbd4434e4e11e9afa.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 070/410] ARM: dts: omap3-n900: Fix the audio
 CODEC's reset pin
From: Ben Hutchings <ben@decadent.org.uk>
To: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>
Date: Thu, 07 Jun 2018 19:20:22 +0100
In-Reply-To: <7e63eb22-6477-37b6-93fb-fd0170615f64@ti.com>
References: <lsq.1528380321.59534108@decadent.org.uk>
         <7e63eb22-6477-37b6-93fb-fd0170615f64@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-c8klV5GcRRC8bTCkQSHJ"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c8klV5GcRRC8bTCkQSHJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-07 at 10:03 -0500, Andrew F. Davis wrote:
> On 06/07/2018 09:05 AM, Ben Hutchings wrote:
> > 3.16.57-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
>=20
>=20
> This relies on a patch that may not have been back-ported this far back,
> it is more safe to not take this patch.

I agree, and I should have spotted that since I pointed it out in an
earlier review.

Ben.

>=20
> > ------------------
> >=20
> > From: "Andrew F. Davis" <afd@ti.com>
> >=20
> > commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 upstream.
> >=20
> > The correct DT property for specifying a GPIO used for reset
> > is "reset-gpios", fix this here.
> >=20
> > Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X support")
> >=20
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  arch/arm/boot/dts/omap3-n900.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -427,7 +427,7 @@
> >  	tlv320aic3x: tlv320aic3x@18 {
> >  		compatible =3D "ti,tlv320aic3x";
> >  		reg =3D <0x18>;
> > -		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
> > +		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
> >  		ai3x-gpio-func =3D <
> >  			0 /* AIC3X_GPIO1_FUNC_DISABLED */
> >  			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> > @@ -444,7 +444,7 @@
> >  	tlv320aic3x_aux: tlv320aic3x@19 {
> >  		compatible =3D "ti,tlv320aic3x";
> >  		reg =3D <0x19>;
> > -		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
> > +		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
> > =20
> >  		AVDD-supply =3D <&vmmc2>;
> >  		DRVDD-supply =3D <&vmmc2>;
> >=20
--=20
Ben Hutchings
The most exhausting thing in life is being insincere.
                                                 - Anne Morrow Lindberg


--=-c8klV5GcRRC8bTCkQSHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsZd2YACgkQ57/I7JWG
EQlMmw/7BcVzMmB/wdFw+lld1gUriJ/gVDFVQhFRx9iz+ZNMFshZlYX39Ijitkwp
B2EP3+f7dD6a5KPhifa+XWGvB0cO1g4NmHb/JposWlfYnQkGiiQG0Q8RQwPnC1eE
/T74XQgXI4tFmhuV9RFof5/5qBzKVvdSRDfI2KFP/DANSEXM9SU6wZ8k+8lemlcc
ks4u5u6nLdOQqS2OkD55f3hc9IvLHEBGbeER/iwRKHele8NbESLdXH2YvDdIDbtT
xtIQCBivMEc55+N170i6i7GFCS41ckkyhkO7emm+bk9Ug4KYIcfbESleTRyhzpQv
BrEjfCQlmC9oh5R2qFwKEu3R00S5JC9BnTTX1go3dAoUSewmPaNwZhhPv5kTtjQV
c3C8gdY1kAUiun350emD2BTguA4PjYF2ZDWMXGViU6PJ6GAnaCd+82IU3jkW7bWo
hmuYd+6HihcS+vzhep5RXs82b0Nw7l1DZ4mTSlz7IzO4Q7V8bi+Zzsr3t0r7dBBo
MEzZ4h7R/YNw1XPx+o38Mr5cKkwAHnpHW7PYyFEXoVg1TyhUwghsUZ8+zd5rbzUX
0rh3ekcvb5m65jBpleYgcfbI07xuToeF9cIiGW0jOdXyVxSSv5mtrvh2t7bHR7Li
YhNgpMyhMvwZYgtdbrmICJ9SVFvejNA3Mo02WWsxi/2uH19mxJ0=
=Bgaf
-----END PGP SIGNATURE-----

--=-c8klV5GcRRC8bTCkQSHJ--
