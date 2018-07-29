Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21F6FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D7A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeG2NIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:08:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51803 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeG2NIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:08:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 642EC80646; Sun, 29 Jul 2018 13:37:50 +0200 (CEST)
Date:   Sun, 29 Jul 2018 13:37:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180729113749.GA7333@amd>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add a sample program to demonstrate fsopen/fsmount/move_mount to mount
> something.

> @@ -0,0 +1,118 @@
> +/* fd-based mount test.
> + *
> + * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */

Can we do SPDX here?

> +static void check_messages(int fd)
> +{
> +	char buf[4096];
> +	int err, n;
> +
> +	err =3D errno;
> +
> +	for (;;) {
> +		n =3D read(fd, buf, sizeof(buf));
> +		if (n < 0)
> +			break;
> +		n -=3D 2;
> +
> +		switch (buf[0]) {
> +		case 'e':
> +			fprintf(stderr, "Error: %*.*s\n", n, n, buf + 2);
> +			break;
> +		case 'w':
> +			fprintf(stderr, "Warning: %*.*s\n", n, n, buf + 2);
> +			break;
> +		case 'i':
> +			fprintf(stderr, "Info: %*.*s\n", n, n, buf + 2);
> +			break;
> +		}
> +	}

Hmm, so kernel now returns messages in english? Not sure that is
reasonable, as that is going to cause problems with translations...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltdpw0ACgkQMOfwapXb+vJVPQCfTdFl0Cg4welkfP0BroZo+10H
ipEAnA2qnvw/D+ipZkAGPHJU8lECpTM1
=IODW
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
