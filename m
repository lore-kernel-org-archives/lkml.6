Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeBEOWC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:22:02 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:56397 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeBEOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:21:57 -0500
Date: Mon, 5 Feb 2018 15:21:55 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
Message-ID: <20180205142155.vgd2olchbwzm6a7x@flea>
References: <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
 <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
 <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
 <e3a8682c-7524-ee99-8d4f-c492709e6e49@micronovasrl.com>
 <20180201101411.d23efsjt7jdyi4zh@flea.lan>
 <51323c6d-ba50-f09e-fcd7-d9b18d03673a@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nunsc3phayviv7ll"
Content-Disposition: inline
In-Reply-To: <51323c6d-ba50-f09e-fcd7-d9b18d03673a@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nunsc3phayviv7ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 05:09:33PM +0100, Giulio Benetti wrote:
> Il 01/02/2018 11:14, Maxime Ripard ha scritto:
> > On Sat, Jan 27, 2018 at 11:07:09PM +0100, Giulio Benetti wrote:
> > > > > > > I don't really know what the polarity of D0 would be just by
> > > > > > > judging at that capture, but we would have noticed if the col=
ors
> > > > > > > were inverted for quite some time now.
> > > > > >=20
> > > > > > D0-D23 are correct.
> > > > > >=20
> > > > > > With that capture, I mean to show you instead dclk is inverted,=
 as
> > > > > > dclk samples D0 on falling edge.
> > > > >=20
> > > > > Ah right, DCLK being the first channel?
> > > >=20
> > > > Yes, sorry I didn't place a label on channels
> > > >=20
> > > > >=20
> > > > > > So 0 is NEGEDGE and 1 is POSEDGE(1/3 of clock phase).
> > > > > > 1/3 clock phase seems enough to me to be considered POSEDGE,
> > > > > > 2/3 instead risks to go too much to the right of D0(even if it
> > > > > > could work).
> > > > >=20
> > > > > Do you have captures with both settings?
> > > >=20
> > > > Not now, but asap I'm going to take.
> > >=20
> > > Here we are:
> > > 1/3 phase: https://pasteboard.co/H4VehON.png
> > > 2/3 phase: https://pasteboard.co/H4Veq8a.png
> > >=20
> > > Yellow: D0
> > > Blue: DCLK
> > >=20
> > > As you can see:
> > > 1/3 phase has DCLK rising edge almost in the middle of D0
> > > 2/3 phase has DCLK rising edge that comes too late
> > >=20
> > > I would go for "1/3 phase" for Rising edge and "normal phase" for
> > > Falling edge.
> > >=20
> > > What do you think?
> >=20
> > It seems fair. This need a whole lot of comments though :)
>=20
> Yes, then, do I proceed resubmitting both corrected patches with corrected
> commit logs?

Yes, please.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--nunsc3phayviv7ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp4aIIACgkQ0rTAlCFN
r3TZjA//Q9bxOY8dTejXjDTUPqSwlWRkCBFm/h7LXzzzBcHL0v6ZFCaE921yXp1i
AcusZ+Hgs+iIeHXlaYWnk3IoXTQL7NU0W4UlRunUCy1zG75bAKZYO4uevZnIQUjI
dB9+3HWrCXAHtABdcpplXF8TdXIzbh7MvJtOe5HQKzAw44gM1moRtVBDMD0ST3+z
S+QqjLMYjnOt80/BPO0cbWNsFcstkez11wtd+yd2/H5Z5+UNPaTD7XsFweV9q5MN
IxREzurWxp5Xue3aBqWM6dNIwG1CCB8xPtkxokhXVs5FfYH2dGJb8CHeJE+kHr1K
PfTfnbx/Y/3JE7xe9da9xCMPtJWCsxAB2h+ABkfoAXCq7lyohg2W5Lu7isMoqB95
/kP2n0md3mlNlQed777XHB0cL3hquWmrGVxdUHBIqDv5g9d/mvjgLH9upRBxZhJF
uHMuXjhkl2Q7ZwI9Fl7EUxCqucEUeC3WU99FBhXgeDUX0m2Vw23j/GLrFk+C8CBX
5KxPWuQ7IS+AfXI5lmjL5DzSBSjkMKER0GUdefgNxx1XFzhgvc4miYyL+5MN0LQE
xkFzzn4nOJKCEExItR0T1F4QsdDjQh3xLOa/WkUGsoa5oXUx+PpYTuDbqSqACn3o
cEfEn5xutjKqS4S79ZitOpafw16p70Hbxvp+9J35fQk72R0hRs8=
=oqHS
-----END PGP SIGNATURE-----

--nunsc3phayviv7ll--
