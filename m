Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeBHXVr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:21:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34288 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBHXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:21:45 -0500
X-Google-Smtp-Source: AH8x224mCKuWCJ34LagbAg5WKQyUzWxsMO2Zd95qbODwMMzjq7N2+VkBLlyZm+6aou1gezUe2MMjeg==
Date: Fri, 9 Feb 2018 00:21:41 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALPS Trackpoint & pressure
Message-ID: <20180208232141.2jxjd2xzkfua42mr@pali>
References: <20180204150839.b5qm4wb26vic35st@pali>
 <20180205224955.GB46524@dtor-ws>
 <20180206002947.GB27776@jelly>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yt7uegiil54peyln"
Content-Disposition: inline
In-Reply-To: <20180206002947.GB27776@jelly>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yt7uegiil54peyln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 February 2018 10:29:47 Peter Hutterer wrote:
> On Mon, Feb 05, 2018 at 02:49:55PM -0800, Dmitry Torokhov wrote:
> > On Sun, Feb 04, 2018 at 04:08:39PM +0100, Pali Roh=C3=A1r wrote:
> > > Hi! Now playing again with trackpoint connected to ALPS rushmore
> > > touchpad and I'm seeking a nice feature. Via ALPS PS/2 protocol it
> > > reports pressure of trackpoint. Parser for it is already implemented =
in
> > > alps.c and value is assigned to variable "z". When I just move
> > > trackpoint z is zero, when I push trackpoint while moving, then z is
> > > number higher, maximally 32. Variable "z" is set, but unused.
> > >=20
> > > Do we have some input interface which can be used to report this
> > > pressure of trackpoint to userspace? I can use this feature e.g. as
> > > additional button...
> >=20
> > We could either do the conversion in kernel and emit BTN_LEFT, or
> > report ABS_PRESSURE and see if userspace will be able to handle
> > REL_X/REL_Y/ABS_PRESSURE device.
> >=20
> > Adding Peter.
>=20
> judging by trackpoint history, I'd leave the pressure->click conversion to
> userspace because every trackpoint may need a different threshold setting.
> "easier" to have this in userspace with dmi matches etc. plus, converting=
 to
> BTN_LEFT in the kernel means we cannot use it as a separate interaction
> anymore.

Also BTN_LEFT is already reported when left button under trackpoint is
pressed. Therefore it would not be possible to distinguish between
trackpoint "press" and real left button press.

> That aside, I think exporting ABS_PRESSURE is fine, that's what it's there
> for. Nothing will use it for now though, tbh not sure yet how that would =
be
> exported from libinput. but worth filing a bug for, please assign it to m=
e.

Ok, so ABS_PRESSURE? Also then question is, how to report minimal and
maximal (possible) value? If we are going to "standardize" API for it,
we should also define min/max values, so userspace would be able to
normalize this pressure event. I can imagine that some devices can
report 8bit value, but ALPS rushmore reports only 5bit value.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yt7uegiil54peyln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnzbggAKCRCL8Mk9A+RD
UqSSAJ9f43wEMj2CwVK5QVJu3OAXOCq/PACfay6sJF8STOOq8pFYo4MRXelDrAU=
=121q
-----END PGP SIGNATURE-----

--yt7uegiil54peyln--
