Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BADC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151972077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151972077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeIGSHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:07:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42549 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbeIGSHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:07:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0CF862079D; Fri,  7 Sep 2018 15:26:31 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8B3D20379;
        Fri,  7 Sep 2018 15:26:20 +0200 (CEST)
Date:   Fri, 7 Sep 2018 15:26:20 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Kocialkowski <contact@paulk.fr>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
Message-ID: <20180907132620.lmsvlwpa3rzioj2h@flea>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
 <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hu5t7oybgv7p55pp"
Content-Disposition: inline
In-Reply-To: <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hu5t7oybgv7p55pp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Fri, Sep 07, 2018 at 03:13:19PM +0200, Hans Verkuil wrote:
> On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
> > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >=20
> > This introduces the Cedrus VPU driver that supports the VPU found in
> > Allwinner SoCs, also known as Video Engine. It is implemented through
> > a V4L2 M2M decoder device and a media device (used for media requests).
> > So far, it only supports MPEG-2 decoding.
> >=20
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data that
> > is used to generate the frame.
> >=20
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for the Allwinner VPU.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> One high-level comment:
>=20
> Can you add a TODO file for this staging driver? This can be done in
> a follow-up patch.
>=20
> It should contain what needs to be done to get this out of staging:
>=20
> - Request API needs to stabilize
> - Userspace support for stateless codecs must be created

On that particular note, as part of the effort to develop the driver,
we've also developped two userspace components:

  - v4l2-request-test, that has a bunch of sample frames for various
    codecs and will rely solely on the kernel request api (and DRM for
    the display part) to test and bringup a particular driver
    https://github.com/bootlin/v4l2-request-test

  - libva-v4l2-request, that is a libva implementation using the
    request API
    https://github.com/bootlin/libva-v4l2-request

Did you have something else in mind?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hu5t7oybgv7p55pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSfHsACgkQ0rTAlCFN
r3QxZg/9GeduzkWPv/fZmHl4wwxZayt10goQkM42PfX6x2so6f2V8SuL0GBRITQt
HTWg6NKhu47952sU2dwu/1yEX2cInQvpK81INpMuAC7nNdfvr8DPfMG65+b4jm5e
Bzla1OnBTimftcRkmaGW/xJid0uf6Skn765hEnLAM3hYiWhOVmXV5klIRJ1onP2j
tS0JxYc9jmD/f7G1TIQlTr/0RuZNeBdGMouYf8uuX439PHyOdVVJC6pn0Qfq1R6Z
M2CTacJKGde/y9ytRpNnjZNO8NuQpstgu8GzCJZqYpCJAxajjRhC0xFnT5u9Z1yU
+Qhmo7/VLacmEPBFzFRxQOMbD+G3pNS23fX6TcqMKn0OUuGbc3UB/egOQIDTgumQ
sl+z4hbp96iPdXxRiFf1fJ8cuulV1Gjn6BqtyiN9p8AzJORrbIgsBdBr84VrrTVA
B3CYV4BZOVvT1MSThvlWWviB1GL5SN58MpG/BirE41Pd4k3/DdDSRZ5+k43I7F+s
O/gw/NPTVTLfTxYoLz85zPHGEu8n2UyVemOb9q5aD4TALygXivI1CWvYtEzFsGvB
nAdSdroFa/jn4zzBUxktyRxUxgR40XCsTc8g+rvppsTrMh1aZsCIfCkglsDq9IjG
6Oc6ZfiPSAOdVQzEFZP9+Ln89y1LmWJnva0visMUkVan/cVonw4=
=Cfug
-----END PGP SIGNATURE-----

--hu5t7oybgv7p55pp--
