Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B9BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BDA20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BDA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeFUIF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754354AbeFUIFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:05:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EDD83082A29;
        Thu, 21 Jun 2018 08:05:19 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6561E5D6A8;
        Thu, 21 Jun 2018 08:05:11 +0000 (UTC)
Subject: Re: [PATCH v10 2/9] cpuset: Add new v2 cpuset.sched.domain_root flag
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-3-git-send-email-longman@redhat.com>
 <20180620142735.GM2494@hirez.programming.kicks-ass.net>
 <b44b0748-9fec-6bb0-7665-435487e5d8b3@redhat.com>
Organization: Red Hat
Message-ID: <89436f95-47d7-32d9-d466-ac7d4c58f25b@redhat.com>
Date:   Thu, 21 Jun 2018 16:05:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <b44b0748-9fec-6bb0-7665-435487e5d8b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 21 Jun 2018 08:05:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 03:58 PM, Waiman Long wrote:
> On 06/20/2018 10:27 PM, Peter Zijlstra wrote:
>> On Mon, Jun 18, 2018 at 12:14:01PM +0800, Waiman Long wrote:
>>> +  cpuset.sched.domain_root
>> Why are we calling this a domain_root and not a partition?
> A partition can consist of several cgroups in a tree structure. That
> flag should only be set at the root of a partition. I will change the
> name to partition_root if you think this name is acceptable.
>
>>> +	A read-write single value file which exists on non-root
>>> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
>>> +	either "0" (off) or "1" (on).  This flag is set by the parent
>>> +	and is not delegatable.
>> You still haven't answered:
>> ,  
>>   https://lkml.kernel.org/r/20180531094943.GG12180@hirez.programming.kicks-ass.net
>>
>> the question stands.
> I am sorry to miss your question. Turning on domain_root will affects
> the cpu mapping in the parent. That is why it cannot be set by the child
> as a child is not supposed to be able to affect the parent.

After thinking a bit more about it, you are right that I should not use
the term "not delegatable" here. I will rephrase in the next version.

Cheers,
Longman
