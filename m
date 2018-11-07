Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D55C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2DE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2DE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeKGK4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:56:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbeKGK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:56:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0B6E6B60945C;
        Wed,  7 Nov 2018 09:28:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 7 Nov 2018
 09:28:34 +0800
Subject: Re: [PATCH -next] edac: i82975x: remove set but not used variable
 'dtype'
To:     Borislav Petkov <bp@alien8.de>
References: <20181101022604.7312-1-yuehaibing@huawei.com>
 <20181106180526.GL13712@zn.tnic>
CC:     <linux-edac@vger.kernel.org>, <ravi@jetztechnologies.com>,
        <arvino55@gmail.com>, <mchehab@kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3e4fefcf-588b-9999-e8d2-4d0eb9a11585@huawei.com>
Date:   Wed, 7 Nov 2018 09:28:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181106180526.GL13712@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/7 2:05, Borislav Petkov wrote:
> On Thu, Nov 01, 2018 at 10:26:04AM +0800, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/edac/i82975x_edac.c:378:16: warning:
>>  variable ‘dtype’ set but not used [-Wunused-but-set-variable]
>>
>> It never used since introduction in commit
>> 084a4fccef39 ("edac: move dimm properties to struct dimm_info")
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/edac/i82975x_edac.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
>> index 892815e..ae0d8fa 100644
>> --- a/drivers/edac/i82975x_edac.c
>> +++ b/drivers/edac/i82975x_edac.c
>> @@ -375,7 +375,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
>>  	u32 cumul_size, nr_pages;
>>  	int index, chan;
>>  	struct dimm_info *dimm;
>> -	enum dev_type dtype;
>>  
>>  	last_cumul_size = 0;
>>  
>> @@ -413,7 +412,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
>>  		 *   [0-7] for single-channel; i.e. csrow->nr_channels = 1
>>  		 *   [0-3] for dual-channel; i.e. csrow->nr_channels = 2
>>  		 */
>> -		dtype = i82975x_dram_type(mch_window, index);
> 
> Please get rid of that silly function too and move the comment and the
> assignment to the single place where it is done:
> 
>         /*
>          * ECC is possible on i92975x ONLY with DEV_X8
>          */
>         dimm->dtype = DEV_X8;
> 

OK， will send v2.

> 
> Thx.
> 

