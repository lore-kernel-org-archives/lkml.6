Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB6BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C746A20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C746A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH3Cph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:45:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60252 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeH3Cph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:45:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 33BD826A007
Date:   Thu, 30 Aug 2018 00:46:27 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: syscon-poweroff: Replace mdelay() with
 msleep() in syscon_poweroff()
Message-ID: <20180829224627.g42fm5ujzygxi4mp@earth.universe>
References: <20180730135029.9228-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juyk23fuxnvgrlxg"
Content-Disposition: inline
In-Reply-To: <20180730135029.9228-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--juyk23fuxnvgrlxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 30, 2018 at 09:50:29PM +0800, Jia-Ju Bai wrote:
> syscon_poweroff() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
>=20
> This is found by a static analysis tool named DCNS written by myself.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---

This is also a shutdown driver, not applying.

-- Sebastian

>  drivers/power/reset/syscon-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/=
syscon-poweroff.c
> index f9f1cb54fbf9..b8b154606dbe 100644
> --- a/drivers/power/reset/syscon-poweroff.c
> +++ b/drivers/power/reset/syscon-poweroff.c
> @@ -36,7 +36,7 @@ static void syscon_poweroff(void)
>  	/* Issue the poweroff */
>  	regmap_update_bits(map, offset, mask, value);
> =20
> -	mdelay(1000);
> +	msleep(1000);
> =20
>  	pr_emerg("Unable to poweroff system\n");
>  }
> --=20
> 2.17.0
>=20

--juyk23fuxnvgrlxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHIkMACgkQ2O7X88g7
+pqQTBAApt7BJKuvQgjBnyZDwc5ndZyjuRXbv13ihfhyl7GTtV7yctPv87Ir6aBK
ojnngKXZC44L76XDmrI+5tnmm31XQGt1iCN7Egl+XKh4Mj/8STQlIyY24zT6d6iQ
CsEpPhP/L/CBXojQMa3PipqOKe24Mr+izec74ustbSboacUdesYRvygbreFaS3Fe
pxqbMBJbKKOhbBIeIvYMcTbHgAAcvj62+pePl5m1H0QQm251UO5FaznZFolE06OF
g2EWPwgO/adyHm/s7M57jq1DHiNPIQSZd3ZiDmqxYNb/C54baTyRrUJAbhSpgKZ3
SxKb+iId396CFwWXpR4HVioHTm7nKMCk6BvpcbF2dKwsdI4vUNCapevJuRnne4ll
ODlfOivzuFsxM5oqeoCMWkdEHJL2tgyIEeQ8QqY7Hvvvr841NHWUtEKlLoKzXKEA
ecW9teJ2fGMUYP8TRcpHwE+PXLYWUmL3hYcaxTcILoiWaMSlMjxDfuv4rwUGnyHY
d/LLfs7OeoROV/VXnTkT2L6jhX9tBX63leTgmRF26vRfvYl6aTFyYKdkJKH+JKr9
CdEeHgeRby2Flqs8ec12mNXfipV6hpti8F3LU4Mg7DRtTm9i8oeFweQI7i8g0VVw
7y9T1hHM77UCFdB60LFMsiqwiqc7sPVWqJ8TQH2/auohRJh+h8k=
=u/zi
-----END PGP SIGNATURE-----

--juyk23fuxnvgrlxg--
