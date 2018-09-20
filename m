Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8EFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F43D21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F43D21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbeITGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:01:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeITGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:01:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C5CB126B9CE
Received: by earth.universe (Postfix, from userid 1000)
        id 5EFAE3C0A85; Thu, 20 Sep 2018 02:20:52 +0200 (CEST)
Date:   Thu, 20 Sep 2018 02:20:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] twl4030_charger: fix charging current
 out-of-bounds
Message-ID: <20180920002052.xex3xdrvzkb7wf7k@earth.universe>
References: <20180917052035.12234-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tavpoct2v7do34bb"
Content-Disposition: inline
In-Reply-To: <20180917052035.12234-1-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tavpoct2v7do34bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 07:20:35AM +0200, Andreas Kemnade wrote:
> the charging current uses unsigned int variables, if we step back
> if the current is still low, we would run into negative which
> means setting the target to a huge value.
> Better add checks here.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index b72838663872..c954b7234393 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -421,7 +421,8 @@ static void twl4030_current_worker(struct work_struct=
 *data)
> =20
>  	if (v < USB_MIN_VOLT) {
>  		/* Back up and stop adjusting. */
> -		bci->usb_cur -=3D USB_CUR_STEP;
> +		if (bci->usb_cur >=3D USB_CUR_STEP)
> +			bci->usb_cur -=3D USB_CUR_STEP;
>  		bci->usb_cur_target =3D bci->usb_cur;
>  	} else if (bci->usb_cur >=3D bci->usb_cur_target ||
>  		   bci->usb_cur + USB_CUR_STEP > USB_MAX_CURRENT) {
> --=20
> 2.11.0
>=20

--tavpoct2v7do34bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui5+QACgkQ2O7X88g7
+pqu/w/+PuOEdsIBjlmz1T5XE3MmdQj/ox9PMIqczw1TcK2QH4ccBJGs0EHWKGFX
CdGiFkWx/bH+cNkEAO+yMPOp11qUSDu/fp+riwpfwQQuhvfxvQ31Fj408FYvUlgk
8z4XJ0VglpKSRnSt8CL1VAkpknPu/jenyUau4IFa/0kpOZwS5IGQ+HYypaeGAbF+
aOW5vQBQ5r5slbd243loDup4ObpWMHn/oyzjpPFmNDn612QP3lGaPm3K3s9GsGZe
Yklha8aUlZb9J7MIpIAv5ELeKaIUmF0BfWW77WKwxV8vFwG22aeSu5VIEIVU1+ft
FisOtKR4gwD0D0ZA2O5Ij1N5XLUOj+tJjfroCa4ic1rXVyBkc9dqVr8y6dvOamJT
xF6qupvRj0AR2cCxjLEj/fVT+ajaw6HG3zy7018n4Kc3n/rjAwaYmSfGJZXHN6M5
jL/E9F3q42E6tgBB6YbCWHk2gAg4hr/DzFvm8teXaBpaVFArOxSF8N6HXxDgqIbr
mKI6ZRMGm290iZpp5/6a9VGZSvtCMUNkJZ5vD45nfvHFTFRRKB319EMSvJiYHQTK
Osq2CwZg1Et3x/C7GF3pugr23NmD/OtcNRUwSJ5Au5+QEgv9lcm4Rw8dpwuCtope
pSm5tkcwiSugnNMkUhlPyh6cK2e3GQieqs+ijp0BPGoxLmGPTVc=
=Wo7z
-----END PGP SIGNATURE-----

--tavpoct2v7do34bb--
