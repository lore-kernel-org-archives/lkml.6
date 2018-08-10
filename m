Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A1DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4378922430
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tuxWNTb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4378922430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeHJTO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:14:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38962 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbeHJTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RqolvuqE2WmiOhQDdTO0mCOyYpdY0h2LvVS6NsPELyA=; b=tuxWNTb/bYBiTAThLteBJP88g
        /jGxb5Xi7rdZ/2OTTdl/VG/Dtur0JACtmfYYvln4pKxamZ7MGjr80YSqod2UwpToxdQhXal5KgRst
        DGTA7KH13u3BrNvuF8KDRSRQbdXlH3dV8MyWo8m5+C2x5K/TFUXtZHkLlYwoPL71UMNm4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1foAVv-0004sb-Ks; Fri, 10 Aug 2018 16:43:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 46769112435F; Fri, 10 Aug 2018 17:43:45 +0100 (BST)
Date:   Fri, 10 Aug 2018 17:43:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180810164345.GH20971@sirena.org.uk>
References: <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
X-Cookie: Words are the voice of the heart.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:27:05AM -0700, Doug Anderson wrote:
> On Fri, Aug 10, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 10, 2018 at 08:40:17AM -0700, Doug Anderson wrote:

> >> The clock framework should be able to accomplish what you want.  If
> >> you just request the rate it will do its best to make the rate
> >> requested.  If we want to see what clock would be set before setting

> > The request could be massively off the deliverable rate - 50% or more.

> Agreed.  If the clock is massively off and that causes problems then
> someone will need to debug it and find a solution.  I'm not aware of
> us being in that case in the driver in question.

For the logic in the SPI core it's relatively common, lots of SPI
controllers are limited to something in the region of 10-12.5MHz but it's
common for devices to be able to run up to the region of 30MHz.

> >> >> 3. If you really truly need code in the SPI driver then make sure y=
ou
> >> >> include a compatible string for the SoC and have a table in the dri=
ver
> >> >> that's found with of_device_get_match_data().  AKA:

> >> It wouldn't be open-coding, it would be a different way of specifying
> >> things.  In my understanding it's always a judgement call about how
> >
> > If you're saying we need clock rate selection logic (which is what it
> > sounds like) rather than data then that seems like a problem.
>=20
> We're talking past each other I think.  Maybe a concrete example helps?

=2E..

> IMO the line marked "/* UNNEEDED */" below should be removed:

>     ...
>     spi-max-frequency =3D <50000000>;  /* UNNEEDED */

This is a line in the device tree (which I agree shouldn't be there),
not code in the SPI driver?

> ...and then the driver should say "oh, I have a compatible string of
> "qcom,geni-spi-sdm845" so I know my controller's max frequency must be
> 50 MHz.  It can get that information using of_device_get_match_data().

> Hopefully that's clearer?

That's just a data table, when you talk about code in the driver
(particularly given the wider discussion of what the maximum rate might
be) it sounds rather more involved than that.

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttwMAACgkQJNaLcl1U
h9B/IAf9EhX/x7ITUJ2ludOKYLs5jT10JI6Sch29xzZJM/rwQZKQ5MkhmHaueXBD
TFNoj831zKp0Y1SqsOF4OtuNnXjE08sMiuCeHCkuFBuVgPAgHTPonHf0S7v2P2+E
qw0mjvqLIs/kLu+tspS2e6zsg7mOgab7WFFUcZyQgridiAOoeryGsVgVJw7LDhH0
3c1jv1BjBE0uR6xRYJERBqbJnyrQZH8k0O2Tc/AMMQxEBtsXDGKWdS4AiCa049SA
4NX1Zc0FELg3Yw7oC2T2PpPLzv+5FlMf/GqzYQubu/vv9rja9I7tKhoxwM1iBnVx
9PSIMfBY/ZxtQKrvvEso7k5RSmgONw==
=F/JN
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
