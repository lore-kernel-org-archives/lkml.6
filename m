Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399872086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjZvmiHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfALEFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 23:05:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43759 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfALEFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 23:05:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so7848791pfk.10;
        Fri, 11 Jan 2019 20:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHL2KuRAkECnHXOLptHd4M/L9NgINZ27nYWV6gTR1KQ=;
        b=rjZvmiHM2ZNj+jiu3m4jAtKgbIxAFPmvBhHk249rifaUofkLymF/t6ODySmBw8BiBH
         aK8G5oUuHISr/qmsTo3nHH1RGVRqyggZjik/e5L2vlir/Iy4hEf1OmOpuRNSi8YApTDj
         rHjOt6Iu7mAm4rKfy2LiEc1Ivc0eRoA4b0OYZ6ZSjM7R8rXSPbfCvKxqcQ8eWECawh+S
         UKPv2gZoxgsQyA0x0pAuKkzaTMe/isjzxEqAGYisEUXSnf/GPOYkm7+9ckXcuhcNYjsL
         0DJvv7oQ6/dBG93RsQQyK/0mezJmHk2xSBrtrh5i5QD2U3FqyneeMMYoZGfPzoCj/pOs
         3ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHL2KuRAkECnHXOLptHd4M/L9NgINZ27nYWV6gTR1KQ=;
        b=gn6/RRk8PM3/vI9j+n/OTf7s5m9P8MhGynRUcJa87jYZUftBVYycCwbjzQWvhpJTQS
         AHvbZBi+cGd/nAwIO7MbiQnxZJwpzYXybOdI6wxjnBtLY3xB4XNjjj7U5nwlU3cS61Tk
         UxIEPvW8/9NkzBo6Wd9ctjnGYLpQu7z3gHdw3WCVxobuyXiXmOrVt1mgEl1nvdUf8ffu
         CCeDC9cWSIISsvXIP/wqw6JW4igsJzCEopIJoxMr/tV1lJ2i+0nyOyaBJP++FIzaVVfG
         mWRFh/qbijAfPE0T2T58B2be2ypAl51ivZ2Y7u9cbnHyiB1Kc4O3f+fDzKQTusLjxl5E
         t3jQ==
X-Gm-Message-State: AJcUukcGFrfSS9sz/12hi1P3hP76mO4PZS6nBhCQNHnGihgKqm7RcOL0
        JX3yIuG7tkFKRlRusKftde4=
X-Google-Smtp-Source: ALg8bN7BjYzDWGojWqNU7h2PI6CdeYfNYvsxcG+vLEGZsUheDFrW5CfA/+Jxj6ftZ6tPkeD9HIcdwA==
X-Received: by 2002:a62:8a51:: with SMTP id y78mr17008047pfd.35.1547265940834;
        Fri, 11 Jan 2019 20:05:40 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id 24sm338911899pfl.32.2019.01.11.20.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 20:05:40 -0800 (PST)
Date:   Sat, 12 Jan 2019 12:05:33 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Improve the latency tracers
Message-ID: <20190112040531.w7wvt5x6ztxb6qcg@mail.google.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190101154614.8887-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven, Have you checked this serias yet? :)

On Tue, Jan 01, 2019 at 11:46:09PM +0800, Changbin Du wrote:
> Happy new year!
> 
> This series make some improments for the kernel latency tracers, especilly
> for the wakeup tracers. The latency tracers will show us more useful
> information. With this series, the wakeup tracers look like this
> when display-graph is enabled:
> 
> # tracer: wakeup
> #
> # wakeup latency trace v1.1.5 on 4.20.0+
> # --------------------------------------------------------------------
> # latency: 593 us, #674/674, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:4)
> #    -----------------
> #    | task: kworker/0:1H-339 (uid:0 nice:-20 policy:0 rt_prio:0)
> #    -----------------
> #
> #                                       _-----=> irqs-off        
> #                                      / _----=> need-resched    
> #                                     | / _---=> hardirq/softirq 
> #                                     || / _--=> preempt-depth   
> #                                     ||| /                      
> #   REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
> #      |          |     |    |        ||||      |   |                     |   |   |   |
>         0 us |   0)    <idle>-0    |  dNs. |               |  /*      0:120:R   + [000]   339:100:R kworker/0:1H */
>         3 us |   0)    <idle>-0    |  dNs. |   0.000 us    |            (null)();
>   <idle>-0       0dNs.   66us : <stack trace>
>  => try_to_wake_up
>  => __queue_work
>  => queue_work_on
>  => call_timer_fn
>  => run_timer_softirq
>  => __do_softirq
>  => irq_exit
>  => smp_apic_timer_interrupt
>  => apic_timer_interrupt
>  => native_safe_halt
>  => default_idle
>  => default_idle_call
>  => do_idle
>  => cpu_startup_entry
>  => start_kernel
>  => secondary_startup_64
>        67 us |   0)    <idle>-0    |  dNs. |   0.721 us    |  ttwu_stat();
>        69 us |   0)    <idle>-0    |  dNs. |   0.607 us    |  _raw_spin_unlock_irqrestore();
>        71 us |   0)    <idle>-0    |  .Ns. |   0.598 us    |  _raw_spin_lock_irq();
>        72 us |   0)    <idle>-0    |  .Ns. |   0.584 us    |  _raw_spin_lock_irq();
>        73 us |   0)    <idle>-0    |  dNs. |   1.125 us    |  __next_timer_interrupt();
>        75 us |   0)    <idle>-0    |  dNs. |               |  call_timer_fn() {
>        76 us |   0)    <idle>-0    |  dNs. |               |    delayed_work_timer_fn() {
>       [...]
>       564 us |   0)   kworker-13   |  d... |               |      set_next_entity() {
>       565 us |   0)   kworker-13   |  d... |   0.524 us    |        __update_load_avg_se();
>       566 us |   0)   kworker-13   |  d... |   0.562 us    |        __update_load_avg_cfs_rq();
>       567 us |   0)   kworker-13   |  d... |   2.765 us    |      }
>       568 us |   0)   kworker-13   |  d... | + 10.077 us   |    }
>       569 us |   0)   kworker-13   |  d... |   0.000 us    |  __schedule();
> kworker/-13      0d...  593us : <stack trace>
>  => schedule
>  => worker_thread
>  => kthread
>  => ret_from_fork
>       593 us |   0)   kworker-13   |  d... |               |  /*     13:120:I ==> [000]   339:100:R kworker/0:1H */
> 
> Changbin Du (5):
>   function_graph: Support displaying relative timestamp
>   sched/tracing: Show more info for funcgraph wakeup tracers
>   sched/tracing: Put a margin between flags and duration for wakeup
>     tracers
>   sched/tracing: Show stacktrace for wakeup tracers
>   trace/doc: Add latency tracer funcgraph example
> 
>  Documentation/trace/ftrace.rst       | 51 ++++++++++++++++++++++++++++
>  kernel/trace/trace.h                 |  9 ++---
>  kernel/trace/trace_functions_graph.c | 30 ++++++++++++++--
>  kernel/trace/trace_irqsoff.c         |  2 +-
>  kernel/trace/trace_sched_wakeup.c    | 11 ++++--
>  5 files changed, 94 insertions(+), 9 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Cheers,
Changbin Du
