Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81520C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5B824748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+57sY+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5B824748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGBVFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:05:48 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35859 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbeGBVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:05:44 -0400
Received: by mail-yw0-f196.google.com with SMTP id t198-v6so7155974ywc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TgR1wPJpNuxWalOIbefskoEqMomVcfO6gB6fuvGW/cA=;
        b=U+57sY+JAmX5j8AAre72JC7IwPZ88loqowsdMRsMztnI0Zn4LkRXCMQxa37kao6mmi
         hDn4OX0mq7yUHNaLnNWd8lQUN5lE/239kZIdpqbey8USI+vO/NkGp9EuOLwWvjkXf4Ib
         E/HzPWV9iav+jWnp2Qb3Zw0C3qHKEYI6XjyWqPtHRyNG6PdDknbCtjTqjYo51vvi9TYq
         DllASpExIbTAz1eJhwPIhxA9xgLlhU1ZdmLz02//ByXpzUQo1IEWh/Yl5Q9fgixFN4sp
         1b9FC62HBVkG/xfOgUX3RN0gRGaOYE8daWIWCMKTbgI6TmobcYln696Tpcv+YFiIGvev
         I85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TgR1wPJpNuxWalOIbefskoEqMomVcfO6gB6fuvGW/cA=;
        b=tM+w05kdelcyEZ8YNNhG/RecuIaI+ryByHWQQ3DBzXhwpX7UeqJ1bNCkms9+maWmrt
         ryXZg/Cm7NAmp1wnc+V2MlywnmiKd05okSWgLTnd+OGCrQujGUHOcLOr4Lmh3yGQ5BOJ
         GmNm4dp+MRjPLFMfF8+VNIoKQJR35boqJrIvT+Zuv4xIgibi/XgcFrNAY1VOWcIE+e8y
         NXiCUc9uYZvVagj3HUlMCxRPH8tP3uuJZV7Ji9C4BXyJL5lqLgo7NuN8nmE3f9oKLMrZ
         DQwpDqZGcdazFe+lXddaMtybqr4g+bZ43aojPx/kb+tDWjOXH2Bx1vBJLoHqRKUEQByz
         dvwQ==
X-Gm-Message-State: APt69E0+9WGlNcoWsQBMHiyxqpFvso/Efg1390ALI22OzXGICzSeNRvN
        pb8dnmHD+P9zG0dmpKyBvF0=
X-Google-Smtp-Source: AAOMgpcaDWqDR4gLmxEyH07tSlB8kfgg0djLuIgaXnSy9Zg5ysOGjDlfpedOFiB1bGhrznfqM8Ri8Q==
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr215211ywk.74.1530565542534;
        Mon, 02 Jul 2018 14:05:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id k6-v6sm7774514ywl.42.2018.07.02.14.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:05:41 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:05:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE() in process_one_work()?
Message-ID: <20180702210540.GL533219@devbig577.frc2.facebook.com>
References: <20180620192901.GA9956@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620192901.GA9956@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul.

Sorry about the late reply.

On Wed, Jun 20, 2018 at 12:29:01PM -0700, Paul E. McKenney wrote:
> I have hit this WARN_ON_ONCE() in process_one_work:
> 
> 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> 		     raw_smp_processor_id() != pool->cpu);
> 
> This looks like it is my rcu_gp workqueue (see splat below), and it
> appears to be intermittent.  This happens on rcutorture scenario SRCU-N,
> which does random CPU-hotplug operations (in case that helps).
> 
> Is this related to the recent addition of WQ_MEM_RECLAIM?  Either way,
> what should I do to further debug this?

Hmm... I checked the code paths but couldn't spot anything suspicious.
Can you please apply the following patch and see whether it triggers
before hitting the warn and if so report what it says?

Thanks.

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938fbb23..81caab9643b2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -79,6 +79,15 @@ static struct lockdep_map cpuhp_state_up_map =
 static struct lockdep_map cpuhp_state_down_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-down", &cpuhp_state_down_map);
 
+int cpuhp_current_state(int cpu)
+{
+	return per_cpu_ptr(&cpuhp_state, cpu)->state;
+}
+
+int cpuhp_target_state(int cpu)
+{
+	return per_cpu_ptr(&cpuhp_state, cpu)->target;
+}
 
 static inline void cpuhp_lock_acquire(bool bringup)
 {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78b192071ef7..365cf6342808 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1712,6 +1712,9 @@ static struct worker *alloc_worker(int node)
 	return worker;
 }
 
+int cpuhp_current_state(int cpu);
+int cpuhp_target_state(int cpu);
+
 /**
  * worker_attach_to_pool() - attach a worker to a pool
  * @worker: worker to be attached
@@ -1724,13 +1727,20 @@ static struct worker *alloc_worker(int node)
 static void worker_attach_to_pool(struct worker *worker,
 				   struct worker_pool *pool)
 {
+	int ret;
+
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
 	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
 	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
 	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	ret = set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	if (ret && pool->cpu >= 0 && worker->rescue_wq)
+		printk("XXX rescuer failed to attach: ret=%d pool=%d this_cpu=%d target_cpu=%d cpuhp_state=%d chuhp_target=%d\n",
+		       ret, pool->id, raw_smp_processor_id(), pool->cpu,
+		       cpuhp_current_state(pool->cpu),
+		       cpuhp_target_state(pool->cpu));
 
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
