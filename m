Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C70C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A38204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A38204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeFUJBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:01:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49058 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFUJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:01:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E178B80555; Thu, 21 Jun 2018 11:01:43 +0200 (CEST)
Date:   Thu, 21 Jun 2018 11:01:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>, tytso@mit.edu
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers3@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Message-ID: <20180621090142.GB21807@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Wed 2018-06-20 17:40:51, Chen Yu wrote:
> crypto_hibernate is a user-space utility to generate
> 512bits AES key and pass it to the kernel via ioctl
> for hibernation encryption.(We can also add the key
> into kernel via keyctl if necessary, but currently
> using ioctl seems to be more straightforward as we
> need both the key and salt transit).

Ah, here you go:

https://en.wikipedia.org/wiki/Uswsusp

It can already do encryption. If you see problems there, patches will
be gladly accepted to fix them.

If you want to maintain uswsusp in kernel tree, I guess that would be
an option, too.

If you want to just help swsusp, I have some patches that reduce
duplicities between x86-32 and x86-64. It would be cool to clean them
up and get them merged.

> Suggested-by: "Theodore Ts'o" <tytso@mit.edu>

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsraXYACgkQMOfwapXb+vLpTACgoPaUypOAaz3Rq6lnFosS6iG0
uRYAmgPEWp/kWz9PDcNapGWIb3SAWlul
=SwCy
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
