Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9559BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465642411F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iGedchrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465642411F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeGEEga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 00:36:30 -0400
Received: from ozlabs.org ([203.11.71.1]:37507 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbeGEEg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 00:36:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LlRt6Pl7z9s1b;
        Thu,  5 Jul 2018 14:36:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530765386;
        bh=mUl+0qiDZA58IWfvLcLta2IEKjEWrRm3gg9avl9ddeE=;
        h=Date:From:To:Cc:Subject:From;
        b=iGedchrHToISp5lY0kEQIZCeht0R2gDSgzdmVbHIRTSk3c5kZXmZ08HBoxAy23kiO
         Nd1FVMLZZhaBvFYf/fE7qkaCn+O11j//0KO+Ym0GMyHl3g2d6Ni6YZPwKbF9kkNJY4
         KMDCHM1Sk4sBtGpRiuW1ARvOdQGeUIFAh15DSDfPK1VZd3g5Jc9RjzyJA8pw79Q76g
         6ME23DLyKQZLmjjs03bln+eWUycLvbCRNooE6Wwqluaui6S2VAXytNs00L/kDbBClj
         R83aRnvZEH8DeJn9a4JqiD5B01ecbx1dXhbYTJtO/W5GhK0ieGTNERPMCRDMqTU2fq
         sMCxA8azUpBtw==
Date:   Thu, 5 Jul 2018 14:36:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the ida tree
Message-ID: <20180705143626.70ddefcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H+GHONWwqxWVXl1Rbh98rZR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H+GHONWwqxWVXl1Rbh98rZR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ida tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/kernel.h:14:0,
                 from include/asm-generic/bug.h:18,
                 from arch/powerpc/include/asm/bug.h:128,
                 from include/linux/bug.h:5,
                 from arch/powerpc/include/asm/mmu.h:126,
                 from arch/powerpc/include/asm/lppaca.h:36,
                 from arch/powerpc/include/asm/paca.h:21,
                 from arch/powerpc/include/asm/current.h:16,
                 from include/linux/mutex.h:14,
                 from arch/powerpc/platforms/powernv/vas-window.c:13:
arch/powerpc/platforms/powernv/vas-window.c: In function 'vas_assign_window=
_id':
arch/powerpc/platforms/powernv/vas-window.c:528:42: error: 'VAX_WINDOWS_PER=
_CHIP' undeclared (first use in this function); did you mean 'VAS_WINDOWS_P=
ER_CHIP'?
   pr_err("Too many (%d) open windows\n", VAX_WINDOWS_PER_CHIP);
                                          ^
include/linux/printk.h:304:33: note: in definition of macro 'pr_err'
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                 ^~~~~~~~~~~
arch/powerpc/platforms/powernv/vas-window.c:528:42: note: each undeclared i=
dentifier is reported only once for each function it appears in
   pr_err("Too many (%d) open windows\n", VAX_WINDOWS_PER_CHIP);
                                          ^
include/linux/printk.h:304:33: note: in definition of macro 'pr_err'
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                 ^~~~~~~~~~~

Caused by commit

  bbf959d51112 ("ppc: Convert vas ID allocation to new IDA API")

I applied the following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 5 Jul 2018 14:33:40 +1000
Subject: [PATCH] ppc: fixup for "Convert vas ID allocation to new IDA API"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/powernv/vas-window.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/pla=
tforms/powernv/vas-window.c
index d313b38846eb..97c9b4863609 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -525,7 +525,7 @@ static int vas_assign_window_id(struct ida *ida)
 	int winid =3D ida_alloc_max(ida, VAS_WINDOWS_PER_CHIP, GFP_KERNEL);
=20
 	if (winid =3D=3D -ENOSPC) {
-		pr_err("Too many (%d) open windows\n", VAX_WINDOWS_PER_CHIP);
+		pr_err("Too many (%d) open windows\n", VAS_WINDOWS_PER_CHIP);
 		return -EAGAIN;
 	}
=20
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/H+GHONWwqxWVXl1Rbh98rZR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9oEoACgkQAVBC80lX
0GwrUwgAlDbxi1X1hhUxdHaP6NK835oCZU5J8b2qTdh1INzFlu0Nbumb8KpQHFL+
xQ4i9HmiWwn8aJCOEo5Hs8jFE2iqmn2yFbRQCbXKgTcjA1Rgu/NDJAxEuZpsl2Oz
yJiE5Ofm2BFlwO2lxYZ3uaFefkp7AIrvi90WqBZHUCIAVnTu2ffoqIHotS+BVO5/
Sqb5PjKb6LA05G6Uy2LHsjmb06dXLjj5yd/594tjb1jy3UuDdliAV6y9dO02BkeM
x9CvI8B1ZOtSoZaEydu7/JiV9bpuJRu5FlAv4dtDNoIuXyErhDTOxECqxpXLpAjK
gBmVijBiEOp5cIU18PqOc7d37Vqkuw==
=pRG8
-----END PGP SIGNATURE-----

--Sig_/H+GHONWwqxWVXl1Rbh98rZR--
