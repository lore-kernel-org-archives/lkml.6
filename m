Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E1CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1542087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfA3Jmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:42:36 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:37684 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:42:36 -0500
Received: from [10.28.18.236] (10.28.18.236) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 30 Jan
 2019 17:43:19 +0800
Subject: Re: [PATCH][next] mtd: rawnand: meson: fix missing assignment of ret
 on a call to meson_chip_buffer_init
To:     Colin Ian King <colin.king@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190129105757.19138-1-colin.king@canonical.com>
 <aeadd16e-ed46-28f2-15de-66d1d9f1ed11@amlogic.com>
 <20190130103250.4080a3b3@xps13>
 <25109367-14bc-90b1-f0a9-ad65aac46bf8@canonical.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <30e51df9-d1ad-9066-41e0-d8ee6aa3ad4a@amlogic.com>
Date:   Wed, 30 Jan 2019 17:43:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <25109367-14bc-90b1-f0a9-ad65aac46bf8@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.18.236]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel, Colin,

On 2019/1/30 17:34, Colin Ian King wrote:
> On 30/01/2019 09:32, Miquel Raynal wrote:
>> Hi Liang, Colin,
>>
>> Liang Yang <liang.yang@amlogic.com> wrote on Wed, 30 Jan 2019 17:26:49
>> +0800:
>>
>>> Hi Colin,
>>>
>>> On 2019/1/29 18:57, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> The call to meson_chip_buffer_init is not assigning ret, however, ret
>>>> is being checked for failure. Fix this by adding in the missing assignment.
>>>>
>>>> Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>    drivers/mtd/nand/raw/meson_nand.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index e858d58d97b0..b9c543d1054c 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -1206,7 +1206,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>    		dev_err(nfc->dev, "16bits bus width not supported");
>>>>    		return -EINVAL;
>>>>    	}
>>>> -	meson_chip_buffer_init(nand);
>>>> +	ret = meson_chip_buffer_init(nand);
>>>
>>> Looks good to me:
>>>
>>> Acked-by: Liang Yang <liang.yang@amlogic.com>
>>
>> This is nand/next material, so if you don't mind I would like to squash
>> the two fixes you sent into the original commit inserting the driver.
> 
> Sure, ok with me, squashing them makes sense.
> 
> Colin

ok.

>>
>>
>> Thanks,
>> Miquèl
>>
> 
> .
> 
