Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42275C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FA020846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FA020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeFUKvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:51:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54202 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754295AbeFUKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:51:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T36L4I4_1529578284;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T36L4I4_1529578284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jun 2018 18:51:24 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix bandwidth timer clock drift
 condition
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsegall@google.com, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180620101834.24455-1-xlpang@linux.alibaba.com>
 <xm26fu1hpf2b.fsf@bsegall-linux.svl.corp.google.com>
 <60638b2b-5044-3653-287b-738f254dbf92@linux.alibaba.com>
 <20180621080814.GQ2494@hirez.programming.kicks-ass.net>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <911d9cb6-b147-dcca-b8d5-243f82e9d94d@linux.alibaba.com>
Date:   Thu, 21 Jun 2018 18:51:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621080814.GQ2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/18 4:08 PM, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 11:56:56AM +0800, Xunlei Pang wrote:
>>>> Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
>>>> Cc: Ben Segall <bsegall@google.com>
>>>
>>> Reviewed-By: Ben Segall <bsegall@google.com>
>>
>> Thanks Ben :-)
>>
>> Hi Peter, could you please have a look at them?
> 
> I grabbed them, thanks guys!
> 
>>
>> Cc stable@vger.kernel.org
> 
> For both or just the first?
> 

Both, thanks!
