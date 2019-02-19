Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91F521738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="V24mjFjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfBSUAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:00:13 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56440 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBSUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:12 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9ADFF86CE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:00:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1550606409;
        bh=/yCqWzdJK8jc7zhpDVQMLhrHJ5ps1ZelreD+gsoqY6A=;
        h=From:To:CC:Subject:Date:References;
        b=V24mjFjvNoFv+yhk+bESujB/qx3M/lRKayHgo6SWPBMoXcLmQR2sUzxC+wOVYLSWb
         6gO/zCOVkAVIkDFUgAGAFsmGCqnasN74t/QIxqryw78kAzbnH5sQ19P4Jq2cDg+SMq
         ZaKAjuj4t1JJ7WuD7CCRyK1HAnF5z60691Tsh/rRcP3nzbXSkPFsvK39r5KcUQStT6
         aIJhp2quqeKizdbAYW482TYQ7mu+pcJPdENzkFZ2spcRB4enNCVU0ffRfnuKMZqkMG
         bIzBg6kDORLkIbEr8L9/p0jFweRrnWXDx+H3W5HBaLidnb9HfSmjMgZ3a5jyLxFpF5
         rLI+K4S6OMN7A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c6c60480001>; Wed, 20 Feb 2019 09:00:08 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 20 Feb 2019 09:00:09 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 20 Feb 2019 09:00:09 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: mvebu: kirkwood: remove error message when
 retrieving mac address
Thread-Topic: [PATCH] ARM: mvebu: kirkwood: remove error message when
 retrieving mac address
Thread-Index: AQHUxzQ4aDgGoLLrG0248l+FI4FVAQ==
Date:   Tue, 19 Feb 2019 20:00:09 +0000
Message-ID: <ed2e24ed25504979aef666b6f677f34e@svr-chch-ex1.atlnz.lc>
References: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz>
 <877edv3jmw.fsf@FE-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/19 4:14 AM, Gregory CLEMENT wrote:=0A=
> Hi Chris,=0A=
>   =0A=
>   On lun., f=E9vr. 18 2019, Chris Packham <chris.packham@alliedtelesis.co=
.nz> wrote:=0A=
> =0A=
>> Kirkwood has always had the ability to retrieve the local-mac-address=0A=
>> from the hardware (usually this was configured by the bootloader). This=
=0A=
>> is particularly useful when dealing with a legacy non-DT aware=0A=
>> bootloader.=0A=
>>=0A=
>> The "error" message just indicated that the board used an old bootloader=
=0A=
>> and in many cases users can't do anything about this. The message=0A=
>> probably should have been pr_info() to inform the user that the kernel=
=0A=
>> has been helpful but rather than than let's remove it entirely to make=
=0A=
>> the kernel less noisy.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> =0A=
> I'm OK with this patch, however as it is not a fix, it's too late for=0A=
> 5.1. I will apply it on mvebu/arm for 5.2 once 5.1-rc1 will be released.=
=0A=
> =0A=
=0A=
No problem with that. We have a local fork I'll cherry pick it into once =
=0A=
it hits linux-mvebu.=0A=
=0A=
> Thanks,=0A=
> =0A=
> gregory=0A=
> =0A=
>> ---=0A=
>>   arch/arm/mach-mvebu/kirkwood.c | 2 --=0A=
>>   1 file changed, 2 deletions(-)=0A=
>>=0A=
>> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwo=
od.c=0A=
>> index 0aa88105d46e..bf3ff0f580c2 100644=0A=
>> --- a/arch/arm/mach-mvebu/kirkwood.c=0A=
>> +++ b/arch/arm/mach-mvebu/kirkwood.c=0A=
>> @@ -107,8 +107,6 @@ static void __init kirkwood_dt_eth_fixup(void)=0A=
>>   		clk_prepare_enable(clk);=0A=
>>   =0A=
>>   		/* store MAC address register contents in local-mac-address */=0A=
>> -		pr_err(FW_INFO "%pOF: local-mac-address is not set\n", np);=0A=
>> -=0A=
>>   		pmac =3D kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);=0A=
>>   		if (!pmac)=0A=
>>   			goto eth_fixup_no_mem;=0A=
>> -- =0A=
>> 2.20.1=0A=
>>=0A=
> =0A=
=0A=
