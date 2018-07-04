Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4454C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618DF23CCB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qxDImSZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618DF23CCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeGDDaM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:30:12 -0400
Received: from ozlabs.org ([203.11.71.1]:55757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbeGDDaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:30:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41L61q22lTz9s52;
        Wed,  4 Jul 2018 13:30:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530675008;
        bh=MlbuQHWXUn1ZxYvWAZCPYffejCSvGWnfnVjKgcgjImE=;
        h=Date:From:To:Cc:Subject:From;
        b=qxDImSZBRFoQllKRmkrZ2GP/TbOE4Cgr3K1DwLqG1+/ayyjXGloltLOYzDuYx//xY
         712IJND4Eiyuqhzvl2frUWQtJLDTjXsI+NkFrvqLtuHYxL1vzcx8dW6QxfOaVNOhuL
         FY5wSBuSTYqDf82//Wk7JKHDoCBzn/gBZ+mjdeHjQ+1CaqaICo9pqjwOFpSPB1XOLI
         /7OXnEWs4oBS1EZ6ZlABDRLMRvEi4rxgJH2ApMp6IxieBC5++zoWYaxBp5p88WhllK
         7S60d8QZjiA0XGZmZlCsGcCE4ZtsHs/nz3P6sQm7ro+Fl31qElRJcwGClVqjtSWkQx
         ePNneIWjae7LA==
Date:   Wed, 4 Jul 2018 13:30:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20180704133006.4d42d1a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jc//Iydba38lvZakE8=FEEU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jc//Iydba38lvZakE8=FEEU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

After merging the slave-dma tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-edma-common.o

Introduced by commit

  6ad069123f03 ("dmaengine: fsl-edma: extract common fsl-edma code (no chan=
ges in behavior intended)")

--=20
Cheers,
Stephen Rothwell

--Sig_/jc//Iydba38lvZakE8=FEEU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls8Pz4ACgkQAVBC80lX
0Gz+cwf/SwM8RV8PxM5zt3emGZuLYS1LHo9SgJk/N2Qjh2S+aoL4P+gHwCp3jL2/
cu6KpGoT4k5qFgDy2nAZ14t5J4XKZOFg2DOFq6dQM28FMr8UHb+XFFZjiJf3yN0n
D4Mof4y7GTsuiNdTRkMgrMyLT2HlSgHPRBz9n3efFJ+OC2H3IVhWLgl1B5BnikMY
GA1aSQsYn86jYvtuYFwB0scrIQr1eQHM/gIGdLea16Z7vDdwTW9CfxU9ta+xp+tD
gpT06GzWs3YJjYXVKViQAFbbG7Rv+nlduu3kbN4I3JXdAsEu133ivFEP8fX4aD+v
jD/FI2Cl4FNptvtoa1htB8We6GnIlA==
=tlVi
-----END PGP SIGNATURE-----

--Sig_/jc//Iydba38lvZakE8=FEEU--
