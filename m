Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5188F20844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBGJZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:25:38 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:45035 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBGJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:24:58 -0500
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D3DD210000F;
        Thu,  7 Feb 2019 09:24:54 +0000 (UTC)
Date:   Thu, 7 Feb 2019 10:24:54 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     David Miller <davem@davemloft.net>,
        Chengyu Song <csong@cs.ucr.edu>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Message-ID: <20190207092454.xq5jvnfnuhcp37nm@flea>
References: <20190205221559.17545-1-yzhai003@ucr.edu>
 <20190206.201736.1146228626076916564.davem@davemloft.net>
 <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
 <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b2zwkslu724bwfel"
Content-Disposition: inline
In-Reply-To: <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b2zwkslu724bwfel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 09:53:16PM -0800, Yizhuo Zhai wrote:
>=20
>=20
> On Wed, Feb 6, 2019 at 9:52 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> >
> > Thanks, but why initialization matters here? Is performance the main co=
ncern?
> >
> > On Wed, Feb 6, 2019 at 8:17 PM David Miller <davem@davemloft.net> wrote:
> >>
> >> From: Yizhuo <yzhai003@ucr.edu>
> >> Date: Tue,  5 Feb 2019 14:15:59 -0800
> >>
> >> > @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac=
_priv *priv)
> >> >       struct sunxi_priv_data *gmac =3D priv->plat->bsp_priv;
> >> >       struct device_node *node =3D priv->device->of_node;
> >> >       int ret;
> >> > -     u32 reg, val;
> >> > +     u32 reg, val =3D 0;
> >> > +
> >> > +     ret =3D regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
> >> > +     if (ret) {
> >> > +             dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n=
");
> >> > +             return ret;
> >> > +     }
> >>
> >> I agree with the other reviewer that since you check 'ret' the initial=
ization of
> >> 'val' is no longer needed.
>
> Thanks, but why initialization matters here? Is performance the main
> concern?

Not really, but if we turn this the other way around, why should we do
something that doesn't bring anything?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--b2zwkslu724bwfel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFv5ZgAKCRDj7w1vZxhR
xbinAQCsh3JO2mI1qvmsvNyCd6VyFGOI43tcOkD82skXiUg9dAD/YvGF3TSHZJKp
cAOI+cr8VR4R3TTVsQD56oQioQFJfQY=
=RDQE
-----END PGP SIGNATURE-----

--b2zwkslu724bwfel--
