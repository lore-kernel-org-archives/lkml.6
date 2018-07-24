Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17921C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E5020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E5020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbeGXOLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:11:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53692 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388279AbeGXOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:11:24 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 845C68051E; Tue, 24 Jul 2018 15:04:58 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:04:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Yu Chen <yu.c.chen@intel.com>,
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
Message-ID: <20180724130457.GB29006@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
 <20180718202235.GA4132@amd>
 <20180718235851.GA22170@sandybridge-desktop>
 <20180719110149.GA4679@amd>
 <20180719132003.GA30981@sandybridge-desktop>
 <20180720102532.GA20284@amd>
 <1532346156.3057.11.camel@suse.com>
 <20180723122227.GA30092@amd>
 <1532432981.17797.13.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <1532432981.17797.13.camel@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-24 13:49:41, Oliver Neukum wrote:
> On Mo, 2018-07-23 at 14:22 +0200, Pavel Machek wrote:
>=20
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
>=20
> Hi,
>=20
> very well, maybe we should state clearly that the goal of these
> patch set is to make Secure Boot and STD coexist. Anything else
> is a nice side effect, but not the primary justification, right?
>=20
> And we further agree that the model of Secure Boot requires the
> encryption to be done in kernel space, don't we?
> Furthermore IMHO the key must also be generated in trusted code,
> hence in kernel space. Yu Chen, I really cannot see how
> a symmetrical encryption with a known key can be secure.

Nicely said. Yes, this is the message I was trying to get across.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltXI/kACgkQMOfwapXb+vJ+ewCghIg2fa7yTlSaIb0/9kAwh5kX
iGkAniIMjQO7Ya9aUYd/svOSXMPHmWqt
=EpGN
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
