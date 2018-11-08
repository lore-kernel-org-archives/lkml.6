Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4392B2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K11mL6AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4392B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeKIBXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:23:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKIBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/MZukFSpCuBEoizT4c3YKDQ8IZGjR9aSJBXouowbvFw=; b=K11mL6AJsm3afKC8+M6MIP5WZ
        ba5Qf1PXbPmZrNC5EpDox1ovrSTfkwD6lWLFdmLDJ1JCjIvHZ1Bxk0Vj4Vsl9FKG1YhVXLmiX7+t6
        YaCvEDwG6IMkghBmld8l/NdJWAAeZpee9yJrht+CE/HqBl9fbzsdiMJksB+ibIhS25P8LHeA14Fy5
        DfvS22Sdn6Qtazpt9/KP4VWjUDzFVa2jYlKqQTrtOfLYpPtYnjF0GgWyq5DzICJM3aTwfpechuHb+
        x6bUFy214XKuINqMhS+DKeQxZBPnOVTV+Gm/nBkoCqcI42fUAqK6Vk5xySegDekYCWFp7mIGTWVJg
        Z3c6MnAHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKmWL-0003xk-8S; Thu, 08 Nov 2018 15:47:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94BA920284F98; Thu,  8 Nov 2018 16:46:58 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:46:58 +0100
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
Subject: Re: [PATCH v15 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181108154658.GY9761@hirez.programming.kicks-ass.net>
References: <1541689726-20088-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541689726-20088-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:08:34AM -0500, Waiman Long wrote:
> Waiman Long (12):
>   cpuset: Enable cpuset controller in default hierarchy
>   cpuset: Define data structures to support scheduling partition
>   cpuset: Simply allocation and freeing of cpumasks
>   cpuset: Add new v2 cpuset.sched.partition flag
>   cpuset: Add an error state to cpuset.sched.partition
>   cpuset: Track cpusets that use parent's effective_cpus
>   cpuset: Make CPU hotplug work with partition
>   cpuset: Make generate_sched_domains() work with partition
>   cpuset: Expose cpus.effective and mems.effective on cgroup v2 root
>   cpuset: Use descriptive text when reading/writing
>     cpuset.sched.partition
>   cpuset: Add documentation about the new "cpuset.sched.partition" flag
>   cpuset: Expose cpuset.cpus.subpartitions with cgroup_debug
> 
>  Documentation/admin-guide/cgroup-v2.rst | 182 +++++-
>  include/linux/cgroup-defs.h             |   1 +
>  kernel/cgroup/cgroup-internal.h         |   2 +
>  kernel/cgroup/cgroup.c                  |  14 +-
>  kernel/cgroup/cpuset.c                  | 942 +++++++++++++++++++++++++++++---
>  kernel/cgroup/debug.c                   |   4 +-
>  6 files changed, 1070 insertions(+), 75 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Waiman!
