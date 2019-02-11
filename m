Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB92222A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892734;
	bh=rBvQLWBQkjPGCmqtIwneGZmTxEQVsIFEHnPEzscPeaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVUy/BhhSk3DbTbrLkZ1FXT0dOX/mL2BCd1eVL4tZ8/IXces+TrBRWOAn4vXPJSFP
	 YLs8iSgAICNTiJUXuizpqUb6pxaq07gh/SXveC4V+JzDgJpRH2XqLPzJQ6EFT5noJd
	 +pe353hlQn7N6/sDAVravlhqCtVpb1QkPPhB59G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfBKNpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:45:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37392 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfBKNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:45:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so11925977wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQ7WC4iZI0fH6JBvX0aLtoUPVjSMED/F+NlHmiD49ko=;
        b=LT2qr0qIXv6/ktARX7i5PMn65EkcaKQc7yZn0FRAwk+kJ1MXNtu9RJtyQSqw4+OV91
         A7/G8jcvl+0aCIZ6SRtNHm+Y3YhUgXgg3ZRhZkOQ8L0UzLIaB/Q0cpydGucC5S4G61HZ
         Eaj7DmNd3Ky+P3ZUITc6JMvXRDrlZHgItB2rXCk0JXNArVsji9Tr7CUW3j3yp70awD1H
         qN+WqTJclwt8bqWGb4jmKkWtaUen3Qt/U/Z0lghIbV+0olOWrDErdVcwhEokC4BXtG5G
         y/pB4sMZbfbw52un5PrytcB7m5+OP0nLtT8BtWA5OynIfOXxUyn6ADNy2gVEnAxrb93O
         l9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQ7WC4iZI0fH6JBvX0aLtoUPVjSMED/F+NlHmiD49ko=;
        b=mpIxTlaTo2BWK264hvKxO0TzHl8lt5fVw0vLzu4AHVX8KoUa5jbZIrcnnSRCtKd9XP
         DhgBWLSk0jZBOg4kAyJh6Fsl2bHqp5F8zSkhH9hMUd2/DViTbEg1G9lQC2eqsvJIhOAm
         5ktzEoIy2G+GwgiRkBmtuiaiPkYnsn++lbylO650PoG0GlWXJJFkHge/2Ks65MoS+GQw
         BDm/PSurgXtqfSLSVXrx0AoKDjXi/R3oXKVtfW/GuwcLWuY+iLSt6pYdMmKXa4HuACHz
         2X6LQ3n6WLzFN6OXBhzoyn1O4qss6WYP0UoOkeLGasTBUMUcHkqHvHVFgUQTgXrRkwTc
         KMvw==
X-Gm-Message-State: AHQUAub5ulWAXhVAevTRC21F7XCYS6JPdx7YnYkOgMORVkHJO3RZXVPi
        U+8XvU5CxiV95IfWGTlYeEw=
X-Google-Smtp-Source: AHgI3IbblIEnoeWnYPSuxq6O3lsra7nrKFC/Q9SUJ1OItngkkqSK64xtlcDyecdSSnNKKGnkytztcQ==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr5450747wma.114.1549892730345;
        Mon, 11 Feb 2019 05:45:30 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y1sm13560363wru.4.2019.02.11.05.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 05:45:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:45:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190211134527.GA121589@gmail.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Julien Thierry <julien.thierry@arm.com> wrote:

> While running a user_access regions, it is not supported to reschedule.
> Add an overridable primitive to indicate whether a user_access region is
> active and check that this is not the case when calling rescheduling
> functions.
> 
> These checks are only performed when DEBUG_UACCESS_SLEEP is selected.
> 
> Also, add a comment clarifying the behaviour of user_access regions.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> ---
>  include/linux/kernel.h  | 11 +++++++++--
>  include/linux/uaccess.h | 13 +++++++++++++
>  kernel/sched/core.c     | 22 ++++++++++++++++++++++
>  lib/Kconfig.debug       |  8 ++++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 8f0e68e..73f1f82 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -237,11 +237,18 @@
>  struct pt_regs;
>  struct user;
> 
> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> +extern void __might_resched(const char *file, int line);
> +#else
> +#define __might_resched(file, line) do { } while (0)
> +#endif
> +
>  #ifdef CONFIG_PREEMPT_VOLUNTARY
>  extern int _cond_resched(void);
> -# define might_resched() _cond_resched()
> +# define might_resched() \
> +	do { __might_resched(__FILE__, __LINE__); _cond_resched(); } while (0)
>  #else
> -# define might_resched() do { } while (0)
> +# define might_resched() __might_resched(__FILE__, __LINE__)
>  #endif
> 
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 37b226e..2c0c39e 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -263,6 +263,15 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  #define probe_kernel_address(addr, retval)		\
>  	probe_kernel_read(&retval, addr, sizeof(retval))
> 
> +/*
> + * user_access_begin() and user_access_end() define a region where
> + * unsafe user accessors can be used. Exceptions and interrupt shall exit the
> + * user_access region and re-enter it when returning to the interrupted context.
> + *
> + * No sleeping function should get called during a user_access region - we rely
> + * on exception handling to take care of the user_access status for us, but that
> + * doesn't happen when directly calling schedule().
> + */
>  #ifndef user_access_begin
>  #define user_access_begin(ptr,len) access_ok(ptr, len)
>  #define user_access_end() do { } while (0)
> @@ -270,6 +279,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
>  #endif
> 
> +#ifndef unsafe_user_region_active
> +#define unsafe_user_region_active()	false
> +#endif
> +
>  #ifdef CONFIG_HARDENED_USERCOPY
>  void usercopy_warn(const char *name, const char *detail, bool to_user,
>  		   unsigned long offset, unsigned long len);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a674c7db..b1bb7e9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
>  		__schedule_bug(prev);
>  		preempt_count_set(PREEMPT_DISABLED);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> +	    unlikely(unsafe_user_region_active())) {
> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> +		       prev->comm, prev->pid, preempt_count());
> +		dump_stack();
> +	}
> +
>  	rcu_sleep_check();
> 
>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  EXPORT_SYMBOL(___might_sleep);
>  #endif
> 
> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> +void __might_resched(const char *file, int line)
> +{
> +	if (!unsafe_user_region_active())
> +		return;

Could you please more clearly explain why you want/need an exception from 
the __might_resched() debug warning?

Thanks,

	Ingo
