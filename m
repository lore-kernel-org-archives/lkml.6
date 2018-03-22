Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbeCVBeR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752309AbeCVBeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:34:16 -0400
From: NeilBrown <neil@brown.name>
To: James Hogan <jhogan@kernel.org>
Date: Thu, 22 Mar 2018 12:34:06 +1100
Cc: John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: remove ralink_halt()
In-Reply-To: <20180321235249.GC13126@saruman>
References: <87370v9mkg.fsf@notabene.neil.brown.name> <20180321235249.GC13126@saruman>
Message-ID: <87po3w7v1t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21 2018, James Hogan wrote:

> On Tue, Mar 20, 2018 at 07:29:51PM +1100, NeilBrown wrote:
>>=20
>> ralink_halt() does nothing that machine_halt()
>> doesn't already do, so it adds no value.
>>=20
>> It actually causes incorrect behaviour due to the
>> "unreachable()" at the end.  This tell the compiler that the
>> end of the function will never be reached, which isn't true.
>> The compiler responds by not adding a 'return' instruction,
>> so control simply moves on to whatever bytes come afterwards
>> in memory.  In my tested, that was the ralink_restart()
>> function.  This means that an attempt to 'halt' the machine
>> would actually cause a reboot.
>>=20
>> So remove ralink_halt() so that a 'halt' really does halt.
>>=20
>> Signed-off-by: NeilBrown <neil@brown.name>
>
> Thanks, I've cosmetically tweaked the commit message (mainly reflow to
> 72 characters) and added:
>
> Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
> Cc: <stable@vger.kernel.org> # 3.9+
>
> and applied for 4.16.
>
> BTW, I'm intrigued to know if there's a particular reason you don't
> author / sign-off as "Neil Brown"? Its supposed to be real names, though
> "NeilBrown" is hardly difficult to figure out so I don't actually
> object.

I started using NeilBrown way back when I was an undergrad student and
it stuck.  When you grow up as a Brown, you know your name isn't going
to make you unique. e.g. I'm not an author of "Red Hat Linux System
Administration Unleashed" (he has a space in his name!!).  So I chose a
different way to make my name distinctive.
Yes, it isn't technically compliant - you are the second person to
comment in the nearly twenty years I've been working on Linux :-)

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqzCA8ACgkQOeye3VZi
gbl4NA/+M5iS2J3edM0UUHOPt+1VoIpL6IYc9fyMFN8IrT1XBwui3rRFCjsJUUpM
Uv356aQByjNgcCSkvqzb/yXbsvEPS67byGjbiFY+C1xuotcNGLmcBupbUw74N3JY
DgM1nsnj0oPYls0n1qmy/S9QSlPD0yU1YoTVzy5uZzg0a+qN8iBU1yBqL1yJnkaM
le1lizpXEqHm7uYjyasAsLBzSPVGcdW/tBWJnpiKEGNKovI8qt1tNhne6Ai5ZfH8
kHn/W0mRz+xCXKxQ4bY1J050O4ivoFQoxmQVgEKZ73PMlZuc45PQiu/Psj1B8jSR
/O9AxD2A5lMJGktyFSjbFhq92rAifPM6ym8G1ggpwmBiHUjqIcvBHov78S76JDiD
TV7OwKpW3oo54I5UOcXVxf4uORBFIkg4X30ZjKb/hl0rhrTXib6SIm8KMkvm8xlr
LiI8e8uGlTXee5oxj5AVa9kj6MCs0Mld0XtG83vi0ZWGowELgZMbaX81OChSPFzo
VlK+0+vQzLEFc3Jt8rB6UIwYkwro+Ysf2OTkD2/fs5M7N316upGvTLPYaTqmnIDr
iCr6nZQTaZVivtBfJ7aiudT+1JlpjSAYOaf1GnyDFYHIgy1tyKh/1X+5J/6DWFW3
4YhFBb2qdKvt0LebMXl6cmO3VY6mJC9VrohGaW9zaOH3E9b/Otc=
=Zx1e
-----END PGP SIGNATURE-----
--=-=-=--
