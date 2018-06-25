Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D50C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A12E2586F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A12E2586F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFYL7Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:59:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39022 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeFYL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:59:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1306C80383; Mon, 25 Jun 2018 13:59:14 +0200 (CEST)
Date:   Mon, 25 Jun 2018 13:59:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180625115913.GD17001@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd>
 <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



> > Well, AFAICT in this case userland has the key and encrypted data are
> > on disk. That does not seem to be improvement.
>=20
> Not really.
>=20
> With the encryption in the kernel, if the kernel is careful enough,
> use space will not be able to read the image even if it knows the
> passphrase, unless it can also add itself to the initramfs image
> loaded by the restore kernel, which (at least) can be made way more
> difficult than simply reading the plain-text image data via an I/F
> readily provided by the kernel.

I still do not see the improvement. If you are root, you can modify
the initramfs and decrypt the data.

Please explain in the changelog how this is better than existing solution.

> >> Besides, the user space part of what you are calling uswsusp has not
> >> been actively maintained for years now and honestly I don't know how
> >> many users of it there are.
> >
> > I'd assume distros want progress bars so they still use it?
>=20
> I'd rather not speak for distros, but if hibernation images are
> written to fast storage, progress bars are not that useful any more.
> They are not used on Windows any more, for one.
>=20
> > Anyway, there's solution for encrypted hibernation.
>=20
> Which is suboptimal and you know it.

If this is better, please explain how in the changelog.

> > If Intel wants to invent different solution for that, and put it into k=
ernel, they
> > should explain what the advantages are, relative to existing solution.
>=20
> I'm not sure what "they" is supposed to mean here, but the advantages
> are quite clear to me: better security and reduced syscall overhead.

Better security against which attack?

Syscall overhead is not a problem for hibernation, and you know it.

		    	  	      		       Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsw2REACgkQMOfwapXb+vL5WgCdEZn9n38yd3VV3SBZCeMULHhV
O2YAnjoj7kfQr0rzXiX99zLDo1lPSv1v
=oRsa
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
