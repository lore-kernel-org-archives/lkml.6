Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 50379C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F162B208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JLZJrfBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F162B208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935933AbeFMXkN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:40:13 -0400
Received: from ozlabs.org ([203.11.71.1]:47571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935490AbeFMXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:40:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415jsj1MM2z9s01;
        Thu, 14 Jun 2018 09:40:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528933209;
        bh=6NQ4wTWX/azfgfaYiQ+z7bRkypvxKk+A8S5NjdIkRbw=;
        h=Date:From:To:Cc:Subject:From;
        b=JLZJrfBCQkSH1MaguE9TisYzot+J8KCuPJxTYCIjmm+UtCp3F1NmbBM2XJZFganJ0
         joxHYLuxnG2+FvsBwfu2xAIu0iJnjL1Rl3vBAsc2lccTXtxyv45SqxrSvELvvupDhv
         RjPHNCgG/N7sLHcti7mX20t9N8OHNHPBSgHZpD2pfzhjT9gPT+Eax//yO9TDt6Upjs
         rXlvXv+ob7VXx6FT2+fjnDHoIayu5+LBOtCPaiufC4T1FrLblJGLDwggscG/9b1Wjv
         AFtJaA/c7/t85+bs5mU6EDfLlXr6V3Kqy6zeMRkvi2hipp6/832qA8POa6phv4Qbn3
         wGEqRFrTLlCrQ==
Date:   Thu, 14 Jun 2018 09:40:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>
Subject: linux-next: manual merge of the fbdev tree with Linus' tree
Message-ID: <20180614094005.7de2c95e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cLOMUZHCCuKOBXT_COQpXhm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cLOMUZHCCuKOBXT_COQpXhm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/mmp/fb/mmpfb.c

between commit:

  6396bb221514 ("treewide: kzalloc() -> kcalloc()")

from Linus' tree and commit:

  e0e894f59418 ("video: fbdev-MMP: Delete an error message for a failed mem=
ory allocation in two functions")

from the fbdev tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/video/fbdev/mmp/fb/mmpfb.c
index f27697e07c55,292b3e403044..000000000000
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@@ -493,12 -493,11 +493,11 @@@ static int modes_setup(struct mmpfb_inf
  		return 0;
  	}
  	/* put videomode list to info structure */
 -	videomodes =3D kzalloc(sizeof(struct fb_videomode) * videomode_num,
 -			GFP_KERNEL);
 +	videomodes =3D kcalloc(videomode_num, sizeof(struct fb_videomode),
 +			     GFP_KERNEL);
- 	if (!videomodes) {
- 		dev_err(fbi->dev, "can't malloc video modes\n");
+ 	if (!videomodes)
  		return -ENOMEM;
- 	}
+=20
  	for (i =3D 0; i < videomode_num; i++)
  		mmpmode_to_fbmode(&videomodes[i], &mmp_modes[i]);
  	fb_videomode_to_modelist(videomodes, videomode_num, &info->modelist);

--Sig_/cLOMUZHCCuKOBXT_COQpXhm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlshq1UACgkQAVBC80lX
0Gw6fgf+PeHsaHLzCdwE+tyKvNXYES8QeujT+UEkzGz1lbyTZPJv41UvwqWsDFbI
B2DpIXuF9TNjEsxtFvxv9zqS92VK8qIcbVxTrR3ul0d3j3nPxMAjLCl9g4EjBdQ+
8XP7QB6gX8Ov9q+T3VtTazSJYVMe9FE+fysC4IDQKhrH/tVP+2BPK2/XW146u7ku
5RuQF0OkpVZUoUr07YoMCr+Vb/5AJkLevVCkHq9HawJ+W+eUyAzHVzD1AYHsK3Rv
AliulTE3WnDWAtSjUut423Ng5XJv57FWJFD8dVbjLgmi+33cR5vKauHODg92sAS9
UlE6TfpXNHbIlgMn7tTZTT/JhhRB6Q==
=bBIz
-----END PGP SIGNATURE-----

--Sig_/cLOMUZHCCuKOBXT_COQpXhm--
