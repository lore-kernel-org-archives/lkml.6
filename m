Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAB5208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAB5208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390809AbeHPNL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:11:26 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60607 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbeHPNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:11:26 -0400
X-Originating-IP: 37.159.11.54
Received: from w540 (unknown [37.159.11.54])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1BEBCE0011;
        Thu, 16 Aug 2018 10:13:52 +0000 (UTC)
Date:   Thu, 16 Aug 2018 12:13:51 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] media: ov772x: Disable clk on error path
Message-ID: <20180816101351.GB19047@w540>
References: <1534363839-28509-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <1534363839-28509-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello Alexey,
   thanks for the patch

On Wed, Aug 15, 2018 at 11:10:39PM +0300, Alexey Khoroshilov wrote:
> If ov772x_power_on() is unable to get GPIO rstb,
> the clock is left undisabled.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>

Acked-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks
   j

> ---
>  drivers/media/i2c/ov772x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
> index e2550708abc8..7b62bf1fc5b1 100644
> --- a/drivers/media/i2c/ov772x.c
> +++ b/drivers/media/i2c/ov772x.c
> @@ -828,6 +828,7 @@ static int ov772x_power_on(struct ov772x_priv *priv)
>  					     GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->rstb_gpio)) {
>  		dev_info(&client->dev, "Unable to get GPIO \"rstb\"");
> +		clk_disable_unprepare(priv->clk);
>  		return PTR_ERR(priv->rstb_gpio);
>  	}
>
> --
> 2.7.4
>

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbdU5fAAoJEHI0Bo8WoVY8nHoQAKFTbaogq1/Umm3uZCUTcVQ1
nPdhav4jEpna4q+e5slQ9+YVMvg4gWEsEYdgO+XSZTkFJomAnLC6q8R7yKVDMxFM
zYHNbpfCT2GaL43klmLxmFv78QxMIJbu96n6VOKecyPSDg7+DtRKIXcMsvvnuYMO
yziTOOKXD1XzbcjDX0grb4A1JvpZR7Hvp8xC5eHxR31a/rQPW8tgiO5x7fQQgwer
BMB34xgGpoH50mKAz6GqmRx2at2OMXvToRl/PmWkqCl+xj0UEj7FdxJxeBqWLNSg
w7+QvGJPramJHPmXm3gBDcXsEXiY/FhiA1Z77k98d70nmCznEkdLfhbX38sEgbFp
FPnx1WEha/ZEuJcKQGsk6HraKRiVgI/OME3NEfrPXUwRhXld1zEeAgbUFfajndYB
EVgDgdhrYmcFDr6kGa8FDWg0FJdKRYQpB34xKlf35izOQ36noQaCNcyHcln9vVgd
Qey1WPIlcqw1x1VeoHIGdLdakgIHUCsiLxi8B4iOwdp0vRryF+48HmU3GXUIy+4B
tTGhenAc+rEBbNgHVHDL4PU4bLNqTjLxsZCfO7W6MCt9GkA12Iubo//WDawwCjWE
doo64vG+xLqCtBERIXPVRNYFu04V3k9fhWLXbJYRm7+bzsYpRDkRE6zCXToTFiwE
gthgWZ5fJnU6bcV1lrR3
=86Og
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
