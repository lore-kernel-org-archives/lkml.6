Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C03ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF0220875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF0220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbeGWNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:23:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45838 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWNX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:23:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 069B880387; Mon, 23 Jul 2018 14:22:27 +0200 (CEST)
Date:   Mon, 23 Jul 2018 14:22:27 +0200
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
Message-ID: <20180723122227.GA30092@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
 <20180718202235.GA4132@amd>
 <20180718235851.GA22170@sandybridge-desktop>
 <20180719110149.GA4679@amd>
 <20180719132003.GA30981@sandybridge-desktop>
 <20180720102532.GA20284@amd>
 <1532346156.3057.11.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1532346156.3057.11.camel@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > 2. Ideally kernel memory should be encrypted by the
> > >    kernel itself. We have uswsusp to support user
> > >    space hibernation, however doing the encryption
> > >    in kernel space has more advantages:
> > >    2.1 Not having to transfer plain text kernel memory to
> > >        user space. Per Lee, Chun-Yi, uswsusp is disabled
> > >        when the kernel is locked down:
> > >        https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/
> > >        linux-fs.git/commit/?h=3Dlockdown-20180410&
> > >        id=3D8732c1663d7c0305ae01ba5a1ee4d2299b7b4612
> > >        due to:
> > >        "There have some functions be locked-down because
> > >        there have no appropriate mechanisms to check the
> > >        integrity of writing data."
> > >        https://patchwork.kernel.org/patch/10476751/
> >=20
> > So your goal is to make hibernation compatible with kernel
> > lockdown? Do your patches provide sufficient security that hibernation
> > can be enabled with kernel lockdown?
>=20
> OK, maybe I am dense, but if the key comes from user space, will that
> be enough?

Yes, that seems to be one of problems of Yu Chen's patchset.

> > > Joey Lee and I had a discussion on his previous work at
> > > https://patchwork.kernel.org/patch/10476751
> > > We collaborate on this task and his snapshot signature
> > > feature can be based on this patch set.
> >=20
> > Well, his work can also work without your patchset, right?
>=20
> Yes. But you are objecting to encryption in kernel space at all,
> aren't you?

I don't particulary love the idea of doing hibernation encryption in
the kernel, correct.

But we have this weird thing called secure boot, some people seem to
want. So we may need some crypto in the kernel -- but I'd like
something that works with uswsusp, too. Plus, it is mandatory that
patch explains what security guarantees they want to provide against
what kinds of attacks...

Lee, Chun-Yi's patch seemed more promising.				Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltVyIMACgkQMOfwapXb+vIOHwCfWnqIbC9JuKoYO//G3dJDkF4H
cqYAnReOwwOusvgY1EgOrXWVBygOU3+J
=lsnx
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
