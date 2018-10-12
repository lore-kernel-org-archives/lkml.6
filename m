Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E79C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851602098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kcreWZgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851602098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJLJo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:44:56 -0400
Received: from ozlabs.org ([203.11.71.1]:40427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeJLJoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:44:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WWcl2gzfz9s47;
        Fri, 12 Oct 2018 13:14:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539310490;
        bh=wjKR/4I5eJzBI/bon/+z+4U3r6ozLwdwHa4v1UEGMkY=;
        h=Date:From:To:Cc:Subject:From;
        b=kcreWZgV5sXY3FDjaC1tCH4n5seN+p6uFdpQPSU/4JkuUmyBtlkZf12+D8wy3Q4vl
         BfRMYw+lpacGoDn2pcabg6k6qBEztlVzQFIaDhF9xxrlUm4VFL0Fb+R5UwM7Pxn9cs
         AE1Q5uvb8xfYf/BuLgncuM48jpzwbB4a3wK/mTibY+hQyLyI36leXlsIU7DkrZfqKa
         bFsY4OclTiH7V/upJdliuNKnV7anp6yrUhkKwI93SIxRbN/dKsuNPV+Odil/F2lxqH
         KfChqw/Xjpcj8m02WoYqwKgBkXZuGAezI/k4DdLkSChqWal9QoqzJJJ/EjPc00uIgC
         K8xBFgSEaxAqA==
Date:   Fri, 12 Oct 2018 13:14:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20181012131444.605564b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ezwu5_G0L7Bz8/2204BEODX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ezwu5_G0L7Bz8/2204BEODX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/mm/pgtable.c

between commit:

  184d47f0fd36 ("x86/mm: Avoid VLA in pgd_alloc()")

from Linus' tree and commit:

  1be3f247c288 ("x86/mm: Avoid VLA in pgd_alloc()")

from the tip tree.

I fixed it up (I used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ezwu5_G0L7Bz8/2204BEODX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvAA5QACgkQAVBC80lX
0GwR5Af9F75MRgtsrz9Y+fOsgP1yq5zOeKFdXDVKnSBRrqMAfEZGPdIwsmJHEU+E
YiJ7q941M8UnYWnocIa/UrwgYxV9wRuj3p8zXX7O4gj4OmcJyAWYkj+C8SJ0qpGi
WypKz+WUetVgdGdYzGukFR0ch6kcMSjD6r3Fce91HPpNBRAAkAClak+uyUagGUgy
ZLjDsrJGvAiLPGnM9qaixRZ3IctCYUoi6CL4p/RR60KM+4+FQca2M3J+Yla7epJS
sr8EIHUn9utVWoN9L4YwqdQ53Y7uGeofYhoJnFWN1/Mty8es9cqkq1HY2fiseviL
ERD1Frt6mdt7BpWXLPpUMm50CXyC2g==
=2yu+
-----END PGP SIGNATURE-----

--Sig_/ezwu5_G0L7Bz8/2204BEODX--
