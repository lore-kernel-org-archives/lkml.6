Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32527206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfAIWTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:19:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45739 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAIWTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:19:31 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 909B2808A8; Wed,  9 Jan 2019 23:19:23 +0100 (CET)
Date:   Wed, 9 Jan 2019 23:19:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Message-ID: <20190109221928.GA32688@amd>
References: <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
 <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
 <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
 <1547016579.2789.17.camel@HansenPartnership.com>
 <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
 <1547063189.2879.47.camel@HansenPartnership.com>
 <CALCETrWKUTKp1tO00fPcbtm5vu2b4CHJQ6XcmkrWJY9P1h+mzA@mail.gmail.com>
 <1547070220.2758.4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1547070220.2758.4.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Note if someone has your laptop and the ability to boot their own
> > > kernels, they could always corrupt the kernel into decrypting the
> > > image or giving you the unsealed key, but there's no real way of
> > > preventing that even with PCR sealing or lockdown, so the basis for
> > > the threat model is very much my laptop in my possession running my
> > > kernel.
> >=20
> > I'm not entirely sure I agree.  With a TPM-aware bootloader, it
> > really ought to be possible to seal to PCRs such that a corrupted
> > kernel can't restore the image.  Obviously a *compromised* but
> > otherwise valid kernel will be able to restore the image.
>=20
> It is possible to seal the key so that only the same booted kernel can
> restore the image, yes.  One of the measurements that goes into the
> boot log is the hash of the kernel and you can seal to this value ...
> obviously if you upgrade your kernel RPM (or shim or grub) this value
> changes and you'd lose the ability to restore the hibernated image, but
> since the image is very kernel specific, that's probably OK.

Non-ancient kernels actually support hibernation by one kernel and
restore by another one.

But yes, normally it is same kernel binary doing hibernation and
restore.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw2c3AACgkQMOfwapXb+vJsLQCfQpFcrOhA1gXr6iyY8t2KD3C7
e9wAnR2l05dQ/Z/mafMvvKDMZM5JLHog
=KQIG
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
