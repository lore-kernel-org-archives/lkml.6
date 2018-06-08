Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YLUGF/4HGlu7AgAAmS7hNA
	; Fri, 08 Jun 2018 04:45:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 77C94607DC; Fri,  8 Jun 2018 04:45:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NhJ1hg6L"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D6BA86063F;
	Fri,  8 Jun 2018 04:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6BA86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeFHEpf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:45:35 -0400
Received: from ozlabs.org ([203.11.71.1]:41229 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbeFHEpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:45:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4128wp6KqLz9s1B;
        Fri,  8 Jun 2018 14:45:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528433131;
        bh=u47OcEjxHlhCB01i88ZfEXBfxksSTTezI55/sSTpXs8=;
        h=Date:From:To:Cc:Subject:From;
        b=NhJ1hg6LKDPS4KLTMBst66O2OdHcxxWm9xiSgJlIVOAQJabncb5rGcylnaolEk7wW
         DLLQTX5cBWhNZB8AS/JW9K5pSmTBMw577Iw+2HdVGfQgBXdjAcTSMWaXeEB1nw1smQ
         nkx2wyDxQLXQrCi2dbVav5HGsrfiEn8ym0MTwkzfVnIeCX5V6edNMrxIBtnUS7k1cM
         BIq3328wL/PAewK5fd9LbGwI8xjabhmaBu8r7BUes18XXcIJRu+b/4EPlCCG3Plbqi
         vZ/PA38dhHobcBmHv/fNJ/nW+3n4QD4oaALe8snGYwreU3KnINhwm7nG/kdv4HUJ3c
         uWuaTM/XvzItA==
Date: Fri, 8 Jun 2018 14:45:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20180608144530.782d7aee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7UF87IhDa62mIJnFa_Z=6bY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7UF87IhDa62mIJnFa_Z=6bY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from fs/fat/inode.c:24:0:
fs/fat/inode.c: In function '__fat_get_block':
fs/fat/inode.c:163:9: warning: format '%ld' expects argument of type 'long =
int', but argument 5 has type 'sector_t {aka long long unsigned int}' [-Wfo=
rmat=3D]
         "invalid FAT chain (i_pos %lld, last_block %ld)",
         ^
fs/fat/fat.h:397:24: note: in definition of macro 'fat_fs_error'
  __fat_fs_error(sb, 1, fmt , ## args)
                        ^~~

Introduced by commit

  3bdac70a1921 ("fat: use fat_fs_error() instead of BUG_ON() in __fat_get_b=
lock()")

--=20
Cheers,
Stephen Rothwell

--Sig_/7UF87IhDa62mIJnFa_Z=6bY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsaCeoACgkQAVBC80lX
0GyKVwf9HyNfDYXAt0Rc8u0Lm3gAVLRK8J8HF3k1OD3prNhlAUOheDD35kbD88Jv
GYhzbzrDeH7eAahSXaHt/5rCrSObX5dPz0F4SX1LrMwPwY3ll8DkfJrig8w0CujZ
KFTkL/gm5R51Hak5fdTVaPR9Nz3o30unbxqIu/abwY88mVoJaU20me0QWMUDLVQj
mkKrq3bJd6d0frubilUHNOnWXjZZSRHmugNiuOkr9GKXa5YabGegBXfLMLbtNRaJ
k/LLIznRh9/Z7AeO6UbmYJMW0EwoeTbO/CGBiR19S6dUZXGajQ6yTjdEWy00O31x
+qtFo/JheKXMA3sHQ0zcAb3CvsP+UQ==
=YGvW
-----END PGP SIGNATURE-----

--Sig_/7UF87IhDa62mIJnFa_Z=6bY--
