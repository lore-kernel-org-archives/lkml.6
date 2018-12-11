Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F37C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF172086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF172086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLKVpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:45:31 -0500
Received: from sauhun.de ([88.99.104.3]:46174 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLKVpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:45:30 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 5ED834C0E8F;
        Tue, 11 Dec 2018 22:45:28 +0100 (CET)
Date:   Tue, 11 Dec 2018 22:45:27 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jian Hu <jian.hu@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
Message-ID: <20181211214527.GA5660@kunai>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
 <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
 <20181211203652.rogajl4ajwu7cs6f@ninjato>
 <7hsgz3u4fu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <7hsgz3u4fu.fsf@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> I am okay if it is reasonable below in file
> >> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just =
uses
> >> axg's compatible.
> >>=20
> >> 			i2c0: i2c@1f000 {
> >> 				compatible =3D "amlogic,meson-axg-i2c";
> >
> > Actually, you should have
> >
> > 	compatible =3D "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";
> >
> > in the DT to have support for future SoC specific additions. And then,
> > patch 1 is needed.
> >
> > Or do you handle this differently? I'd think this is DT standard.
>=20
> It's a DT standard *if* there are actual hardware differences.  In this
> case, the IP block is identical, so there are no driver changes.
>=20
> We prefer to add a new compatible if and when there are actual
> driver/hardware changes.

OK, fine with me. I just hope for you guys that there really is no
change in the IP block, otherwise you need to update DTs later.


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQL/IACgkQFA3kzBSg
KbbXFg//SIq2lU0nge0Dh0BSX8NJGPF/ETdhp8hcEKs5kManXc/Kd+rLlNJC7y84
AMSGX9pIK899f51uMMgI6AbzNGimTk8Y2nghiHLyq6tum6QeFdOIjDJOC3lICUhx
z7L+BEZ6hFNJPBZRSCRlio3dag2k8qHhM5ah6Xu6i7mH+g1JrNi6gFyrZsNv8hFy
3Hg/bL7DwZXQJFknp0tsOglXiJThOz7VDx460zqn5cyl2PRvSaRvhZ67Yzg9I7Sz
TQIW+KLj/hv2JApKkJtlYFHit+p3ZZvb/JfaGfO2FsKnBL6WJQJT6dLwPiK1guG7
wSmp3eOqAlgeI3NMNqmAy2SfYqZn3IoVsuNy9us5+hkshxwsgOxkoT1Vvde3o19b
c42k8bolyzyvdKDGbl1UuahvQLB3pdYvDa1kCzO63BlW6slMVsjhcYuK0yP7AW7F
4SSumOdaFrd3azSi7pl5eG21J19U45sSxWow9oMRuw9yW9JHDiB5mIKt4dLTIym/
mAbfHswdxtRDepqmM2UyLRN5RX6bJA8aefum/2jdNg98dbiUHMX8akHqbS//eiOX
xBZcptougATsy9JIVcw25PSpg0NTUM4udScSsKyptNTFkFoE6PyF7ln67R8M3R2n
uTW6i946iQ/olPGPhN/yCWg3AoD9mAdaxEOIcGZ3ekgA94NbgUc=
=J9xG
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
