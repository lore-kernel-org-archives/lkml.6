Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D0EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840DB2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZelLQlEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840DB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJHMDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:03:05 -0400
Received: from ozlabs.org ([203.11.71.1]:60997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeJHMDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:03:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T7KR3pmHz9sBq;
        Mon,  8 Oct 2018 15:53:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538974395;
        bh=m3VuQRQ/FyMFCyuoQnOM1j3GEpNY1gATPCFZWbxDgtg=;
        h=Date:From:To:Cc:Subject:From;
        b=ZelLQlEEegeUFTgcuMB8xN2mm5YXEKxZp2k+W8zEbA6i9NV+iIIEGPqOrR/va3AjL
         2eGXn1AqVX4c+wgVDwL5E/iSuxvjFkIgLiT3yEM1urTeXujKHqGEHZ4YIJ0wcVSic1
         SaFWkja3t4S3e4owIQSF3OEIF+9lFCd5T8PLVPiDXsT5scTZs77E3fRfQZJqG/cDiC
         Ofv+7M2YeiOYrRhriTHO7ca+pmhPJpNa3UYVQ9CocysXC6TdRuzlKeulDK1bMZ4KJG
         kUL+coQv+vyaGyHWKZBIH2OX+MvpHg4ia8ohtIHfKTeuWqU7zxGQZ4PChdbKjdOFg1
         fpTYMCylrTsFg==
Date:   Mon, 8 Oct 2018 15:53:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20181008155315.3ecadc28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WubPpHMgJlRj+nYV/MDIctJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WubPpHMgJlRj+nYV/MDIctJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/media/imx/imx-media-of.c

between commit:

  21711787045d ("media: staging/imx: of: Remove recursive graph walk")

from the v4l-dvb tree and commit:

  f93861c2d611 ("staging: Convert to using %pOFn instead of device_node.nam=
e")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/staging/media/imx/imx-media-of.c
index 1c9175433ba6,163437e421c5..000000000000
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@@ -20,13 -20,67 +20,13 @@@
  #include <video/imx-ipu-v3.h>
  #include "imx-media.h"
 =20
 -static int of_get_port_count(const struct device_node *np)
 +static int of_add_csi(struct imx_media_dev *imxmd, struct device_node *cs=
i_np)
  {
 -	struct device_node *ports, *child;
 -	int num =3D 0;
 +	int ret;
 =20
 -	/* check if this node has a ports subnode */
 -	ports =3D of_get_child_by_name(np, "ports");
 -	if (ports)
 -		np =3D ports;
 -
 -	for_each_child_of_node(np, child)
 -		if (of_node_cmp(child->name, "port") =3D=3D 0)
 -			num++;
 -
 -	of_node_put(ports);
 -	return num;
 -}
 -
 -/*
 - * find the remote device node given local endpoint node
 - */
 -static bool of_get_remote(struct device_node *epnode,
 -			  struct device_node **remote_node)
 -{
 -	struct device_node *rp, *rpp;
 -	struct device_node *remote;
 -	bool is_csi_port;
 -
 -	rp =3D of_graph_get_remote_port(epnode);
 -	rpp =3D of_graph_get_remote_port_parent(epnode);
 -
 -	if (of_device_is_compatible(rpp, "fsl,imx6q-ipu")) {
 -		/* the remote is one of the CSI ports */
 -		remote =3D rp;
 -		of_node_put(rpp);
 -		is_csi_port =3D true;
 -	} else {
 -		remote =3D rpp;
 -		of_node_put(rp);
 -		is_csi_port =3D false;
 -	}
 -
 -	if (!of_device_is_available(remote)) {
 -		of_node_put(remote);
 -		*remote_node =3D NULL;
 -	} else {
 -		*remote_node =3D remote;
 -	}
 -
 -	return is_csi_port;
 -}
 -
 -static int
 -of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
 -		bool is_csi_port)
 -{
 -	int i, num_ports, ret;
 -
 -	if (!of_device_is_available(sd_np)) {
 +	if (!of_device_is_available(csi_np)) {
- 		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
- 			csi_np->name);
+ 		dev_dbg(imxmd->md.dev, "%s: %pOFn not enabled\n", __func__,
 -			sd_np);
++			csi_np);
  		/* unavailable is not an error */
  		return 0;
  	}

--Sig_/WubPpHMgJlRj+nYV/MDIctJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu64rsACgkQAVBC80lX
0GzRtAf/TJTWF4BVPvDRufUibISmhswkytM87QCduKIE1wVlsQnDVLrd2yYKO/17
c0IN0xLcfK0oVRTzykuvdHh9nXZYlYOJVJceSX17fThlbw8uNZOexs6GLF56r0CQ
Jnbbzt9p9Jyu6X/ss6Hwx6i2fX3a4Ok3zs/Im7n83aMRb46XTa9RwDLLp0MS70lr
tZbZmyuwMx3TTNFJeJwZlO5D3EeUBzu/MRAVWml/cTRyfUzK3aBjU2Qr8u1sf7g+
soCEcTKpa5X20PqQCe+mZW7PsZe8hitD/4lLjCwf99vEBYVBFOPbvXnVSSe/csFg
B1tIlLF+wPQ1q4/350KSmoN+mZX1/g==
=kqkF
-----END PGP SIGNATURE-----

--Sig_/WubPpHMgJlRj+nYV/MDIctJ--
