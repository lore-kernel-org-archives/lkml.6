Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB474C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BAB2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pvpfD1GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfBBVdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:33:17 -0500
Received: from ozlabs.org ([203.11.71.1]:43399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfBBVdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 16:33:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43sRzF1zLwz9s4Z;
        Sun,  3 Feb 2019 08:33:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549143193;
        bh=99lhwY/OGswJwkhzOKiMQ5o9GVYBvyfNKaAGgRHZNas=;
        h=Date:From:To:Cc:Subject:From;
        b=pvpfD1GC9rHBhS9WJnm8hxdqVBZVZPJQX+TeT29/dLw1lSrVU5c1sJ6pCz8HHUGKx
         V9bNUme/RjeKyIkjdG1xce/7JqwiREN6wH90kpLANatuo8wjodIHbQsoupGTo0HVVw
         x0xzxU3oTeOHpFHPWkhtD8DU4xzudOvCboU53jiJJ5wWVQc5xVA0H6KSwZ6bYUI3MY
         F/Lz2QQv4tJbaKnQnxC1I37I/N90uKtqyrAGur15zdFtcjyDDgi+hrHgMkAkRDm5zI
         vX4LERMEkzEhJSi6hCPySjQ9J/m+Ip73xF72ICp1d2xmduqoWW/bA/Y4KQkl1rAVgT
         KwbPkE1XpKELw==
Date:   Sun, 3 Feb 2019 08:33:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andreas Schwab <schwab@suse.de>, Palmer Dabbelt <palmer@sifive.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: Fixes tag needs some work in the origin tree
Message-ID: <20190203083310.12b97619@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.zZ9TSU4MuKdwxg66cFvAFz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.zZ9TSU4MuKdwxg66cFvAFz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[Just a reminder for the future.]

Hi all,

In commit

  2bb10639f12c ("RISC-V: fix bad use of of_node_put")

Fixes tag

  Fixes: 94f9bf118f ("RISC-V: Fix of_node_* refcount")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/.zZ9TSU4MuKdwxg66cFvAFz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxWDJYACgkQAVBC80lX
0GxoPgf9HfjG1zGR/52aXHCLUzJ+uvffNhoPqDDkxVtcjZjO6TvUj416ooVWXHNg
3ZIY+NZ3sUFKq6RNVw0UjpSvQ/pXOVYT+U1OtwmQ2u67rZhb66VQmVTfYTIbKS53
Z6PXrAX6KC6N1c9MK39a2UUjYx2CgEIrRQKVpgcWXKnoK8vu6l8KIb1c9KzKAWYs
sybuBmsyjW/2Bfy4Ko7amVrpIC8m0GaLfDtFrDuhe+sbbY1sI7iHrYoeQDYEGcSo
VzypM6mTnipvu56EWTTa1l7pTs+w7JJa/gIQ9Ixrg1XUQVGumLBkpDDvKVFyomUd
qN79cJHZun6E5iNiz5C4w1tX5mDylQ==
=vNha
-----END PGP SIGNATURE-----

--Sig_/.zZ9TSU4MuKdwxg66cFvAFz--
