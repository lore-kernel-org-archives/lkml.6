Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E02C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C720890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="x90sFewP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C720890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbeG3XjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:39:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56454 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbeG3XjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:39:06 -0400
Date:   Tue, 31 Jul 2018 00:01:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <1532988062.4702.2@smtp.crapouillou.net>
In-Reply-To: <20180725152105.GA6347@rob-hp-laptop>
References: <20180724231958.20659-1-paul@crapouillou.net>
        <20180724231958.20659-5-paul@crapouillou.net>
        <20180725152105.GA6347@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532988122; bh=uyOBqCzxDV0asKeRIufrDW3zREtdLhGsMYq2FKqiMPs=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=x90sFewPGlIVhTUgIkSeqK1P9k/Mlph8bBgG9P5tnqR5AyBdNzVsI/x65pNeNAM+CvQPnuorI8llfx30M9Tc094mL5t2Bho6tiS/oF3AN1puOSx4bTqXbc/qAD/pHDfEFS31+Ye11moFxrDxd9xdsU8lS3mSC0NgZb3gDU7rILs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le mer. 25 juil. 2018 =E0 17:21, Rob Herring <robh@kernel.org> a =E9crit :
> On Wed, Jul 25, 2018 at 01:19:41AM +0200, Paul Cercueil wrote:
>>  Add documentation about how to properly use the Ingenic TCU
>>  (Timer/Counter Unit) drivers from devicetree.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  24 +---
>>   .../devicetree/bindings/timer/ingenic,tcu.txt      | 147=20
>> +++++++++++++++++++++
>>   .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 +--
>>   3 files changed, 151 insertions(+), 37 deletions(-)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>=20
>>   v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>>       added content.
>>=20
>>   v5: - Edited PWM/watchdog DT bindings documentation to point to=20
>> the new
>>         document.
>>       - Moved main document to
>>         Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>       - Updated documentation to reflect the new devicetree bindings.
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt=20
>> b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  index 7d9d3f90641b..a722cdde3aa7 100644
>>  --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>>  @@ -1,25 +1,5 @@
>>   Ingenic JZ47xx PWM Controller
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>=20
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
>>  +This documentation has moved; for a description of the devicetree=20
>> bindings of
>>  +this driver, please refer to ../timer/ingenic,tcu.txt.
>=20
> This should be evident from the git log. Just remove it.

Ok.

>>  diff --git=20
>> a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt=20
>> b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  new file mode 100644
>>  index 000000000000..65d125b460aa
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  @@ -0,0 +1,147 @@
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
>=20
>>  +- #address-cells: Should be <1>;
>>  +- #size-cells: Should be <1>;
>>  +- ranges: Should be one range for the full TCU registers area
>=20
> These can all be implied.

Ok.

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
>=20
> How many and what are they. The example shows there are 3.

They are 2 or 3, and they are all the same (three parent IRQs for one=20
irqchip).
It's explained in the hardware doc, should I add it here as well?

>>  +
>>  +Optional properties:
>>  +
>>  +- ingenic,timer-channel: Specifies the TCU channel that should be=20
>> used as
>>  +  system timer. If not provided, the TCU channel 0 is used for the=20
>> system timer.
>>  +
>>  +- ingenic,clocksource-channel: Specifies the TCU channel that=20
>> should be used
>>  +  as clocksource and sched_clock. It must be a different channel=20
>> than the one
>>  +  used as system timer. If not provided, neither a clocksource nor=20
>> a
>>  +  sched_clock is instantiated.
>=20
> clocksource and sched_clock are Linux specific and don't belong in DT.
> You should define properties of the hardware or use existing=20
> properties
> like interrupts or clocks to figure out which channel to use. For
> example, if some channels don't have an interrupt, then use them for
> clocksource and not a clockevent. Or you could have timers that run in
> low-power modes or not. If all the channels are identical, then it
> shouldn't matter which ones the OS picks.

