Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C483ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5122B214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5122B214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeJQPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:55:16 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5469 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:55:16 -0400
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="21801738"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 17 Oct 2018 01:00:47 -0700
Received: from localhost.localdomain (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Wed, 17 Oct 2018 01:00:45 -0700
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon> <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <47586729-d711-cd38-a4b2-bef09f64cba3@microchip.com>
Date:   Wed, 17 Oct 2018 11:00:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yogesh,

On 10/17/2018 10:46 AM, Yogesh Narayan Gaur wrote:
> Hi Boris,
> 
>> -----Original Message-----
>> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
>> Sent: Wednesday, October 17, 2018 1:00 PM
>> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
>> <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
>> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
>> linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
>> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
>> kernel@lists.infradead.org; Cristian.Birsan@microchip.com
>> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
>> NOR flash memories
>>
>> On Wed, 17 Oct 2018 09:10:45 +0200
>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>
>>> On Wed, 17 Oct 2018 09:07:24 +0200
>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>>
>>>> On Wed, 17 Oct 2018 02:07:43 +0000
>>>> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>>>>
>>>>>>
>>>>> Actually there is no entry of s25fs512s in current spi-nor.c file.
>>>>> For my connected flash part, jedec ID read points to s25fl512s. I
>>>>> have asked my board team to confirm the name of exact connected
>>>>> flash part. When I check the data sheet of s25fs512s, it also
>>>>> points to the same Jedec ID information. { "s25fl512s",
>>>>> INFO(0x010220, 0x4d00, 256
>>>>> * 1024, 256, ....}
>>>>>
>>>>> But as stated earlier, if I skip reading SFDP or read using 1-1-1
>>>>> protocol then read are always correct. For 1-4-4 protocol read are
>>>>> wrong and on further debugging found that Read code of 0x6C is
>>>>> being send as opcode instead of 0xEC.
>>>>>
>>>>> If I revert this patch, reads are working fine.
>>>>
>>>> Can you try with the following patch?
>>>>
>>>
>>> Hm, nevermind. The problem is actually not related to 4B vs non-4B
>>> mode but 1-1-4 vs 1-4-4 modes.
> Yes, that's only I have stated in my first mail that instead of 1-4-4 mode read opcode is being sent for 1-1-4 mode.
>>>
>>
>> Can you try with this patch applied?
>>
> With suggested patch, read for protocol 1-4-4 working correctly.
> 
> 	[    1.625360] m25p80 spi0.0: found s25fl512s, expected m25p80                                                                   
> 	[    1.631094] m25p80 spi0.0: failed to parse SMPT (err = -22)                                                                   
> 	[    1.636661] 261 8c4c780 opcode(read:eb, pp:2, erase:d8)                                                                       
> 	[    1.641878] 266 8c4c780 opcode(read:ec, pp:12, erase:dc)                                                                      
> 	[    1.647200] m25p80 spi0.0: s25fl512s (65536 Kbytes)         
> 
> Without this patch, param_headers are getting freed and restoring previous erase map i.e. opcode related to 1-1-4 protocol.
> 

Can you add some prints in spi_nor_parse_smpt() to isolate what's failing? We
should understand whether it's something wrong in spi_nor_parse_smpt() or the
s25fs512s smpt table does not respect the standard.

Thanks,
ta

> 
>> --->8---
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c index
>> 9407ca5f9443..cf33d834698c 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -3132,6 +3132,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>>                 switch (SFDP_PARAM_HEADER_ID(param_header)) {
>>                 case SFDP_SECTOR_MAP_ID:
>>                         err = spi_nor_parse_smpt(nor, param_header);
>> +                       if (err) {
>> +                               dev_warn(dev,
>> +                                        "failed to parse SMPT (err = %d)\n",
>> +                                        err);
>> +                               /*
>> +                                * SMPT parsing is optional, let's not drop
>> +                                * all information we extracted so far just
>> +                                * because it failed.
>> +                                */
>> +                               err = 0;
>> +                       }
>>                         break;
>>
>>                 default:
> 
