Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCBC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829AC218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfAaNZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:25:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726153AbfAaNZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:25:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2583F6669A5BB3B6B6C5;
        Thu, 31 Jan 2019 21:25:00 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 21:24:49 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix probing for ITT_entry_size
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1548933583-12504-1-git-send-email-yuzenghui@huawei.com>
 <b25b4419-d552-4829-027f-3b676afc7fbf@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <232b35f6-ecff-4e84-881c-bf1805cfab07@huawei.com>
Date:   Thu, 31 Jan 2019 21:21:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <b25b4419-d552-4829-027f-3b676afc7fbf@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/31 20:48, Marc Zyngier wrote:
> On 31/01/2019 11:19, Zenghui Yu wrote:
>> According to ARM IHI 0069C (ID070116), we should use GITS_TYPER's
>> bits [7:4] as ITT_entry_size.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   include/linux/irqchip/arm-gic-v3.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 071b4cb..c848a7c 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -319,7 +319,7 @@
>>   #define GITS_TYPER_PLPIS		(1UL << 0)
>>   #define GITS_TYPER_VLPIS		(1UL << 1)
>>   #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
>> -#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
>> +#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
>>   #define GITS_TYPER_IDBITS_SHIFT		8
>>   #define GITS_TYPER_DEVBITS_SHIFT	13
>>   #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
>>
> 
> Well spotted. I've applied this as a fix after having added the relevant
> Fixes: tag and massaged the commit message a bit.

Thanks Marc!

Zenghui

> 
> Thanks,
> 
> 	M.
> 

