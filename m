Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933579AbeEWPlG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:41:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48576 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbeEWPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:41:02 -0400
Date: Wed, 23 May 2018 16:40:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180523154057.GL4828@sirena.org.uk>
References: <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UK1lfQXsnwKrySH9"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UK1lfQXsnwKrySH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 08:23:22AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Wed, May 23, 2018 at 1:29 AM, Mark Brown <broonie@kernel.org> wrote:
>=20
> > It's arguable either way - you could say that the client gets to specify
> > a safe range at all times or you could say that the machine constraints
> > should cover all cases where the hardware is idling.  Of course RPMh
> > is missing anything like the machine constraints (as we can see from all
> > the fixing up of undesirable hard coding we have to do) so it's kind of
> > pushed towards the first case.

> OK, fair enough.  If others all agree that it's OK to make requests
> about the voltage of a disabled regulator then I won't stand in the
> way.  I guess it does call into question the whole idea of caching /
> not sending the voltage until the first enable because it means
> there's no way for the client to use this feature until they've
> enabled / disabled the regulator once.  If you think of it as invalid
> to adjust the voltage of a disabled regulator then the caching
> argument is super clean, but once you say that you should normally be

It's got to be valid to think about the voltage of a disabled regulator
since drivers want to be able make sure that the regulator gets enabled
with a sensible config.  With most hardware this is really easy since
you can just look at the status reported by the hardware but the RPM
makes this hard since there's so much write only stuff in there.

> able to do it it feels more like a hacky workaround.  ...but I suppose
> that's what we've got to live with...

These RPM systems are always going to have problems of some kind
unfortunately unless the interface changes.

--UK1lfQXsnwKrySH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFi4gACgkQJNaLcl1U
h9AAPwf9HbEl7cITEB2ThBWHPHov7x75fnfLf+B+F1OiRHUSW9PmiFaCEv6L8y3v
tYMre9zclDiBbeDBvhwZIb8wtxrV8vNG8EJ5IjaXcrxXI5Y8E8SRyIT2PMARafeq
h1xIn73J55Z5WByvp1+0CKM7G88RhZKvCo55bgVOwSuD7C3LOX+zkktIIyu2G7A+
8zTl8lfMk6Wj2LvMywE0OC3nlMm3jhsso4xLhTVLzHe6Nsi8TGIOl/bVokJUHnnR
iVhbbqXVVOKqguyyObsi2hFIuwOrpk/I/54LksQOygcZzbsb6c7/wDeEvQRlTIzX
5Cyk63hdfSnbuWazYEFcpwMWZgsYIA==
=nKyD
-----END PGP SIGNATURE-----

--UK1lfQXsnwKrySH9--
