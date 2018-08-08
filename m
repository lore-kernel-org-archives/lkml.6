Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA0CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D821AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8D821AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeHIAUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:20:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41800 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:20:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 92EB48062F; Wed,  8 Aug 2018 23:58:42 +0200 (CEST)
Date:   Wed, 8 Aug 2018 23:58:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
Message-ID: <20180808215842.GF15831@amd>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd>
 <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd>
 <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
 <20180808210926.GC15831@amd>
 <cdf671fa-674d-6e34-177e-c0e9cb4f6137@ti.com>
 <20180808214527.GE15831@amd>
 <65e927b4-8bd2-1f34-3422-36ce21f674c3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <65e927b4-8bd2-1f34-3422-36ce21f674c3@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> Yes, and LED strings are statically assigned to banks, right?
> >>>
> >>> So why not simply forget about LED strings for sake of hw
> >>> abstractions, and work just with banks?
> >>
> >> How would you set the control bank register for the correct LED string=
 configuration?
> >=20
> > Have property at each LED saying which which HVLEDs it controls?
>=20
> Isn't that what I have already using the reg property?

> Then we would have to aggregate the configuration and make a determinatio=
n in the driver.

Yes.

> But that does not follow the LED child node ideology.
> Each output of the LED driver should have a child node.
>=20
> In this case the outputs are the sinks(inputs) and there are only 2 sinks=
 so having 3 LED child nodes would be confusing
> and there are required properties for each child like label.

No, I don't want that.

I'd like 2 child nodes, each specifying which HVLEDs it controls.

Let me edit the original proposal.

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrZ5IACgkQMOfwapXb+vLNYwCfQzUR/jIi8wFhYImeoMIUxbes
TkIAnR1wNHsAHZSwLAWK3cwthtSerAl+
=XAcD
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
