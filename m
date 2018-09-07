Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EAAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FAA2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FAA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeIGNlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:41:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59700 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIGNlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:41:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 10FD5208AE; Fri,  7 Sep 2018 11:01:40 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id D5110206FF;
        Fri,  7 Sep 2018 11:01:29 +0200 (CEST)
Date:   Fri, 7 Sep 2018 11:01:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 02/10] phy: Add configuration interface
Message-ID: <20180907090129.yg5m5h7ocoow5xbv@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <8397722.XVQDA25ZU6@avalon>
 <20180906144807.pn753tgfyovvheil@flea>
 <20180906162450.GA26997@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3efarss5q7c4qdy6"
Content-Disposition: inline
In-Reply-To: <20180906162450.GA26997@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3efarss5q7c4qdy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 06:24:50PM +0200, Andrew Lunn wrote:
> > > > +int phy_configure(struct phy *phy, enum phy_mode mode,
> > > > +		  union phy_configure_opts *opts)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (!phy)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (!phy->ops->configure)
> > > > +		return 0;
> > >=20
> > > Shouldn't you report an error to the caller ? If a caller expects the=
 PHY to=20
> > > be configurable, I would assume that silently ignoring the requested=
=20
> > > configuration won't work great.
> >=20
> > I'm not sure. I also expect a device having to interact with multiple
> > PHYs, some of them needing some configuration while some other do
> > not. In that scenario, returning 0 seems to be the right thing to do.
>=20
> You could return -EOPNOTSUPP. That is common in the network stack. The
> caller then has the information to decide if it should keep going, or
> return an error.

Ok, that works for me then.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3efarss5q7c4qdy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSPmgACgkQ0rTAlCFN
r3SiCA//esrZwoTzf8uzPwocw6DIoDgAujUydvkWg7qNajUtjsAvyts+hsYpYV8C
Dgn3S8EbeJ4WNv1G5R+jJJh3WfqmQhWMWB9N3ibVdI9EIO3W1Kw9nkVr/iXXn6Rs
wop44tjmo9L4yZwwylUapQZklVuIcHx62cIxFBdeeKuTdt4oa8OCNP0yTR4HS4g4
WDX3WZccwp/vU9ZpgMYng2hAcmjAXEiYfsqrAd74R7gI8op44cz1ziWQLSaNGsut
/z+7VfrCN54fQFwFqZojPuIW6yuAU2wo7hE+rTS20vVCdJtBEs0OpwPhWQ0LMBk4
qQZLue46W56LFdPkSEYDkFYY5zkxIBJqBQUjz6SdcYEQsn7Jrp92KJf1+FI5ilH/
vYkAYUIYHjQOPF4kltvFQx9JkeUa7CSeVqix2qF09ZYOpxAVcuNuRQnu9ia/i8kU
PX+89tf0m5uS0++2orSJLtd+EMMmH/u71X4r4AhNdmkBw9iYzs2i7axzjvoPcVup
f9l9fc0N3iCbYjACSSFt+2cOVQ6sRiDr5XQe+YmKgHwJXUd0lYtudXovTrA5TVAp
jWYOl60hs0RIBEt2OU5rgVCFRLtItaUQ7BLg1l/L+8V6bv7d/nKejb+uWrmqqZ+5
AvnjVcSZv4hey+4XM49HL8Mcnif251tTIrg2UKK6oK/W5opasbw=
=1fsx
-----END PGP SIGNATURE-----

--3efarss5q7c4qdy6--
