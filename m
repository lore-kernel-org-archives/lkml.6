Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE518C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0C2473A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE0C2473A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeGDG5A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:57:00 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45485 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932420AbeGDG47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:56:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T3x1A3P_1530687402;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T3x1A3P_1530687402)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Jul 2018 14:56:42 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <20180702152106.GD533219@devbig577.frc2.facebook.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <351ef694-92b5-bd43-e766-19e1a1e71453@linux.alibaba.com>
Date:   Wed, 4 Jul 2018 14:56:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702152106.GD533219@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 11:21 PM, Tejun Heo wrote:
> Hello, Peter.
> 
> On Tue, Jun 26, 2018 at 05:49:08PM +0200, Peter Zijlstra wrote:
>> Well, no, because the Changelog is incomprehensible and the patch
>> doesn't really have useful comments, so I'll have to reverse engineer
>> the entire thing, and I've just not had time for that.
> 
> Just as an additional data point, we also sometimes see artifacts from
> cpu_adjust_time() in the form of per-task user or sys time getting
> stuck for some period (in extreme cases for over a minute) while the
> application isn't doing anything differently.  We're telling the users
> that it's an inherent sampling artifact but it'd be nice to improve it
> if possible without adding noticeable overhead.  No idea whether this
> patch's approach is a good one tho.

The patch has no noticeable overhead except the extra cputime fileds
added into task_struct. We've been running this patch on our servers
for months, looks good till now.

Thanks!
