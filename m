Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087FC24E1D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H8LMj7l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087FC24E1D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934165AbeF2Htx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:49:53 -0400
Received: from ozlabs.org ([203.11.71.1]:43289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933688AbeF2Htw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:49:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41H81p4Z0vz9ryk;
        Fri, 29 Jun 2018 17:49:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530258590;
        bh=eZwnbnYkDpgnsF3ygSfGRR6cNBXqh2iXAju8mkAh9xg=;
        h=Date:From:To:Cc:Subject:From;
        b=H8LMj7l4HrHOASte02kC43PPFu4JXzRGa6SwYG5Qskkhnv05rvVM2LNmQNtLfqjNg
         WNJzdUA3S3z7AO6LTM9unCpREgpfz6pWnto7cwctsa8oDR6Ga9RjEfzmT2/ywogqYA
         yZJsJK/FuQZOOJ8KFEastlk7xlDHscRBeQA3x1JOuHWoHWhXirWt+F6GHE5xx0MU+Y
         jj/iwQZEJLR6w3wtjZa9/mVCSmLsd6Mjjl9GmoJOfE6SevzF87UTpenuKfK5ynTL4l
         QRjHbo3PmgzMUgeGVraHvbk5fiZ5HVuZLYm82AZgKacC0gop55Bkd13BIyfA+AGjBV
         x8t1QN7ddXn9g==
Date:   Fri, 29 Jun 2018 17:49:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180629174946.1b4f40ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kC6n6m0sbVYWzVTz_IMJyL+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kC6n6m0sbVYWzVTz_IMJyL+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from include/linux/kernel.h:10:0,
                 from include/linux/list.h:9,
                 from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:51,
                 from include/linux/seqlock.h:36,
                 from include/linux/time.h:6,
                 from fs/proc/inode.c:9:
fs/proc/inode.c: In function 'proc_init_kmemcache':
include/linux/compiler.h:339:38: error: call to '__compiletime_assert_110' =
declared with attribute error: BUILD_BUG_ON failed: sizeof(struct proc_dir_=
entry) >=3D SIZEOF_PDE
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:319:4: note: in definition of macro '__compiletime=
_assert'
    prefix ## suffix();    \
    ^~~~~~
include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_a=
ssert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_a=
ssert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
fs/proc/inode.c:110:2: note: in expansion of macro 'BUILD_BUG_ON'
  BUILD_BUG_ON(sizeof(struct proc_dir_entry) >=3D SIZEOF_PDE);
  ^~~~~~~~~~~~

Caused by commit

  527ae8759f10 ("proc: fixup PDE allocation bloat")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kC6n6m0sbVYWzVTz_IMJyL+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls15JoACgkQAVBC80lX
0Gy4UQf/ZmPl9OWfJxZMfy995TKmvAjaa7Qkzxy522Ov4X7v8WnKi/RA4vQJ3RAo
T3s5KDwLRFRgWHFFVQZjv+Bc2VjQOAQzhqyWiG1YNsV/K6hY5U8T5zXhl0YQBF3t
9gyt98yZuQ5lQA7G+Q5vM03Gz9JptuRQ162ahBZmMajqKxYRVYxbFd5hIxTCCyc2
qzBg6HGnbSqBNPJJ8zTflaZo6UpbqHjEWjBRPrBnWhfIhKzWuKEz6ZX9PYBM79kk
fcG2m4RVqtwpscTH65XX0I1qhUqjSuHDFZZhxg8b//IVuu5HJjK59K2VFXcVow/A
hJHfGBlh40DHuFOiz+kr8WGh2Ypl/A==
=rHHR
-----END PGP SIGNATURE-----

--Sig_/kC6n6m0sbVYWzVTz_IMJyL+--
