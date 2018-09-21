Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D50C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6201021479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6201021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbeIUIfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:35:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52383 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeIUIfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:35:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7DD827CAAE119;
        Fri, 21 Sep 2018 10:48:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 10:48:54 +0800
Message-ID: <5BA45C16.9090701@huawei.com>
Date:   Fri, 21 Sep 2018 10:48:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Baoquan He <bhe@redhat.com>
CC:     <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: kexec_file: remove some duplicated include file
References: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com> <20180921021524.GP2555@MiWiFi-R3L-srv> <5BA4570F.6050700@huawei.com> <20180921023529.GQ2555@MiWiFi-R3L-srv>
In-Reply-To: <20180921023529.GQ2555@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/21 10:35, Baoquan He wrote:
> On 09/21/18 at 10:27am, zhong jiang wrote:
>> On 2018/9/21 10:15, Baoquan He wrote:
>>> On 09/20/18 at 01:12pm, zhong jiang wrote:
>>>> kexec.h and slab.h have duplicated include. hence just remove
>>>> redundant file.
>>> They have duplicated include, why do you remove both of them?
>> because we include the kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
> OK, Could you rewrite the log with this? The old log makes me think
> kexec.h and slab.h themselves have duplicated include.
Ok,  I will rewrite the log and repost in v2. Thanks

Sincerely,
zhong jiang
>> Thanks,
>> zhong jiang
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>> ---
>>>>  kernel/kexec_file.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index c6a3b68..35cf0ad 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -25,8 +25,6 @@
>>>>  #include <linux/elf.h>
>>>>  #include <linux/elfcore.h>
>>>>  #include <linux/kernel.h>
>>>> -#include <linux/kexec.h>
>>>> -#include <linux/slab.h>
>>>>  #include <linux/syscalls.h>
>>>>  #include <linux/vmalloc.h>
>>>>  #include "kexec_internal.h"
>>>> -- 
>>>> 1.7.12.4
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>> .
>>>
>>
> .
>


