Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8966021473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wI8qWnww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeLQWEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:04:34 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44020 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:04:33 -0500
Date:   Mon, 17 Dec 2018 23:03:42 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 03/26] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Message-Id: <1545084222.1958.0@smtp.crapouillou.net>
In-Reply-To: <20181217210531.GA29770@bogus>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-4-paul@crapouillou.net> <20181217210531.GA29770@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1545084268; bh=0iT4feV+fIrIhlPppB6ixum7kDT+QVUyrgSwa39x6SU=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=wI8qWnwweXtIKMzmPJ6f34E/nMWv618S6v43rauipbhDIdds1pXZpDGpqYoi07p8/lLPl3Q+EL/wb20ZgbhzgqiRGOSAKSQkKpdlhxTKzCdBRHN4nxg7ydgVpq43TamhWOO6d95t+Ezwca92REx5iQwgXcDek69gnqtQFyyMvUE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le lun. 17 d=E9c. 2018 =E0 22:05, Rob Herring <robh@kernel.org> a =E9crit :
> On Wed, Dec 12, 2018 at 11:08:58PM +0100, Paul Cercueil wrote:
>>  Add documentation about how to properly use the Ingenic TCU
>>  (Timer/Counter Unit) drivers from devicetree.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v4: New patch in this series. Corresponds to V2 patches 3-4-5=20
>> with
>>           added content.
>>=20
>>       v5: - Edited PWM/watchdog DT bindings documentation to point=20
>> to the new
>>             document.
>>           - Moved main document to
>>             Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>           - Updated documentation to reflect the new devicetree=20
>> bindings.
>>=20
>>       v6: - Removed PWM/watchdog documentation files as asked by=20
>> upstream
>>           - Removed doc about properties that should be implicit
>>           - Removed doc about ingenic,timer-channel /
>>             ingenic,clocksource-channel as they are gone
>>           - Fix WDT clock name in the binding doc
>>           - Fix lengths of register areas in watchdog/pwm nodes
>>=20
>>       v7: No change
>>=20
>>       v8: - Fix address of the PWM node
>>           - Added doc about system timer and clocksource children=20
>> nodes
>=20
> I thought we'd sorted this out...

Yeah, well I just can't please everybody. V6/V7 didn't have the
system timer or clocksource in devicetree, which was good for
you, but then the driver nearly doubled in size and complexity,
and Thierry rightfully refused it. Now I'm at the point where
I'm trying alternative ways of encoding the information in
devicetree, as suggested by various people, just so that you
accept it. Because I don't see any other option.

>>=20
>>   .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ---
>>   .../devicetree/bindings/timer/ingenic,tcu.txt      | 176=20
>> +++++++++++++++++++++
>>   .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 --
>>   3 files changed, 176 insertions(+), 42 deletions(-)
>>   delete mode 100644=20
>> Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>   create mode 100644=20
>> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>   delete mode 100644=20
>> Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt=20
>> b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  deleted file mode 100644
>>  index 7d9d3f90641b..000000000000
>>  --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  +++ /dev/null
>>  @@ -1,25 +0,0 @@
>>  -Ingenic JZ47xx PWM Controller
>>  -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>  -
>>  -Required properties:
>>  -- compatible: One of:
>>  -  * "ingenic,jz4740-pwm"
>>  -  * "ingenic,jz4770-pwm"
>>  -  * "ingenic,jz4780-pwm"
>>  -- #pwm-cells: Should be 3. See pwm.txt in this directory for a=20
>> description
>>  -  of the cells format.
>>  -- clocks : phandle to the external clock.
>>  -- clock-names : Should be "ext".
>>  -
>>  -
>>  -Example:
>>  -
>>  -	pwm: pwm@10002000 {
>>  -		compatible =3D "ingenic,jz4740-pwm";
>>  -		reg =3D <0x10002000 0x1000>;
>>  -
>>  -		#pwm-cells =3D <3>;
>>  -
>>  -		clocks =3D <&ext>;
>>  -		clock-names =3D "ext";
>>  -	};
>>  diff --git=20
>> a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt=20
>> b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  new file mode 100644
>>  index 000000000000..8a4ce7edf50f
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  @@ -0,0 +1,176 @@
>>  +Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
>>  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  +
>>  +For a description of the TCU hardware and drivers, have a look at
>>  +Documentation/mips/ingenic-tcu.txt.
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4740-tcu
>>  +  * ingenic,jz4725b-tcu
>>  +  * ingenic,jz4770-tcu
>>  +- reg: Should be the offset/length value corresponding to the TCU=20
>> registers
>>  +- clocks: List of phandle & clock specifiers for clocks external=20
>> to the TCU.
>>  +  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
>>  +- clock-names: List of name strings for the external clocks.
>>  +- #clock-cells: Should be <1>;
>>  +  Clock consumers specify this argument to identify a clock. The=20
>> valid values
>>  +  may be found in <dt-bindings/clock/ingenic,tcu.h>.
>>  +- interrupt-controller : Identifies the node as an interrupt=20
>> controller
>>  +- #interrupt-cells : Specifies the number of cells needed to=20
>> encode an
>>  +  interrupt source. The value should be 1.
>>  +- interrupt-parent : phandle of the interrupt controller.
>>  +- interrupts : Specifies the interrupt the controller is connected=20
>> to.
>>  +
>>  +
>>  +Children nodes
>>  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  +
>>  +
>>  +PWM node:
>>  +---------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4740-pwm
>>  +  * ingenic,jz4725b-pwm
>>  +- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of=20
>> the cell
>>  +  format.
>>  +- clocks: List of phandle & clock specifiers for the TCU clocks.
>>  +- clock-names: List of name strings for the TCU clocks.
>>  +
>>  +
>>  +Watchdog node:
>>  +--------------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4740-watchdog
>>  +  * ingenic,jz4780-watchdog
>>  +- clocks: phandle to the WDT clock
>>  +- clock-names: should be "wdt"
>>  +
>>  +
>>  +OST node:
>>  +---------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be one of:
>>  +  * ingenic,jz4725b-ost
>>  +  * ingenic,jz4770-ost
>>  +- clocks: phandle to the OST clock
>>  +- clock-names: should be "ost"
>>  +- interrupts : Specifies the interrupt the OST is connected to.
>>  +
>>  +
>>  +System timer node:
>>  +------------------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be "ingenic,jz4740-tcu-timer"
>=20
> Is this an actual sub-block? Or just a way to assign a timer to a
> clockevent?

Just a way to assign a timer to a clockevent.

>>  +- clocks: phandle to the clock of the TCU channel used
>>  +- clock-names: Should be "timer"
>>  +- interrupts : Specifies the interrupt line of the TCU channel=20
>> used.
>>  +
>>  +
>>  +System clocksource node:
>>  +------------------------
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be "ingenic,jz4740-tcu-clocksource"
>=20
> The h/w has a block called 'clocksource'?
>=20
> If there's a difference in the timer channels, then that difference
> should be described in DT, not just 'use timer X for clocksource'.

Same as above, this is just a way to assign a channel to the=20
clocksource.

>>=20
>  +- clock-names: Should be "timer"
>  +- clocks: phandle to the clock of the TCU channel use

Regards,
- Paul Cercueil
=

