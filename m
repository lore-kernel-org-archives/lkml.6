Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D6C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E95320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KxKGzxA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E95320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeFTVMG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:12:06 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49641 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeFTVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:12:05 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 428B38365A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:12:03 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529529123;
        bh=Yk5jAnNyfKTNzW2hLECKLgZOt8lC2QKVsaDWNzpo7QM=;
        h=From:To:CC:Subject:Date:References;
        b=KxKGzxA5GNZNgKTP6W9uXOgBG8q+QMOQ47fiULb8ofJO4U3O91NzHkc7tzKAe9fKY
         BB/6AtD7twnLkRsRVrjA5mrb+VpsaK+e5EAww415gLSD9sSIYCoZnIiwNHuMnsS/rk
         kpKb5sn848N97dg1E0HuxzHKjbceqRnvhz+2G2Gk=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2ac3230002>; Thu, 21 Jun 2018 09:12:03 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 21 Jun 2018 09:12:03 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 21 Jun 2018 09:12:03 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Marek Vasut" <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 3/4] mtd: rawnand: micron: add fixup for ONFI revision
Thread-Topic: [PATCH v3 3/4] mtd: rawnand: micron: add fixup for ONFI revision
Thread-Index: AQHUCFRaI54oCSYLX0qAaZtUfGOAxg==
Date:   Wed, 20 Jun 2018 21:12:02 +0000
Message-ID: <5e3b8f2f896f44aaab97086dceb2a69b@svr-chch-ex1.atlnz.lc>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
 <20180620050544.31549-4-chris.packham@alliedtelesis.co.nz>
 <20180620095410.664091d8@bbrezillon>
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

On 20/06/18 19:54, Boris Brezillon wrote:=0A=
> On Wed, 20 Jun 2018 17:05:43 +1200=0A=
> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:=0A=
> =0A=
>> Some Micron NAND chips (MT29F1G08ABAFAWP-ITE:F) report 00 00 for the=0A=
>> revision number field of the ONFI parameter page. Rather than rejecting=
=0A=
>> these outright assume ONFI version 1.0 if the revision number is 00 00.=
=0A=
>>=0A=
>> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>> This is now qualified on vendor =3D=3D MICRON. I haven't qualified this=
=0A=
>> based on specific chips the ABAFA (id=3Dd1) and ABBFA (id=3Da1) variants=
 are=0A=
>> documented to have this behaviour.=0A=
>>=0A=
>> Changes in v2:=0A=
>> - use fixup_onfi_param_page=0A=
>> Changes in v3:=0A=
>> - add code comment next to workaround=0A=
>>=0A=
>>   drivers/mtd/nand/raw/nand_micron.c | 13 +++++++++++++=0A=
>>   1 file changed, 13 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/n=
and_micron.c=0A=
>> index 5ec4c90a637d..5cec79372181 100644=0A=
>> --- a/drivers/mtd/nand/raw/nand_micron.c=0A=
>> +++ b/drivers/mtd/nand/raw/nand_micron.c=0A=
>> @@ -289,6 +289,19 @@ static int micron_nand_init(struct nand_chip *chip)=
=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>> +static void micron_fixup_onfi_param_page(struct nand_chip *chip,=0A=
>> +					 struct nand_onfi_params *p)=0A=
>> +{=0A=
>> +	/*=0A=
>> +	 * MT29F1G08ABAFAWP-ITE:F and possibly others report 00 00 for the=0A=
>> +	 * revision number field of the ONFI parameter page. Assume ONFI=0A=
>> +	 * version 1.0 if the revision number is 00 00.=0A=
>> +	 */=0A=
>> +	if (le16_to_cpu(p->revision) =3D=3D 0)=0A=
>> +		p->revision =3D cpu_to_le16(1 << 1);=0A=
> =0A=
> Would be better to have macros defining all version numbers in rawnand.h=
=0A=
> =0A=
> #define ONFI_VERSION_1_0		BIT(1)=0A=
> #define ONFI_VERSION_2_0		BIT(2)=0A=
> #define ONFI_VERSION_2_1		BIT(3)=0A=
> #define ONFI_VERSION_2_2		BIT(4)=0A=
> #define ONFI_VERSION_2_3		BIT(5)=0A=
> #define ONFI_VERSION_3_0		BIT(6)=0A=
> #define ONFI_VERSION_3_1		BIT(7)=0A=
> #define ONFI_VERSION_3_2		BIT(8)=0A=
> #define ONFI_VERSION_4_0		BIT(9)=0A=
> =0A=
=0A=
Make sense. Do you want me to do so in a v4 or send a new patch and =0A=
clean up the other uses?=0A=
=0A=
>> +}=0A=
>> +=0A=
>>   const struct nand_manufacturer_ops micron_nand_manuf_ops =3D {=0A=
>>   	.init =3D micron_nand_init,=0A=
>> +	.fixup_onfi_param_page =3D micron_fixup_onfi_param_page,=0A=
>>   };=0A=
> =0A=
> =0A=
=0A=
