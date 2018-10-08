Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF65BC65C19
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0942064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0942064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJHR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:29:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39405 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHR3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:29:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E2414207F3; Mon,  8 Oct 2018 12:18:37 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3F2E2072D;
        Mon,  8 Oct 2018 12:18:27 +0200 (CEST)
Date:   Mon, 8 Oct 2018 12:18:28 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 10/29] drm/sun4i: Rename DE2 registers related macros
Message-ID: <20181008101828.hb4xtppbexwalbkk@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-11-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u2h5j7rewatczeh5"
Content-Disposition: inline
In-Reply-To: <20181007093905.11253-11-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u2h5j7rewatczeh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 07, 2018 at 11:38:46AM +0200, Jernej Skrabec wrote:
> In preparation to introduce DE3 support, change prefix from "SUN8I_" to
> "DE2_". Current prefix suggest that it's valid only for one family,
> whereas in reality, DE2 unit is used also on sun50i family.
> Additionally, it will be easier to distinguish DE3 specific macros by
> using "DE3_" prefix.
>=20
> No functional change in this commit.

I'm not too sure about this one. There's basically two ways to look at
this: you described the first one, and the second one would be to
treat it as we do for the compatibles: the IP was introduced on one
SoC family, and then got used on some other ones.

Trying to always match the one you have however have a quite big
maintainance cost, as can be shown by your patch: you always have to
adapt comments, function names, defines, etc. This creates a lot of
useless churns (ie, non-functional changes) in the drivers, that need
to be written in the first place, and then reviewed.

It's just not worth it.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--u2h5j7rewatczeh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7LvMACgkQ0rTAlCFN
r3RJlg/8CrYQK3P9WPVn2PZZWm6SjDK98/0Th/16/S3fgrZjIQomWjGTz9sIeK1C
qrEhqPgg9KO+vrKbTlFAID3P09Mz0FUjD5Bq5tuNyrMdCWi5QlopS20LgFYDyxMI
n+TSyDqIgtYKe852XrhZ9Lh8QUTiNX/ixFn5Jume0kYshdwKqB7YzMc8GXXlRxe/
ekFikGy1F4P2/vU9cvZW/5nNIN2qDExx+hM/sHuRNXc/hHaU3cFPVzhssVcWT6c2
/Fx7cI8jimEivcDQYkIj3ozbrK0dLeJKRZ8J8d0/HeU8mHJ7DKn6SSIFq5RFMkcB
pVKFoaJpk1JFygWkTeaNsomuNMTPzS0FHBviGKifHnQ4dXPakefjPrItf33G7dDn
a6m4Yy+TsdRaR4mKaLSQTVIqXurdWTjlY6Tcqqqrd7bN5TbSZxRM6qjjPK/OULzV
SACtzLNSBIlfXfEMg+tR0K6mkpWsmdAZNCIYxuf5Dr7wPzP4N7ra4JANzpzlwKqK
etlbG+i3n6pcsFYzIU7eSbRmv7u9wBiuJSV7AiCyS4GMmn9BHyW4MORlRGMz7jls
cBfZSD25XtzW958ZQ4x5ATsZG6QsrZ+jRL/uy/GodyzDGYB8djIK2lQefaPpYOS6
7sZzF4ZtOYOrLVGKI0mgLhnNBmyCSq4KleQ+Bi1zXB2Xh1PeL4Q=
=5UDP
-----END PGP SIGNATURE-----

--u2h5j7rewatczeh5--
