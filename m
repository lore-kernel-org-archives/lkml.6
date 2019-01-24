Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9555AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0CE2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="akZNAcHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfAXD62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:58:28 -0500
Received: from ozlabs.org ([203.11.71.1]:57173 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfAXD61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:58:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lT0G4Xxqz9s55;
        Thu, 24 Jan 2019 14:58:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548302305;
        bh=OtZ8gXhvBooT701r/p4zqyW3jzEFXjV/WZ67Q3CIayM=;
        h=Date:From:To:Cc:Subject:From;
        b=akZNAcHw8O1HDCV7mCZ3I81yIgg99FmkJSt9XdbcUKeioQ61H1CW5JHZ+RNu0dY7b
         NxZQjKCA3R6iIMT8HByE6gJl+nY39k165TeOFhNASPY9VdfPOkmPFtj9WN6iQX7CBu
         +d1wuBTGrwqyoyuZFaxsPfHrtvu4DYeyRAzGULHQu3fXyro4/A3IST+N6e/PwJX0Wy
         q6rGC6fHuauTK9e1D5kb3o3t99+CjZtN8Rfym3LmACp4OwgciLiyeVmxDCEt1fKUpi
         PFZVEhJzOTzJDWjODCSqmfluEISViAxnMs0/C4GE8GAGnMcdqKsrt4ZN0GHxW8TmK0
         lFPYQX9VytJug==
Date:   Thu, 24 Jan 2019 14:58:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Ching Huang <ching2048@areca.com.tw>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190124145821.6e747c25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9xTUu=j4.7vSBu4zXQ5pQaW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9xTUu=j4.7vSBu4zXQ5pQaW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/scsi/arcmsr/arcmsr_hba.c

between commit:

  750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")

from Linus' tree and commit:

  3e3153b050fc ("scsi: arcmsr: Use dma_alloc_coherent to replace dma_zalloc=
_coherent")

from the scsi tree.

I fixed it up (I just used the scsi tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/9xTUu=j4.7vSBu4zXQ5pQaW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJN90ACgkQAVBC80lX
0Gz6Wgf/bUH1MQwBmuH/QWKNRufPIvs9+ePhTZF68QTJP1xbOTGWS2ozN6G5v2Go
Bx7CCSkaLy1LcUpqprKAWtWkIRh9g5Y94YABEMdakd0V5Jto7g6UlaSW5eWNBWsp
TnwW67Wbti5xwoDb3EL/7mDGNxKiVRjxwmDNsA+J5lSNnTRon7m83NvbgFWu9sYI
+bwpxlu1fyFzXT3HSHZ2qD0G0H4OVKEc9QTU5E/LrXa4rydJT59Jq/aF5NduYInU
P3Y9AuxScQllJxYSANVI3TMrIY8Bv82v2DgVp/f0/FxtJ1PKNRdo/ZVBVzK3OSVY
wBEkaDXl8OCZ6u1R18nHwa2nvKUQxw==
=4YxI
-----END PGP SIGNATURE-----

--Sig_/9xTUu=j4.7vSBu4zXQ5pQaW--
