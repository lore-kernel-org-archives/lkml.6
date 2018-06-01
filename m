Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeFAK53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:57:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39649 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFAK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:57:28 -0400
Date: Fri, 1 Jun 2018 12:57:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Stanley <joel@jms.id.au>, "Tobin C. Harding" <me@tobin.cc>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: ptrval hiding -- first kernel messages look rather "interesting"
Message-ID: <20180601105726.GA10068@amd>
References: <20180601103144.GD31639@amd>
 <CAHp75VcaVieUTRurTA-XL1G1Nc3dqjM0kXANd2bugq51UPCNWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <CAHp75VcaVieUTRurTA-XL1G1Nc3dqjM0kXANd2bugq51UPCNWQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-01 13:49:41, Andy Shevchenko wrote:
> On Fri, Jun 1, 2018 at 1:31 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > v4.17 on n900:
> >
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> > [    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
> > [    0.000000]     lowmem  : 0xc0000000 - 0xcff00000   ( 255 MB)
> > [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> > [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> > [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
> > [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
> > [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 309 kB)
> > [    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 333 kB)
> > [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> >
> > I mean -- security is nice, but perhaps we should adjust the messages
> > so this does not look like we are making fun of the user?
>=20
> Colleague of mine (perhaps you even know him) wrote recently a small
> patch that improves kernel by 400% by removing ptr_to_id() completely.
>=20
> Okay, joking is joking, but it was a proposal to have some command
> line option to enforce no-hash pointers.
> I would rather enable it when one of the existing option is present
> (like 'debug'), though it might alter the output in user space or
> something else.
> So, I have no strong opinion here.

I guess my proposal would be replacing the four lines with single line:

=2Etext (8160 kB) .init (1024 kB) .data ( 309 kB) .bss ( 333 kB)

I'm not sure if exact addresses are normally useful, and having big
table saying "redacted!" looks strange.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsRJpYACgkQMOfwapXb+vKmAACgniNiWvOe9lXQTdsFYtZuSgNh
NBUAnin6SqeeVBJUWNFCYskSoYO/vs1Z
=HTDA
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
