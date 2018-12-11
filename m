Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D645C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF62084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDF62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLKUg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:36:56 -0500
Received: from sauhun.de ([88.99.104.3]:45624 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKUgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:36:55 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id ACF164C0E90;
        Tue, 11 Dec 2018 21:36:53 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:36:53 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
Message-ID: <20181211203652.rogajl4ajwu7cs6f@ninjato>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
 <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6j4ocolv5vcwqhy"
Content-Disposition: inline
In-Reply-To: <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r6j4ocolv5vcwqhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I am okay if it is reasonable below in file
> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just uses
> axg's compatible.
>=20
> 			i2c0: i2c@1f000 {
> 				compatible =3D "amlogic,meson-axg-i2c";

Actually, you should have

	compatible =3D "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";

in the DT to have support for future SoC specific additions. And then,
patch 1 is needed.

Or do you handle this differently? I'd think this is DT standard.


--r6j4ocolv5vcwqhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQH+QACgkQFA3kzBSg
KbYghA//e+Y8jxdhjD74FHRwHJedpaaTeb8kDXLWeywBEDsZikyyg521dDLFYodO
1fm88aVcj21Of70l3aXd5XlRUndSa701Rm/JStWJR6xgHY1wmU0MiuUAINO3XvbE
90yyjh5gVOonytSaEM1at5rvgsuMknBPDWigRNEbPfQkXckMYyh+Ini2nAvKs5ZB
GZUNMt1JZcKRdd599coNfhuKPQAxp+SmikdPBJ+H9RSm58IyU8iitPw9AR6JesMM
7ihWoNOC5REbI8CzCKlYTFM0J8ppRnpJfzAkDKDl18V147TAmXVBQ+hPSDKfTxYH
VbtZQ9AUPUawMWhTVmt7ZsZuZPmOoPjccsLo+nWqz/db/JDyhyMzjY/46AWl37U2
b6H55meUJyPVf/AKDY67ey/DpjA00C6URXkOLCelW0vV4qy71hzYgMXGGJ3yWdwi
4NmJtPpqax3st/K2/mwDQc4humJ+4FeLw9OREsLhdOw++3fRkYr8ZrysJDmNH7yS
h5cgVTGqE0rtCt9sct8Om88gut//78pusStosThw+nwHbTOL5gsK405OrSQFoe2N
nitfLq2ISw/njOwajTWSgdUcWa9kkwmTk/UixXjBe8r5VEiv32qmt/Q/K8vmyDES
O9MOHcWu3slySjEBzXQs519PblIQJCYgUdHVaXwuIStWkHpkO1k=
=Uiz1
-----END PGP SIGNATURE-----

--r6j4ocolv5vcwqhy--
