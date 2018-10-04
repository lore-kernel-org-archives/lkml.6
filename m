Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E300C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4C121473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Et4jP5pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4C121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJDMgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:36:18 -0400
Received: from ozlabs.org ([203.11.71.1]:39071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:36:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Qhfb0nPkz9s7T;
        Thu,  4 Oct 2018 15:44:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538631881;
        bh=npRTV0/90Ykf4DfkhuFpIjQTsHZabeYfUMPUiK6ixUs=;
        h=Date:From:To:Cc:Subject:From;
        b=Et4jP5pYFkM2fvX3tlvKbuPdcmnKO5LW3SiXDVaYwi4EbhFBdBNLUPMPxgN+e7d5c
         hAVc6luUSvOlSfQ0J1olqUuZ6JTIb8mbVUkF/d2bISa+lEwxJNJTJYuGtCvLyknAgf
         sstT8rCrOEB2F4ouu9HhJ67xxJisCgPArLi8aCc4HHAtp5U1YP47KmQLCwF8zbIvQW
         3Z/k8lm8VhQnGfRQmtIlC6UcvE7H7BsCixydtroZOkKDWhQ/JsebX6xAXs8QpK5ric
         FgyqYAG6Llnw9wtt/4C5C8QqhgcPE4Hph3KEthZyumbm1HbGplJlINx8O5D4YNpTaP
         CD9l1jH4C4qpA==
Date:   Thu, 4 Oct 2018 15:44:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: linux-next: build failure after merge of the slave-dma tree
Message-ID: <20181004154438.64f9d8c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YCPojftoRel_Sj9/MM3eZ0c"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YCPojftoRel_Sj9/MM3eZ0c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

After merging the slave-dma tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/dma/fsl-edma.c:67: warning: "EDMA_SEEI_SEEI" redefined
 #define EDMA_SEEI_SEEI(x) ((x) & 0x1F)

In file included from drivers/dma/fsl-edma.c:25:
drivers/dma/fsl-edma-common.h:21: note: this is the location of the previou=
s definition
 #define EDMA_SEEI_SEEI(x) ((x) & GENMASK(4, 0))

 ...

drivers/dma/fsl-edma.c:115:6: error: nested redefinition of 'enum fsl_edma_=
pm_state'
 enum fsl_edma_pm_state {
      ^~~~~~~~~~~~~~~~~
drivers/dma/fsl-edma.c:115:6: error: redeclaration of 'enum fsl_edma_pm_sta=
te'
In file included from drivers/dma/fsl-edma.c:25:
drivers/dma/fsl-edma-common.h:63:6: note: originally defined here
 enum fsl_edma_pm_state {
      ^~~~~~~~~~~~~~~~~

and so on ...

Caused by commit

  101d256a45ed ("Merge branch 'testing/dirn_remove' into next")

which reintroduced a whole lot of stuff into drivers/dma/fsl-edma.c that
had been modev out in commit

  9d831528a656 ("dmaengine: fsl-edma: extract common fsl-edma code (no chan=
ges in behavior intended)")

I used the slave-dma tree from next-20181003 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/YCPojftoRel_Sj9/MM3eZ0c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1qMYACgkQAVBC80lX
0GzQZwf+N7ov5mEqgHd2zxDeUnbUp1F9dbFm55OyikJ46v3KGNWvXdS603YCAsQx
2WVTImr9gL9gLxUFh+em6A83GEnbphHtOx6IywadJtRrm2pGl/hEVYYJiBIPBwL/
KqBnKgLLllEhqndK/q8/FL1h5y7JBQls2L70TODqJpdcwUldRKGkDSAuzfqhMNVO
vdy9RlBttU27e5pJjYhC+GqBiGIh+7F9vc6XyrJK2g0+KtXhLTyjenFwOj3iwTws
FyW4N3iIUPbYl+FayMxoAQHmwveX4uetYbLbxahhlc97qhiFZlUuO/R3Ce1udURz
7f0u0JqeRIgmF7GxTS/sZdqLAHzTWg==
=CrCk
-----END PGP SIGNATURE-----

--Sig_/YCPojftoRel_Sj9/MM3eZ0c--
