Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD1FF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B6920893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B6920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeG2NIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:08:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51809 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeG2NIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:08:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9E5FE80647; Sun, 29 Jul 2018 13:37:55 +0200 (CEST)
Date:   Sun, 29 Jul 2018 13:37:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't let getdents return bogus names
Message-ID: <20180729113755.GB7333@amd>
References: <20180716194843.252772-1-jannh@google.com>
 <20180716195657.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20180716195657.GO30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-16 20:56:57, Al Viro wrote:
> On Mon, Jul 16, 2018 at 09:48:43PM +0200, Jann Horn wrote:
> > When you e.g. run `find` on a directory for which getdents returns
> > "filenames" that contain slashes, `find` passes those "filenames" back =
to
> > the kernel, which then interprets them as paths. That could conceivably
> > cause userspace to do something bad when accessing something like an
> > untrusted USB stick, but I'm not aware of any specific example.
> >=20
> > Instead of returning bogus filenames to userspace, return -EUCLEAN.
>=20
> Because there's such a lot of userland code that expect and handles that
> error value...
>=20
> I'm not sure if this mitigation is actually better than "just return it
> as-is", TBH.

Well, userspace should handle errors.. it may not understand what this
particular error means, but that's still better than risking issues
with / in path....

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltdpxMACgkQMOfwapXb+vLXiwCgvna3Iw+Gbdg1U/GXNW0JeBwb
6GgAn1X3GXWcK1tPTRBGUd5bAnxB4dSI
=Io9+
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
