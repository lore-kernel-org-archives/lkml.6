Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8F4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9EF2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ghj9DONw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9EF2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJHL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:57:33 -0400
Received: from ozlabs.org ([203.11.71.1]:40321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHL5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:57:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T7C50kxhz9sBq;
        Mon,  8 Oct 2018 15:47:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538974065;
        bh=xBq+VK8aSUmx6Vuiyd7M/H6neAW8E7HH+QEmNxVHCqI=;
        h=Date:From:To:Cc:Subject:From;
        b=Ghj9DONwJcUH7VnH7F4Nbq8cP8gAXxq6kxhZQbxcUV7aClZ7pAHMcZPHduyYf3790
         N2Chh0gKMGTcsz6uENzQKIbyaIvTPRqiLun3fiDLIu1yLnAX0kpotj+rkcVHZvgv0o
         F9cNtUO6oaxyfhdLnUpMfkaPk9bv47ATn9VqXF39Ie9AsVF+/3DKJfMtyvJIvujtZO
         h+jM5IbGYSuWNI+XjRs3kFzxCzpqeiuqV/7PJITD4n2SRN2Vbu1rjhitC4f/Ogjynr
         dgnKvhkerdj4iZdGSft3TroEKiU29nmoSZTwazVc2ZmRe/8oaHdg6XLB31A/rgrRjz
         G2FxusfcRf7GQ==
Date:   Mon, 8 Oct 2018 15:47:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20181008154743.156e63be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nNaefXIMJ/AX9S.B1DBgi_D"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nNaefXIMJ/AX9S.B1DBgi_D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/media/imx/imx-media-dev.c

between commit:

  b803cd359833 ("media: staging/imx: Switch to v4l2_async_notifier_add_*_su=
bdev")

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

diff --cc drivers/staging/media/imx/imx-media-dev.c
index 481840195071,3f48f5ceb6ea..000000000000
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@@ -47,34 -80,52 +47,43 @@@ int imx_media_add_async_subdev(struct i
  	struct imx_media_async_subdev *imxasd;
  	struct v4l2_async_subdev *asd;
  	const char *devname =3D NULL;
 -	int ret =3D 0;
 -
 -	mutex_lock(&imxmd->mutex);
 +	int ret;
 =20
 -	if (pdev)
 +	if (fwnode) {
 +		asd =3D v4l2_async_notifier_add_fwnode_subdev(
 +			&imxmd->notifier, fwnode, sizeof(*imxasd));
 +	} else {
  		devname =3D dev_name(&pdev->dev);
 -
 -	/* return -EEXIST if this asd already added */
 -	if (find_async_subdev(imxmd, fwnode, devname)) {
 -		if (np)
 -			dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
 -			__func__, np);
 -		else
 -			dev_dbg(imxmd->md.dev, "%s: already added %s\n",
 -			__func__, devname);
 -		ret =3D -EEXIST;
 -		goto out;
 +		asd =3D v4l2_async_notifier_add_devname_subdev(
 +			&imxmd->notifier, devname, sizeof(*imxasd));
  	}
 =20
 -	imxasd =3D devm_kzalloc(imxmd->md.dev, sizeof(*imxasd), GFP_KERNEL);
 -	if (!imxasd) {
 -		ret =3D -ENOMEM;
 -		goto out;
 +	if (IS_ERR(asd)) {
 +		ret =3D PTR_ERR(asd);
- 		if (ret =3D=3D -EEXIST)
- 			dev_dbg(imxmd->md.dev, "%s: already added %s\n",
- 				__func__, np ? np->name : devname);
++		if (ret =3D=3D -EEXIST) {
++			if (np)
++				dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
++				__func__, np);
++			else
++				dev_dbg(imxmd->md.dev, "%s: already added %s\n",
++				__func__, devname);
++		}
 +		return ret;
  	}
 -	asd =3D &imxasd->asd;
 =20
 -	if (fwnode) {
 -		asd->match_type =3D V4L2_ASYNC_MATCH_FWNODE;
 -		asd->match.fwnode =3D fwnode;
 +	imxasd =3D to_imx_media_asd(asd);
 +
 +	if (devname)
 +		imxasd->pdev =3D pdev;
 +
- 	dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
- 		__func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
++	if (fwnode)
+ 		dev_dbg(imxmd->md.dev, "%s: added %pOFn, match type FWNODE\n",
+ 			__func__, np);
 -	} else {
 -		asd->match_type =3D V4L2_ASYNC_MATCH_DEVNAME;
 -		asd->match.device_name =3D devname;
 -		imxasd->pdev =3D pdev;
++	else
+ 		dev_dbg(imxmd->md.dev, "%s: added %s, match type DEVNAME\n",
+ 			__func__, devname);
 -	}
 -
 -	list_add_tail(&imxasd->list, &imxmd->asd_list);
 -
 -	imxmd->subdev_notifier.num_subdevs++;
 =20
 -out:
 -	mutex_unlock(&imxmd->mutex);
 -	return ret;
 +	return 0;
  }
 =20
  /*

--Sig_/nNaefXIMJ/AX9S.B1DBgi_D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu64W8ACgkQAVBC80lX
0GxKJggAgJr2EtNxfcR22lRYhjeorG8FlKHyJ7dopiWh4atRkL+0VwDQ1Bctr3do
sTf51G/Laajcj4c/T7S4yymV96ishnzt1jvmdK72RnVEhq6Rm+G58RK2iSA1skJg
crJkuafgrTrg/VS5iawFe1EhgeTdxym7UumqVh7dbeGraMhfoTG8xRcqSwFrOOG0
Wf0LPPBbRM6uKgat0JpAgNs3u/kFsBHHIS6mnhsZHCItax2CQvFKq9IsM9o1kZ8H
fihX1iSZNEr3NUk66j8p3Xe7NA/teN1lHEiQkilg5XycY+TwoZU+7FjNXUXVksNo
RpYpMmYotjkut2wkYhShCvHUHawg8A==
=NfEr
-----END PGP SIGNATURE-----

--Sig_/nNaefXIMJ/AX9S.B1DBgi_D--
