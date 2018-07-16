Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A87208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F69KNs65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A87208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeGPIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:22:18 -0400
Received: from ozlabs.org ([203.11.71.1]:49071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeGPIWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:22:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TbMD0wFpz9ryt;
        Mon, 16 Jul 2018 17:56:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531727768;
        bh=oTJdxMAy9UumQi6IHTkchMNRFGrFcubKOHbsuMVQPW0=;
        h=Date:From:To:Cc:Subject:From;
        b=F69KNs65vJVsVZLtN/h45K2rjdBst+kD2QrsHdup85V8UA6ImIN0QWTWESDgNqjqd
         sHeKQa9z2+fCVytkl5NBmWZqefX4Rcsrw32eSwifeGogLbhMuFDIlGLU+zyYDHZSQ/
         vSr2d1GiYBaSkzk9pL+FDOII8wAwdbIFBPgxzp3yyrC3twDxHtDHhf65pCpoR7pGxh
         hZC8mrCEjmrpoFqB54Q3W7PQdyxIkFnlzdPR2b8+R6ngoexgh0SYFEnlbgP5QilE+6
         /XvoBxoaqVJlLX030w1ixHBH8R46ShVwLbQcONTpHPHgka5AUGVZjDV2i0Lo0oI0CJ
         iHSMFYLiOEnsQ==
Date:   Mon, 16 Jul 2018 17:56:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 16
Message-ID: <20180716175607.66099a5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FKS3XK1H8Uv.3a0NTAZfCtd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FKS3XK1H8Uv.3a0NTAZfCtd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180713:

The arm-soc tree gained a build failure so I used the version from
next-20180713.

Non-merge commits (relative to Linus' tree): 6029
 5901 files changed, 216652 insertions(+), 121372 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 283 trees (counting Linus' and 65 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.



--=20
Cheers,
Stephen Rothwell

--Sig_/FKS3XK1H8Uv.3a0NTAZfCtd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltMT5cACgkQAVBC80lX
0GzLiwgApCVFePPQyCCuY8PHZlwQB1tY5HiyvHDJGqdk7SgBJN49TQDbWGB6aJy7
ACLznX8IGPNwqFNhD2hj9uOhPrpJFGkAim1YeFYmdaGhAkTp3x8QvqLJxLGl3qYp
CmXANRq5mE0MRha+pq+LfyZf6a/Z8BRGWXlN4ws/+g9ugcZ2y1wS5UEy7UK7ybqr
oaRISl+crSI2Axd+tDMqGlYLpJowhr7iJywGbFSlwgUTqErgxsMER71M/IF7GY6D
vXFBxGYPXIrVwmGIJ20mcKEtiBZytw4rpadNLeH9txqz5yBb3cnPU5kLrJRewmiG
cvQ8E2F4BKxwBjZfj8yDx5hfk9uwbQ==
=+lIO
-----END PGP SIGNATURE-----

--Sig_/FKS3XK1H8Uv.3a0NTAZfCtd--
