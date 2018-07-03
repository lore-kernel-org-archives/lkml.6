Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B9221F45
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B9221F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932713AbeGCOyz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:54:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41979 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932410AbeGCOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:54:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 557BF20750; Tue,  3 Jul 2018 16:54:51 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 236C5203EC;
        Tue,  3 Jul 2018 16:54:51 +0200 (CEST)
Date:   Tue, 3 Jul 2018 16:54:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mmc: sunxi: Disable irq during pm_suspend
Message-ID: <20180703145452.o2zbchnnvncpvwfj@flea>
References: <1530602925-7714-1-git-send-email-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmtnw3hn2w3npscp"
Content-Disposition: inline
In-Reply-To: <1530602925-7714-1-git-send-email-stefan@olimex.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmtnw3hn2w3npscp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Jul 03, 2018 at 10:28:43AM +0300, Stefan Mavrodiev wrote:
> When mmc host controller enters suspend state, the clocks are
> disabled, but irqs are not. For some reason the irqchip emmits
> false interrupts, which causes system lock loop.
>=20
> Debug log is:
>   ...
>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>   sunxi-mmc 1c11000.mmc: enabling the clock
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   mmc1: new DDR MMC card at address 0001
>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>    mmcblk1: p1
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> and so on...
>=20
> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
>=20
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Thanks a lot for figuring this out, I have a (very) minor comment though..

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e747259..acae7a8 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *=
dev)
>  	sunxi_mmc_init_host(host);
>  	sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
>  	sunxi_mmc_set_clk(host, &mmc->ios);
> +	enable_irq(host->irq);
> =20
>  	return 0;
>  }
> @@ -1455,6 +1456,7 @@ static int sunxi_mmc_runtime_suspend(struct device =
*dev)
>  	struct mmc_host	*mmc =3D dev_get_drvdata(dev);
>  	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> =20
> +	disable_irq(host->irq);

Can you add a comment there stating why we need them in the first
place (which is basically what you described) so that it's obvious for
anyone editing it.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wmtnw3hn2w3npscp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls7jjsACgkQ0rTAlCFN
r3QigQ/+OtJlUCJXwjAg2q8E+32X2TgIge/B/sF+ezKwMCwYqA6uFD1yG9TA5twQ
EJVU0aGid1kwEBzj45Z6NHLthhq+TKCY+alRlg+gGkuKMJJyZ1V7/JYMX3vLEJBk
D7nwwGeFbz42QsiXsXhxHrsl1KgtS6dBz+o0+3DhT7NmvUWkeTdwYsnWwwk2fCv3
F9KbAIz2reFN9fEJUMY3VoDZ5BC980uqAQKe3gIQv+e120iLtbmFaMRCftMJ+iU9
hLyX0iCNENCCA+ONzwHMnGvIpZUQYWinjTBaWTCQxJUzybJHur8lDGnZ0czVdTsy
6SmFRMiEk5ZvtFNG8GuQ5CFC8/EOl32K1dGr7s74JIV8dJjZFGY5rN7uNhH+82EB
7Cp7Z1IFFmjg/qyI3qkrwgJ9/girVK1Fv/jalnW7MJ03GQeRusd0fqNYrMzIoR7q
yqLR5KwO687EnB62t8Qyc72pDHbddDpY3ZYQ81n7dNWsKLE2wIGy3gObkJiO/eNE
SBgd9mQu30glDPRq9O73gSYsvAGcH28bBofrezcO4cn9u3s+0chkBPJYL4xVd5ee
8IAUl7YnK3v5P0BLnbL6NReKm7+C1IvPY+nnyzVjn2XsO+p4rPgZRQafJaAP462h
FPElvG+y5j6s/s+UWHpEklKcpyMH4JXnvBV4p//qIhs1Uf3+r20=
=qg1H
-----END PGP SIGNATURE-----

--wmtnw3hn2w3npscp--
