Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ABFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F135320877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F135320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJECuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:50:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51664 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbeJECuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:50:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5BBB3207F3; Thu,  4 Oct 2018 21:56:05 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2B836206FF;
        Thu,  4 Oct 2018 21:56:05 +0200 (CEST)
Date:   Thu, 4 Oct 2018 21:56:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if null
Message-ID: <20181004195605.txvbkshvxklyzxyb@flea>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
 <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6k4kmrvnmdrrg4l"
Content-Disposition: inline
In-Reply-To: <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6k4kmrvnmdrrg4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 04:24:58PM +0200, Giulio Benetti wrote:
> If using tcon with VGA,

We don't have support for VGA at the moment. Or are you talking about
using a VGA bridge?

> tcon->panel will be null(0), this will cause segmentation fault when
> trying to dereference tcon->panel->connector.

It's not a segmentation fault, but a null pointer dereference. And
that case will also happen with bridges.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--p6k4kmrvnmdrrg4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu2cFQACgkQ0rTAlCFN
r3TSxw/8Dziy1NiInMstE2LiZhh8Lwqi77TDLFHYbY0jmc86gPC3nQ+HHAldfF3d
HYWS7ubeG8FkNnyg4327nGC2pR3iSmWXhNWQlqPx9rggDANSAT/Nv7fo0ZbValL4
iyacp43k4hrWhSpZuPsAvFq349Qh06HsGsQkU/3tS/uTa2hntW1170eA3s+re+BW
I2R+DDzRkzkwgNjUTHFW/vG4iG6hlzZbmsi9FgIOg3jNKXNAniveLGOQNICfra62
DdHh3RxGhRjkuqFt8snOM/Y4MkC0BnadnEwyCRBVg9KAfQe0BQv7p3EyGr8n6QW6
ExOjK3HxsWCDYOcnrqR9AvbuYIZGzMOSUkUBKInar2yY3UFXmd/QGG6dT6hjJS7I
8qMExOjZkRN5/oHpMYb93gF3MfW3Z63nfaHCcRPitNnlvANBo36nZqvXHLiVxlZf
dNJbw0p1v+mhPNPiIMmnBQiL17xwUqSC/R69U8XXY3FbPBAGGqu6VZORtv2isbKC
AJA3mAZGJfIiNr8YJytHU4GTazN/9cUQhLBz+XE8d3W63B8oZSbmPwUc26NK5W7h
eCezPgMWjxUYX/orSkiocW9NXRUcIDhBSOnq8wlzb6cIAMX00Nz4bFo/2+BHAgn4
Ujpmxecr5cS/Gyc7f+e3zXJ/GkzXrFgRrTudPq0xS6VqZfoO/tk=
=JJRK
-----END PGP SIGNATURE-----

--p6k4kmrvnmdrrg4l--
