Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D5CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C6D208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C6D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeISOYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:24:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeISOYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:24:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AD9A1208C7; Wed, 19 Sep 2018 10:47:29 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 79FE7207D4;
        Wed, 19 Sep 2018 10:47:19 +0200 (CEST)
Date:   Wed, 19 Sep 2018 10:47:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     airlied@linux.ie, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
Message-ID: <20180919084719.6ymf6h4eftomfab3@flea>
References: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tb2cum6aarkak5h3"
Content-Disposition: inline
In-Reply-To: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tb2cum6aarkak5h3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 03:25:20PM +0800, zhong jiang wrote:
> Fix the following compile warning:
>=20
> drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
> bool has_lvds_rst, has_lvds_alt, can_lvds;
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

I can't see any code path that would lead to an uninitialized usage of
that variable.

Which compiler produced that warning? I tried building it today with
gcc 8.1.1, and I don't see that warning either.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tb2cum6aarkak5h3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluiDRcACgkQ0rTAlCFN
r3RcQw//aG8uLJ1U9c9dGYL00bx8p8vEIeiXZ35l0fUj8zvVaXEyPaaGUEnkbwCC
oXaA56VVACSkUQFshlrThp5D8MzqtTh80RCt6YYZUO6YNuH0g5gohOUpnPqALxGM
6vQI/btUHeMjmZpuVDyF39tJp7FlnygTLWltdB9LHZFUN/cSTRsQDSvyRCmEd7ir
v7f/fpYsg5UB65B6Q1P94LlaLQF7MXehPE4z4hno0836RiSLRVjImqEEUQ6YJJ05
HtCSvviYtjbQXz9zh/062PqRdrNLXXfibyTvHtw985imge+WUy1pV+F0HKza3w2h
nEceP+O83cxxeT5rpuxDYUypZHuoLDLeb/S/y4JQulQ09x+j0m+eK2VkfCdftCQ1
rdNGXXi3+OCZ/ER+moIZj/RwEnDIuGB2Msrv+XGPDbtBwOicoTTX7MxOD2lC4mir
bMW1ovLZ9ceOCpfEwpL4MaS7SYwj7L/XMQ/k9b8mLINS7CibbIAp8Q7ivpGbC4YF
Oi1zr/QiqGhN70Hw5FkTXnCRq7cIn76eozDXrhOWkJPK5ZIQxpcpfZY3nbhDSQwo
0dR0qZZTYAHkYTsejHJmZnsVvxn0eJ+RDbJ6eSQWTRRLdqRgMWpjGHO4gyl0Nk9w
NX1HPmVIP8FavswFo+ZL4RkZ/QfB1vFUcfYq5sWzzpX9H1cnBXo=
=rS+S
-----END PGP SIGNATURE-----

--tb2cum6aarkak5h3--
