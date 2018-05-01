Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbeEAKOi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:14:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52855 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeEAKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:14:37 -0400
Date: Tue, 1 May 2018 12:14:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180501101435.GA18574@amd>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180426061108.GB4977@amd>
 <20180429120705.GA18149@kroah.com>
 <201804292207.26775.linux@rainbow-software.org>
 <20180429233737.GD16033@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20180429233737.GD16033@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-04-29 16:37:37, Greg KH wrote:
> On Sun, Apr 29, 2018 at 10:07:26PM +0200, Ondrej Zary wrote:
> > On Sunday 29 April 2018 14:07:05 Greg KH wrote:
> > > On Thu, Apr 26, 2018 at 08:11:08AM +0200, Pavel Machek wrote:
> > > > On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> > > > > Recently ncpfs got moved to staging.  Also recently, we had some =
fuzzer
> > > > > developers report bugs in hfs, which they deem a security hole be=
cause
> > > > > Ubuntu attempts to automount an inserted USB device as hfs.
> > > >
> > > > We promise "no-regressions" for code in main repository, no such
> > > > promise for staging. We have quite a lot of code without maintainer.
> > > >
> > > > Moving code to staging means it will get broken -- staging was not
> > > > designed for this. I believe moving anything there is bad idea.
> > > >
> > > > Staging is for ugly code, not for code that needs new maintainter.
> > >
> > > Staging is used for getting code _out_ of the kernel tree as well as
> > > _in_.  We use it all the time to move code there, see if anyone shows=
 up
> > > in 6-8 months to say "I will fix this!", and if not, we delete it.
> > >
> > > Look at what just happened to IRDA in the 4.17-rc1 release as an exam=
ple
> > > of this.
> >=20
> > Really a "great" example of deleting working code :(=20
>=20
> What do you mean?  The irda code was broken and not working at all.
> There were loads of bug reports about it for years, with no developers
> or maintainers willing to do the work on it to get it to actually work
> again.
>=20
> If someone does want to step up and do it, great!  It's a simple revert
> of two git commits and they are back in business.

> Dropping code from the tree is not like it is gone for forever.  If
> someone wants to pick it up, it is trivial to do so.

That is a lie and you know it.

In particular, having code moved to staging means it is going to
bitrot, because it will not be updated with global changes.

Plus coding standards change over time, so if you simply revert,
you'll not be able to simply merge it back.

Plus that revert means bisection is no longer easy/possible to find
the real breakages.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlroPgsACgkQMOfwapXb+vIGvgCgpgu5xKHtASizH4GW7mc/7nyM
w3MAoIgcScmc/mUsy2Kx2s0ywezRbrX3
=AuAF
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
