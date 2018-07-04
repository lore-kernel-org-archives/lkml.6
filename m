Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9493C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8003C246F6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8003C246F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933616AbeGDHos (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:44:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36569 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbeGDHoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:44:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5A6B0207F4; Wed,  4 Jul 2018 09:44:44 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 240E7208C5;
        Wed,  4 Jul 2018 09:44:34 +0200 (CEST)
Date:   Wed, 4 Jul 2018 09:44:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] mmc: sunxi: Disable irq during pm_suspend
Message-ID: <20180704074435.46aqhuthrn2vok5x@flea>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5f54sll2jggg7dtn"
Content-Disposition: inline
In-Reply-To: <1530685741-20604-1-git-send-email-stefan@olimex.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5f54sll2jggg7dtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 09:28:59AM +0300, Stefan Mavrodiev wrote:
> When mmc host controller enters suspend state, the clocks are
> disabled, but irqs are not. For some reason the irqchip emits
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

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5f54sll2jggg7dtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls8euIACgkQ0rTAlCFN
r3QWcxAAkanogogQaGFEgZZiX02cRiz03ciIQAbsl77c3hxxh5Kpe8/hdfpVYwHL
F+eVvMUeD4WeX7qXOptd3NlBClOSRw3atXmW1z7aEIQwKrKYNZn8foAjuV2+jrz5
3PfQalJf8ZpZDUDnZqISCIvt778H0qAp7DYk4+Hk0q5fUo5KYC+PebhHg8EL44ig
m//ETl6Te/d7dppUlO3n6qeF6AfdSToFg0e5E3g3L7nbot7mZWZ8Arc1AcyU1qjZ
WRxRz40PTBq/dMIC3DGSCC4zQ8dMZ9+W2+4eisFXG7+Oh7i6nstXxR8VCotmp3H6
HIgHxFmVaRPnmgWlGu0POvvxwI2d0e89tLMirk9MK4AP8sQgViDsl21kg4Q9G3sN
2z5gwco+8bTwmLjGg5eR8WM2zSMBfyWF/ZPqFwLT9Rx2MZCuS1uzkEjI0OIz3RjK
dh6feqFals4qT3NzzsRgV8wZLA3uaHD/Qef+zzfPCRcWvj596IPOy9QRsoQUn4/k
gN1fNSalYjSSmAXsCkEYDSgZcjCdgV3pRGcDfmv6cIzAysPATbulyrxa5gzXdkcp
QRItj0ZuVZLiMbAKfjNMVqUcGUZSm5Yl+OJao1FHE6UMlD8Q4HK+Tu2wNT+yWzTk
XxmYG10kFow2jI1o0Imce+f/ocacDvjmNZZaH9kT4khr8921p0g=
=s/IJ
-----END PGP SIGNATURE-----

--5f54sll2jggg7dtn--
