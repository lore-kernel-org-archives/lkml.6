Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5144ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E9720882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E9720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeIOGfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:35:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725754AbeIOGfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:35:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5507DD3727678;
        Sat, 15 Sep 2018 09:18:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Sat, 15 Sep 2018
 09:18:20 +0800
Message-ID: <5B9C5DDB.7060809@huawei.com>
Date:   Sat, 15 Sep 2018 09:18:19 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix a GCC compiled warning.
References: <1536936549-30631-1-git-send-email-zhongjiang@huawei.com> <CANiq72ndUkKyZ1gxgv9kv_Niq0sb7RwLj4QGrKNa2bg_jmd45A@mail.gmail.com>
In-Reply-To: <CANiq72ndUkKyZ1gxgv9kv_Niq0sb7RwLj4QGrKNa2bg_jmd45A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/15 0:43, Miguel Ojeda wrote:
> Hi Zhong,
>
> On Fri, Sep 14, 2018 at 4:49 PM, zhong jiang <zhongjiang@huawei.com> wrote:
>> Fix the following compile warning:
>>
>> kernel/sched/core.c: In function ‘update_rq_clock_task’:
>> kernel/sched/core.c:139:6: warning: unused variable ‘steal’ [-Wunused-variable]
>>   s64 steal = 0, irq_delta = 0;
>>
> Dou (and I, without having noticed Dou's) also sent another patch for this, see:
>
>   https://lore.kernel.org/patchwork/patch/973402/
>   https://lore.kernel.org/patchwork/patch/983794/
Thank you for spoting this. I miss them.

Sincerely,
zhong jiang
> Cheers,
> Miguel
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  kernel/sched/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 7577ce4..1003c1d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -136,7 +136,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>>   * to sched_rt_avg_update. But I don't trust it...
>>   */
>>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
>> -       s64 steal = 0, irq_delta = 0;
>> +       s64 __maybe_unused steal = 0, irq_delta = 0;
>>  #endif
>>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>>         irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
>> --
>> 1.7.12.4
>>
>


