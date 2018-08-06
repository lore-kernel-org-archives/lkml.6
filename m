Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5260BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0062321916
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0062321916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbeHFO5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:57:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFO5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:57:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 980F2207B5; Mon,  6 Aug 2018 14:47:59 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3B32D206A6;
        Mon,  6 Aug 2018 14:47:59 +0200 (CEST)
Date:   Mon, 6 Aug 2018 14:47:59 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180806124759.7e2uz7jvoycalris@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730133448.GD13198@lunn.ch>
 <20180801082413.2mjm52vwxw3anun6@qschulz>
 <20180801143147.GA16322@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dwtbtpadbufkaztq"
Content-Disposition: inline
In-Reply-To: <20180801143147.GA16322@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dwtbtpadbufkaztq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Aug 01, 2018 at 04:31:47PM +0200, Andrew Lunn wrote:
> > > Maybe this should be serdes-mux? The SERDES itself should have some
> > > registers somewhere. If you ever decide to make use of phylink,
> > > e.g. to support SFP, you are going to need to know if the SERDES is
> > > up. So you might need to add the actual SERDES device, in addition to
> > > the mux for the SERDES.
> > >=20
> >=20
> > I'm not sure to follow.
> >=20
> > To be honest, I might have mislead you. The whole configuration of the
> > serdes is in the hsio register address space. For now, muxing is the
> > only reason there is a driver for the serdes but there are other things
> > that can be configured (though not used yet): de/serializer, input/outp=
ut
> > buffers, PLL, ... configuration registers for the SerDes.
>=20
> When you are using the SERDES for networking, you need to know if the
> SERDES has achieved sync. For example, when the SERDES connects to an
> optical SFP module, the SERDES bit stream continues unmodified over
> the optical link to the SERDES in the peer. The optical module can
> tell you if it is receiving optical power, but it cannot tell you if
> the optical signal makes any sense. The SERDES however knows how to
> decode the bitstream, sync to it, etc. So you need some registers in
> the SERDES to get this status information. Typically, you can also get
> access to the SGMII/1000Base-X code word, so you can do
> auto-negotiation, or know if you need to send each bit 10 or 100 times
> in order to do 100Mbps or 10Mbps. If you are connecting to a PHY which
> can do > 1Gbps, you need to change the SERDES between SGMII,
> 1000Base-X, 2500Base-X, etc. Before you can say the link is up, you
> want the PHY to tell you it has link to its peer PHY, and you want to
> know the SERDES is ready. Typically the SERDES is last, since you
> don't know what to configure the SERDES to until the PHY is finished
> negotiating the link to its peer.
>=20
> If you look at any of the Marvell SERDES interfaces, found in PHYs or
> switches, there are dozens of registers for controlling the SERDES.
>=20
> Now, it could be we don't have a clear definition of what a SERDES
> is. The Marvell documents has a lot in its definition of SERDES, where
> as what you could be purely a 'dumb' parallel to serial convert, and
> all the rest of the logic is in the Ethernet MAC and the PCIe device?
>=20
> Now, back to my original point. Where are the registers for 'the rest
> of this logic'? If they are in the MAC address space, we don't have a
> problem. If they are somewhere else, maybe you will need to add
> another device. What is this device called? That is why i'm trying to
> differentiate between the 'SERDES-MUX' and the 'SERDES'.
>=20

If I've correctly read the datasheet of the switch, the sync status bit
is in the MAC address space. Same for 1000BASE-X/SGMII, autonegotiation.

The point I was trying to make was that this driver isn't only for
"muxing". There are also a handful of registers for
(electronically-related ?) features of SerDes (e.g. "control of phase
regulator logic", "deserializer phase control", a few
thresholds/hysteresis/frequencies, etc...

I understand that "serdes" isn't also fully matching the work done by
this driver as some features are handled within the MAC controller
address space.

Let me know if something bothers you/does not make sense,
Thanks,
Quentin

--dwtbtpadbufkaztq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAltoQ38ACgkQhLiadT7g
8aNNmRAAj3K9XzeEroN7RKAVvgvpx7JR0bTMte0G2EebUPsrmM1SYW9MD7zypbzA
7JKgVaQdeYy0DIf6TCUfLb9Q9w7EETlnF2iWawDPt5OpvD+sYOYOSmUbCkUOBk56
r4EI1HLCyo2tTcHtKcnDOw7b55Racgmc2ToSOLiL/u3koVZwgHFStrNP1Y+woQ8N
saLzxwhhCGQhb+GLL3U2Silk6WO+Pbj3TG0YDf0YFhufaFHaux+Ni6kHaFjGuHy8
68RQwrGBwjXdgopf5o7aqcEuUXUN6Lx2Q4eEHdxJZXxN7y+eo5uJLntRj+fk2Nn1
AWW+f5fsHju5LYy+icEBYFDAzH2aBsgLCNtD1zxmoEv6Ot/HHJRIFOF1noQB79D/
ZU4pKZsftOxCb3dLkDnRg3WrA7M1jIbmVGsFM3fIro7+oebhJjdGyLTPmOC2UmS5
w9JgFVkEh+uCnACJyclgORW9Xydbn7BhiU3AKUehpKUJ7FYArFGozHaMC9oxeYdj
Skj9M0+1FOanAcsXOO+pcHock11Fn7vDBc8HOpq4OXvPSFTeHYDE5DHOwvFgqGDI
QKb6R2bZqy2VXlluhxbGbnz+57xZ1KjtA3Mcb+XVZlaxsiDWL91OA8o1Bjk0VRwQ
wTvgzjRnqMOrp7TJPxhSDk12KPTvz74ShQRoM6zaJNBWN8yUsAA=
=0PCv
-----END PGP SIGNATURE-----

--dwtbtpadbufkaztq--
