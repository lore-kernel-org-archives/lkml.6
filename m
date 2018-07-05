Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9483BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F4324024
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F4324024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeGEM0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:26:14 -0400
Received: from foss.arm.com ([217.140.101.70]:48856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753777AbeGEM0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:26:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7DD7A9;
        Thu,  5 Jul 2018 05:26:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11F6A3F2EA;
        Thu,  5 Jul 2018 05:26:10 -0700 (PDT)
Date:   Thu, 5 Jul 2018 13:26:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tobias Tefke <tobias.tefke@gmail.com>
Cc:     tobias.tefke@tutanota.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: events: use correct articles in comments
Message-ID: <20180705122608.h7j5wo7wd4ndw2jm@lakrids.cambridge.arm.com>
References: <20180705112756.1663-1-tobias.tefke@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705112756.1663-1-tobias.tefke@tutanota.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 01:27:56PM +0200, Tobias Tefke wrote:
> These words are pronounced (and start) with a vowel sound.
> Therefore the article we use has to be 'an' instead of 'a'.
> 
> Signed-off-by: Tobias Tefke <tobias.tefke@tutanota.com>

To clarify Alexander's reply, there's some guidance on writing commit
messages in section 2 of:

Documentation/process/submitting-patches.rst

The basic idea is that the commit message should make sense on its own,
even if you can't see the diff. Describe the problem first, any
caveats, then the solution taken (in the imperative tense).

e.g. the above could be:

----
Some of the comments in the kernel events code use articles incorrectly,
'a' for words beginning with a vowel sound, where 'an' should be used.
This is somewhat jarring for native speakers reading the comments.

Fix these comments to use 'an' appropriately.
----

The diff looks sound, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  kernel/events/core.c    | 16 ++++++++--------
>  kernel/events/uprobes.c |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 323fab1e512d..95dc7278d8c7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1656,7 +1656,7 @@ perf_event_groups_next(struct perf_event *event)
>  				typeof(*event), group_node))
>  
>  /*
> - * Add a event from the lists for its context.
> + * Add an event from the lists for its context.
>   * Must be called with ctx->mutex and ctx->lock held.
>   */
>  static void
> @@ -1844,7 +1844,7 @@ static void perf_group_attach(struct perf_event *event)
>  }
>  
>  /*
> - * Remove a event from the lists for its context.
> + * Remove an event from the lists for its context.
>   * Must be called with ctx->mutex and ctx->lock held.
>   */
>  static void
> @@ -2148,7 +2148,7 @@ static void __perf_event_disable(struct perf_event *event,
>  }
>  
>  /*
> - * Disable a event.
> + * Disable an event.
>   *
>   * If event->ctx is a cloned context, callers must make sure that
>   * every task struct that event->ctx->task could possibly point to
> @@ -2677,7 +2677,7 @@ static void __perf_event_enable(struct perf_event *event,
>  }
>  
>  /*
> - * Enable a event.
> + * Enable an event.
>   *
>   * If event->ctx is a cloned context, callers must make sure that
>   * every task struct that event->ctx->task could possibly point to
> @@ -2755,7 +2755,7 @@ static int __perf_event_stop(void *info)
>  	 * events will refuse to restart because of rb::aux_mmap_count==0,
>  	 * see comments in perf_aux_output_begin().
>  	 *
> -	 * Since this is happening on a event-local CPU, no trace is lost
> +	 * Since this is happening on an event-local CPU, no trace is lost
>  	 * while restarting.
>  	 */
>  	if (sd->restart)
> @@ -4827,7 +4827,7 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
>  	int ret;
>  
>  	/*
> -	 * Return end-of-file for a read on a event that is in
> +	 * Return end-of-file for a read on an event that is in
>  	 * error state (i.e. because it was pinned but it couldn't be
>  	 * scheduled on to the CPU at some point).
>  	 */
> @@ -9898,7 +9898,7 @@ static void account_event(struct perf_event *event)
>  }
>  
>  /*
> - * Allocate and initialize a event structure
> + * Allocate and initialize an event structure
>   */
>  static struct perf_event *
>  perf_event_alloc(struct perf_event_attr *attr, int cpu,
> @@ -11229,7 +11229,7 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
>  }
>  
>  /*
> - * Inherit a event from parent task to child task.
> + * Inherit an event from parent task to child task.
>   *
>   * Returns:
>   *  - valid pointer on success
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ccc579a7d32e..aed1ba569954 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -918,7 +918,7 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
>  EXPORT_SYMBOL_GPL(uprobe_register);
>  
>  /*
> - * uprobe_apply - unregister a already registered probe.
> + * uprobe_apply - unregister an already registered probe.
>   * @inode: the file in which the probe has to be removed.
>   * @offset: offset from the start of the file.
>   * @uc: consumer which wants to add more or remove some breakpoints
> @@ -947,7 +947,7 @@ int uprobe_apply(struct inode *inode, loff_t offset,
>  }
>  
>  /*
> - * uprobe_unregister - unregister a already registered probe.
> + * uprobe_unregister - unregister an already registered probe.
>   * @inode: the file in which the probe has to be removed.
>   * @offset: offset from the start of the file.
>   * @uc: identify which probe if multiple probes are colocated.
> @@ -1403,7 +1403,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri)
>  
>  /*
>   * Called with no locks held.
> - * Called in context of a exiting or a exec-ing thread.
> + * Called in context of an exiting or an exec-ing thread.
>   */
>  void uprobe_free_utask(struct task_struct *t)
>  {
> -- 
> 2.18.0
> 
