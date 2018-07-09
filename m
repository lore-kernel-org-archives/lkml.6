Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FD220875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FD220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeGIPAR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:00:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44970 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932903AbeGIPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:00:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T4ILWfP_1531148410;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T4ILWfP_1531148410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Jul 2018 23:00:10 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <e1b69cf9-a3a7-ea67-7c0e-d67ac81f29f1@linux.alibaba.com>
 <20180705104632.GE2494@hirez.programming.kicks-ass.net>
 <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
 <5a3354c1-d3fe-33dc-53cf-6eb621177052@linux.alibaba.com>
 <20180709104857.GK2476@hirez.programming.kicks-ass.net>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <566b7d56-9139-a524-3108-54ba231f295c@linux.alibaba.com>
Date:   Mon, 9 Jul 2018 23:00:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709104857.GK2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 7/9/18 6:48 PM, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 01:52:38PM +0800, Xunlei Pang wrote:
>> Please see the enclosure for the reproducer cputime_adjust.tgz
> 
> No, I'm not going to reverse engineer something if you cannot even
> explain what the problem is.
> 

I rewrote the whole changelog and sent v2, please have a look.

Thanks,
Xunlei
