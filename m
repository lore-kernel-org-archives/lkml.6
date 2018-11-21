Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B682146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B682146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeKVBUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:20:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeKVBUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:20:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4385C3082139;
        Wed, 21 Nov 2018 14:45:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E5D5413F;
        Wed, 21 Nov 2018 14:45:37 +0000 (UTC)
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
To:     Qian Cai <cai@gmx.us>, akpm@linux-foundation.org,
        tglx@linutronix.de
Cc:     yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20181120232810.2503-1-cai@gmx.us>
 <20181121021157.3061-1-cai@gmx.us>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <04159ff2-fe5d-333b-3714-f991909ed463@redhat.com>
Date:   Wed, 21 Nov 2018 09:45:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121021157.3061-1-cai@gmx.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 21 Nov 2018 14:45:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 09:11 PM, Qian Cai wrote:
> The current value of the early boot static pool size is not big enough
> for systems with large number of CPUs with timer or/and workqueue
> objects selected. As the results, systems have 60+ CPUs with both timer
> and workqueue objects enabled could trigger "ODEBUG: Out of memory.
> ODEBUG disabled". Hence, fixed it by computing it according to
> CONFIG_NR_CPUS and CONFIG_DEBUG_OBJECTS_* options.
>
> Signed-off-by: Qian Cai <cai@gmx.us>
> ---
>
> Changes since v3:
> * style fixes
>
> Changes since v2:
> * Made the calculation easier to read suggested by longman@redhat.com.
>
> Changes since v1:
> * Removed the CONFIG_NR_CPUS check since it is always defined.
> * Introduced a minimal default pool size to start with. Otherwise, the pool
>   size would be too low for systems only with a small number of CPUs.
> * Adjusted the scale factors according to data.
>
>  lib/debugobjects.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 70935ed91125..140571aa483c 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -23,9 +23,81 @@
>  #define ODEBUG_HASH_BITS	14
>  #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
>  
> -#define ODEBUG_POOL_SIZE	1024
> +#define ODEBUG_DEFAULT_POOL	512
>  #define ODEBUG_POOL_MIN_LEVEL	256
>  
> +/*
> + * Some debug objects are allocated during the early boot. Enabling some options
> + * like timers or workqueue objects may increase the size required significantly
> + * with large number of CPUs. For example (as today, 20 Nov. 2018),
> + *
> + * No. CPUs x 2 (worker pool) objects:
> + *
> + * start_kernel
> + *   workqueue_init_early
> + *     init_worker_pool
> + *       init_timer_key
> + *         debug_object_init
> + *
> + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
> + *
> + * sched_init
> + *   hrtick_rq_init
> + *     hrtimer_init
> + *
> + * CONFIG_DEBUG_OBJECTS_WORK:
> + * No. CPUs x 6 (workqueue) objects:
> + *
> + * workqueue_init_early
> + *   alloc_workqueue
> + *     __alloc_workqueue_key
> + *       alloc_and_link_pwqs
> + *         init_pwq
> + *
> + * Also, plus No. CPUs objects:
> + *
> + * perf_event_init
> + *    __init_srcu_struct
> + *      init_srcu_struct_fields
> + *        init_srcu_struct_nodes
> + *          __init_work
> + *
> + * Increase the number a bit more in case the implmentatins are changed in the
> + * future, as it is better to avoid OOM than spending a bit more kernel memory
> + * that will/can be freed.
> + *
> + * With all debug objects config options selected except the workqueue and the
> + * timers, kernel reports,
> + * 64-CPU:  ODEBUG: 4 of 4 active objects replaced
> + * 256-CPU: ODEBUG: 4 of 4 active objects replaced
> + *
> + * all the options except the workqueue:
> + * 64-CPU:  ODEBUG: 466 of 466 active objects replaced
> + * 256-CPU: ODEBUG: 1810 of 1810 active objects replaced
> + *
> + * all the options except the timers:
> + * 64-CPU:  ODEBUG: 652 of 652 active objects replaced
> + * 256-CPU: ODEBUG: 2572 of 2572 active objects replaced
> + *
> + * all the options:
> + * 64-CPU:  ODEBUG: 1114 of 1114 active objects replaced
> + * 256-CPU: ODEBUG: 4378 of 4378 active objects replaced
> + */
> +#ifdef CONFIG_DEBUG_OBJECTS_WORK
> +#define ODEBUG_WORK_PCPU_CNT	10
> +#else
> +#define ODEBUG_WORK_PCPU_CNT	0
> +#endif /* CONFIG_DEBUG_OBJECTS_WORK */
> +
> +#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
> +#define ODEBUG_TIMERS_PCPU_CNT	10
> +#else
> +#define ODEBUG_TIMERS_PCPU_CNT	0
> +#endif /* CONFIG_DEBUG_OBJECTS_TIMERS */
> +
> +#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * \
> +				(ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))
> +
>  #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
>  #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
>  #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
> @@ -58,8 +130,13 @@ static int			debug_objects_fixups __read_mostly;
>  static int			debug_objects_warnings __read_mostly;
>  static int			debug_objects_enabled __read_mostly
>  				= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
> +/*
> + * This is only used after replaced static objects, so no need to scale it to
> + * use the early boot static pool size and it has already been scaled according
> + * to actual No. CPUs in the box within debug_objects_mem_init().
> + */
>  static int			debug_objects_pool_size __read_mostly
> -				= ODEBUG_POOL_SIZE;
> +				= ODEBUG_DEFAULT_POOL;
>  static int			debug_objects_pool_min_level __read_mostly
>  				= ODEBUG_POOL_MIN_LEVEL;
>  static struct debug_obj_descr	*descr_test  __read_mostly;

Acked-by: Waiman Long <longman@redhat.com>

