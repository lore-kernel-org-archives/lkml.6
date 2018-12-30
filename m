Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896CC2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeL3RfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:35:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59728 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeL3RfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:35:10 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 829E780803; Sun, 30 Dec 2018 18:35:01 +0100 (CET)
Date:   Sun, 30 Dec 2018 18:35:05 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20181230173505.GA19593@amd>
References: <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
 <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com>
 <20181229190726.GA29851@amd>
 <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-30 18:09:35, Jacek Anaszewski wrote:
> On 12/29/18 8:07 PM, Pavel Machek wrote:
> >Hi!
> >
> >>>>With the "color" sysfs file it will make more sense to allow for user
> >>>>defined color palettes.
> >>>>
> >>>
> >>>I think defining these values in the device tree or acpi severely limi=
ts the devices
> >>>capabilities.  Especially in development phases.  If the knobs were ex=
posed then the user space
> >>>can create new experiences.  The color definition should be an absolut=
e color defined in the dt and
> >>>either the framework or user space needs to mix these appropriately.  =
IMO user space should set the policy
> >>>of the user experience and the dt/acpi needs to set the capabilities.
> >>>
> >>>I do like Pavels idea on defining the more standard binding pattern to=
 "group" leds into a single group.
> >>>
> >>>Maybe the framework could take these groups and combine/group them int=
o a single node with the groups colors.
> >>
> >>There is still HSV approach [0] in store. One problem with proposed
> >>implementation is fixed algorithm of RGB <-> HSV color space conversion.
> >>Maybe allowing for some board specific adjustments in DT would add
> >>more flexibility.
> >>
> >>[0] https://lkml.org/lkml/2017/8/31/255
> >
> >Yes we could do HSV. Problem is that that we do not really have RGB
> >available. We do have integers for red, green and blue, but they do
> >not correspond to RGB colorspace.
>=20
> OK, so conversion from HSV to RGB would only increase the aberration.
> So, let's stick to RGB - we've got to have some stable ground and this
> is something that the hardware at least pretends to be compliant
>with.

I'm not saying that we should stick to RGB. I'm just saying that
problem is complex.

And no, hardware does not even pretend to be compliant with RGB color
model ( https://en.wikipedia.org/wiki/RGB_color_model ). In
particular, in RGB there is non-linear brightness curve.

> Our problem is how to set the color atomically. With HSV approach we
> were to obviate the problem by mapping brightness file to the "V"
> component of that color space, and write all H,S and V values to the
> hardware only on write to brightness file.

I'm not sure how realistic the "atomic color" problem is. Computers
are way faster than human vision.

I believe problem to start with is the "white" problem. Setting
R=3DG=3DB=3D255 will _not_ result in anything close to white light on
hardware I have.

Anyway,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwpAckACgkQMOfwapXb+vIhpQCfS83ci9L7MbTalisB+P5Ztdw0
YXkAn1KqE3+dR8IkohS02o+hspyKEbXg
=XO1Z
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
