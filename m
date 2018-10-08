Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF7BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705C720878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705C720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJHQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:32:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37511 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHQcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:32:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A2053208B7; Mon,  8 Oct 2018 11:21:20 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6E88F20898;
        Mon,  8 Oct 2018 11:21:10 +0200 (CEST)
Date:   Mon, 8 Oct 2018 11:21:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
Message-ID: <20181008092111.qcufr4o7cy3nnj4b@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mohfoqypvlhtueck"
Content-Disposition: inline
In-Reply-To: <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mohfoqypvlhtueck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> If tcon->panel pointer is NULL, trying to dereference from it
> (i.e. tcon->panel->connector) will cause a null pointer dereference.
>=20
> Add tcon->panel null pointer check before calling
> sun4i_tcon0_mode_set_dithering().
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
>                       RGB565/RGB666 LCD panels")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied both, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mohfoqypvlhtueck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7IYYACgkQ0rTAlCFN
r3T2Ig//RX8QMjB1fpCJfjm3Hn9puA1tstV2U8Aar5tL2Z2ucctRxYhk2WBJt/qP
Y6fFIRiiAo6+kxo440mp9Emf3g7IWnP2lmtsqCxv13gw964tral3xTr8G088v4Rm
rZn8uu4iqdGyIq2D6VM+S7XW1B8T8pCaXsZv2hc4SSSnLrM/3+lPBA+gU7MB5rAK
iBUQqUwIVAT0UgNyS+wq1ZWT2+JSy1XKLIL9EiFODGKQ+C8aSGN67+vIY3477+OO
BggrNr51rBFwsJHdqvSVG6jN1GDVwgMJLtA039WxIQpni5HIPus0sx+XgjNw9jCV
chukRoxi+HBEANCoTCQwROttkYuBSv6wJY1ZEJiiz7eyJZJOyULjmGSF8wSh1XBC
+pmGf5+u80WAV56KXGPkULTk/1MTBkuCSTHLwfJX2GvjWVMYqFsdJTW0BMtI/zyW
0PHShRLWgEAtn9XoWD7qwA0mZ2sk+aprvFMYK3lvuMM7DXshiz7sD73c3LW2koj3
ySVHwAQbfX0jQpC7/+qslfi20gSMFE5tXHiQpaSHBboNhA8zfj2DOM6B8UTXQFdU
HAQkyEyLWjO0Ng2gYlF70j0g+jZOebejEa8J08RnJ6yAavxvtVs8rARmMGH8FXDq
x1YIMDG3Ndhyqu5VIKm4m4nWHLb5yV+DiCKksBHniGrReeLrAkQ=
=1Tms
-----END PGP SIGNATURE-----

--mohfoqypvlhtueck--
