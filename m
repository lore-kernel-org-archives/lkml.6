Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35466C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82A120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82A120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeG3Xr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:47:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeG3Xr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:47:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61F5AAFC2;
        Mon, 30 Jul 2018 22:10:55 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 31 Jul 2018 08:10:43 +1000
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-mmc: Use BIT macro instead of explicit shifting in board.h
In-Reply-To: <20180727160733.GA10467@nishad>
References: <20180727160733.GA10467@nishad>
Message-ID: <87muu8l6ho.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27 2018, Nishad Kamdar wrote:

> Replace explicit shifting with BIT macro in board.h.
> Issue found by checkpatch.
>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> ---
>  drivers/staging/mt7621-mmc/board.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/mt7621-mmc/board.h b/drivers/staging/mt7621-=
mmc/board.h
> index a7d82f321b00..983791ee308d 100644
> --- a/drivers/staging/mt7621-mmc/board.h
> +++ b/drivers/staging/mt7621-mmc/board.h
> @@ -36,10 +36,10 @@
>  #ifndef __ARCH_ARM_MACH_BOARD_H
>  #define __ARCH_ARM_MACH_BOARD_H
>=20=20
> -#define MSDC_CD_PIN_EN      (1 << 0)  /* card detection pin is wired   */
> -#define MSDC_WP_PIN_EN      (1 << 1)  /* write protection pin is wired */
> -#define MSDC_RST_PIN_EN     (1 << 2)  /* emmc reset pin is wired       */
> -#define MSDC_REMOVABLE      (1 << 5)  /* removable slot                */
> +#define MSDC_CD_PIN_EN      BIT(0)  /* card detection pin is wired   */
> +#define MSDC_WP_PIN_EN      BIT(1)  /* write protection pin is wired */
> +#define MSDC_RST_PIN_EN     BIT(2)  /* emmc reset pin is wired       */
> +#define MSDC_REMOVABLE      BIT(5)  /* removable slot                */
>=20=20
>  #define MSDC_SMPL_RISING    (0)
>  #define MSDC_SMPL_FALLING   (1)
> --=20
> 2.17.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltfjOYACgkQOeye3VZi
gbkm9A//R2oeRHsq/v8i7dWZZkVkpJ2ghbJ6mpgG5tEj1r+Pyfx19weKLmriqP09
VR00XPeiM8BXFxWZ0f0BvduyDf7UQqgqIWz2FVV/2l2eLWIfnKgJt8DB8OIqm+oB
c/SPDAEI5eA9TTQF+U8dl0NPY92SP8WGhjHLK8YQ94BLVXpDEvX6vkB/NYlobJzG
qSlm2WQ5W4LOGQuLMOErELB1AXGNdHWgxUm2YdiuUjqtuyE2nmUpOUQbLDmOkAEr
sZy5LPIzh4pzCfNnJxBIFFHtpSOW/cKvxSWzBjqiexjT7Q+4LGjsIZRVfJ47RWwk
sUlXb/CZKFxlUxAtgCgG4aYi1Jmns+XW+vVCH2P9WXZx55RVO7RJaXUQUzteSoFk
RzZbULDNxkk8EY8Rt5yCufIaJYu+vOHI/Q3S7CFfUuUqCwcOeT+FGzsNmxWg07LX
tFwzWI96hdsBGYwyyICVcdeyS18zcE9/hpXEfsVzAmHVETysJGuoC9gqIFOBBQ7a
cuuCnPb+8+IXKJhgmhSvhuFOyxr2znX4f5rmGo+SMnJ3sBzJlAkxDxWwQiBCGxSD
e5YkZg1zGnnEJ5wQpquBqjucIwANJHapuGrH2Q8IWPkg0YFgMIisnSEACbpxjXA3
EA0rgROxlIwpIF7g6Fyx+e6SS0TIRBGWUxUJdZCObTlDdkR4KSo=
=s3CJ
-----END PGP SIGNATURE-----
--=-=-=--
