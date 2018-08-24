Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E637208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E637208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHXSHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:07:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49481 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeHXSHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:07:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3237422A2A; Fri, 24 Aug 2018 16:32:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0064B20728;
        Fri, 24 Aug 2018 16:32:47 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:32:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: tcon-top: Use struct_size() in devm_kzalloc()
Message-ID: <20180824143247.7lxwsckmkyaiqzob@flea>
References: <20180824010521.GA25451@embeddedor.com>
 <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ztjew4jkypqxdqf"
Content-Disposition: inline
In-Reply-To: <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ztjew4jkypqxdqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 07:56:12PM -0700, Kees Cook wrote:
> On Thu, Aug 23, 2018 at 6:05 PM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> >
> > struct foo {
> >         int stuff;
> >         void *entry[];
> > };
> >
> > instance =3D devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * co=
unt, GFP_KERNEL);
> >
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> >
> > instance =3D devm_kzalloc(dev, struct_size(instance, entry, count), GFP=
_KERNEL);
> >
> > This issue was detected with the help of Coccinelle.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4ztjew4jkypqxdqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluAFw4ACgkQ0rTAlCFN
r3QrPw/7BX6NZcZ28BGC3zlB+eOW9HSaVQZBgPE9xKGjXkCakLMlc+EuIJUpx5ki
lxSs8L1H1QbnBdwfPKEoFiJ8xYzSr88NRoWRSrupW3Sz4ueh2GKKToJWDRmKygps
8Wv+tGCP68fKhAJafhutQY9LY9yz401JKiSkIcCEYsLDrX+oVKWZrXXjId9c0nG9
JqH9EWYit3f5zS4Z2qO9lLmrcPfAjbbk6t9VaBbmSR58EOBb2iqvEZ76NSnTCCXq
NzmqPBRyVmPSq65m5BzQXtrKSFpvGPMtYfC8sajZzlkhZcAqf2VpqICEcYx78IO7
XVUB+H/K2/58O8HHL/pkc4WDGm9hqYLXUEB0TMPIhYbSBN2kuHwl/m9maijNGw5Z
2rKocWOVEHhfuowhhW3r3yAYBriFxvmGLZYnc9ybwUCqMa6ReDn2+XU5+kd/vU2m
PR/jF8GWYz6TUdsk95cYHsfIn1+fwZo03RfhsQPGFvNmH5Dj/XT4yfZ08HFuqwnD
/rDzlpWG+Ti1reZmYPWs2KAfk69M4IAcNLEAhdidfL/9Ae47kzWbQcBcO4RIucyj
/Q/6hMvmZfDL7LQtRljrVUGeW1IviRYxQyWOTAYkI7wP3BNOSF5gvahsLNqGIzfB
QGTh2JHfFXwjaWNWsHKpicNjYQNuAp6UMrzHjNalGuQunf8sJOY=
=KTff
-----END PGP SIGNATURE-----

--4ztjew4jkypqxdqf--
