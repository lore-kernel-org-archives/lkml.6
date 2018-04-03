Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbeDCIvY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:51:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51516 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeDCIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:51:22 -0400
Date: Tue, 3 Apr 2018 10:51:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Williams <dcbw@redhat.com>
Cc: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: linux-next on x60: hangs when I request suspend was Re: linux-next
 on x60: network manager often complains "network is disabled" after resume
Message-ID: <20180403085120.GD3926@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <1521474008.20208.2.camel@redhat.com>
 <20180319173356.GA28462@amd>
 <1521481549.20208.8.camel@redhat.com>
 <20180320080334.GA31772@amd>
 <1521551568.16848.5.camel@redhat.com>
 <20180325061927.GA2148@amd>
 <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I wanted to re-test next (4.16.0-rc7-next-20180329), but that one does
not suspend at all.

I normally suspend by pressing power button in MATE, but that action
currently results in machine hanging.

								Pavel


On Mon 2018-03-26 10:33:55, Dan Williams wrote:
> On Sun, 2018-03-25 at 08:19 +0200, Pavel Machek wrote:
> > > > > Ok, what does 'nmcli dev' and 'nmcli radio' show?
> > > >=20
> > > > Broken state.
> > > >=20
> > > > pavel@amd:~$ nmcli dev
> > > > DEVICE  TYPE      STATE        CONNECTION
> > > > eth1    ethernet  unavailable  --
> > > > lo      loopback  unmanaged    --
> > > > wlan0   wifi      unmanaged    --
> > >=20
> > > If the state is "unmanaged" on resume, that would indicate a
> > > problem
> > > with sleep/wake and likely not a kernel network device issue.
> > >=20
> > > We should probably move this discussion to the NM lists to debug
> > > further.  Before you suspend, run "nmcli gen log level trace" to
> > > turn
> > > on full debug logging, then reproduce the issue, and send a pointer
> > > to
> > > those logs (scrubbed for anything you consider sensitive) to the NM
> > > mailing list.
> >=20
> > Hmm :-)
> >=20
> > root@amd:/data/pavel# nmcli gen log level trace
> > Error: Unknown log level 'trace'
>=20
> What NM version?  'trace' is pretty old (since 1.0 from December 2014)
> so unless you're using a really, really old version of Debian I'd
> expect you'd have it.  Anyway, debug would do.
>=20
> > root@amd:/data/pavel# nmcli gen log level help
> > Error: Unknown log level 'help'
>=20
> nmcli gen help
>=20
> > root@amd:/data/pavel# nmcli gen log level
> > Error: value for 'level' argument is required.
> > root@amd:/data/pavel# nmcli gen log level debug
>=20
> This should be OK.
>=20
> > root@amd:/data/pavel# cat /var/log/sys/log
>=20
> It routes it to whatever the syslog 'daemon' facility logs to (however
> that's configured on your system).  Usually /var/log/messages or
> /var/log/daemon.log or sometimes your distro configures it to
> /var/log/NetworkManager.log.
>=20
> Or if you're using a systemd-based distro, it would probably be in the
> systemd journal so "journalctl -b -u NetworkManager"
>=20
> > Where do I get the logs? I don't see much in the syslog...
>=20
> > And.. It seems that it is "every other suspend". One resume results
> > in
> > broken network, one in working one, one in broken one...
>=20
> Does your distro use pm-utils, upower, or systemd for suspend/resume
> handling?
>=20
> Dan

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDQIgACgkQMOfwapXb+vJlNwCffj9I76y/inQmM5n3MBpHRnQ2
/d8An0c2qoHmtzrhJj/9CeogIKHuLobz
=KQ5p
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
