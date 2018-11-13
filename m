Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB490C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC06223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC06223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbeKMXdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:33:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52799 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbeKMXdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:33:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6F110207BB; Tue, 13 Nov 2018 14:35:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37833206A7;
        Tue, 13 Nov 2018 14:35:18 +0100 (CET)
Date:   Tue, 13 Nov 2018 14:35:18 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yong Deng <yong.deng@magewell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v12 0/2] Initial Allwinner V3s CSI Support
Message-ID: <20181113133518.6nnh4m37s6awfw6d@flea>
References: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aa6ku2d2rt2bopyg"
Content-Disposition: inline
In-Reply-To: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aa6ku2d2rt2bopyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yong,

On Tue, Oct 30, 2018 at 04:09:48PM +0800, Yong Deng wrote:
> I can't make v4l2-compliance always happy.
> The V3s CSI support many pixformats. But they are not always available.
> It's dependent on the input bus format (MEDIA_BUS_FMT_*).=20
> Example:
> V4L2_PIX_FMT_SBGGR8: MEDIA_BUS_FMT_SBGGR8_1X8
> V4L2_PIX_FMT_YUYV: MEDIA_BUS_FMT_YUYV8_2X8
> But I can't get the subdev's format code before starting stream as the
> subdev may change it. So I can't know which pixformats are available.
> So I exports all the pixformats supported by SoC.
> The result is the app (v4l2-compliance) is likely to fail on streamon.
>=20
> This patchset add initial support for Allwinner V3s CSI.
>=20
> Allwinner V3s SoC features a CSI module with parallel interface.
>=20
> This patchset implement a v4l2 framework driver and add a binding=20
> documentation for it.=20

I've tested this version today, and I needed this patch to make it
work on top of v4.20:
http://code.bulix.org/9o8fw5-503690?raw

Once that patch applied, my tests were working as expected.

If that make sense, could you resubmit a new version with these merged
so that we can try to target 4.21?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--aa6ku2d2rt2bopyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+rTFgAKCRDj7w1vZxhR
xYo2AQCjVo2DMx05jzJV1L//qtVnrQ6uzy9rgeGLzFkU83S2LwD+M/yMUjwAJhl1
suMk4OlZFxntxFuQqwNLoQJMmuBicQI=
=Vno6
-----END PGP SIGNATURE-----

--aa6ku2d2rt2bopyg--
