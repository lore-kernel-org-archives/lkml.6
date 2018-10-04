Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E059FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAC320877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAC320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJECsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:48:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51555 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJECsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:48:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7642A207F3; Thu,  4 Oct 2018 21:54:06 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 46668206FF;
        Thu,  4 Oct 2018 21:54:06 +0200 (CEST)
Date:   Thu, 4 Oct 2018 21:54:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/sun4i: tcon: fix check of tcon->panel null
 pointer
Message-ID: <20181004195406.prjuko556tnuau2u@flea>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opjbizbyovgucput"
Content-Disposition: inline
In-Reply-To: <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opjbizbyovgucput
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 03, 2018 at 04:24:57PM +0200, Giulio Benetti wrote:
> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
> has been used, but that macro doesn't check if tcon->panel pointer is
> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
>=20
> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
> condition to check if it's a pointer not null.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

The commit log should be improved. The issue isn't really with the
IS_ERR macro as you suggest, but that what is returned by
of_drm_find_panel, and thus stored in tcon->panel. is not an error
pointer in the first place but a NULL pointer on error. So the check
doesn't check for the proper thing.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--opjbizbyovgucput
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu2b90ACgkQ0rTAlCFN
r3SECg/8C8s1dR1+g7QU0KMFTa1z6f1VKKe7qQV1le5xEG4b9NdltxS3NNjg70bn
mAushukubUMuhx01QT1cio8X7ANl605+2m1UGzVsHqLXayv+gW2DtfAx1TLvQgDp
tTQG+EG/vmplrs2pI4n0LBHfetQmWbT3wjqcTV/XzFHqOQMOD3Bs7Ig0hq+9FTPJ
xSMcVvHVhHpB6yNdixoXPTeziIuv9ywnRd/0BoafMmM1KV4acfsAfLOYbGR3uvGF
hl8MoDbGZwXlmvplM//HI96P7qmy9YJun4hXnkJ17IeC1tHWUbEb8TLEhuesTFfN
92TKoNO1ZI44Hfjsl52dgVrFTGMdMxdGxvNFX9kNsBIVLgvynwQfQ4CL2JKISvbp
QSg1Kc5U4O55TX6fm4vJoXvCeFccCB1R2HLnk6ygmysvp/4p3Mm3srKMeVnqQw0Y
REOjWt7dqX17d3RTn4Tg+c1vlTzuBPeO7iwRK0hSencm06epl4Ym0Eyaxdv3Imjh
qrSXlHfvqdKpKV/xrvLFnsHIyGvNkmle/vYFI55XADO3ii3PSvd8OkrY0lgVwd6U
h1tN2povQz2XtnplXK0cX6YZN98QZ5gxgzRj832Lbxp5aNy+9KMRNVgELCtEbiJe
/8yYGnbHV0Qn5BwRxBVlh/8Nja1FNZN6aMSxhp0fEBjJKGTwHFk=
=spN4
-----END PGP SIGNATURE-----

--opjbizbyovgucput--
