Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC6CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D5F205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D5F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeLJHQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:16:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeLJHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:16:08 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0FE1A897E95B;
        Mon, 10 Dec 2018 15:16:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Dec 2018
 15:16:01 +0800
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
To:     Lee Jones <lee.jones@linaro.org>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
 <20181210061557.GL26661@dell>
CC:     <dmitry.torokhov@gmail.com>, <matthias.bgg@gmail.com>,
        <chen.zhong@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
Date:   Mon, 10 Dec 2018 15:16:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181210061557.GL26661@dell>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/10 14:15, Lee Jones wrote:
> On Sun, 09 Dec 2018, YueHaibing wrote:
> 
>> Remove duplicated include.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
>> index 02c67a1..5027ebb 100644
>> --- a/drivers/input/keyboard/mtk-pmic-keys.c
>> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
>> @@ -19,7 +19,6 @@
>>  #include <linux/input.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/kernel.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/regmap.h>
> 
> You are removing the wrong one.

No, linux/kernel.h is a duplicated include indeed.

> 
> Please convert this patch's main intent to alphabetise the header
> files.  Then you can remove any obvious duplicates.

I can alphabetize it in v2 if need be.

> 

