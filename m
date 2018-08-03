Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7E7216ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uSVLFAc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7E7216ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeHCH6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:58:51 -0400
Received: from ozlabs.org ([203.11.71.1]:53695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbeHCH6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:58:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hc1f29kcz9s0R;
        Fri,  3 Aug 2018 16:04:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533276246;
        bh=vXGAl+URm4C9YC+kbJcJqqbWuC0tVeBgXpUHUwB0f+g=;
        h=Date:From:To:Cc:Subject:From;
        b=uSVLFAc0bHUT5Mu0eQnXBzHoasSiEYNwFjzZhI9upUb1IEC2wfbNhZMO9UWOKVzYY
         Sqsjny2IKEaJ6X/qE1u/og3TN8Nt6MXQVITpkkJVzryx8VR2NUpyMnzdmznCzwjzJP
         NENrUBk/wykyDIqHPlSYjBe4cEwd/75QPTe/4GbodS4KI3LTPSq0MtpsYb8yKQ34qZ
         e5OcJwnmjQ0MO5E6UG+LirBzYFH0enSS8jWcTQk6rTtRMB/iRL4uk6jnoj/QkEtHAb
         jo9DTCaQGwUqIVQGJWZHDC0DZnGnunafWPNBACBuGWz81mfw5gwffBMNg2VrNfwc0O
         Mpm4Jo0IPay3A==
Date:   Fri, 3 Aug 2018 16:04:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@cavium.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20180803160405.15df3dac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k_28nBIYg1ADeskmg.IQ9Dp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k_28nBIYg1ADeskmg.IQ9Dp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got conflicts in:

  drivers/scsi/qla2xxx/qla_gs.c

between commit:

  b5f3bc39a0e8 ("scsi: qla2xxx: Fix inconsistent DMA mem alloc/free")

from Linus' tree and commit:

  8777e4314d39 ("scsi: qla2xxx: Migrate NVME N2N handling into state machin=
e")

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

P.S. it looks like more use could be made of "c" in this function ...

diff --cc drivers/scsi/qla2xxx/qla_gs.c
index 7a3744006419,407eb705f1be..000000000000
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@@ -3394,19 -3383,40 +3391,40 @@@ int qla24xx_post_gpnid_work(struct scsi
 =20
  void qla24xx_sp_unmap(scsi_qla_host_t *vha, srb_t *sp)
  {
- 	if (sp->u.iocb_cmd.u.ctarg.req) {
- 		dma_free_coherent(&vha->hw->pdev->dev,
- 			sp->u.iocb_cmd.u.ctarg.req_allocated_size,
- 			sp->u.iocb_cmd.u.ctarg.req,
- 			sp->u.iocb_cmd.u.ctarg.req_dma);
- 		sp->u.iocb_cmd.u.ctarg.req =3D NULL;
- 	}
- 	if (sp->u.iocb_cmd.u.ctarg.rsp) {
- 		dma_free_coherent(&vha->hw->pdev->dev,
- 			sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
- 			sp->u.iocb_cmd.u.ctarg.rsp,
- 			sp->u.iocb_cmd.u.ctarg.rsp_dma);
- 		sp->u.iocb_cmd.u.ctarg.rsp =3D NULL;
+ 	struct srb_iocb *c =3D &sp->u.iocb_cmd;
+=20
+ 	switch (sp->type) {
+ 	case SRB_ELS_DCMD:
+ 		if (c->u.els_plogi.els_plogi_pyld)
+ 			dma_free_coherent(&vha->hw->pdev->dev,
+ 			    c->u.els_plogi.tx_size,
+ 			    c->u.els_plogi.els_plogi_pyld,
+ 			    c->u.els_plogi.els_plogi_pyld_dma);
+=20
+ 		if (c->u.els_plogi.els_resp_pyld)
+ 			dma_free_coherent(&vha->hw->pdev->dev,
+ 			    c->u.els_plogi.rx_size,
+ 			    c->u.els_plogi.els_resp_pyld,
+ 			    c->u.els_plogi.els_resp_pyld_dma);
+ 		break;
+ 	case SRB_CT_PTHRU_CMD:
+ 	default:
+ 		if (sp->u.iocb_cmd.u.ctarg.req) {
+ 			dma_free_coherent(&vha->hw->pdev->dev,
 -			    sizeof(struct ct_sns_pkt),
++			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
+ 			    sp->u.iocb_cmd.u.ctarg.req,
+ 			    sp->u.iocb_cmd.u.ctarg.req_dma);
+ 			sp->u.iocb_cmd.u.ctarg.req =3D NULL;
+ 		}
+=20
+ 		if (sp->u.iocb_cmd.u.ctarg.rsp) {
+ 			dma_free_coherent(&vha->hw->pdev->dev,
 -			    sizeof(struct ct_sns_pkt),
++			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
+ 			    sp->u.iocb_cmd.u.ctarg.rsp,
+ 			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
+ 			sp->u.iocb_cmd.u.ctarg.rsp =3D NULL;
+ 		}
+ 		break;
  	}
 =20
  	sp->free(sp);

--Sig_/k_28nBIYg1ADeskmg.IQ9Dp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltj8FUACgkQAVBC80lX
0GxtGAf/VpBcwZLxtCW5tgyOEK3P90da+NbBgB0uObQpkmdF6x55XKTf7trRP8Id
nCWaQd7XS9/hz7g9XgTwZV4CZoW3lm0DyUpVcpWnVQzqqeeqQLteELUYscSQhmV8
NrzKJWcMokx6Dt8tj6ndYjHsbtRz4uI6Letq32DZnbSQayi47K/IUiGqgg0vTrLW
10pUgSuaYzlY1XeU3/LbGpKDbjPioZ0pl7rWnAbogGkjRN5jdwNcLftGhQqOsRbU
Gmnt30WQHGkQTMRFwyCaHpSQHOL69KOwCWfIB07YIYALmXEx0IL200PsnBM+sr4s
g7IqOKcynVnC32KKuzhWd767yNMxxg==
=4fGJ
-----END PGP SIGNATURE-----

--Sig_/k_28nBIYg1ADeskmg.IQ9Dp--