We already talked about that. All the TCU channels can be used for PWM.
The problem is I cannot know from the driver's scope which channels will
be free and which channels will be requested for PWM. You suggested=20
that I
parse the devicetree for clients, and I did that in the V3/V4 patchset.=20
But
it only works for clients requesting through devicetree, not from=20
platform
code or even sysfs.

One thing I can try is to dynamically change the channels the system=20
timer
and clocksource are using when the current ones are requested for PWM.=20
But
that sounds hardcore...

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
>>  +- clocks: phandle to the RTC clock
>>  +- clock-names: should be "rtc"
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
>>  +Example
>>  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  +
>>  +#include <dt-bindings/clock/jz4770-cgu.h>
>>  +#include <dt-bindings/clock/ingenic,tcu.h>
>>  +
>>  +/ {
>>  +	tcu: timer@10002000 {
>>  +		compatible =3D "ingenic,jz4770-tcu";
>>  +		reg =3D <0x10002000 0x1000>;
>>  +		#address-cells =3D <1>;
>>  +		#size-cells =3D <1>;
>>  +		ranges =3D <0x0 0x10002000 0x1000>;
>>  +
>>  +		#clock-cells =3D <1>;
>>  +
>>  +		clocks =3D <&cgu JZ4770_CLK_RTC
>>  +			  &cgu JZ4770_CLK_EXT
>>  +			  &cgu JZ4770_CLK_PCLK
>>  +			  &cgu JZ4770_CLK_EXT>;
>>  +		clock-names =3D "rtc", "ext", "pclk", "tcu";
>>  +
>>  +		interrupt-controller;
>>  +		#interrupt-cells =3D <1>;
>>  +
>>  +		interrupt-parent =3D <&intc>;
>>  +		interrupts =3D <27 26 25>;
>>  +
>>  +		watchdog: watchdog@0 {
>>  +			compatible =3D "ingenic,jz4740-watchdog";
>>  +			reg =3D <0x0 0x10>;
>>  +
>>  +			clocks =3D <&tcu TCU_CLK_WDT>;
>>  +			clock-names =3D "wdt";
>>  +		};
>>  +
>>  +		pwm: pwm@10 {
>>  +			compatible =3D "ingenic,jz4740-pwm";
>>  +			reg =3D <0x10 0xff0>;
>>  +
>>  +			#pwm-cells =3D <3>;
>>  +
>>  +			clocks =3D <&tcu TCU_CLK_TIMER0
>>  +				  &tcu TCU_CLK_TIMER1
>>  +				  &tcu TCU_CLK_TIMER2
>>  +				  &tcu TCU_CLK_TIMER3
>>  +				  &tcu TCU_CLK_TIMER4
>>  +				  &tcu TCU_CLK_TIMER5
>>  +				  &tcu TCU_CLK_TIMER6
>>  +				  &tcu TCU_CLK_TIMER7>;
>>  +			clock-names =3D "timer0", "timer1", "timer2", "timer3",
>>  +				      "timer4", "timer5", "timer6", "timer7";
>>  +		};
>>  +
>>  +		ost: timer@e0 {
>>  +			compatible =3D "ingenic,jz4770-ost";
>>  +			reg =3D <0xe0 0x20>;
>=20
> This is creating an overlapping region with PWM which should be=20
> avoided.
> Are timers and PWM the same h/w? Then there should be one node (or=20
> maybe
> you can do 1 node per channel if each channel is independent (has its
> own register range, clocks, interrupts, etc.
>=20
> Or the PWM node needs to exclude this region (by having 2 reg=20
> regions).

I will use two regions then.

>>=20
>  +};
>>=20
>  +	};
>>  +
>>  +			clocks =3D <&tcu TCU_CLK_OST>;
>>  +			clock-names =3D "ost";
>>  +
>>  +			interrupts =3D <15>;
>>  +		};

Thanks,
-Paul Cercueil
=

