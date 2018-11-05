Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95593C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B852084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wled1MLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B852084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbeKFGlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:41:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45190 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EpWhBZ5QUIfyFnhOfLb4oY9WoQnu74A9fHyyejaAuh0=; b=wled1MLKtuR18jWE+dv7jHiDD9
        OH28qjRNladc2rP6HgQC4VMzn7W5Yh8z5UbY8cR9GGbBUjlGb797ZBBo5+VwlvPXxS3DF4pyMSvwE
        H9naExW4ruiVBxwxk0En3GEUbEAFJx9t6bPg6dhfKaPNzGA5XZ6rurcD36VUh4HR7hd1GkDMW5eXv
        LGWgT+O5DsCj8wFyy2e1UZimIhZrXv73+be3sFbTOCsNDS0OiQHtgs76HA/8QH/JrtQ9Mr20a+BJE
        AjGV+o33gfWxQwj0D+7RjXWTCeSuBkG8Q8DR408e5SqDSHO75zSGKapjlTuv+ty4sjm7BcDBIAWlq
        6MVYFywQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJmHp-00013Y-9q; Mon, 05 Nov 2018 21:19:53 +0000
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
To:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7693f8a2-e180-520a-0d07-cc3090d2139f@infradead.org>
Date:   Mon, 5 Nov 2018 13:19:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105165558.11698-2-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 8:55 AM, Daniel Jordan wrote:
> Motivates and explains the ktask API for kernel clients.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
>  Documentation/core-api/index.rst |   1 +
>  Documentation/core-api/ktask.rst | 213 +++++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
>  create mode 100644 Documentation/core-api/ktask.rst

Hi,

> diff --git a/Documentation/core-api/ktask.rst b/Documentation/core-api/ktask.rst
> new file mode 100644
> index 000000000000..c3c00e1f802f
> --- /dev/null
> +++ b/Documentation/core-api/ktask.rst
> @@ -0,0 +1,213 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +============================================
> +ktask: parallelize CPU-intensive kernel work
> +============================================
> +
> +:Date: November, 2018
> +:Author: Daniel Jordan <daniel.m.jordan@oracle.com>
> +
> +
> +Introduction
> +============

[snip]


> +Resource Limits
> +===============
> +
> +ktask has resource limits on the number of work items it sends to workqueue.

                                                                  to a workqueue.
or:                                                               to workqueues.

> +In ktask, a workqueue item is a thread that runs chunks of the task until the
> +task is finished.
> +
> +These limits support the different ways ktask uses workqueues:
> + - ktask_run to run threads on the calling thread's node.
> + - ktask_run_numa to run threads on the node(s) specified.
> + - ktask_run_numa with nid=NUMA_NO_NODE to run threads on any node in the
> +   system.
> +
> +To support these different ways of queueing work while maintaining an efficient
> +concurrency level, we need both system-wide and per-node limits on the number

I would prefer to refer to ktask as ktask instead of "we", so
s/we need/ktask needs/


> +of threads.  Without per-node limits, a node might become oversubscribed
> +despite ktask staying within the system-wide limit, and without a system-wide
> +limit, we can't properly account for work that can run on any node.

s/we/ktask/

> +
> +The system-wide limit is based on the total number of CPUs, and the per-node
> +limit on the CPU count for each node.  A per-node work item counts against the
> +system-wide limit.  Workqueue's max_active can't accommodate both types of
> +limit, no matter how many workqueues are used, so ktask implements its own.
> +
> +If a per-node limit is reached, the work item is allowed to run anywhere on the
> +machine to avoid overwhelming the node.  If the global limit is also reached,
> +ktask won't queue additional work items until we fall below the limit again.

s/we fall/ktask falls/
or s/we fall/it falls/

> +
> +These limits apply only to workqueue items--that is, helper threads beyond the
> +one starting the task.  That way, one thread per task is always allowed to run.


thanks.
-- 
~Randy
