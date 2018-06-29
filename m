Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80705C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C70127962
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fputi9NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C70127962
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933407AbeF2GGP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:06:15 -0400
Received: from ozlabs.org ([203.11.71.1]:43873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeF2GGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:06:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41H5kC67mhz9s01;
        Fri, 29 Jun 2018 16:06:11 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530252372;
        bh=qhJsegPAjVuFSlPGzzu2VY1L18Pmi78vXOu9PpqCTuQ=;
        h=Date:From:To:Cc:Subject:From;
        b=fputi9NVQjWocMWr4xL4mHqOvc+S3aXMhOqUqJuBc3QtF8LmOInyoqvRXbhmkbeYa
         nnEQaGRAOMUBx4/aFVRO4tjHenBWJ+vihZF3zpL1uxJXaDIzmyZReCerTsS4YBgShS
         bHSzn1Bu7JC0GY2DMs/BDB13o0AlgynIs7SfE9ipIOXdxkpKisug7/e7wW0C693lfi
         c0aPwEB0QDCmHbs9d82aXfGopVi8QMa+ttXYBSlc3UHKdg3XpMFifQm23npoqiDs2Z
         hAmhTZIZOppBAr0PYs1r1eT8kHswwvMSCjee92PqwI/XxJzWX+aMgXItY0v3ZCTcMr
         d2hqbpkCHcPoQ==
Date:   Fri, 29 Jun 2018 16:06:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20180629160610.5abd17c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uW3YB7B95BxXcRBkn=3QYaN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uW3YB7B95BxXcRBkn=3QYaN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Theodore,

After merging the random tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/mmzone.h:10:0,
                 from include/linux/gfp.h:6,
                 from include/linux/umh.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from drivers/char/random.c:242:
drivers/char/random.c: In function 'random_ioctl':
drivers/char/random.c:1973:32: error: 'random_wait' undeclared (first use i=
n this function); did you mean 'random_write'?
    wake_up_interruptible_poll(&random_wait, POLLIN);
                                ^
include/linux/wait.h:216:12: note: in definition of macro 'wake_up_interrup=
tible_poll'
  __wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
            ^
drivers/char/random.c:1973:32: note: each undeclared identifier is reported=
 only once for each function it appears in
    wake_up_interruptible_poll(&random_wait, POLLIN);
                                ^
include/linux/wait.h:216:12: note: in definition of macro 'wake_up_interrup=
tible_poll'
  __wake_up(x, TASK_INTERRUPTIBLE, 1, poll_to_key(m))
            ^

Caused by commit

  e4f3df9712bb ("random: Wake up writers when random pools are zapped")

interacting with commit

  a11e1d432b51 ("Revert changes to convert to ->poll_mask() and aio IOCB_CM=
D_POLL")

from Linus' tree.

I took a stab and applied the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 29 Jun 2018 15:43:01 +1000
Subject: [PATCH] random: fix up for revert of poll_mask changes

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 00db7aed3204..d686aa2a129b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1970,7 +1970,7 @@ static long random_ioctl(struct file *f, unsigned int=
 cmd, unsigned long arg)
 		input_pool.entropy_count =3D 0;
 		blocking_pool.entropy_count =3D 0;
 		if (random_write_wakeup_bits) {
-			wake_up_interruptible_poll(&random_wait, POLLIN);
+			wake_up_interruptible_poll(&random_write_wait, POLLIN);
 			kill_fasync(&fasync, SIGIO, POLL_OUT);
 		}
 		return 0;
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/uW3YB7B95BxXcRBkn=3QYaN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1zFIACgkQAVBC80lX
0GwHvAf+L2N9Iey4ayCFP/sBek5BrbC6Lvb/E1zhzIs3+m1rX1xK5X2V5JMDO98k
zVIxKR4EuUzWup5KpsF2vbAj/BTsLjBPOQ2/sXFpGisI0sMNYTucKj/VKc5ciOSX
Y88HUUVQdJItTkiFGX1GQOk7jDVfXMoc1Jb7zu/1GoICSea+OyAB381POGKkLCOx
ak2pWfQKs/jScFcl14DnTZDeQiaOO/ISHIjWPgC40xO6UCgBWMi2TYRl7JRBQ6NP
9WjYEJi342f+D+Pc4Gr7Zs6MPFiZ5oJs6AEhGSbcV+wIoSI4ZGmjS+BZSIpbPqp4
U5Je2g4pWXPv7Nq6SG25ex5y8yPbIQ==
=36uH
-----END PGP SIGNATURE-----

--Sig_/uW3YB7B95BxXcRBkn=3QYaN--
