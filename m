Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A41FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BF21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfBOTT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:19:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39988 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfBOTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:19:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 215358041E; Fri, 15 Feb 2019 20:19:48 +0100 (CET)
Date:   Fri, 15 Feb 2019 20:19:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     rjones@redhat.com, kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190215191953.GB17897@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I watched fosdem talk about
nbdkit... https://www.youtube.com/watch?v=3D9E5A608xJG0 . Nice. But word
of warning: I'm not sure using it read-write on localhost is safe.

In particular, user application could create a lot of dirty data
quickly. If there's not enough memory for nbdkit (or nbd-client or
nbd-server), you might get a deadlock.

Also note that nbd.txt in Documentation/blockdev/ points to
sourceforge; it should probably point to
https://github.com/NetworkBlockDevice/nbd ?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxnENkACgkQMOfwapXb+vL+EQCfZXt/MloA/a8FFjwc20cRijma
JTgAoL13Win1MIZDJWucp+Rxsm+EQaon
=93hc
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
