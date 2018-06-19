Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CEC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC4F20833
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mgRqzD69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC4F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeFSX5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:57:03 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47558 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeFSX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:57:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DDDFE800E6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:56:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529452617;
        bh=Sb3HAbWnbRhPu1Xi819Jz0Sjeyt87Tlr8VTUQ6uHJ08=;
        h=From:To:CC:Subject:Date:References;
        b=mgRqzD69YCcOWmnIYwoW37+txIibmPIgP2lbZxBnnnLqA6qWjhB1eomrzs0TRqiR0
         inzwIxuWzeuccqzk2kxeOTQgaPQopZ5RzmM3G1tCZNeu1HLPiB22OFhQ0AArQuiC3r
         XsXm7S7kZs8t9UHluztvKLGoog++n84z1Bjr1Lkk=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b29984a0001>; Wed, 20 Jun 2018 11:56:58 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 20 Jun 2018 11:56:56 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 20 Jun 2018 11:56:56 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Subject: Re: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Topic: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Index: AQHUBsA+zZ/Rrpto/keRRl4OvggntA==
Date:   Tue, 19 Jun 2018 23:56:56 +0000
Message-ID: <66701c795bdc492aa3e3ffce6a0181d9@svr-chch-ex1.atlnz.lc>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
 <20180618151450.3e740270@xps13>
 <f16525ea6b534123bda64b09e818ce6d@svr-chch-ex1.atlnz.lc>
 <0caaea1b4f5a4b45b436833424c4c8c8@svr-chch-ex1.atlnz.lc>
 <20180619065555.1900487c@bbrezillon>
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

Adding participants from =0A=
http://lists.infradead.org/pipermail/linux-mtd/2017-March/072974.html=0A=
=0A=
On 19/06/18 16:56, Boris Brezillon wrote:=0A=
=0A=
> Hi Chris, >=0A=
> On Tue, 19 Jun 2018 01:44:24 +0000=0A=
> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:=0A=
> =0A=
>> On 19/06/18 12:35, Chris Packham wrote:=0A=
>>> On 19/06/18 01:15, Miquel Raynal wrote:=0A=
>>>> Hi Chris,=0A=
>>>>=0A=
>>>> On Mon, 18 Jun 2018 16:52:53 +1200, Chris Packham=0A=
>>>> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>>>   =0A=
>>>>> Hi,=0A=
>>>>>=0A=
>>>>> I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F c=
hip=0A=
>>>>> to one of our boards which uses the Marvell NFCv2 controller.=0A=
>>>>>=0A=
>>>>> This particular chip is a bit odd in that the datasheet states suppor=
t=0A=
>>>>> for ONFI 1.0 but the revision number field is 00 00. It also is marke=
d=0A=
>>>>> ABAFA but reports internally as ABAGA. Finally it has internal 8-bit =
ECC=0A=
>>>>> which cannot be disabled.=0A=
>>>>=0A=
>>>> Boris and I agree that in this case, the chip should not be probed if=
=0A=
>>>> ecc->type !=3D ON_DIE (and eventually NONE).=0A=
>>>>=0A=
>>>> This should be handled in the Micron driver.=0A=
>>>>=0A=
>>>> Also, what is the returned value of micron_supports_on_die_ecc() (with=
=0A=
>>>> patch 1/2)?=0A=
>>>=0A=
>>> micron_supports_on_die_ecc() returns MICRON_ON_DIE_UNSUPPORTED.=0A=
>>> Technically this chip should be MICRON_ON_DIE_MANDATORY since it can't=
=0A=
>>> be disabled but that wouldn't be much help since that would still resul=
t=0A=
>>> in -EINVAL. I'll dig into micron_supports_on_die_ecc() and see if I can=
=0A=
>>> find something in the datasheet to use.=0A=
>>>    =0A=
>>=0A=
>> Some further debugging. Nothing (in 4.17) calls=0A=
>> set_bit(ONFI_FEATURE_ON_DIE_ECC) so I don't think=0A=
>> micron_supports_on_die_ecc() can return anything other than=0A=
>> MICRON_ON_DIE_UNSUPPORTED, unless I'm missing something for how the=0A=
>> {get,set}_feature_list is populated.=0A=
> =0A=
> Nope you're not. Looks like we broke Micron on-die ECC in 4.17.=0A=
> =0A=
>>=0A=
>> With the onfi.version fix and the following=0A=
>>=0A=
>> --- a/drivers/mtd/nand/raw/nand_micron.c=0A=
>> +++ b/drivers/mtd/nand/raw/nand_micron.c=0A=
>> @@ -66,7 +66,9 @@ static int micron_nand_onfi_init(struct nand_chip *chi=
p)=0A=
>>=0A=
>>           if (p->supports_set_get_features) {=0A=
>>                   set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->set_feature_l=
ist);=0A=
>> +               set_bit(ONFI_FEATURE_ON_DIE_ECC, p->set_feature_list);=
=0A=
>>                   set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->get_feature_l=
ist);=0A=
>> +               set_bit(ONFI_FEATURE_ON_DIE_ECC, p->get_feature_list);=
=0A=
>>           }=0A=
> =0A=
> Can you send a patch containing only the above changes with the=0A=
> Cc-stable and Fixes tags?=0A=
> =0A=
>> @@ -240,7 +246,7 @@ static int micron_supports_on_die_ecc(struct=0A=
>> nand_chip *chip)=0A=
>>            * Some Micron NANDs have an on-die ECC of 4/512, some other=
=0A=
>> -         * 8/512. We only support the former.=0A=
>> +         * 8/512.=0A=
>>            */=0A=
>> -       if (chip->ecc_strength_ds !=3D 4)=0A=
>> +       if (chip->ecc_strength_ds !=3D 4 && chip->ecc_strength_ds !=3D 8=
)=0A=
>>                   return MICRON_ON_DIE_UNSUPPORTED;=0A=
>>=0A=
> =0A=
> This should be done in a separate patch.=0A=
>   =0A=
>> I can get micron_supports_on_die_ecc() to return MICRON_ON_DIE_SUPPORTED=
.=0A=
>>=0A=
> =0A=
> That's weird. You should have MICRON_ON_DIE_MANDATORY here. Could it be=
=0A=
> that the ONFI_FEATURE_ON_DIE_ECC_EN bit does not really reflect the ECC=
=0A=
> engine state? If that's the case, we'll have to change the way we=0A=
> detect if on-die ECC is supported/mandatory/not-supported (based on the=
=0A=
> model name stored in the ONFI param page?).=0A=
> =0A=
=0A=
Even though though MT29F1G08ABAFAWP-ITE:F says on-die ECC is enabled and =
=0A=
cannot be disabled it still seems to respond to =0A=
micron_nand_on_die_ecc_setup(chip, false); by clearing the feature bit =0A=
retrieved by nand_get_features(chip, ONFI_FEATURE_ON_DIE_ECC, feature).=0A=
=0A=
I see in the original thread that the detection of the 70s parts can be =0A=
done by the "Number of bits ECC correctability". Can we assume that all =0A=
70s has MICRON_ON_DIE_MANDATORY or do I need to make it based on =0A=
specific IDs?=0A=
