Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC0C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCDD213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oJ2EzGUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCDD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeIMH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:29:40 -0400
Received: from ozlabs.org ([203.11.71.1]:36287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeIMH3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:29:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 429j8p4DFyz9s4V;
        Thu, 13 Sep 2018 12:22:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536805338;
        bh=x3a9OrdaavZS45WF9u0dIa4KdmknAkEx8W34qTuyzq8=;
        h=Date:From:To:Cc:Subject:From;
        b=oJ2EzGUwFX3kV/VG3uq2TO9sXi7YAc5P+YixcJU+h1C5hdjTiQFs+HbzLmtCG+L+k
         4UrvP6PReM0XpO2PG+89VRkschcJdJCOnUZY89vqc40gVtG8d6u9xoouLn556b/msj
         pX7jjJb0mIX2u+pOgxMQwvxtwbvFsRappiJ/CMngwiJwbBOYBPPMsceTkgZoeCMSQD
         C5hibgRADBQ5DqzeFSPFl6WIvLtSWV6fU0iJBs1VAGASVKy3JgLPVGXia6/lWCLgCW
         DVk7NkARgOXyDfmfohUmdlkMIuyXAUmbfyzVEj3CPXeiH/KLgOfm2Ox6cEk3cI3GaI
         E7f6Z1ok7StQw==
Date:   Thu, 13 Sep 2018 12:22:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20180913122218.0fb31482@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a=1Z73gZHiu.ccaUFaLIjJi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a=1Z73gZHiu.ccaUFaLIjJi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

After merging the slave-dma tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/dma/mcf-edma.c: In function 'mcf_edma_filter_fn':
drivers/dma/mcf-edma.c:296:33: warning: cast from pointer to integer of dif=
ferent size [-Wpointer-to-int-cast]
   return (mcf_chan->slave_id =3D=3D (u32)param);
                                 ^

Introduced by commit

  e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")

--=20
Cheers,
Stephen Rothwell

--Sig_/a=1Z73gZHiu.ccaUFaLIjJi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluZydoACgkQAVBC80lX
0GzSsQgAiwnMSowK8AeznNkbyzk1Jeph5SLBYN67OIx5H0569+2MC13a2PPIPEHx
B+9ey3N1bhEhHOtz92RAGK3dtmnL14jw2sgAb1fOWkhlb/XsxPmXIX9bWj9HLB1S
+HIkuLX9BT23mSUvkXN7fFLbiUDpZiocElhoCOl/moqyxdWMDH3nwcLjBE9xMdbR
87E4XqaLAwkq+jIM2jhBuCDDVzY0skMMfPV1v0i3UaLcigBCevotcMOr/gQ+lMGl
4phvnpslKgtwpJQxXWAIv8HcYE8sjfDzPNY24wOOer0dKiAGs6uQJTRcJKLtrqlk
moCEETtgLIGjkMfggpQDCjEoZJqKyw==
=Cwva
-----END PGP SIGNATURE-----

--Sig_/a=1Z73gZHiu.ccaUFaLIjJi--
