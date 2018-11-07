Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE323C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B67720883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Xh7Z/dKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B67720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbeKGN4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:56:09 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40209 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKGN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:56:09 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 68EEF8448C;
        Wed,  7 Nov 2018 17:27:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541564848;
        bh=jGpTKjhvRcr/oNvZYZ/8LyNVnvVvDDY7NiAc3U9jtc4=;
        h=From:To:CC:Subject:Date:References;
        b=Xh7Z/dKhJ6Zg0If+DDDzNfRenh9XkR7WzZv7BAeC792rD5k9SNihchabgGRk1vy02
         YIhtprulLTJ/4ek7L669sSPNhZ4tCi5CG4xjEX60EgVVzDgPpo1yQ/eBEJVq0+I9Rm
         0hsQ+dW4ZjKucUsnRr5zj1ODMwXiVJ3XZhZRYR+Z0k1pbxPmsVmQ95Y1tlkcfXwXsh
         Jnr4EtuF8xZl4z6N+Apxv0MVs1zzaoK12RHlctuDJ9gCUgdPK2GYUDps91H4krrUzv
         MmbfyqXjPxWSLKRT3BPexfnCoh7Bsqes5IBa6QdHSaxtLA0tDju4Ss+nBUnKuxrtnR
         Y/4xR4zvi9aUQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be269b00001>; Wed, 07 Nov 2018 17:27:28 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 7 Nov 2018 17:27:28 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 7 Nov 2018 17:27:28 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Thread-Index: AQHUdk5nXr6sO2VXpkGFaxm/KObkRw==
Date:   Wed, 7 Nov 2018 04:27:27 +0000
Message-ID: <1ed7434bfded41bfba3b739f58f69102@svr-chch-ex1.atlnz.lc>
References: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
 <20181107040010.27436-2-chris.packham@alliedtelesis.co.nz>
 <64720b73-dddf-783c-a3a4-3f32a748bf5d@roeck-us.net>
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

On 7/11/18 5:24 PM, Guenter Roeck wrote:=0A=
> On 11/6/18 8:00 PM, Chris Packham wrote:=0A=
>> With the addition of the invert-pwm property the adt7475 needs its own=
=0A=
>> binding documentation rather being captured under trivial-devices.txt.=
=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>    .../devicetree/bindings/hwmon/adt7475.txt     | 22 ++++++++++++++++++=
+=0A=
>>    .../devicetree/bindings/trivial-devices.txt   |  4 ----=0A=
>>    2 files changed, 22 insertions(+), 4 deletions(-)=0A=
>>    create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.tx=
t=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Docum=
entation/devicetree/bindings/hwmon/adt7475.txt=0A=
>> new file mode 100644=0A=
>> index 000000000000..79255439e157=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt=0A=
>> @@ -0,0 +1,22 @@=0A=
>> +*ADT7475 hwmon sensor.=0A=
>> +=0A=
>> +Required properties:=0A=
>> +- compatible: One of=0A=
>> +	"adi,adt7473"=0A=
>> +	"adi,adt7475"=0A=
>> +	"adi,adt7476"=0A=
>> +	"adi,adt7490"=0A=
>> +=0A=
>> +- reg: I2C address=0A=
>> +=0A=
>> +optional properties:=0A=
>> +=0A=
>> +- invert-pwm: This configures the PWM to use logic low for 100% duty cy=
cle.=0A=
>> +=0A=
>> +Example:=0A=
>> +=0A=
>> +hwmon@2e {=0A=
>> +	compatible =3D ;=0A=
>> +	reg =3D <0x2e>;=0A=
>> +	invert-pwm;=0A=
> =0A=
> If I understand correctly, the flag is set per pwm channel. A single glob=
al=0A=
> property seems inappropriate.=0A=
=0A=
Yes it is per-channel. But I was having a hard time imagining a hardware =
=0A=
design that would use both inverted and non-inverted at the same time.=0A=
=0A=
Do you have a preference for how the properties should look?=0A=
=0A=
   invert-pwm[123]?=0A=
=0A=
   invert-pwm =3D <0x7>;?=0A=
=0A=
> =0A=
> Guenter=0A=
> =0A=
>> +};=0A=
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Doc=
umentation/devicetree/bindings/trivial-devices.txt=0A=
>> index 69c934aec13b..4f29100d6bbf 100644=0A=
>> --- a/Documentation/devicetree/bindings/trivial-devices.txt=0A=
>> +++ b/Documentation/devicetree/bindings/trivial-devices.txt=0A=
>> @@ -14,10 +14,6 @@ ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-=
Pin SOT with SMBus Alert an=0A=
>>    ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor=
-Based Systems=0A=
>>    adi,adt7461		+/-1C TDM Extended Temp Range I.C=0A=
>>    adt7461			+/-1C TDM Extended Temp Range I.C=0A=
>> -adi,adt7473		+/-1C TDM Extended Temp Range I.C=0A=
>> -adi,adt7475		+/-1C TDM Extended Temp Range I.C=0A=
>> -adi,adt7476		+/-1C TDM Extended Temp Range I.C=0A=
>> -adi,adt7490		+/-1C TDM Extended Temp Range I.C=0A=
>>    adi,adxl345		Three-Axis Digital Accelerometer=0A=
>>    adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility=
 value "adi,adxl345" must be listed too)=0A=
>>    ams,iaq-core		AMS iAQ-Core VOC Sensor=0A=
>>=0A=
> =0A=
> =0A=
=0A=
