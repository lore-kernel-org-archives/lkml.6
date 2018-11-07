Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF25A20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF25A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKHIbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:31:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27663 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbeKHIbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:31:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D060804E0;
        Wed,  7 Nov 2018 22:59:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F91219481;
        Wed,  7 Nov 2018 22:58:59 +0000 (UTC)
Subject: Re: [PATCH v14 10/12] cpuset: Add documentation about the new
 "cpuset.sched.partition" flag
To:     Peter Zijlstra <peterz@infradead.org>
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
 <1539635377-22335-11-git-send-email-longman@redhat.com>
 <20181106115045.GO22431@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <7f71f746-582b-42d0-11f1-e690ab4d94b0@redhat.com>
Date:   Wed, 7 Nov 2018 17:58:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181106115045.GO22431@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 07 Nov 2018 22:59:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 06:50 AM, Peter Zijlstra wrote:
> On Mon, Oct 15, 2018 at 04:29:35PM -0400, Waiman Long wrote:
>> The cgroup-v2.rst file is updated to document the purpose of the new
>> "cpuset.sched.partition" flag and how its usage.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst | 66 +++++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 533e85cb851b..178cda473a26 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1686,6 +1686,72 @@ Cpuset Interface Files
>>  
>>  	Its value will be affected by memory nodes hotplug events.
>>  
>> +  cpuset.sched.partition
>> +	A read-write single value file which exists on non-root
>> +	cpuset-enabled cgroups.  It accepts either "0" (off) or "1"
>> +	(on) when written to.  
>> +     This flag is set and owned by the
>> +	parent cgroup.
> What does that mean? The parent cgroup doesn't 'set' anything at all.
> The user will.
>
>> +
>> +	If set, it indicates that the current cgroup is the root of a
>> +	new partition or scheduling domain that comprises itself and
>> +	all its descendants except those that are separate partition
>> +	roots themselves and their descendants.  The root cgroup is
>> +	always a partition root.
>> +
>> +	There are constraints on where this flag can be set.  It can
>> +	only be set in a cgroup if all the following conditions are true.
>> +
>> +	1) The "cpuset.cpus" is not empty and the list of CPUs are
>> +	   exclusive, i.e. they are not shared by any of its siblings.
>> +	2) The parent cgroup is a partition root.
>> +	3) The "cpuset.cpus" is also a proper subset of the parent's
>> +	   "cpuset.cpus.effective".
>> +	4) There is no child cgroups with cpuset enabled.  This is for
>> +	   eliminating corner cases that have to be handled if such a
>> +	   condition is allowed.
>> +
>> +	Setting this flag will take the CPUs away from the effective
>> +	CPUs of the parent cgroup.  Once it is set, this flag cannot
>> +	be cleared if there are any child cgroups with cpuset enabled.
>> +
>> +	A parent partition cannot distribute all its CPUs to its
>> +	child partitions.  There must be at least one cpu left in the
>> +	parent partition.
>> +
>> +	Once becoming a partition root, changes to "cpuset.cpus" is
>> +	generally allowed as long as the first condition above is true,
>> +	the change will not take away all the CPUs from the parent
>> +	partition and the new "cpuset.cpus" value is a superset of its
>> +	children's "cpuset.cpus" values.
>> +	Sometimes, external factors like changes to ancestors'
>> +	"cpuset.cpus" or cpu hotplug can cause the state of the partition
>> +	root to change.  On read, the "cpuset.sched.partition" file
>> +	can show the following values.
> Are those the only conditions under which that -1 can happen? Parent
> taking away CPUs it previously granted and hotplug?

Yes, if none of the cpus are available. It will become invalid. It still
remains a partition (a partial one) if at least one cpu is allocated to
that partition.

>> +
>> +	"0"  Not a partition root
>> +	"1"  Partition root
>> +	"-1" Erroneous partition root
>> +
>> +	It is a partition root if the first 2 partition root conditions
>> +	above are true and at least one CPU from "cpuset.cpus" is
>> +	granted by the parent cgroup.
>> +
>> +	A partition root can become an erroneous partition root if none
>> +	of CPUs requested in "cpuset.cpus" can be granted by the parent
>> +	cgroup or the parent cgroup is no longer a partition root.
>> +	In this case, it is not a real partition even though the
>> +	restriction of the first partition root condition above will
>> +	still apply.  All the tasks in the cgroup will be migrated to
>> +	the nearest ancestor partition.
> Effectively or actual? Actual migrating tasks out of the cgroup is
> irreversible.

I am not talking about actual migration to a different cgroup. I am
talking moving to a different partition. When a partition become
invalid, it will inherent the partition parent's effective cpumask.

>> +	An erroneous partition root can be transitioned back to a real
>> +	partition root if at least one of the requested CPUs can now be
>> +	granted by its parent.	In this case, the tasks will be migrated
>> +	back to the newly created partition.  Clearing the partition
>> +	flag of an erroneous partition root is always allowed even if
>> +	child cpusets are present.
> So you need to clarify the above point (I think it is effectively),
> because otherwise you don't know which tasks to put back.

I will clarify that.

Thanks,
Longman

