Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9499DC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240FA2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240FA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeLNBdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:33:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727654AbeLNBdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:33:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D8D1C5DCC1861;
        Fri, 14 Dec 2018 09:33:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Dec 2018
 09:33:50 +0800
Subject: Re: [PATCH -next] audit: remove duplicated include from audit.c
To:     Paul Moore <paul@paul-moore.com>
References: <20181209062502.16308-1-yuehaibing@huawei.com>
 <CAHC9VhSCnZ4HfqA5ZR3xEzrofGZobLhbHr_N2OftkzW=Z6Q_YQ@mail.gmail.com>
CC:     Eric Paris <eparis@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-audit@redhat.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <fbe38a4d-9922-e2c2-76bb-0e110d4e678f@huawei.com>
Date:   Fri, 14 Dec 2018 09:33:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSCnZ4HfqA5ZR3xEzrofGZobLhbHr_N2OftkzW=Z6Q_YQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/14 7:42, Paul Moore wrote:
> On Sun, Dec 9, 2018 at 1:25 AM YueHaibing <yuehaibing@huawei.com> wrote:
>> Remove duplicated include.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  kernel/audit.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index a0a4544..632d360 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -60,7 +60,6 @@
>>  #include <linux/mutex.h>
>>  #include <linux/gfp.h>
>>  #include <linux/pid.h>
>> -#include <linux/slab.h>
> 
> As discussed previously, I don't want to remove header files whose
> declarations are used in the source file.  While it may be true that
> slab.h is included in one of the previously included header files, I
> like leaving it as an explicit include to help document the dependency
> and protect us from changes in the other header files.

The slab.h is included twice in audit.c , It like this:

#include <linux/file.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/atomic.h>
#include <linux/mm.h>
#include <linux/export.h>
#include <linux/slab.h>		//the first
#include <linux/err.h>
#include <linux/kthread.h>
#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <linux/spinlock.h>
#include <linux/rcupdate.h>
#include <linux/mutex.h>
#include <linux/gfp.h>
#include <linux/pid.h>
#include <linux/slab.h>    //duplicated


> 
> --
> paul moore
> www.paul-moore.com
> 
> 

