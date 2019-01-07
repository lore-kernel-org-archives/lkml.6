Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A486CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEB92173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfAGSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:07:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48009 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfAGSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:07:06 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 131D2808D5; Mon,  7 Jan 2019 19:06:58 +0100 (CET)
Date:   Mon, 7 Jan 2019 19:07:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Message-ID: <20190107180703.GE933@amd>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20190107173743.GC4210@linux-l9pv.suse>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for your review!
>=20
> > > The hibernate function can be used to snapshot memory pages to an ima=
ge,
> > > then kernel restores the image to memory space in a appropriate time.
> > > There have secrets in snapshot image and cracker may modifies it for
> > > hacking system. Encryption and authentication of snapshot image can p=
rotect
> > > the system.
> > >=20
> > > Hibernate function requests the master key through key retention serv=
ice.
> > > The snapshot master key can be a trusted key or a user defined key. T=
he
> > > name of snapshot master key is fixed to "swsusp-kmk". User should loa=
ds
> > > swsusp-kmk to kernel by keyctl tool before the hibernation resume.
> > > e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
> >=20
> > But if userspace has a key, encryption is useless against root.
> >
>=20
> Yes, but this concern is not only for hibernation encryption. This patch
> set does not provide solution against this concern.

So, can we postpone these patches until we have a solution secure
against root users?

> My security goals:
>=20
> - Encrypt and authicate hibernate snapshot image in kernel space. Userspa=
ce
>   can only touch an encrypted and signed snapshot image.
>=20
> - The code of encryption are in kernel. They will be signed and verify wi=
th
>   kernel binary when secure boot enabled. It's better than using
>   unauthenticated userspace code at runtime.

These are not goals. I'd like to understand why you want to put it into
kernel in the first place.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzlUcACgkQMOfwapXb+vK4kgCfVB1Z62JFyX7Bq7sSXrFTCqN8
rT0AoKyLzzIy+PWQLFi2lG7Z/J1iUq3L
=H3zH
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
