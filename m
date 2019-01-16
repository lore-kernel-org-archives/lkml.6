Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F410EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7FD20868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfAPTSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:18:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43665 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbfAPTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:18:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2B5D1209EF; Wed, 16 Jan 2019 20:18:07 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id C9C10206A6;
        Wed, 16 Jan 2019 20:17:56 +0100 (CET)
Date:   Wed, 16 Jan 2019 09:59:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/sun4i: backend: add missing of_node_puts
Message-ID: <20190116085913.j2ju3mj75x5bqppm@flea>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dunppgcxmo5qgg5l"
Content-Disposition: inline
In-Reply-To: <1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dunppgcxmo5qgg5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 13, 2019 at 09:47:44AM +0100, Julia Lawall wrote:
> The device node iterators perform an of_node_get on each
> iteration, so a jump out of the loop requires an of_node_put.
>=20
> Remote and port also have augmented reference counts, so drop them
> on each iteration and at the end of the function, respectively.
> Remote is only used for the address it contains, not for the
> contents of that address, so the reference count can be dropped
> immediately.
>=20
> The semantic patch that fixes the first part of this problem is
> as follows (http://coccinelle.lip6.fr):
>=20
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator name for_each_child_of_node;
> @@
>=20
>  for_each_available_child_of_node(root, child) {
>    ... when !=3D of_node_put(child)
>        when !=3D e =3D child
> +  of_node_put(child);
> ?  break;
>    ...
> }
> ... when !=3D child
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dunppgcxmo5qgg5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXD7yYQAKCRDj7w1vZxhR
xYlyAQDwvaT1Fd85U90xXfnNEaXT0VONYRQBfzXkZ5deO8x8igEA+PXurQWESJMf
cVGPanmyDaAWOtjRbYLKr4Tkn8cthAk=
=7q2T
-----END PGP SIGNATURE-----

--dunppgcxmo5qgg5l--
