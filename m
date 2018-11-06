Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FF0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A132C20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Py1yXs5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A132C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeKFSNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:13:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeKFSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZtGlg4SEax+LLpOCtbpP3UFflBhBGrANW2SLc/OYBKs=; b=Py1yXs5qWcZ9ibf5IsDIZubx9
        92U/ksfz4MEStGOvWZOfNWd4Ea2w2tUm5o1dlCKNeBE91nh9TfodPiNqMm0RZ/9ec8gi9XtB5vUzZ
        Lz2NUq/glLJ4+Wp5dPCA3kh5i5QmpTHl5MZz6DG4yWErPBvb3E45F204aop5NuI1DjI6m/8DFKn3q
        Hl556k4M4I9vyGlwOWClofkxK0rvW1ykogW3SxWiGxHJswyt7rMcj46RU27mB/AfDU6MLmdnAm/Kz
        fmttpxNQdewssH8ipRWEUUeG7efutv4Bn+Pu6OSGM3MVkP/DOqqW7OVGiqZxPMAZ4jJpQD3Gu6KRu
        qnuSHbMXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJx2u-0006fz-KW; Tue, 06 Nov 2018 08:49:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18F8A2029F9FF; Tue,  6 Nov 2018 09:49:11 +0100 (CET)
Date:   Tue, 6 Nov 2018 09:49:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181106084911.GA22504@hirez.programming.kicks-ass.net>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105165558.11698-2-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 11:55:46AM -0500, Daniel Jordan wrote:
> +Concept
> +=======
> +
> +ktask is built on unbound workqueues to take advantage of the thread management
> +facilities it provides: creation, destruction, flushing, priority setting, and
> +NUMA affinity.
> +
> +A little terminology up front:  A 'task' is the total work there is to do and a
> +'chunk' is a unit of work given to a thread.

So I hate on the task naming. We already have a task, lets not overload
that name.

> +To complete a task using the ktask framework, a client provides a thread
> +function that is responsible for completing one chunk.  The thread function is
> +defined in a standard way, with start and end arguments that delimit the chunk
> +as well as an argument that the client uses to pass data specific to the task.
> +
> +In addition, the client supplies an object representing the start of the task
> +and an iterator function that knows how to advance some number of units in the
> +task to yield another object representing the new task position.  The framework
> +uses the start object and iterator internally to divide the task into chunks.
> +
> +Finally, the client passes the total task size and a minimum chunk size to
> +indicate the minimum amount of work that's appropriate to do in one chunk.  The
> +sizes are given in task-specific units (e.g. pages, inodes, bytes).  The
> +framework uses these sizes, along with the number of online CPUs and an
> +internal maximum number of threads, to decide how many threads to start and how
> +many chunks to divide the task into.
> +
> +For example, consider the task of clearing a gigantic page.  This used to be
> +done in a single thread with a for loop that calls a page clearing function for
> +each constituent base page.  To parallelize with ktask, the client first moves
> +the for loop to the thread function, adapting it to operate on the range passed
> +to the function.  In this simple case, the thread function's start and end
> +arguments are just addresses delimiting the portion of the gigantic page to
> +clear.  Then, where the for loop used to be, the client calls into ktask with
> +the start address of the gigantic page, the total size of the gigantic page,
> +and the thread function.  Internally, ktask will divide the address range into
> +an appropriate number of chunks and start an appropriate number of threads to
> +complete these chunks.

I see no mention of padata anywhere; I also don't see mention of the
async init stuff. Both appear to me to share, at least in part, the same
reason for existence.

> +Scheduler Interaction
> +=====================
> +
> +Even within the resource limits, ktask must take care to run a number of
> +threads appropriate for the system's current CPU load.  Under high CPU usage,
> +starting excessive helper threads may disturb other tasks, unfairly taking CPU
> +time away from them for the sake of an optimized kernel code path.
> +
> +ktask plays nicely in this case by setting helper threads to the lowest
> +scheduling priority on the system (MAX_NICE).  This way, helpers' CPU time is
> +appropriately throttled on a busy system and other tasks are not disturbed.
> +
> +The main thread initiating the task remains at its original priority so that it
> +still makes progress on a busy system.
> +
> +It is possible for a helper thread to start running and then be forced off-CPU
> +by a higher priority thread.  With the helper's CPU time curtailed by MAX_NICE,
> +the main thread may wait longer for the task to finish than it would have had
> +it not started any helpers, so to ensure forward progress at a single-threaded
> +pace, once the main thread is finished with all outstanding work in the task,
> +the main thread wills its priority to one helper thread at a time.  At least
> +one thread will then always be running at the priority of the calling thread.

What isn't clear is if this calling thread is waiting or not. Only do
this inheritance trick if it is actually waiting on the work. If it is
not, nobody cares.

> +Cgroup Awareness
> +================
> +
> +Given the potentially large amount of CPU time ktask threads may consume, they
> +should be aware of the cgroup of the task that called into ktask and
> +appropriately throttled.
> +
> +TODO: Implement cgroup-awareness in unbound workqueues.

Yes.. that needs done.

> +Power Management
> +================
> +
> +Starting additional helper threads may cause the system to consume more energy,
> +which is undesirable on energy-conscious devices.  Therefore ktask needs to be
> +aware of cpufreq policies and scaling governors.
> +
> +If an energy-conscious policy is in use (e.g. powersave, conservative) on any
> +part of the system, that is a signal that the user has strong power management
> +preferences, in which case ktask is disabled.
> +
> +TODO: Implement this.

No, don't do that, its broken. Also, we're trying to move to a single
cpufreq governor for all.

Sure we'll retain 'performance', but powersave and conservative and all
that nonsense should go away eventually.

That's not saying you don't need a knob for this; but don't look at
cpufreq for this.

