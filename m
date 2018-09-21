Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09546ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980A321547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980A321547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeIUIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:14:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbeIUIOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:14:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFEE457C6FE8D;
        Fri, 21 Sep 2018 10:27:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 10:27:28 +0800
Message-ID: <5BA4570F.6050700@huawei.com>
Date:   Fri, 21 Sep 2018 10:27:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Baoquan He <bhe@redhat.com>
CC:     <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: kexec_file: remove some duplicated include file
References: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com> <20180921021524.GP2555@MiWiFi-R3L-srv>
In-Reply-To: <20180921021524.GP2555@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/21 10:15, Baoquan He wrote:
> On 09/20/18 at 01:12pm, zhong jiang wrote:
>> kexec.h and slab.h have duplicated include. hence just remove
>> redundant file.
> They have duplicated include, why do you remove both of them?
because we include the kexec.h and slab.h twice in kexec_file.c. It's unnecessary.

Thanks,
zhong jiang
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  kernel/kexec_file.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index c6a3b68..35cf0ad 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -25,8 +25,6 @@
>>  #include <linux/elf.h>
>>  #include <linux/elfcore.h>
>>  #include <linux/kernel.h>
>> -#include <linux/kexec.h>
>> -#include <linux/slab.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/vmalloc.h>
>>  #include "kexec_internal.h"
>> -- 
>> 1.7.12.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> .
>


