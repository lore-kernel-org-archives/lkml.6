Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC611C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6332320645
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6332320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKUK0Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:26:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:44107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKUK0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:26:24 -0500
Received: from [98.118.28.103] ([98.118.28.103]) by
 msvc-mesg-gmx023.server.lan (via HTTP); Wed, 21 Nov 2018 00:54:21 +0100
MIME-Version: 1.0
Message-ID: <trinity-ce6c61be-cc03-4a9d-8f26-562694d048da-1542758061535@msvc-mesg-gmx023>
From:   "Qian Cai" <cai@gmx.us>
To:     "Waiman Long" <longman@redhat.com>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        arnd@arndb.de
Subject: Re: [PATCH v3] debugobjects: scale the static pool size
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 21 Nov 2018 00:54:21 +0100
In-Reply-To: <e286be8a-7f0a-65ab-0275-15abcd33eb07@redhat.com>
References: <20181120201432.2163-1-cai@gmx.us>
 <20181120232810.2503-1-cai@gmx.us>
 <e286be8a-7f0a-65ab-0275-15abcd33eb07@redhat.com>
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Yh8sHmUuIgZBnQjRZxoMr2hLVK5qzqlGCebz6+TpJ4RipbFMR0AhXZ+kLocNDZKCgAZhj
 kaJWBPDEgE4MaJUCyYjfHAv9Yj+3GLSY5hkJe4P4+SFGKQb7Kv8x02E0imkSIv2iSdszSGPt7m1O
 5ewJVh+SCrRdug6S3s126CtWCntiF8CS+xbsyQp7N3skCDjoIO8MI4kyTju1NOMDiYZL6LMoaxJS
 KlEsB5uroOH14AJprpMGAMdPQJJOB2cm4yvf1shp5bmJ+nK8OZlMa98RjQ13b9ed1yyrRqA33dR1
 OJ0ErHgyZQ05JJM20YsPA+d
X-UI-Out-Filterresults: notjunk:1;V01:K0:Im5exJ9Hq+E=:Ted2bXWw4VdLekAPy59g/m
 C64PdhreSIVUGGEo55Z1zU85EKNsp4Cw2p8asjxWQ0eXtSYqF7yFqwOfOoRuSAMajojJnMn3x
 DKpj/sO/3ffnOCVwkwuD+xkiNpAxRTAYSk9yBcJtHINxD1tfprHaW8sJJZa05uWGVVddUifhb
 Y68jorSDq38A8EovqEOX2UEGHZ0T+RtFVNH1NI8yHwQkr80dlrdD5OZEzkUBV4tUV3RXuCVmi
 WqEHqHvgVsqNV5VYP4T8GXqVUXBDUGI/VthI2/eQUwP8jza2Hotk7L/SEeBJW5C53mxi/lbYS
 tiOZ4xtuKWAAg7uwPqeULtogUk6EOK91YL9ZVaNqlW1ZPKYAZDpwJeik9+zllc5Jzjn/CnUj+
 BgvAEFS/SDGAC3SQfuTsHQv4vaEo/MU7MAj5dPiLfKhQv0I4YPKCmmHTpdzbPw2k2SX1/747/
 6zY5nNGkymUpSj8ui+GbYOxMAYrFMFlfBsPyH4D+RHMeju99YYGLixJMrrjwELZY5rsaks0l2
 5l+BmgGpWW0jeNVzvW04amkyUEF5oFcDqPKK2Tyg4u6Epg4mA++i9b911OAAVM8/OyZfXPyNk
 aYzqNSB1/5n1VUf6PTreYh6AFIQOWYeuLa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 at 6:38 PM, Waiman Long wrote:

