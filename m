Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164D32080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164D32080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeKTBDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:03:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48855 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbeKTBDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:03:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E7E22074F; Mon, 19 Nov 2018 15:39:57 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 61DF5207B0;
        Mon, 19 Nov 2018 15:39:47 +0100 (CET)
Date:   Mon, 19 Nov 2018 15:39:46 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ARM: dts: sunxi: Add all CPUs in cooling maps
Message-ID: <20181119143946.qqipcb2c34imc2td@flea>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
 <b2524a2db87c97c038990af405bd1cca25e579f8.1542362000.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e65cvqpkt4byjzbm"
Content-Disposition: inline
In-Reply-To: <b2524a2db87c97c038990af405bd1cca25e579f8.1542362000.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e65cvqpkt4byjzbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 03:31:14PM +0530, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
>=20
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
>=20
> Update cooling maps to include all devices affected by individual trip
> points.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--e65cvqpkt4byjzbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/LLMgAKCRDj7w1vZxhR
xRtJAQDOkaLC6alOxQ7wIVemizO2wVY5u3Qkz+GeMF/6ZrXtRgEA27cm5xkG74Oy
3/4ibMTbAN4sUM/j6HQjOraKu7e+ogE=
=p7xv
-----END PGP SIGNATURE-----

--e65cvqpkt4byjzbm--
