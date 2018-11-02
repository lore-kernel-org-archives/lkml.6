Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1620C2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1620C2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeKBXlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeKBXlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:41:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E75C7BDA0;
        Fri,  2 Nov 2018 14:34:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C6795D6A6;
        Fri,  2 Nov 2018 14:34:22 +0000 (UTC)
Subject: Re: [PATCH v14 12/12] cpuset: Show descriptive text when reading
 cpuset.sched.partition
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-13-git-send-email-longman@redhat.com>
 <20181017150836.GS270328@devbig004.ftw2.facebook.com>
 <b797288a-6088-f7b0-c881-81633c071754@redhat.com>
 <20181019192444.GV270328@devbig004.ftw2.facebook.com>
To:     Peter Zijlstra <peterz@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bd198f0c-e5b9-13f1-ffe2-05414d0b392f@redhat.com>
Date:   Fri, 2 Nov 2018 10:34:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181019192444.GV270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 02 Nov 2018 14:34:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2018 03:24 PM, Tejun Heo wrote:
> On Fri, Oct 19, 2018 at 02:56:13PM -0400, Waiman Long wrote:
>> On 10/17/2018 11:08 AM, Tejun Heo wrote:
>>> On Mon, Oct 15, 2018 at 04:29:37PM -0400, Waiman Long wrote:
>>>> Currently, cpuset.sched.partition returns the values, 0, 1 or -1 on
>>>> read. A person who is not familiar with the partition code may not
>>>> understand what they mean.
>>>>
>>>> In order to make cpuset.sched.partition more user-friendly, it will
>>>> now display the following descriptive text on read:
>>>>
>>>>   "normal" - A normal cpuset, not a partition root
>>>>   "partition" - A partition root
>>>>   "partition invalid" - An invalid partition root
>>>>
>>>> Suggested-by: Tejun Heo <tj@kernel.org>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Can you also make this consistent when writing to the file?
>>>
>>> Thanks.
>>>
>> How about the attached patch instead?
> Looks good to me.  Once Peter is okay with it, I'll roll it into
> cgroup devel branch.  As v4.19 is almost done, I think it makes more
> sense to target the next merge window (v4.21).
>
> Thanks.
>
Peter, are you OK with the current cpuset v2 patch which does allow
hierarchical partitions as you have requested?

Cheers,
Longman

