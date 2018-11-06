Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A401AC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781ED20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781ED20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbeKGBXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:23:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54768 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388422AbeKGBXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:23:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 09E5F20741; Tue,  6 Nov 2018 16:57:13 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD46320712;
        Tue,  6 Nov 2018 16:57:12 +0100 (CET)
Date:   Tue, 6 Nov 2018 16:57:12 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
Message-ID: <20181106155712.4lcxw7yts7jixnkl@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
 <20181008092111.qcufr4o7cy3nnj4b@flea>
 <f140c083f59eabf6ea323d15d655473e8a77d813.camel@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6wpp5cvpnadqamr5"
Content-Disposition: inline
In-Reply-To: <f140c083f59eabf6ea323d15d655473e8a77d813.camel@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6wpp5cvpnadqamr5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 09:23:08PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2018-10-08=E4=B8=80=E7=9A=84 11:21 +0200=EF=BC=8CMaxime Ripard=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> > > If tcon->panel pointer is NULL, trying to dereference from it
> > > (i.e. tcon->panel->connector) will cause a null pointer
> > > dereference.
> > >=20
> > > Add tcon->panel null pointer check before calling
> > > sun4i_tcon0_mode_set_dithering().
> > >=20
> > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
> > >                       RGB565/RGB666 LCD panels")
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >=20
> > Applied both, thanks!
>=20
> Please bring them to 4.20.
>=20
> Currently in 4.20-rc1, bridge support of sun4i-drm is broken because of
> this problem.

I've merged them in drm-misc-fixes, thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6wpp5cvpnadqamr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+G52AAKCRDj7w1vZxhR
xazqAQDJPstjH7lIINiEPEbb11sPVgR18vN6bE73oWoZ9ff8DQEA5KW6QYDYXeOK
/aPHtxuF3gavO4SzfMxfSXa4IuSrGQg=
=tAvB
-----END PGP SIGNATURE-----

--6wpp5cvpnadqamr5--
