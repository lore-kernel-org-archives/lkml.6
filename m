Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745BCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10856214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pm2niKlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10856214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeIXKjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:39:14 -0400
Received: from ozlabs.org ([203.11.71.1]:54283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeIXKjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:39:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42JWgL1WSrz9s8F;
        Mon, 24 Sep 2018 14:38:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537763939;
        bh=gsGsJMLeUzPXsva8iCq4uM+zGWVQA2f9njOVr8UPD1E=;
        h=Date:From:To:Cc:Subject:From;
        b=Pm2niKlSK127kId+SsK2C4vqs83kxteeQsWf70mt+sjaA4iZbJOrEN7yrxPdashG7
         pL6QeAi8KstwWkJj+yBUDIvlhzYAT5OVXWEgntSgk0g8fKyPeGZdUiHI50Di2VuCJu
         U8DAuJZPMg6uhtlo6Mw6r3k7GR1E+Fh/n4khzZTWkbvKQQt0uZR4Nr5BUe10u6Yvil
         2o6hvaFjLYijn8YOgXr45C5JKSw2sI+vw01qFH0wreMJEO7dZ9lrL7Js/54jdijj+D
         Fa0hyeRTcvF/798/nfbGiJc1HEHN2G7GfLY7+UH6Wwnu3h8enGz9cI4cR5JUHebLVO
         DbPTKzgK4TfAw==
Date:   Mon, 24 Sep 2018 14:38:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jia He <jia.he@hxt-semitech.com>,
        James Morse <james.morse@arm.com>
Subject: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20180924143853.0f6cc235@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H9NPypStBoDAPCLASOe0of0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H9NPypStBoDAPCLASOe0of0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm64/Kconfig

between commit:

  8a695a587333 ("arm64: Kconfig: Remove ARCH_HAS_HOLES_MEMORYMODEL")

from the arm64 tree and commit:

  e1405baa7db1 ("arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig
index da5e6f085561,f8a618a292f4..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -785,7 -786,8 +785,8 @@@ config ARCH_FLATMEM_ENABL
  	def_bool !NUMA
 =20
  config HAVE_ARCH_PFN_VALID
 -	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 +	def_bool y
+ 	select HAVE_MEMBLOCK_PFN_VALID
 =20
  config HW_PERF_EVENTS
  	def_bool y

--Sig_/H9NPypStBoDAPCLASOe0of0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluoal0ACgkQAVBC80lX
0GzA2gf+JPxzWjqtncHmMA8RMrcz6djQDW3CzrEtkwWtrnFuxYL9Lx9Yr4or6PuU
g7URYczAKCv70UvrMvEFWnIcWUQBBwUvwEfYxxBspuk8pq7YUaf4Awxolp0RxJFm
RoS2MHeLuAgRvqCJaQdzwCs9AzHom9Y8ZF0r06uFxbm0w3by9+aPwbvtagZ/vnDG
DDstnRphjNnxxqrCEPJB1zf0/SbaIEMOl08JsFwakBudTAv50EXc7dQS+vMNQGy9
1ojHaVGeqieiVfSWRr9tFK+a9aisRvbGxiRaHMeph54VvbzqeD9Shfm6bnP4UDbS
9oPNA8wZqoEoRaC79WNbvD3Thv0vwg==
=tlOH
-----END PGP SIGNATURE-----

--Sig_/H9NPypStBoDAPCLASOe0of0--
