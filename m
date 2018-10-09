Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F40EC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D122085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qvRz68xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D122085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIOCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:02:09 -0400
Received: from ozlabs.org ([203.11.71.1]:35255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeJIOCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:02:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Tnns6Njnz9s8r;
        Tue,  9 Oct 2018 17:46:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539067602;
        bh=VQGoBfHO8kvMcW1ICNyu9Ctt3UyUO3MR0ADujx3zqqU=;
        h=Date:From:To:Cc:Subject:From;
        b=qvRz68xA3+gI8XV8LIAYbczjuFVaFd0YjSNwC9EryHD2SjhFTXeCtciB2EDIZbPvt
         ogm3ezWmhWL/gwgFaF1z4Ge5e7ob/4bA0Rh4SLLtE1xUOvP6OjAJvWpMFloVsPycxd
         ge7DMOyWxOLJj+bp7lapZ6TtBZ/rrkjtcMr7e/+BM8NS7x+B0W5fsEImNx3LhUOlWM
         SRTTR9TTWbAO+Y4SUcz/lT9UZhvefwsenR+juDAvRssa3EutiS0FaJh0A5cO2nq6HF
         lXQj6r4V602XX9htnFlOdxXt2YZLr19bVuYqHAisDPCBQICXBzyNQpfpgtL0HepSym
         ipbtruAwaaPqA==
Date:   Tue, 9 Oct 2018 17:46:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the s390 tree
Message-ID: <20181009174639.24fbc2ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EZft1rkL7n2bOXoKB2mfZvh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EZft1rkL7n2bOXoKB2mfZvh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/s390/kernel/setup.c

between commit:

  b45248da1a33 ("s390: unify stack size definitions")
  ee46f78659ac ("s390: add support for virtually mapped kernel stacks")

from the s390 tree and commit:

  ab9c2b8deb1b ("memblock: remove _virt from APIs returning virtual address=
")

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/kernel/setup.c
index 2a20e6ef8369,2e29456ca11e..000000000000
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@@ -418,12 -357,8 +418,12 @@@ static void __init setup_lowcore(void
  	lc->last_update_timer =3D S390_lowcore.last_update_timer;
  	lc->last_update_clock =3D S390_lowcore.last_update_clock;
 =20
 -	restart_stack =3D memblock_alloc(ASYNC_SIZE, ASYNC_SIZE);
 -	restart_stack +=3D ASYNC_SIZE;
 +	/*
 +	 * Allocate the global restart stack which is the same for
 +	 * all CPUs in cast *one* of them does a PSW restart.
 +	 */
- 	restart_stack =3D memblock_virt_alloc(THREAD_SIZE, THREAD_SIZE);
++	restart_stack =3D memblock_alloc(THREAD_SIZE, THREAD_SIZE);
 +	restart_stack +=3D STACK_INIT_OFFSET;
 =20
  	/*
  	 * Set up PSW restart to call ipl.c:do_restart(). Copy the relevant

--Sig_/EZft1rkL7n2bOXoKB2mfZvh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu8Ts8ACgkQAVBC80lX
0GyEVggAi2TIY/DBlbClhB88s8QHDXmip9elVtwUaMbVhrenr37GIUXlh/L+QJiR
Lr7RUSJ3KDfxuRppylMcMLrmiDMx6YqNfS0qzT94FCdxvy3zbRm2pa11wm5/dewi
Hl07GmhqNt+6/jNCLh1W48UZf+REmTpdpwW3wkpaboOkV00vQouWy6CUF1YqRQHk
KbD6kW3II2VXR07O7wbKZ5P9Ck7iy7OL0afppynAKGac/kItuDXRlpFZUv2VdUQb
WcPL5vHbpTT+CNxCGR1ZSqeCmGHDt9KrB9Ze8yoeOqMh/yX7GcNAJne3sqoDy62x
Lj47wecnH1cC9OR4Q/4h7R2PkzYz3Q==
=JnFX
-----END PGP SIGNATURE-----

--Sig_/EZft1rkL7n2bOXoKB2mfZvh--
