Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F14CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3A8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J2blYtbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3A8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJRMOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:14:04 -0400
Received: from ozlabs.org ([203.11.71.1]:51347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeJRMOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:14:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42bG0l4Vlfz9s9J;
        Thu, 18 Oct 2018 15:15:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539836103;
        bh=Dk9Buhhq1ShOC2jVYG/XIQa5kJGX2xxmvu8sctsb9DY=;
        h=Date:From:To:Cc:Subject:From;
        b=J2blYtblXwqG6MI4zpCOsRC72OymtCPLVFSMEx1leCYBcLNJPa1XGt0cO4rGIFdgC
         gOa10YGJRa3j2AUhhb34UlcGsz7qkjRUC9LSiFb0KpJOlfjUtspDOu1DJCXOyBt2Dv
         GgGl88Obo2E7ksRh+RQ3f8Y5jQQ6LM30nF7JSnp9XbKU8iFIp9ExxXNcM9gU+I4Ouo
         JSe/IYwAbkvzbGD/ePrUfMyNYNM78VTYdwwaRuUbPeI+ZC0JMRrNYwltLXfenrm7jZ
         4ApsX6xH5BWxAg/j9cl53NSriOe+s6TmyL7SHgrFqh6WrGK1XCKUEiyLXjoUTgmXaM
         R62Rw1tdRarqQ==
Date:   Thu, 18 Oct 2018 15:15:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Smart <jsmart2021@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20181018151502.3d31351f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tAxEV9xwKP8MZ=dGGjo1sq6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tAxEV9xwKP8MZ=dGGjo1sq6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/lpfc/lpfc_debugfs.c

between commit:

  9e210178267b ("scsi: lpfc: Synchronize access to remoteport via rport")

from Linus' tree and commit:

  d021613ee3ac ("scsi: lpfc: Remove set but not used variables 'tgtp'")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/lpfc/lpfc_debugfs.c
index aec5b10a8c85,d6e4cbfe3273..000000000000
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@@ -550,8 -550,7 +550,7 @@@ lpfc_debugfs_nodelist_data(struct lpfc_
  	struct lpfc_nodelist *ndlp;
  	unsigned char *statep;
  	struct nvme_fc_local_port *localport;
- 	struct lpfc_nvmet_tgtport *tgtp;
 -	struct nvme_fc_remote_port *nrport;
 +	struct nvme_fc_remote_port *nrport =3D NULL;
  	struct lpfc_nvme_rport *rport;
 =20
  	cnt =3D (LPFC_NODELIST_SIZE / LPFC_NODELIST_ENTRY_SIZE);

--Sig_/tAxEV9xwKP8MZ=dGGjo1sq6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvICMYACgkQAVBC80lX
0GzPqwf/TTatrHMOKtbfAlZtUSWCWx5Ss//YxEu7x1BLkh2zz9XbaAwPHQwON7Dn
K4L07UYjIoMF3tdWtpFrJw6ToSwc5x26T47mPM4CFR+Oodn/iWLJLkFm3PwLeccV
zHNJWNmoKvGxgHhVE8fr/VkrvdmCHcryVDr+BRfpXZzTaAejhfUgKk2LYkUaR7KL
n/V3WTSC6d/RRNSVICrCytIvZQNjSuhYfrv3WVV8xbbjqGGtZ3ic1AEw126k/Jcv
aWCEMc/PQ+Pbd1TgnOedB9ZDHmSxQkV/CnnX539EXOdy+S3UMkT6aJUda56pVcKu
NtS+2kTjaZwWMcPCMdlFpQcnrVaZEw==
=ByUP
-----END PGP SIGNATURE-----

--Sig_/tAxEV9xwKP8MZ=dGGjo1sq6--
