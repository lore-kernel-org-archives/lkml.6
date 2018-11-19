Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069D3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0022086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="n1d3AUjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0022086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeKTIVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:21:21 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59489 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeKTIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:21:20 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 07D168448C;
        Tue, 20 Nov 2018 10:55:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542664538;
        bh=uUO6UO+ISS9+p+mMZWHwT7liGKY6ugIXQDiaSkxyft8=;
        h=From:To:CC:Subject:Date:References;
        b=n1d3AUjHIxlkViDHjqWcJgx3osxaFA8BQYuATbDM6D+2Uu04WcVIAZpG/T519/DSV
         w5ptb0BmWzG1p84kep1G+AsT9k8fCLJzLaSoRDLAxVy1ehEf6MVsKjoCIOWYkzuCyx
         Au1fW9UmMmaylNJbbFe50J77EJq6nzx8rxXtoKRBo0uBArRdrp4XR/I9D1qxf99Jti
         gK9RJ9h+idxufs32j15jStepZfBWYHEojYyROhn82S3dSl55NTtqnm62v/8biMNykU
         mfX7Y0egbdRaDwVgeByknmz22jkVv3wuChAeX/RaGMrdk/W7bu95PJFxWCleyLbaIz
         a4N9BvQlTcTjg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf3315b0001>; Tue, 20 Nov 2018 10:55:39 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Tue, 20 Nov 2018 10:55:37 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 20 Nov 2018 10:55:37 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Rob Herring <robh@kernel.org>, Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Thread-Topic: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Thread-Index: AQHUd7Y+CyDyo+o2Pk+F1ZC1kICy0g==
Date:   Mon, 19 Nov 2018 21:55:37 +0000
Message-ID: <6326b60e84c04339823e816801445120@svr-chch-ex1.atlnz.lc>
References: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
 <20181108225607.7521-2-chris.packham@alliedtelesis.co.nz>
 <20181117152949.GA31247@bogus>
 <f3a29bc9-dbfc-bfb8-8707-2b67d96c2e04@roeck-us.net>
 <CAL_JsqKgBkR4WN+aTKdHSfCZ8EH39yLCeLwXwmf+nd0_cAy+mw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/18 10:40 AM, Rob Herring wrote:=0A=
> On Sun, Nov 18, 2018 at 4:56 PM Guenter Roeck <linux@roeck-us.net> wrote:=
=0A=
>>=0A=
>> On 11/17/18 7:29 AM, Rob Herring wrote:=0A=
>>> On Fri, Nov 09, 2018 at 11:56:06AM +1300, Chris Packham wrote:=0A=
>>>> With the addition of the invert-pwm property the adt7475 needs its own=
=0A=
>>>> binding documentation rather being captured under trivial-devices.txt.=
=0A=
>>>>=0A=
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>>>> ---=0A=
>>>> Changes in v2:=0A=
>>>> - use pwm-polarity attiribute to indicate normal or inverted polarity.=
=0A=
>>>>=0A=
>>>>    .../devicetree/bindings/hwmon/adt7475.txt     | 24 ++++++++++++++++=
+++=0A=
>>>>    .../devicetree/bindings/trivial-devices.txt   |  4 ----=0A=
>>>>    2 files changed, 24 insertions(+), 4 deletions(-)=0A=
>>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.=
txt=0A=
>>>>=0A=
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Doc=
umentation/devicetree/bindings/hwmon/adt7475.txt=0A=
>>>> new file mode 100644=0A=
>>>> index 000000000000..d9212b5e9036=0A=
>>>> --- /dev/null=0A=
>>>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt=0A=
>>>> @@ -0,0 +1,24 @@=0A=
>>>> +*ADT7475 hwmon sensor.=0A=
>>>> +=0A=
>>>> +Required properties:=0A=
>>>> +- compatible: One of=0A=
>>>> +    "adi,adt7473"=0A=
>>>> +    "adi,adt7475"=0A=
>>>> +    "adi,adt7476"=0A=
>>>> +    "adi,adt7490"=0A=
>>>> +=0A=
>>>> +- reg: I2C address=0A=
>>>> +=0A=
>>>> +optional properties:=0A=
>>>> +=0A=
>>>> +- pwm-polarity: This configures the polarity of the PWM. 0=0A=
>>>> +            (PWM_POLARITY_NORMAL) uses logic high for 100% duty cycle=
. 1=0A=
>>>> +                (PWM_POLARITY_INVERSED) uses logic low for 100% duty =
cycle.=0A=
>>>=0A=
>>> So we're using part of the PWM binding, but none of the rest of it? Wha=
t=0A=
>>> is the PWM connection here?=0A=
>>> The chip has a built-in PWM controller to control fan speeds. PWM frequ=
ency=0A=
>> as well as PWM polarity are configurable. I had suggested to use the ter=
minology=0A=
>> from Documentation/devicetree/bindings/pwm/pwm.txt. Other than terminolo=
gy there=0A=
>> is no connection to a standard pwm controller.=0A=
> =0A=
> Ah, a fan controller. Please make that clear.=0A=
> =0A=
> The fan related bindings need a bit of work IMO. We have the start of=0A=
> something somewhat common with aspeed and npcm bindings, but they=0A=
> could use a bit more work. We need the fan and controller bindings to=0A=
> be somewhat separate where a fan node for a given type of fan doesn't=0A=
> depend on the controller node.=0A=
> =0A=
> AIUI, all fans are not the same, so does this controller only work=0A=
> with 1 type of fan and not need any more board level config? Isn't fan=0A=
> speed not linear with PWM duty cycle and need some sort of map.=0A=
=0A=
That level of configuration is done in userland via the sysfs API (e.g =0A=
lm-sensors). I could have added the pwm output inversion via sysfs but I =
=0A=
erred on the side of the polarity being an artifact of the hardware =0A=
design that is fairly static.=0A=
=0A=
Things like what thresholds to configure and whether to use automatic =0A=
pwm control tend to be much more fluid. Then theres pathological cases =0A=
where other external factors need to be included in the fan control (my =0A=
particular use case is a network switch acting as a PoE PSE so I not =0A=
only need to take into account the ambient temperature but how much PoE =0A=
power is being delivered to connected PDs),=0A=
=0A=
>> Another option/possibility would be to use a boolean, such as pwm-polari=
ty-inverted.=0A=
>> We are open to suggestions.=0A=
>>=0A=
>>> It sounds like this is common for sensors, so this should be documented=
=0A=
>>> somewhere common.=0A=
>>>=0A=
>> Sure, no problem. Any suggestion where ?=0A=
> =0A=
> hwmon/fan.txt (that doesn't exist yet.)=0A=
> =0A=
> Probably all of bindings/hwmon/ should be split up by class of device.=0A=
=0A=
Most of the hwmon chips I've been dealing with lately tend to be multi =0A=
function (e.g. temperature, voltage, fan tach and fan control). The =0A=
single function devices tend to land in trivial-devices.txt because =0A=
there's not much to document other than the compatible string.=0A=
=0A=
