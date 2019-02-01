Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D07E218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="iSoguEc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfBAUJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:09:27 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:21517 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBAUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549051764;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=h3WIbxCD0lKXHBAGSwNbDOmOm7MmY+jA9NqP8Nbk9FI=;
        b=iSoguEc4V1ol8OeMQed1NUrvpnpX0LxwufNX8K9/IeDTiViNZ8jVhmSx4K4yrKKHDi
        wVwBMO5AMy5OoXY9cJn0++515d5lSZdj10TtuhU3/PnJV8S1mgtukUg34c+xeke+Y1mP
        k5px4fMu2M+LCNUgLFTaDH2GvkRgdE4JS+98KlHklXha+HS/g1sSK7PLih9ZuW+TRbS8
        1+cAHn7BSLaMbE2FqRgzrKd+kpROitQfx5rL1C43dq+AGHwsXMzErVvUfYhbPlZ5Pzdf
        M7hiUvhyypZxNg5tDJTlWAjGwssKM1anXO1qiPjRTRxMHT/Awib0zFKEWMxat3Ic+af3
        4qBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCyirt1z5oszmTHPfpZX1HLFRsPjAOKHy7ttlTEy"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:2677:6500:315d:2b28:9e0b:85b0]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 608499v11K9AYV8
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 1 Feb 2019 21:09:10 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v3 2/2] arm: dts: gta04: add gps support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190201200630.2efc9eef@kemnade.info>
Date:   Fri, 1 Feb 2019 21:09:15 +0100
Cc:     Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benoit Cousson <bcousson@baylibre.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24F5EECA-86E0-4462-AC9F-1BD986EAD7F4@goldelico.com>
References: <20190131180640.14480-1-andreas@kemnade.info> <20190131180640.14480-3-andreas@kemnade.info> <20190201100416.GD3691@localhost> <20190201200630.2efc9eef@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> Am 01.02.2019 um 20:06 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Fri, 1 Feb 2019 11:04:16 +0100
> Johan Hovold <johan@kernel.org> wrote:
>=20
>> On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
>>> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
>>> which one is mounted so use the compatibility entry for w2sg0004
>>> for all which will work for both.
>>>=20
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> Changes in v3:
>>> - converted to a patchset
>>> - added vcc-supply
>>>=20
>>> Changes in v2:
>>> - some s/gps/gnss/
>>> - not added vcc-supply because the regulator is not modelled
>>>  in dts at all
>>>=20
>>> w2sg0004 bindings are in next-20190129
>>>=20
>>> arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
>>> 1 file changed, 14 insertions(+)
>>>=20
>>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> index 02d8274a2f47..4ea0f7dc37c6 100644
>>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> @@ -320,6 +320,12 @@ =20
>>> 		>; =20
>>>        };
>>>=20
>>> +	gps_pins: pinmux_gps_pins { =20
>>=20
>> s/gps/gnss/ would be more consistent, but whatever.
>>=20
> well, gps is already in the file at another place. So it is a bit
> inconsistent in any case, without further cleanup. If someone comes
> up with a strong opinion here I would of course change it.

For me the highest priority is that it works. And that does not depend
on the specific node name. The pinmux node is only referenced through a =
phandle,
which is translated into a pure numeric code by DTC.

Another argument could be that the w2sg0004 chip was introduced ca. 2007
when GPS was (AFAIR) the only GNSS system widely available and the only =
one
supported by the chip. So this would be an argument for "gps" since it
is a "GPS only" receiver chip.

Since the DT should describe specific hardware, it maybe should somehow
codify that the chip is GPS only and is not a generic gnss chip =
(although
the driver knows that as well).

BR,
Nikolaus

