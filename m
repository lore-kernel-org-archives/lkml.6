Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D8920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D8920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbeGXNLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:11:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52289 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbeGXNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:11:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 40B4C80558; Tue, 24 Jul 2018 14:05:42 +0200 (CEST)
Date:   Tue, 24 Jul 2018 14:05:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
Message-ID: <20180724120541.GE26036@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
 <20180718202235.GA4132@amd>
 <20180718235851.GA22170@sandybridge-desktop>
 <20180719110149.GA4679@amd>
 <20180719132003.GA30981@sandybridge-desktop>
 <20180720102532.GA20284@amd>
 <1532346156.3057.11.camel@suse.com>
 <20180723122227.GA30092@amd>
 <20180723163848.GB4503@sandybridge-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20180723163848.GB4503@sandybridge-desktop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Yes. But you are objecting to encryption in kernel space at all,
> > > aren't you?
> >=20
> > I don't particulary love the idea of doing hibernation encryption in
> > the kernel, correct.
> >=20
> > But we have this weird thing called secure boot, some people seem to
> > want. So we may need some crypto in the kernel -- but I'd like
> > something that works with uswsusp, too. Plus, it is mandatory that
> > patch explains what security guarantees they want to provide against
> > what kinds of attacks...
> >=20
> > Lee, Chun-Yi's patch seemed more promising.				Pavel
> >=20
> The only difference between Chun-Yi's hibernation encrytion solution
> and our solution is that his strategy encrypts the snapshot from sratch,=
=20
> and ours encryts each page before them going to block device. The benefit
> of his solution is that the snapshot can be encrypt in kernel first
> thus the uswsusp is allowed  to read it to user space even kernel
> is lock down. And I had a discussion with Chun-Yi that we can use
> his snapshot solution to make uswsusp happy, and we share the crypto
> help code and he can also use our user provided key for his signature.
> >From this point of view, our code are actually the same, except that
> we can help clean up the code and also enhance some encrytion process
> for his solution. I don't know why you don't like encryption in kernel,=
=20
> because from my point of view, without encryption hibernation in kernel,
> uswsusp could not be enabled if kernel is lock down : -) Or do I miss som=
ething?

We can do encryption in kernel if really needed, but I don't have to
like it, do I? :-).

I understand what Chun-Yi's code is trying to do. I can't say the same
about yours.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltXFhUACgkQMOfwapXb+vLnWwCeJAvOynLyjmdkzUL2tSyyomge
OtoAn1Q7/LfOdO5IWHWO83ULyQXgfb4p
=bAyw
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
