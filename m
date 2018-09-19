Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C01ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FBB2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FBB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeISIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:52:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbeISIw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:52:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [10.3.19.212])
        by Forcepoint Email with ESMTP id A4FDF87D6C32B;
        Wed, 19 Sep 2018 11:16:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 11:16:27 +0800
Message-ID: <5BA1BF8A.1000807@huawei.com>
Date:   Wed, 19 Sep 2018 11:16:26 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     cgxu519 <cgxu519@gmx.com>
CC:     <gregkh@linuxfoundation.org>, <gaoxiang25@huawei.com>,
        <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: erofs: Fix a unused variable 'arg' warning
References: <1537323381-23839-1-git-send-email-zhongjiang@huawei.com> <5b3438ac-f4d4-7f66-4be0-1720c1eada98@gmx.com>
In-Reply-To: <5b3438ac-f4d4-7f66-4be0-1720c1eada98@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 11:07, cgxu519 wrote:
> On 09/19/2018 10:16 AM, zhong jiang wrote:
>> I find the following warning when compiling the kernel.
>>
>> drivers/staging/erofs/super.c:195:6: warning: unused variable 'arg' [-Wunused-variable]
>>    int arg = 0;
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>   drivers/staging/erofs/super.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
>> index 6423592..c04313f 100644
>> --- a/drivers/staging/erofs/super.c
>> +++ b/drivers/staging/erofs/super.c
>> @@ -192,7 +192,9 @@ static int parse_options(struct super_block *sb, char *options)
>>   {
>>       substring_t args[MAX_OPT_ARGS];
>>       char *p;
>> +#ifdef CONFIG_EROFS_FAULT_INJECTION
>>       int arg = 0;
>> +#endif
>>         if (!options)
>>           return 0;
>
> Hi,
>
> The fix has already included in my patch series "staging: erofs: option validation for remount and some code cleanups",
> so it will be fixed when the series merge into tree and we do not encourage surrounding the code with macro in option
> parsing for this case.
>
Fine.  Thank you for explaination.

Sincerely,
zhong jiang
> Thanks,
> Chengguang
>
> .
>