> On 11/20/2018 06:28 PM, Qian Cai wrote:
> > The current value of the early boot static pool size is not big enough
> > for systems with large number of CPUs with timer or/and workqueue
> > objects selected. As the results, systems have 60+ CPUs with both timer
> > and workqueue objects enabled could trigger "ODEBUG: Out of memory.
> > ODEBUG disabled". Hence, fixed it by computing it according to
> > CONFIG_NR_CPUS and CONFIG_DEBUG_OBJECTS_* options.
> >
> > Signed-off-by: Qian Cai <cai@gmx.us>
> > ---
> > Changes since v2:
> > * Made the calculation easier to read suggested by longman@redhat.com.
> >
> > Changes since v1:
> > * Removed the CONFIG_NR_CPUS check since it is always defined.
> > * Introduced a minimal default pool size to start with. Otherwise, the pool
> >   size would be too low for systems only with a small number of CPUs.
> > * Adjusted the scale factors according to data.
> >
> >  lib/debugobjects.c | 82 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 80 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> > index 70935ed91125..02456a1e57cb 100644
> > --- a/lib/debugobjects.c
> > +++ b/lib/debugobjects.c
> > @@ -23,9 +23,82 @@
> >  #define ODEBUG_HASH_BITS	14
> >  #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
> >  
> > -#define ODEBUG_POOL_SIZE	1024
> > +#define ODEBUG_DEFAULT_POOL	512
> >  #define ODEBUG_POOL_MIN_LEVEL	256
> >  
> > +/*
> > + * Some debug objects are allocated during the early boot. Enabling some
> > + * options like timers or workqueue objects may increase the size required
> > + * significantly with large number of CPUs. For example (as today, 20 Nov.
> > + * 2018),
> > + *
> > + * No. CPUs x 2 (worker pool) objects:
> > + *
> > + * start_kernel
> > + *   workqueue_init_early
> > + *     init_worker_pool
> > + *       init_timer_key
> > + *         debug_object_init
> > + *
> > + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
> > + *
> > + * sched_init
> > + *   hrtick_rq_init
> > + *     hrtimer_init
> > + *
> > + * CONFIG_DEBUG_OBJECTS_WORK:
> > + * No. CPUs x 6 (workqueue) objects:
> > + *
> > + * workqueue_init_early
> > + *   alloc_workqueue
> > + *     __alloc_workqueue_key
> > + *       alloc_and_link_pwqs
> > + *         init_pwq
> > + *
> > + * Also, plus No. CPUs objects:
> > + *
> > + * perf_event_init
> > + *    __init_srcu_struct
> > + *      init_srcu_struct_fields
> > + *        init_srcu_struct_nodes
> > + *          __init_work
> > + *
> > + * Increase the number a bit more in case the implmentatins are changed in
> > + * the future, as it is better to avoid OOM than spending a bit more kernel
> > + * memory that will/can be freed.
> > + *
> > + * With all debug objects config options selected except the workqueue and
> > + * the timers, kernel reports,
> > + * 64-CPU:  ODEBUG: 4 of 4 active objects replaced
> > + * 256-CPU: ODEBUG: 4 of 4 active objects replaced
> > + *
> > + * all the options except the workqueue:
> > + * 64-CPU:  ODEBUG: 466 of 466 active objects replaced
> > + * 256-CPU: ODEBUG: 1810 of 1810 active objects replaced
> > + *
> > + * all the options except the timers:
> > + * 64-CPU:  ODEBUG: 652 of 652 active objects replaced
> > + * 256-CPU: ODEBUG: 2572 of 2572 active objects replaced
> > + *
> > + * all the options:
> > + * 64-CPU:  ODEBUG: 1114 of 1114 active objects replaced
> > + * 256-CPU: ODEBUG: 4378 of 4378 active objects replaced
> > + */
> > +#ifdef CONFIG_DEBUG_OBJECTS_WORK
> > +#define ODEBUG_WORK_PCPU_CNT	10
> > +#else
> > +#define ODEBUG_WORK_PCPU_CNT	0
> > +#endif /* CONFIG_DEBUG_OBJECTS_WORK */
> > +
> > +#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
> > +#define ODEBUG_TIMERS_PCPU_CNT	10
> > +#else
> > +#define ODEBUG_TIMERS_PCPU_CNT	0
> > +#endif /* CONFIG_DEBUG_OBJECTS_TIMERS */
> > +
> > +#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * \
> > +(ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))
> 
> Just a nit about indentation. There should be some indentation in the
> continued line.

I am fine to add that, but checkpatch.pl complained
that there should no spaces at the beginning of a
newline. Guess we just ignore the warning?

“please, no spaces at the start of a line”
