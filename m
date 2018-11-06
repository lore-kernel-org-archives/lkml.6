Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED192085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3V8hSCGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED192085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbeKFVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:15:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbeKFVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NdB1/YSqIQBrvWfgUzA3bL3ENAQ3IbGcwZjZpB53eds=; b=3V8hSCGV5+CrYVpjkmuSmAyuT
        jtrJ1u2IXvkeV7nFEDOdqBVHNIn/ONLOMhSfo0lUhAXFHBcyHEU1mRVSzd/7WnQeUq8ysXsXKWhRc
        Iix6KwsUJyI91Gnrhc8BNxjO6SRz1V3yrAsHEFmdHMkZ2tH7sAV1SxrLtbdJWMKLdO4h70Ln7pXzi
        wb2blUKP+aMCtJYRU4MUz6e3VsJRlxr4ZEDw4Eyii/TQQub0OBnpz7SjxWtoNrXfOqNTnZHrzqZA7
        HRytG+Fgxiba1EIKx1bGYX5B4WUg8xSFuxIhzicVqRx4+UDQq/Uk0xAQUtGYyXkEsGfpXbYQhuVPG
        HC2qsV0jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJzsi-0005pl-20; Tue, 06 Nov 2018 11:50:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B2512029F9FF; Tue,  6 Nov 2018 12:50:45 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:50:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
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
Subject: Re: [PATCH v14 10/12] cpuset: Add documentation about the new
 "cpuset.sched.partition" flag
Message-ID: <20181106115045.GO22431@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-11-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-11-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:29:35PM -0400, Waiman Long wrote:
> The cgroup-v2.rst file is updated to document the purpose of the new
> "cpuset.sched.partition" flag and how its usage.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 66 +++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 533e85cb851b..178cda473a26 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1686,6 +1686,72 @@ Cpuset Interface Files
>  
>  	Its value will be affected by memory nodes hotplug events.
>  
> +  cpuset.sched.partition
> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It accepts either "0" (off) or "1"
> +	(on) when written to.  

> +     This flag is set and owned by the
> +	parent cgroup.

What does that mean? The parent cgroup doesn't 'set' anything at all.
The user will.

> +
> +	If set, it indicates that the current cgroup is the root of a
> +	new partition or scheduling domain that comprises itself and
> +	all its descendants except those that are separate partition
> +	roots themselves and their descendants.  The root cgroup is
> +	always a partition root.
> +
> +	There are constraints on where this flag can be set.  It can
> +	only be set in a cgroup if all the following conditions are true.
> +
> +	1) The "cpuset.cpus" is not empty and the list of CPUs are
> +	   exclusive, i.e. they are not shared by any of its siblings.
> +	2) The parent cgroup is a partition root.
> +	3) The "cpuset.cpus" is also a proper subset of the parent's
> +	   "cpuset.cpus.effective".
> +	4) There is no child cgroups with cpuset enabled.  This is for
> +	   eliminating corner cases that have to be handled if such a
> +	   condition is allowed.
> +
> +	Setting this flag will take the CPUs away from the effective
> +	CPUs of the parent cgroup.  Once it is set, this flag cannot
> +	be cleared if there are any child cgroups with cpuset enabled.
> +
> +	A parent partition cannot distribute all its CPUs to its
> +	child partitions.  There must be at least one cpu left in the
> +	parent partition.
> +
> +	Once becoming a partition root, changes to "cpuset.cpus" is
> +	generally allowed as long as the first condition above is true,
> +	the change will not take away all the CPUs from the parent
> +	partition and the new "cpuset.cpus" value is a superset of its
> +	children's "cpuset.cpus" values.

> +	Sometimes, external factors like changes to ancestors'
> +	"cpuset.cpus" or cpu hotplug can cause the state of the partition
> +	root to change.  On read, the "cpuset.sched.partition" file
> +	can show the following values.

Are those the only conditions under which that -1 can happen? Parent
taking away CPUs it previously granted and hotplug?

> +
> +	"0"  Not a partition root
> +	"1"  Partition root
> +	"-1" Erroneous partition root
> +
> +	It is a partition root if the first 2 partition root conditions
> +	above are true and at least one CPU from "cpuset.cpus" is
> +	granted by the parent cgroup.
> +
> +	A partition root can become an erroneous partition root if none
> +	of CPUs requested in "cpuset.cpus" can be granted by the parent
> +	cgroup or the parent cgroup is no longer a partition root.
> +	In this case, it is not a real partition even though the
> +	restriction of the first partition root condition above will
> +	still apply.  All the tasks in the cgroup will be migrated to
> +	the nearest ancestor partition.

Effectively or actual? Actual migrating tasks out of the cgroup is
irreversible.

> +	An erroneous partition root can be transitioned back to a real
> +	partition root if at least one of the requested CPUs can now be
> +	granted by its parent.	In this case, the tasks will be migrated
> +	back to the newly created partition.  Clearing the partition
> +	flag of an erroneous partition root is always allowed even if
> +	child cpusets are present.

So you need to clarify the above point (I think it is effectively),
because otherwise you don't know which tasks to put back.
