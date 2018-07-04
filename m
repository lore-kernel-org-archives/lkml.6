Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BFCC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8CB24207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8CB24207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934580AbeGDJGy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:06:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40633 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932324AbeGDJGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:06:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B57D22069C; Wed,  4 Jul 2018 11:06:49 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 85EF72069C;
        Wed,  4 Jul 2018 11:06:49 +0200 (CEST)
Date:   Wed, 4 Jul 2018 11:06:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
Message-ID: <20180704090650.hr3j7a6wn7nwfkvq@flea>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbpzbgsb7pdvdpwn"
Content-Disposition: inline
In-Reply-To: <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbpzbgsb7pdvdpwn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 09:16:32AM +0100, Marc Zyngier wrote:
> On 03/07/18 19:42, Samuel Holland wrote:
> > On 07/03/18 10:09, Marc Zyngier wrote:
> >> On 11/05/18 03:27, Samuel Holland wrote:
> >>> Hello,
> >>>
> >>> Several people (including me) have experienced extremely large system
> >>> clock jumps on their A64-based devices, apparently due to the archite=
ctural
> >>> timer going backward, which is interpreted by Linux as the timer wrap=
ping
> >>> around after 2^56 cycles.
> >>>
> >>> Investigation led to discovery of some obvious problems with this SoC=
's=20
> >>> architectural timer, and this patch series introduces what I believe =
is
> >>> the simplest workaround. More details are in the commit message for p=
atch
> >>> 1. Patch 2 simply enables the workaround in the device tree.
> >>
> >> What's the deal with this series? There was a couple of nits to addres=
s, and=20
> >> I was more or less expecting a v2.
> >=20
> > I got reports that people were still occasionally having clock jumps af=
ter
> > applying this series, so I wanted to attempt a more complete fix, but I=
 haven't
> > had time to do any deeper investigation. I think this series is still b=
eneficial
> > even if it's not a complete solution, so I'll come back with another pa=
tch on
> > top of this if/once I get it fully fixed.
> >=20
> > I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (=
24MHz
> > timer) =E2=89=88 150 should be a conservative iteration limit?
>=20
> Should be OK.
>=20
> Maxime: How do you want to deal with the documentation aspect? We need
> an erratum number, but AFAIU the concept hasn't made it into the silicom
> vendor's brain yet. Any chance you could come up with something that
> uniquely identifies this?

Yeah, I don't know how we can address that unfortunately. Or maybe we
can call it timer-broken-1 ? It's as good as an ID than any other ID :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hbpzbgsb7pdvdpwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls8jikACgkQ0rTAlCFN
r3SPuw//UyOhbXeU8eF3IWO7vH9Jsu8IfuJr03W2/7uo64H12IOWILp5sPn6zs59
gwJow1g7997bjyN0+hH8L+krlwkppAZFYrXwTKUFaKDeeImhW5DuEaQTUDmsM2gR
rM3mhTorON07whHwbR5UD20cktblEQ/n/f7Tfo8YOTwaZFt88nsA1K3sGmYc3oXQ
HM86g2nBe5HG/snXxRM32VIvT7ieJdxdaaKrs3ThYBCuZluS8ELXF6Sqi72GCdnx
DBMXzclRbWM6yEzxyZjGm3ggr52miYRmbxory+8UODqM6QvsBwP9WJdM3g6BlfR8
wAfcV0c0W+UoMjbWQ2R3VB3LQAvGDoN63o8KiDiCkL0xhvqVUWnAi5CYGPS4ryGg
YZVJXk9A8s4GvgTwGGM9ExEFmHS4za8wFE/RdpNGuFbvl/eZ3CnNAioD2FxZCvsq
EAPEBVpEUJ/vxHWbIf4Rn9qadfHhkB73ETxLfSSPmhneIp7zR/2UPK1aKDXC5u1L
0ho7gbLHmsYapi3B4ejmjLg4NhaTq/3bQ9yX5aVJ9CWAULg2M/ePlbpKegFpoPIG
UBYqJVBUhejj9fGdlMvEPdyJ5tNfvPozmUA13HC2/rbb6BX37tiu9TsIyjAiMtvJ
ckoZP+SnT4yTp0XJeY9AqyqKdemK6MncQ9SnTTwv+x8fIvITWe8=
=v/4z
-----END PGP SIGNATURE-----

--hbpzbgsb7pdvdpwn--
