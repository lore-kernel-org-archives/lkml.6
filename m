Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2891206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfAIOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60617 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfAIOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:14:21 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 21E3B8094D; Wed,  9 Jan 2019 15:14:13 +0100 (CET)
Date:   Wed, 9 Jan 2019 15:14:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux@armlinux.org.uk,
        lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Message-ID: <20190109141417.GA8529@amd>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support to check if platform's power will be cut off in suspend.
> This will help drivers shared by multiple platforms to take only the
> necessary actions while suspending/resuming (some platform may not need
> to save/restore all the registers if platforms remains powered while
> suspended). In this way suspend/resume time could be improved.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/linux/suspend.h |  6 ++++++
>  kernel/power/suspend.c  | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 3f529ad9a9d2..21f19b167fe2 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend_=
stat_step step)
>   *	Called by the PM core if the suspending of devices fails.
>   *	This callback is optional and should only be implemented by platforms
>   *	which require special recovery actions in that situation.
> + *
> + * @off_in_suspend: Returns wether the platform's power will be cut off =
at

wether -- spelling?

> @@ -185,6 +188,7 @@ struct platform_suspend_ops {
>  	bool (*suspend_again)(void);
>  	void (*end)(void);
>  	void (*recover)(void);
> +	bool (*off_in_suspend)(suspend_state_t state);
>  };

Dunno, should it be per-regulator? SoCs commonly have more than one
power supply, with some of them off during suspend...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw2AbkACgkQMOfwapXb+vLmQgCgqAUamz2/knUA9Lf1Tl4BAceL
vXEAoIbw66S7wi6alwJxvhCaPmHDkJyA
=BZfz
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
