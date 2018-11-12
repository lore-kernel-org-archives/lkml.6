Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E69C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FE220866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PWtWbipV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FE220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeKLKZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:25:41 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47684 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeKLKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:25:41 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BFD3689189;
        Mon, 12 Nov 2018 13:35:04 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541982904;
        bh=nIdzQaTp0g88SX0wpn2+ddX56G6s8sEsfr2+ZGG4SXM=;
        h=From:To:CC:Subject:Date:References;
        b=PWtWbipV8YFdmuuXfB7cgXzXilz5ge1IfX6o+EgCzxxe1FH0ocf2GZb5y0k4luRPc
         i6pLonf+gNcQrFmz/rD52R1SE94b7V1TEMXvEGMkn1JE5N0WFkv0b5EDfj4913Ka47
         g2qXLTI+IV/yFc1KpXIDDV7bxkrjOZoRmdNv82pDF2zH30vXyqmoMl9BVs7w3ICbK2
         sJqo1PW0jyp4WHBNmg/pj9tOALtbRMhd8sWvF+/3oqw/1LtTBKhbVlXprBjVnkNxfh
         A2m3Xe1xhQXpwzg37eFs03Zpq3blySaTGJf3qDD7Bpz1sl9e/p43e4O1lIGfFHyrvm
         byiiSkVR8iI0Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be8cab70000>; Mon, 12 Nov 2018 13:35:03 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Mon, 12 Nov 2018 13:34:59 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 12 Nov 2018 13:34:59 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Thread-Topic: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Thread-Index: AQHUd7Y+CyDyo+o2Pk+F1ZC1kICy0g==
Date:   Mon, 12 Nov 2018 00:34:58 +0000
Message-ID: <7bc274d5aad04713bc068514d063b964@svr-chch-ex1.atlnz.lc>
References: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
 <20181108225607.7521-2-chris.packham@alliedtelesis.co.nz>
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

On 9/11/18 11:56 AM, Chris Packham wrote:=0A=
> With the addition of the invert-pwm property the adt7475 needs its own=0A=
> binding documentation rather being captured under trivial-devices.txt.=0A=
> =0A=
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> ---=0A=
> Changes in v2:=0A=
> - use pwm-polarity attiribute to indicate normal or inverted polarity.=0A=
> =0A=
>   .../devicetree/bindings/hwmon/adt7475.txt     | 24 +++++++++++++++++++=
=0A=
>   .../devicetree/bindings/trivial-devices.txt   |  4 ----=0A=
>   2 files changed, 24 insertions(+), 4 deletions(-)=0A=
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt=
=0A=
> =0A=
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Docume=
ntation/devicetree/bindings/hwmon/adt7475.txt=0A=
> new file mode 100644=0A=
> index 000000000000..d9212b5e9036=0A=
> --- /dev/null=0A=
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt=0A=
> @@ -0,0 +1,24 @@=0A=
> +*ADT7475 hwmon sensor.=0A=
> +=0A=
> +Required properties:=0A=
> +- compatible: One of=0A=
> +	"adi,adt7473"=0A=
> +	"adi,adt7475"=0A=
> +	"adi,adt7476"=0A=
> +	"adi,adt7490"=0A=
> +=0A=
> +- reg: I2C address=0A=
> +=0A=
> +optional properties:=0A=
> +=0A=
> +- pwm-polarity: This configures the polarity of the PWM. 0=0A=
> +		(PWM_POLARITY_NORMAL) uses logic high for 100% duty cycle. 1=0A=
> +                (PWM_POLARITY_INVERSED) uses logic low for 100% duty cyc=
le.=0A=
> +=0A=
> +Example:=0A=
> +=0A=
> +hwmon@2e {=0A=
> +	compatible =3D ;=0A=
=0A=
Oops. I should include a working example. I've fixed this locally but =0A=
I'll hold off on sending v3 to see if there is any additional feedback.=0A=
=0A=
> +	reg =3D <0x2e>;=0A=
> +	pwm-polarity =3D <1>;=0A=
> +};=0A=
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Docu=
mentation/devicetree/bindings/trivial-devices.txt=0A=
> index 69c934aec13b..4f29100d6bbf 100644=0A=
> --- a/Documentation/devicetree/bindings/trivial-devices.txt=0A=
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt=0A=
> @@ -14,10 +14,6 @@ ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-P=
in SOT with SMBus Alert an=0A=
>   ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-B=
ased Systems=0A=
>   adi,adt7461		+/-1C TDM Extended Temp Range I.C=0A=
>   adt7461			+/-1C TDM Extended Temp Range I.C=0A=
> -adi,adt7473		+/-1C TDM Extended Temp Range I.C=0A=
> -adi,adt7475		+/-1C TDM Extended Temp Range I.C=0A=
> -adi,adt7476		+/-1C TDM Extended Temp Range I.C=0A=
> -adi,adt7490		+/-1C TDM Extended Temp Range I.C=0A=
>   adi,adxl345		Three-Axis Digital Accelerometer=0A=
>   adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility v=
alue "adi,adxl345" must be listed too)=0A=
>   ams,iaq-core		AMS iAQ-Core VOC Sensor=0A=
> =0A=
=0A=
