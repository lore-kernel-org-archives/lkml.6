Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D30FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E777020671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E777020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbeGSJYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:24:16 -0400
Received: from sauhun.de ([88.99.104.3]:48058 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeGSJYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:24:14 -0400
Received: from localhost (p54B3338D.dip0.t-ipconnect.de [84.179.51.141])
        by pokefinder.org (Postfix) with ESMTPSA id 959B15E000F;
        Thu, 19 Jul 2018 10:42:08 +0200 (CEST)
Date:   Thu, 19 Jul 2018 10:42:08 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, linux-media@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH -next v4 2/3] media: ov772x: use SCCB regmap
Message-ID: <20180719084208.4zdwt4vzcop4hve7@ninjato>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-3-git-send-email-akinobu.mita@gmail.com>
 <20180719074736.GA6784@w540>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xqqiw3duga2s5vfo"
Content-Disposition: inline
In-Reply-To: <20180719074736.GA6784@w540>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xqqiw3duga2s5vfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -static int ov772x_mask_set(struct i2c_client *client, u8  command, u8 =
 mask,
> > -			   u8  set)
> > -{
> > -	s32 val =3D ov772x_read(client, command);
> > -
> > -	if (val < 0)
> > -		return val;
> > -
> > -	val &=3D ~mask;
> > -	val |=3D set & mask;
> > -
> > -	return ov772x_write(client, command, val);
> > -}
> > -
>=20
> If I were you I would have kept these functions and wrapped the regmap
> operations there. This is not an issue though if you prefer it this
> way :)

I have suggested this way. It is not a show stopper issue, but I still
like this version better.


--xqqiw3duga2s5vfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltQTtwACgkQFA3kzBSg
KbZm3hAAls6hfbYwOifr2nw8YSVbwvRvWoJCrCVAPSWRjj97xNGAe21G1dXK3yU3
7jlwJbm96jA7YZWdPkxJUxha37b5fThlFVHZ7nNFlivied42SIySrGZGUKH02yNV
a409+mGUGe5PAvGwO0/v7snWT5jmuRi84o5PUMUC/jLAOtHONEbOrgz81L3YBgpq
bcjJFy5ZkoWZXbZk3AhEEWCC4rcBIw3pWhLm57/sI/Q+FiqO+a8io02qHhjF7/eS
G62GBO09Ces+xtaIdmcaGzIP+4JvGy0nEjy6JmKWy0E6ryg1DI02X8lJVKFVpW9z
0IXS0PriwXzq6uWgh7qbP8R7oCPtXi2LEedJWc9IBWk3VOoQGkszbHwCakSb9tEA
3xSl+/W0pWVS6o1wWDQJpRPLzY2Hkfdp1CKth5oITsPCLyB36XnRAaVEqbeQ5FmX
FdLbo7CXLyilZwazuyAYN/15+CbglKbNtAZUZMdgn7jvtN4LHUUFivIp7WAHRGUZ
0m/4JKcEDxFajrPwl9BDaDgUB9l7B1GwnkhcI+RYsJHMxFD/Hz5Sc+DNgUE2cb37
hfGuCp5W77b7EC6vyPaj5gzdY6Q+OXPSwBPjjhUVS4mpla7XL/kMW/neGZzN3Gnh
95NhY9twI4pEjGx/j1J6Fk23UNrk5MCpUmCXb4epIwDtkMKWZCY=
=e06+
-----END PGP SIGNATURE-----

--xqqiw3duga2s5vfo--
