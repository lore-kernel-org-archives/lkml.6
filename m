Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12ACC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018C208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8018C208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeGaPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:34:11 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56777 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732173AbeGaPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:34:11 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8A69E1C0008;
        Tue, 31 Jul 2018 13:53:43 +0000 (UTC)
Date:   Tue, 31 Jul 2018 15:53:41 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][media-next] media: i2c: mt9v111: fix off-by-one array
 bounds check
Message-ID: <20180731135341.GD370@w540>
References: <20180731133343.22337-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20180731133343.22337-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Colin,
   thanks for the patch.

On Tue, Jul 31, 2018 at 02:33:43PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The check of fse->index is off-by-one and should be using >= rather
> than > to check the maximum allowed array index. Fix this.
>
> Detected by CoverityScan, CID#172122 ("Out-of-bounds read")
>
> Fixes: aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  drivers/media/i2c/mt9v111.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
> index da8f6ab91307..b1d13f1d695e 100644
> --- a/drivers/media/i2c/mt9v111.c
> +++ b/drivers/media/i2c/mt9v111.c
> @@ -848,7 +848,7 @@ static int mt9v111_enum_frame_size(struct v4l2_subdev *subdev,
>  				   struct v4l2_subdev_pad_config *cfg,
>  				   struct v4l2_subdev_frame_size_enum *fse)
>  {
> -	if (fse->pad || fse->index > ARRAY_SIZE(mt9v111_frame_sizes))
> +	if (fse->pad || fse->index >= ARRAY_SIZE(mt9v111_frame_sizes))
>  		return -EINVAL;
>
>  	fse->min_width = mt9v111_frame_sizes[fse->index].width;
> --
> 2.17.1
>

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbYGnlAAoJEHI0Bo8WoVY82UkQAMWwAJTzbGS8L9Uj0RBWpRxM
8cduuFA2Nj8dduihBJxId1Ui+192x0Rz9ycilg0qk/F3K8YGTp885mT+3e6LfO+w
SE3wburj6g9PzvTVX0Pl1S5EZJ7crZYNYuQcfnBpOlje0cBrhPZSJnC3U8qhvp4B
kfMTFneh2vqJlLqIWtIAXb8U+Kp9lVGL4P5LmPRb+NUlFCBzcx9o+mwHM18fOC1o
yQiYXvLsiD9/sx+4ArJqSy2rM3Wl2ptvk89jmxUggichX5HaZ71Z2LVeEU/kDx+A
/xmWTyaPYfqZf1uZE2zuuY0NTYnqWqz7sAHuYTG1sPnNMolzDy/jEjDXUUdZk3R8
qsdEeoHshLQm0Iz+YqQWWV3hv1rvK4jQnlLQgxs9L7E8HplbsWnGm2LA9W7f/2BX
KIukd5nSvPieaOxVQJ+NAG+75fwmR3SzNywcWIi/mt/64yY9W7Nk3rgbEc4qPCoC
eHLTJ5MM5SfULI5lLDk55nyJmC+RlEIwKAVS1KXc422Ak6/m4EVYaAu7Hszyj/IG
Da6taOpKwNWIr7S0S2FGHF7iUtbmKEM61yuXwAiefPtcwksCK/DRNxBxZ/V9Wwxk
SXDldgQPhv8X/zhEVdwpaRo1fH5P5wGBKiylsRr0XIjw1vThlf5zkuzcsyyds54z
DqofY29g74kfZjHWfp/T
=iV1I
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
