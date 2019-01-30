Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208D1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99FB20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="qBGdC3zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfA3OGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:06:33 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:19681 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3OGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548857189;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=X/nDSTgOj70rF5Zlt5bZKKKCrAGRaGnP+vB3QsvXv/A=;
        b=qBGdC3zubRDp4s0Xuo0jDLg6K1/Uq3QQ4Rk0/LK7eDLf3X1DVDcVnkr210kMRbvOLV
        7sJObmvCheQzBLKfcn8vC92GlUp7enZZOUQ8CWw0sBTd/tTVNC9H7TwwstOjgxJ1RQBS
        AyPbvXV/3Y2nJy1SUsYIjEYpOYIeK9ryM3OVq/C50tm3cy7563HMDrWmGWyiiD8rk4U0
        PZpuXqjdDzJ0Na2MNiKmv6j0Mza8w6wWV/4hyIUuv/2svuGqfnJnJepboZeM2C2syYlO
        2J7uKI/EW7b5DaVo+lYlDcUVHy0ptRb2grO/XbEjDKYIijzDab5bR0stoR//omO+5cdL
        jbtw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMjw4ntOw=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v0UE6CFdf
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 30 Jan 2019 15:06:12 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH] arm: dts: gta04: add gps support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190130090232.GL3691@localhost>
Date:   Wed, 30 Jan 2019 15:06:12 +0100
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Johan Hovold <johan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benoit Cousson <bcousson@baylibre.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89AF1666-1770-4C1C-A5E8-13E1C8D50EFA@goldelico.com>
References: <20190125194310.11170-1-andreas@kemnade.info> <20190128075356.GJ3691@localhost> <20190128163025.7daa385b@kemnade.info> <20190130090232.GL3691@localhost>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> Am 30.01.2019 um 10:02 schrieb Johan Hovold <johan@kernel.org>:
>=20
> On Mon, Jan 28, 2019 at 05:44:29PM +0100, Andreas Kemnade wrote:
>> On Mon, 28 Jan 2019 08:53:56 +0100
>> Johan Hovold <johan@kernel.org> wrote:
>>=20
>>> On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote:
>>>> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
>>>> which one is mounted so use the compatibility entry for w2sg0004
>>>> for all which will work for both.
>>>>=20
>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>> ---
>>>> w2sg0004 bindings (together with the corresponding support is in
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss =
gnss-next)
>>>> arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
>>>> 1 file changed, 13 insertions(+)
>=20
>>>> +	gps: gps { =20
>>>=20
>>> The node should be named "gnss" as per the binding.
>>>=20
>>>> +		compatible =3D "wi2wi,w2sg0004";
>>>> +		pinctrl-names =3D "default";
>>>> +		pinctrl-0 =3D <&gps_pins>;
>>>> +		sirf,onoff-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;
>>>> +		lna-supply =3D <&vsim>; =20
>>>=20
>>> Also, the vcc-supply is a required property.
>>>=20
>> well, it is not require in the driver and it has different behavior
>> (on even when not opened if on-off is there) than the lna-supply used
>> here. So maybe fix the binding documentation?
>=20
> The device-tree describes hardware, and how a particular driver =
happens
> to implement a binding is not relevant.
>=20
> That said, there is a bit of an on-going, shall we say philosophical,
> debate about this. The regulator maintainer takes a firm position that
> all mandatory physical supplies should be represented in firmware
> =09
> 	=
https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
> 	=
https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u
>=20
> while Rob appears to take a slightly different stance on fixed
> regulators while admitting that this an issue which has not yet been
> fully resolved:
>=20
> 	=
https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop=
/T/#u
>=20
> Since this is a new binding, and the hardware requires the vcc supply
> and this is reflected in the binding, I think you should add a fixed
> regulator. At least until you hear otherwise. ;)

Assuming that there is no REGEN signal from the twl4030 unless 1V8 is =
also
stable, I'd suggest as a simple solution:

	 vcc-supply =3D <&vio>;

Alternatively, we could define a dedicated fixed-regulator in =
omap3-gta04.dtsi
for the 3V3 rail. Which is always-on. This would allow to describe that =
e.g. the
itg3200, panel and other chips and sensors are also supplied by this. =
But since
no driver can really make use of it (turn on/off on demand) this is IMHO =
quite
needless.

BR,
Nikolaus

