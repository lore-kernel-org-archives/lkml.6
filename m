Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD3C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15189217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15189217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeHEPjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 11:39:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbeHEPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 11:39:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E95A4DAC21923;
        Sun,  5 Aug 2018 21:34:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Sun, 5 Aug 2018
 21:34:50 +0800
Message-ID: <5B66FCF9.8000903@huawei.com>
Date:   Sun, 5 Aug 2018 21:34:49 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <trivial@kernel.org>
Subject: Re: [PATCH] kernel/kthread:  Make function __kthread_queue_delayed_work
 static
References: <1533300002-27105-1-git-send-email-zhongjiang@huawei.com> <20180803092105.3dd68f05@gandalf.local.home>
In-Reply-To: <20180803092105.3dd68f05@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/3 21:21, Steven Rostedt wrote:
> On Fri, 3 Aug 2018 20:40:02 +0800
> zhong jiang <zhongjiang@huawei.com> wrote:
>
>> Fix the following warning.
>>
>> kernel/kthread.c:859:6: warning: symbol '__kthread_queue_delayed_work' was not declared. Should it be static?
>
> This should go via the trivial tree.
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  kernel/kthread.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 087d18d..3c661a0 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -856,7 +856,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>>  }
>>  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
>>  
>> -void __kthread_queue_delayed_work(struct kthread_worker *worker,
>> +static void __kthread_queue_delayed_work(struct kthread_worker *worker,
>>  				  struct kthread_delayed_work *dwork,
>>  				  unsigned long delay)
> Although, one could say you should align the parameters too, but that's
> not a big deal. Anyway...
>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
  Thanks , I will notice for next time.
> -- Steve
>
>>  {
>
> .
>


