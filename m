Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62513C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296A420818
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n/WTJ1ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfBRXxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:53:02 -0500
Received: from ozlabs.org ([203.11.71.1]:39951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbfBRXxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:53:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443LK66NDwz9s1l;
        Tue, 19 Feb 2019 10:52:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550533979;
        bh=SpAf03UWmXgNo6wGxJFAdERsWmgW7jpK4F/RT8ZfHjc=;
        h=Date:From:To:Cc:Subject:From;
        b=n/WTJ1ZUp9Nf5Ekno5bW5efmv47myooaQsGOt5c7kInZ99zScJlJXKZluerHvLEdz
         pA8PCnrzrP2Psb01wi/HSF8K3WrBM26Prs5QoBueidIB+O1wc6/CDj7jaf/yvy2owI
         Zz4jAi7kwdgo+NL7FLmMPxj0l3+8Fuw/YF1geDheLiKgnqazfo5UW+PMk1m+AFc6YS
         Ixpb/RXFglxYvhcf0y0xqxJeoVsw/UkI/gwd1XeIqBcLA2YWtCPKw7bXP+3G70ra4z
         vFwQafKqK9mQ/vI3EhB9IXBLP9bURwD3IpjMz8tPe9OMHv4bENlU4U5O4IMwgodzu/
         ADdd5R/IPM+Ug==
Date:   Tue, 19 Feb 2019 10:52:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20190219105245.2e1f221b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bzrdqN7TmhUHDR9wN2hYggK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bzrdqN7TmhUHDR9wN2hYggK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/staging/media/imx/imx7-media-csi.c: In function 'imx7_csi_set_fmt':
drivers/staging/media/imx/imx7-media-csi.c:1086:11: error: passing argument=
 2 of 'imx_media_mbus_fmt_to_pix_fmt' from incompatible pointer type [-Werr=
or=3Dincompatible-pointer-types]
           &csi->format_mbus[IMX7_CSI_PAD_SRC],
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/staging/media/imx/imx7-media-csi.c:30:
drivers/staging/media/imx/imx-media.h:183:25: note: expected 'struct v4l2_r=
ect *' but argument is of type 'struct v4l2_mbus_framefmt *'
       struct v4l2_rect *compose,
       ~~~~~~~~~~~~~~~~~~^~~~~~~
drivers/staging/media/imx/imx7-media-csi.c:1087:18: error: passing argument=
 3 of 'imx_media_mbus_fmt_to_pix_fmt' from incompatible pointer type [-Werr=
or=3Dincompatible-pointer-types]
           csi->cc[IMX7_CSI_PAD_SRC]);
           ~~~~~~~^~~~~~~~~~~~~~~~~~
In file included from drivers/staging/media/imx/imx7-media-csi.c:30:
drivers/staging/media/imx/imx-media.h:184:40: note: expected 'const struct =
v4l2_mbus_framefmt *' but argument is of type 'const struct imx_media_pixfm=
t *'
       const struct v4l2_mbus_framefmt *mbus,
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
drivers/staging/media/imx/imx7-media-csi.c:1085:2: error: too few arguments=
 to function 'imx_media_mbus_fmt_to_pix_fmt'
  imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/staging/media/imx/imx7-media-csi.c:30:
drivers/staging/media/imx/imx-media.h:182:5: note: declared here
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/media/imx/imx7-media-csi.c:1089:2: error: too few arguments=
 to function 'imx_media_capture_device_set_format'
  imx_media_capture_device_set_format(vdev, &vdev_fmt);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/staging/media/imx/imx7-media-csi.c:30:
drivers/staging/media/imx/imx-media.h:278:6: note: declared here
 void imx_media_capture_device_set_format(struct imx_media_video_dev *vdev,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  05f634040c0d ("media: staging/imx7: add imx7 CSI subdev driver")

interacting with the earlier commit

  5964cbd86922 ("media: imx: Set capture compose rectangle in capture_devic=
e_set_format")

I have used the v4l-dvb tree from next-20190218 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/bzrdqN7TmhUHDR9wN2hYggK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrRU0ACgkQAVBC80lX
0GyHjAgAlIbD5TA/JqYW2IpKnPp2xdYYO/BR5stAhAIxBQ8vtGNDyckGlWhaRIE6
heuian4hEtHBhlr5mUCysoZ9j7GQ+uWBt4zRyghXlqhFjDJDSHHoN0QHbkebKJKM
OdwP3tVYPFAZpLtLJkYQVaKl0Bx+ssCQShEuUWExiwDygwHSuXEaKyjAaLcOTlCs
xkUVTTcGGBg5zWUx/AR9lnyddonbJs6R4Xdg32GXWUg2g14Ra9MFoU85bpcK8K1Q
1wIfB+H4I7eKZ/TggHqPqJ9t/OHzAfmPrglxafVMtw5oPG64S0v7lFIgz/LmPXIy
CCr6nTKrEBflCcCXXp2YjDK0inL0oQ==
=B7OL
-----END PGP SIGNATURE-----

--Sig_/bzrdqN7TmhUHDR9wN2hYggK--
