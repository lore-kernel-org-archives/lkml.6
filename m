Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D50020857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tAPdo6b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D50020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeG0Esl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:48:41 -0400
Received: from ozlabs.org ([203.11.71.1]:45545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeG0Esl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:48:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cDvj041Rz9ryl;
        Fri, 27 Jul 2018 13:28:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532662130;
        bh=VoJpSZ37m0KFxH4ZrviOXjWuW6WpKpCdsVWw1k4k+lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tAPdo6b/a//ah1pjWGuLZHWiAR10/owjv09uUSy5HfkdpdfIF/9u6UtQQCVp17J7T
         D2qseb8cnxfhNzv2LV4bMdDOTWsddusRNKTuGIt4HTgCRflVE/tXJgA8GmMc3L0D9a
         OC5JOgxAyHmOyWOIh4Du33in7H2zeBPKtbyj1w+o8XQnShy+xS3TO8B7IekuPQG68d
         O7gYiljCd/7XJDMMEk7T1WnMxtju/gNNW/17fTcR00c5C/BI18XJwFhpPGfZskG6DC
         XfTJYNzo2yFpo66OV1Z+0QWrrybblWc/PhTuO1krNMiODhhK9hry3O0/g/LyIZrs7q
         HsSjeAheAVFiA==
Date:   Fri, 27 Jul 2018 13:28:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: linux-next: manual merge of the net-next tree with the rdma
 tree
Message-ID: <20180727132847.2be8563b@canb.auug.org.au>
In-Reply-To: <20180727024832.GA30023@mellanox.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wCED4/E9j3DQ4JJ4eMc2WQ1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wCED4/E9j3DQ4JJ4eMc2WQ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Thu, 26 Jul 2018 20:48:32 -0600 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jul 27, 2018 at 12:33:01PM +1000, Stephen Rothwell wrote:
>=20
> > I fixed it up (I wasn't sure how to fix this up as so much has changed
> > in the net-next tree and both modified functions had been (re)moved,
> > so I effectively reverted the rdma tree commit) and can carry the fix
> > as necessary.  Please come to some arrangement about this. =20
>=20
> How does that still compile? We removed ib_query_gid() from the rdma
> tree and replaced it with rdma_get_gid_attr()..

Yeah, it doesn't :-(

> I think the merge resolution is going to be a bit nasty to absorb
> that much changing..
>=20
> Perhaps we should add a compatability ib_query_gid back to the RDMA
> tree and then send DaveM a commit to fix SMC and remove it during the
> next cycle? Linus can resolve smc_ib.c by using the net version
>=20
> Does someone else have a better idea?

I applied this merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Jul 2018 13:19:31 +1000
Subject: [PATCH] net/smc: fixups for ip_query_gid API removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/smc/smc_ib.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 2cc64bc8ae20..debc6e44f738 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/scatterlist.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_cache.h>
=20
 #include "smc_pnet.h"
 #include "smc_ib.h"
@@ -144,17 +145,21 @@ int smc_ib_ready_link(struct smc_link *lnk)
=20
 static int smc_ib_fill_mac(struct smc_ib_device *smcibdev, u8 ibport)
 {
-	struct ib_gid_attr gattr;
-	union ib_gid gid;
-	int rc;
+	const struct ib_gid_attr *gattr;
+	int rc =3D 0;
=20
-	rc =3D ib_query_gid(smcibdev->ibdev, ibport, 0, &gid, &gattr);
-	if (rc || !gattr.ndev)
-		return -ENODEV;
+	gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
+	if (IS_ERR(gattr))
+		return PTR_ERR(gattr);
+	if (!gattr->ndev) {
+		rc =3D -ENODEV;
+		goto done;
+	}
=20
-	memcpy(smcibdev->mac[ibport - 1], gattr.ndev->dev_addr, ETH_ALEN);
-	dev_put(gattr.ndev);
-	return 0;
+	memcpy(smcibdev->mac[ibport - 1], gattr->ndev->dev_addr, ETH_ALEN);
+done:
+	rdma_put_gid_attr(gattr);
+	return rc;
 }
=20
 /* Create an identifier unique for this instance of SMC-R.
@@ -179,29 +184,27 @@ bool smc_ib_port_active(struct smc_ib_device *smcibde=
v, u8 ibport)
 int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index)
 {
-	struct ib_gid_attr gattr;
-	union ib_gid _gid;
+	const struct ib_gid_attr *gattr;
 	int i;
=20
 	for (i =3D 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
-		memset(&_gid, 0, SMC_GID_SIZE);
-		memset(&gattr, 0, sizeof(gattr));
-		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
+		gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
+		if (IS_ERR(gattr))
 			continue;
-		if (!gattr.ndev)
+		if (!gattr->ndev)
 			continue;
-		if (((!vlan_id && !is_vlan_dev(gattr.ndev)) ||
-		     (vlan_id && is_vlan_dev(gattr.ndev) &&
-		      vlan_dev_vlan_id(gattr.ndev) =3D=3D vlan_id)) &&
-		    gattr.gid_type =3D=3D IB_GID_TYPE_IB) {
+		if (((!vlan_id && !is_vlan_dev(gattr->ndev)) ||
+		     (vlan_id && is_vlan_dev(gattr->ndev) &&
+		      vlan_dev_vlan_id(gattr->ndev) =3D=3D vlan_id)) &&
+		    gattr->gid_type =3D=3D IB_GID_TYPE_IB) {
 			if (gid)
-				memcpy(gid, &_gid, SMC_GID_SIZE);
+				memcpy(gid, &gattr->gid, SMC_GID_SIZE);
 			if (sgid_index)
 				*sgid_index =3D i;
-			dev_put(gattr.ndev);
+			rdma_put_gid_attr(gattr);
 			return 0;
 		}
-		dev_put(gattr.ndev);
+		rdma_put_gid_attr(gattr);
 	}
 	return -ENODEV;
 }
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/wCED4/E9j3DQ4JJ4eMc2WQ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltakW8ACgkQAVBC80lX
0Gxk2Qf/dUiJ3dNtaQ8uQBGtAMB83b2EeQvVOvKMxR2TapgPsBfBCBsBlLMqBhER
kE97W/JyovCfzIkpXAjoywWXGmv2893H/LT1e1BfsfGs36v0vPIiF0+9EgfP/E+c
oXcqustzn2jObXJtE/SCwiF/NdFy1l9+4hC+FZ16vEiDVqCfEzuhoN4JRUEwT9bt
iGWeeiejvhGpJF8Wkolg/U4mfkiTiHSDSzvpplSdYTfavvEpQY+hBjNHwNKS+AJT
9aoBxqMz86PzETRJAPH6gG5YFgWqaIFE6PZdSiH9C5gjRpb2ZMBl4DLV2dfe5G/p
8TYaUB9Cz8/7M62NSo9DB9sdCnLtvQ==
=jGEe
-----END PGP SIGNATURE-----

--Sig_/wCED4/E9j3DQ4JJ4eMc2WQ1--
