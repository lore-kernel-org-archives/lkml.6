Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F461C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1C4206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1C4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbeKIIAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:00:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33449 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbeKIHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:02 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9A772805FE; Thu,  8 Nov 2018 23:05:28 +0100 (CET)
Date:   Thu, 8 Nov 2018 23:05:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 053/144] ARM: OMAP2+: Fix n900 board name for legacy
 user space
Message-ID: <20181108220530.GA17186@amd>
References: <20181108215054.826084593@linuxfoundation.org>
 <20181108215058.676426973@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20181108215058.676426973@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-11-08 13:50:24, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> [ Upstream commit 71c4f6027da75c6c1fd92e05b63108a09ec2b109 ]
>=20
> N900 legacy user space apps need the board name in
> /proc/cpuinfo to work properly for the Hardware entry.
>=20
> For other boards this should not be an issues and they
> can use the generic Hardware entry.
>=20
> Let's fix the issue by adding a custom DT_MACHINE_START
> for n900.
>=20
> Tested-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think this is good idea. N900 support changed a lot in the
meantime. It may not be neccessary or may break something, not
sure. Not comfortable with this w/o testing.

								Pavel

> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -77,6 +77,24 @@ MACHINE_END
>  #endif
> =20
>  #ifdef CONFIG_ARCH_OMAP3
> +/* Some boards need board name for legacy userspace in /proc/cpuinfo */
> +static const char *const n900_boards_compat[] __initconst =3D {
> +	"nokia,omap3-n900",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
> +	.reserve	=3D omap_reserve,
> +	.map_io		=3D omap3_map_io,
> +	.init_early	=3D omap3430_init_early,
> +	.init_machine	=3D omap_generic_init,
> +	.init_late	=3D omap3_init_late,
> +	.init_time	=3D omap3_sync32k_timer_init,
> +	.dt_compat	=3D n900_boards_compat,
> +	.restart	=3D omap3xxx_restart,
> +MACHINE_END
> +
> +/* Generic omap3 boards, most boards can use these */
>  static const char *const omap3_boards_compat[] __initconst =3D {
>  	"ti,omap3430",
>  	"ti,omap3",

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvksyoACgkQMOfwapXb+vL7gwCfbQDgyjld6+2FRkw7/9fPEmgi
vJEAn2GxeSmu1Q1qNMY/NtgH5hzDTP7B
=dimU
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
