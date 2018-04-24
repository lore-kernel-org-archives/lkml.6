Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeDXRpN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:45:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeDXRpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:45:10 -0400
Date: Tue, 24 Apr 2018 18:45:07 +0100
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180424174507.GI22073@sirena.org.uk>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 03:08:57PM -0700, David Collins wrote:
> On 04/19/2018 09:16 AM, Doug Anderson wrote:
> > On Wed, Apr 18, 2018 at 4:30 PM, David Collins <collinsd@codeaurora.org=
> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > You'd need to ask Mark if he's OK with it, but a option #3 is to add a
> > patch to your series fix the regulator framework to try setting the
> > voltage if _regulator_get_voltage() fails.  Presumably in
> > machine_constraints_voltage() you'd now do something like:
> >=20
> >   int target_min, target_max;
> >   int current_uV =3D _regulator_get_voltage(rdev);
> >   if (current_uV < 0) {
> >     /* Maybe this regulator's hardware can't be read and needs to be in=
itted */
> >     _regulator_do_set_voltage(
> >       rdev, rdev->constraints->min_uV, rdev->constraints->min_uV);
> >     current_uV =3D _regulator_get_voltage(rdev);
> >   }
> >   if (current_uV < 0) {
> >     rdev_err(rdev,
> >       "failed to get the current voltage(%d)\n",
> >       current_uV);
> >       return current_uV;
> >   }

> > If Mark doesn't like that then I guess I'd be OK w/ initting it to 0
> > but this needs to be documented _somewhere_ (unlike for bypass it's
> > not obvious, so you need to find someplace to put it).  I'd rather not
> > hack the DT to deal with our software limitations.

> I'm not opposed to your option #3 though it does seem a little hacky and
> tailored to the qcom_rpmh-regulator specific case.  Note that I think it
> would be better to vote for min_uV to max_uV than min_uV to min_uV though.

> Mark, what are your thoughts on the best way to handle this situation?

I think that's probably only OK if we have a specific error code for the
regulator being limited in this way otherwise our error handling for I/O
problems involves us trying to reconfigure supplies which seems like it
would be risky. =20

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfbSIACgkQJNaLcl1U
h9C9WAf/SZljCZJDKB4bLgbVYGBdwEaqqJMWz4oNgio8hF/RR5NeyKDZ8vnlfoLV
JwTzMO3F9m2tLinAzq8c9jc6dRLqTn3SBaWOolg5syXustWlVbchf2+Gjjgo4JDM
VNMYmsDc7UMxMmUnzo1/fBDgTaBC5P3xb/HVTFGV4cktSKOea4tPg6L2JAmDpVL3
/CNf61gKBsKZcJeekPUosVGIeVfyRx+5CWGSHSZ/gdVmy+muKUvT1n6U5Ya1Y31Y
Mz/DJq3+bM/6HwUg5ym/0h1VRq8kZO4MTb/j0Jsr+v+3A7cMaVXaxMM/4weV0sww
blXiNiQT73dqtrJh5I0lGZt1v5Hclg==
=Quty
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
