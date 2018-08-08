Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1084D21A8F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1084D21A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeHHXaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:30:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40514 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbeHHXay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:30:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8CD31805C6; Wed,  8 Aug 2018 23:09:26 +0200 (CEST)
Date:   Wed, 8 Aug 2018 23:09:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
Message-ID: <20180808210926.GC15831@amd>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd>
 <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd>
 <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-08 16:04:43, Dan Murphy wrote:
> On 08/08/2018 04:02 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >>>> +	- #size-cells : 0
> >>>> +	- control-bank-cfg - : Indicates which sink is connected to which =
control bank
> >>>> +		0 - All HVLED outputs are controlled by bank A
> >>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
> >>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
> >>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by ba=
nk A
> >>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by ba=
nk A
> >>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by ban=
k A
> >>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are contro=
lled by bank B
> >>>> +		7 - All HVLED outputs are controlled by bank B
> >>>
> >>> This is quite long way to describe a bitmask, no? Could we make
> >>> it so that control-bank-cfg is not needed?
> >>
> >> The problem we have here is there is a potential to control
> >> 3 different LED string but only 2 sinks.  So control bank A can contro=
l 2 LED strings and control
> >> bank b can control 1 LED string. =20
> >>
> >=20
> > Can we forget about the LED strings, and just expose the sinks as
> > Linux LED devices?
>=20
> 2 sinks 3 LED strings.  How do you know which LED string is which and wha=
t bank it belongs
> to when setting the brightness.  Each Bank has a separate register for br=
ightness control.

Yes, and LED strings are statically assigned to banks, right?

So why not simply forget about LED strings for sake of hw
abstractions, and work just with banks?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrXAYACgkQMOfwapXb+vLRgwCgun7cHxER0vRxtMReDpdcMpAT
I18AoJ9ajaQ301rF1GcXRgL1KIJpZP1i
=EMdf
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
