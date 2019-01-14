Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE8AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7366206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="apf/tfPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfANCxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:53:03 -0500
Received: from ozlabs.org ([203.11.71.1]:37943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfANCxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:53:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dJ1S0bv6z9s55;
        Mon, 14 Jan 2019 13:52:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547434380;
        bh=RLV8lf7lTxnX/EH+AKNBGQLLoEbt0s5HCsJfHOcc6bE=;
        h=Date:From:To:Cc:Subject:From;
        b=apf/tfPSvOIvhAgGZJKYyQ7ZVa432hiSv72zJqzsX3BQESPXHkyroJnERL6hAleA6
         xeXt2Q/40FRjIi0RRqe6wOZm8TQsnYYfoCXQMDrnZpFcadjQwyANkUCq0h4tw58qau
         o0RCa4TFyMREXbsrqE9+QxgB6a7Gj8q6+wHELlZBF0MkWuasRzQN0C22h1pm4HtjJP
         4QBAcVthpjvoon2OSFTPZUvVyACc2vX1qa63/dFNPrBPAJan50cYqftoOtPffdiX48
         LUpIJD+iOtDIIR9fTBujSOErQrf6JYf/WrigKOkwzZqki3lT3R1eJb4rDusFwhZoH0
         jRnX0hoIlx4pg==
Date:   Mon, 14 Jan 2019 13:52:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luo Jiaxing <luojiaxing@huawei.com>
Subject: linux-next: manual merge of the scsi tree with the scsi-fixes tree
Message-ID: <20190114135255.1afee399@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LWLreKvBQ/Z_uIl+eC/KW09"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LWLreKvBQ/Z_uIl+eC/KW09
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

between commit:

  7bb25a89aad2 ("scsi: hisi_sas: Set protection parameters prior to adding =
SCSI host")

from the scsi-fixes tree and commit:

  ef63464bcf8f ("scsi: hisi_sas: Create root and device debugfs directories=
")

from the scsi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index c92b3822c408,b780b5269f0f..000000000000
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@@ -2507,12 -2672,9 +2672,15 @@@ hisi_sas_v3_probe(struct pci_dev *pdev
  		sha->sas_port[i] =3D &hisi_hba->port[i].sas_port;
  	}
 =20
 +	if (hisi_hba->prot_mask) {
 +		dev_info(dev, "Registering for DIF/DIX prot_mask=3D0x%x\n",
 +			 prot_mask);
 +		scsi_host_set_prot(hisi_hba->shost, prot_mask);
 +	}
 +
+ 	if (hisi_sas_debugfs_enable)
+ 		hisi_sas_debugfs_init(hisi_hba);
+=20
  	rc =3D scsi_add_host(shost, dev);
  	if (rc)
  		goto err_out_ha;

--Sig_/LWLreKvBQ/Z_uIl+eC/KW09
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw7+YcACgkQAVBC80lX
0Gz7XwgAikKMCOIYC8KxZCFWjC5hvyYO9ZEdx+eJ0vw/WSDCCZeOMNvCVjA861pI
IHkWyIYcDrvZq/yGeTdm7TZh2gdw+j/dVbG5i/r11rdNeSn/07XK0IJVqGWjsbMc
r2KwsIEpmN4gXJg4GwgRzjnFtp60qJAi5ugt3NWxR9KT+OT+xS7IjAKhRoEcojah
CPmRdsC+h58LzNffAsrWGdS+ENE8F+lGifUJReomGcAvs7s2fJyoqMo5GM3xdbEx
TF0G8JjtWFDoSd03Du+3Tkesj9EHAJ9ARf2kb8OIHSHQv2DX5dfihIlp1ACbNu+l
aHBetYpFHuRZt/v+boQjW96uya1hKw==
=lq9r
-----END PGP SIGNATURE-----

--Sig_/LWLreKvBQ/Z_uIl+eC/KW09--
