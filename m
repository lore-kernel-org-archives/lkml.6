Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1276C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4A2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548058083;
	bh=WoXqts8Zyyj3IcCcrBeogQKzogQyA/qUsPtodKHtexM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FVsryK1uGy3OSaCA7I/N1XUC9MowGiuGtnHBqL5cADVf+KlPD4l3zst44kH6SSyBq
	 rKFoEYbrgimNDIF0FP6eCtxHgWlYIZo3xdoPuQLt2gk/DjV+PNrilkNmRDFQ6HeS2G
	 TTEUPltxfcwIZC+r28Vw9gw95fhGIl+MjCpblnzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfAUIIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfAUIH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:07:59 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D78421783;
        Mon, 21 Jan 2019 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548032491;
        bh=WoXqts8Zyyj3IcCcrBeogQKzogQyA/qUsPtodKHtexM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xhf4SW1OsEEMgUedcEFUIjJ5Fm7zk/nIfjJafYfyIFqX8y+GTazmqNSdOUJNETNyn
         3YMqgToiLxsLCne4WbHa2KAOvMxxhlVLEzAPogVw4HtLrKG3uTu44QIDpgkFLGTjcG
         GqbqP7eaCf03iyiH9uwHPQKJe9bdD/i7vXojLw/k=
Received: by earth.universe (Postfix, from userid 1000)
        id 362FB3C08E2; Sun, 20 Jan 2019 22:23:26 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:23:26 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     hdegoede@redhat.com, wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20190120212326.6kk4tcpzs6ytlvho@earth.universe>
References: <20181122142551.25367-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ovmzsfkld3ku7wlo"
Content-Disposition: inline
In-Reply-To: <20181122142551.25367-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ovmzsfkld3ku7wlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2018 at 09:25:51AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Thanks, queued to power-supply-next. Sorry for the delay, I missed
this when I collected patches for the 5.0 kernel.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 084c8ba9749d..9ff2461820d8 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -307,22 +307,12 @@ static int fuel_gauge_debug_show(struct seq_file *s=
, void *data)
>  	return 0;
>  }
> =20
> -static int debug_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, fuel_gauge_debug_show, inode->i_private);
> -}
> -
> -static const struct file_operations fg_debug_fops =3D {
> -	.open       =3D debug_open,
> -	.read       =3D seq_read,
> -	.llseek     =3D seq_lseek,
> -	.release    =3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(fuel_gauge_debug);
> =20
>  static void fuel_gauge_create_debugfs(struct axp288_fg_info *info)
>  {
>  	info->debug_file =3D debugfs_create_file("fuelgauge", 0666, NULL,
> -		info, &fg_debug_fops);
> +		info, &fuel_gauge_debug_fops);
>  }
> =20
>  static void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
> --=20
> 2.17.0
>=20

--ovmzsfkld3ku7wlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE5ssACgkQ2O7X88g7
+ppAWA//Wxt0SzuHUUfk6z2Z1e/IO5kyxalrUCImNkjSTgb1aNxc779EHweTgpKu
pGUdSiBlpPcOa8CgtozABrKlHjmmRFYWRcfVxGogZyCQBt2mQwgW/TbS3pHUN8Sr
VnQrAv+cf0g3M5c6WnPguvOVvLao/zwwymvQqqDPNvoYDrrS4oOP0InlE4uhSIfP
LyPToq0PkWaImWHB/mr5Y7iy79b4qkKe744nJtDlbroVSvESmktGIdQ4vaiJhc10
yvLppZMm0CmU2IrjQtNQYgnWssTRUrfZ/JJ0a8t1lT3W69n0J05X9vZrC5kGaTyD
ovyixjLt8Fwcw9EZC+YlKunMoUYiUc7mD5U3ftbuxSxWbAnCds3tqiNf2XoqIkUr
JYa4azZy+S9Gm1io6ySja3HSjgG0NBrkVitjSC5nqKD9S3bQY8eaUkA5iib3n5oZ
UEv/0eRlfHngl+FVIBjeM1RNeRSLY/70hwON9skYG7RuA6GnYPNpxXVW0Z1WAYeO
8S+Omo01WNdu1pBwN/qqVVa8AFBH6BUXxCHObo7z6Ef0AGwZS3B0tpboe1UZuTwn
F3x32rPyYG0DHVEcr5uH0FKXwfo6n9hnADoXsVFhbVdN+si3PUXvOV/EDSaksN1L
Wvkcu4u+QT60Wda/tTNA542Rrhw0WFW3/4nsdWciaGZJGdznd8w=
=uac3
-----END PGP SIGNATURE-----

--ovmzsfkld3ku7wlo--
