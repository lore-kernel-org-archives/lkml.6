Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAF2208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF2208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJBBVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:21:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42308 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeJBBVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:21:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 419AC207BF; Mon,  1 Oct 2018 20:42:13 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 13D072039F;
        Mon,  1 Oct 2018 20:42:13 +0200 (CEST)
Date:   Mon, 1 Oct 2018 17:45:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     jorik@kippendief.biz
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] ARM: dts: sun8i-h3: add sy8106a to orange pi plus
Message-ID: <20181001154545.iwxjgw5exg4psfy4@flea>
References: <20180929131830.13924-1-jorik@kippendief.biz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmtks3qffvmnpfjl"
Content-Disposition: inline
In-Reply-To: <20180929131830.13924-1-jorik@kippendief.biz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmtks3qffvmnpfjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2018 at 03:18:30PM +0200, jorik@kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
>=20
> The Orange Pi Plus board lacks voltage scaling capabilities in its
> current form. This results in random freezes during boot when cpufreq is
> enabled, probably due to wrong voltages.
>=20
> This patch (more or less copy/paste from 06139c) does the following
> things on this board:
> - enable r_i2c
> - add sy8106a to the r_i2c bus
> - have the sy8106a regulate VDD of cpu
>=20
> Since the Orange Pi Plus has the same PMU setup as the Orange Pi PC, I
> simply took min/max/fixed/ramp from the latter DTS. In that file the
> origin of the values are described by the following comment:
>=20
>   "The datasheet uses 1.1V as the minimum value of VDD-CPUX,
>   however both the Armbian DVFS table and the official one
>   have operating points with voltage under 1.1V, and both
>   DVFS table are known to work properly at the lowest
>   operating point.
>   Use 1.0V as the minimum voltage instead."
>=20
> I have tested this on patch two Orange Pi Plus boards, by running a
> kernel with this patch and do intermettent runs of cpuburn while
> monitoring voltage, frequency and temperature. The board runs stable
> across its operatiing points while showing a reasonable (< 40C)
> temperature. My Orange Pi PC, when put to the same test, yields similar
> stable results.
>=20
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

Queued for 4.21, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fmtks3qffvmnpfjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluyQSgACgkQ0rTAlCFN
r3S65BAAkGP/ueMCgEolqSLvfgtp4VuXNguTnW77nmoGGCxntZplJl8ywIgNbnLd
44gudDip4b+Qz+48x9SdeTyyVqjFGySuQoMtFGO/greDCdVaJoGySU9yKBt9JqKK
YR9FEJezYMGsRZLc2I1WqvZX6Ec37OxAlkPuctGq47eqPc3+rSxIS2v76pYBBEkq
ZeF7j4ezw4sIwnDDQaBCsh9N4NQgDahKCTLUE7p57zwtoduXMYwW90Ez+2F0WqHS
GV7plvFV/PDSR27F2VAjCw+tjjVjbvjLg3GyMZ2vmkIFglk1s7vAAZx/rW6kNENe
59Pc8TPU0W8X1o6JFrOczkjPzXpbQmzSPpoPWyzq7j16TeAqpztce6VF7GLeXXUq
0BMlgfhkYXzZ00HkM8XLqLcdjk6O6TCzhus7MMLIJeGH6riJ5BmFjbiehU+Fmddt
LTceSIPIWA2PklGkNqJCge5n9QdF+UJdDrlzfBZbo1Z9NPoLKtWxjeBHjT263T2v
9tnqrs/O0682b/4FaU/TGvfU/VrQKXvjZgps4+HkVEZjj0ZXVeluQ7L4epaLJ0sN
qHr+Pt4tzHAWIkDqccD89OJMVRWTltNbPVjkrgxLAdLTvqqFGX9vwV8JqFmQ4jcj
jmPF74OQc5EjpXp0MG+10RnebpLELVpoqv/vPFnSo+Rm1lurT3Q=
=yFLZ
-----END PGP SIGNATURE-----

--fmtks3qffvmnpfjl--
