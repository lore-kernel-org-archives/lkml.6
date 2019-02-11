Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E46C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A7421479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cpdyQyq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBKEbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:31:34 -0500
Received: from ozlabs.org ([203.11.71.1]:50257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfBKEbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:31:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yXt82pN1z9s4Z;
        Mon, 11 Feb 2019 15:31:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549859492;
        bh=yy1ttDWvZJFMljRjiFSehkyqVW9LPIU25Phxr7XWShg=;
        h=Date:From:To:Cc:Subject:From;
        b=cpdyQyq7rTttrAcme7UQZE7MMzagiGMmnp8ZrnvurKYID/MFRUmOEq/JlaH43wf7v
         KnBpTA17cGwTSEEReVaXW9W5tHKxY6K+yUlnqsP9Beqslrx85kMCWhVe1MPQxM+O6f
         O+umtf9Ac9eVxYdNuTKrecOLUj9xUJuqK1UxSsOj/4o9/Gyn+dLYgIrEmEmBYxDbmZ
         keExdMtCGnWkFITZj7CBitt2X+2MYojPVxQtLroSbX8qozZlccTVEpjM5SezayHz7o
         GO+LkKhGsFvmctrzA6y0glTjsBisdMcyiK4YYtLcHrU39H4IA/AbQl/FOV9C+vOnk7
         FbOOp9F7fcYsA==
Date:   Mon, 11 Feb 2019 15:31:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20190211153127.09756262@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5Nwd28GjUgGNQ606dgNeb2_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Nwd28GjUgGNQ606dgNeb2_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

between commit:

  7bb25a89aad2 ("scsi: hisi_sas: Set protection parameters prior to adding =
SCSI host")

from Linus' tree and commit:

  b3cce125cb1e ("scsi: hisi_sas: Add support for DIX feature for v3 hw")

from the scsi-mkp tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 8481c5795e1f,00738d0673fe..000000000000
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@@ -2698,12 -2805,6 +2806,15 @@@ hisi_sas_v3_probe(struct pci_dev *pdev
  	if (hisi_sas_debugfs_enable)
  		hisi_sas_debugfs_init(hisi_hba);
 =20
 +	if (hisi_hba->prot_mask) {
 +		dev_info(dev, "Registering for DIF/DIX prot_mask=3D0x%x\n",
 +			 prot_mask);
 +		scsi_host_set_prot(hisi_hba->shost, prot_mask);
++		if (hisi_hba->prot_mask & HISI_SAS_DIX_PROT_MASK)
++			scsi_host_set_guard(hisi_hba->shost,
++					    SHOST_DIX_GUARD_CRC);
 +	}
 +
  	rc =3D scsi_add_host(shost, dev);
  	if (rc)
  		goto err_out_ha;

--Sig_/5Nwd28GjUgGNQ606dgNeb2_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxg+p8ACgkQAVBC80lX
0GwakQgAgUeViVSfNmXMbGdBosKyZJrRrGfiyLpoYjfEFgZB6ppKGiUqmVz72lqW
XFkLdrRe2F426BwSqccy7tbJhga8TFErnkIdAktYF+AUU5PsGsZ49yO5GW8sX3Fh
pcmazAMyVI8hCREw8wZHyxMl4+EtiQZmHoM9Gfr84rD1uOrRtwLBaLcSNE2DLjvg
ulMWrv1+HTokluizaR7UDee/Gb/frsIdbCv6HyJoXjyzOx54DBfuBcbkuTLcUs9z
U9TlEmFcSASsrVcqqFVrH/TDZNAKD7iecFthamTuXqcExlpS6hjSxvzb+4yLAZwW
rLKNFVxYZlDGDK9mUECLWq84Arc1Xw==
=WJSB
-----END PGP SIGNATURE-----

--Sig_/5Nwd28GjUgGNQ606dgNeb2_--
