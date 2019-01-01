Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CBA218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8SjYgkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfAAPrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 10:47:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36986 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfAAPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 10:47:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so13583179plr.4;
        Tue, 01 Jan 2019 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tLXhdT28FWC1wYUG/heDNtCpgdf8rJnS3sN3zMtnwpU=;
        b=R8SjYgkVwrvRCb8iWjAH6RZdNi0qdysZAaSvnuEcXjRUYCKPkKMWn7oKNDMLiCIltB
         pnL44iAwCq/dZSm6ZI4g2QdjbFvSCj1R3T3vO6FbKjok6SduHhiDGp8L9O8x/StLhajn
         JKsoLRX7Z0Dp/pPXO9hnpEjOUZ9sh9roXWb7DvUFxOUZMg1ZaZ4gTdiNMruQL/XleW1e
         Qt87fTvweaZuPH8NEypH/lPkWAz9xXWZDX3JpH4zYKqIv+jSc5w8bFpZ5pPKuZqfisXg
         mrTYjRRzM2IvYnIWsPSlQ90sYJ6d/fijxOhXokPkoJ4Hb26YfgeBu+RZ0RZEDuG0Dhq5
         go2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tLXhdT28FWC1wYUG/heDNtCpgdf8rJnS3sN3zMtnwpU=;
        b=dTk/jvCVS+aLbFwtqNuEBsVywMRbk2BSv/Oc3VTomDBRdkx5X9FuiHjhEEFPME31Bl
         4rMTyAFjAmIWhdtIIWrdDiX6/0A4zD/tPcxzZJro5soLYN2KAQPOo8mqsTsNtnoDBsVY
         We/mYPXzmqTCd1hpkrlMTCmf6xHMvwQJde9K1w0KUcdPH/vzcZ0MVu9LBsYP1JNDDvTt
         YPbusYoOxZecYfuh0mWvpZmuspMPNAsN9LKG1fxbIRC/Pi028sG0ooo2RZ3t+5v7CXR8
         paw3FVuURfg73h+Cr3a40Iwdq7+fCV3Z8eUwI0M1DDpDc3YMDnLsbDJBDNFUrMGOQoNM
         sBVA==
X-Gm-Message-State: AJcUukdkWt3VP+CSH5Z7DCY9If+egmChWxOHkGhfarB5pK54xXsKllVH
        aWGQD4TwR8i/7H5fyB4cONw=
X-Google-Smtp-Source: ALg8bN5b4IHKujd+Kx69M1jEzlP64y4BnrSdl+DfxmXeEzQFelEGx7viNVHex2W1a4aGj6U01DoFuQ==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr39376378plk.196.1546357620813;
        Tue, 01 Jan 2019 07:47:00 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id m3sm84122386pff.173.2019.01.01.07.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 07:46:59 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 0/5] Improve the latency tracers
Date:   Tue,  1 Jan 2019 23:46:09 +0800
Message-Id: <20190101154614.8887-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Happy new year!

This series make some improments for the kernel latency tracers, especilly
for the wakeup tracers. The latency tracers will show us more useful
information. With this series, the wakeup tracers look like this
when display-graph is enabled:

# tracer: wakeup
#
# wakeup latency trace v1.1.5 on 4.20.0+
# --------------------------------------------------------------------
# latency: 593 us, #674/674, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: kworker/0:1H-339 (uid:0 nice:-20 policy:0 rt_prio:0)
#    -----------------
#
#                                       _-----=> irqs-off        
#                                      / _----=> need-resched    
#                                     | / _---=> hardirq/softirq 
#                                     || / _--=> preempt-depth   
#                                     ||| /                      
#   REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
#      |          |     |    |        ||||      |   |                     |   |   |   |
        0 us |   0)    <idle>-0    |  dNs. |               |  /*      0:120:R   + [000]   339:100:R kworker/0:1H */
        3 us |   0)    <idle>-0    |  dNs. |   0.000 us    |            (null)();
  <idle>-0       0dNs.   66us : <stack trace>
 => try_to_wake_up
 => __queue_work
 => queue_work_on
 => call_timer_fn
 => run_timer_softirq
 => __do_softirq
 => irq_exit
 => smp_apic_timer_interrupt
 => apic_timer_interrupt
 => native_safe_halt
 => default_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_kernel
 => secondary_startup_64
       67 us |   0)    <idle>-0    |  dNs. |   0.721 us    |  ttwu_stat();
       69 us |   0)    <idle>-0    |  dNs. |   0.607 us    |  _raw_spin_unlock_irqrestore();
       71 us |   0)    <idle>-0    |  .Ns. |   0.598 us    |  _raw_spin_lock_irq();
       72 us |   0)    <idle>-0    |  .Ns. |   0.584 us    |  _raw_spin_lock_irq();
       73 us |   0)    <idle>-0    |  dNs. |   1.125 us    |  __next_timer_interrupt();
       75 us |   0)    <idle>-0    |  dNs. |               |  call_timer_fn() {
       76 us |   0)    <idle>-0    |  dNs. |               |    delayed_work_timer_fn() {
      [...]
      564 us |   0)   kworker-13   |  d... |               |      set_next_entity() {
      565 us |   0)   kworker-13   |  d... |   0.524 us    |        __update_load_avg_se();
      566 us |   0)   kworker-13   |  d... |   0.562 us    |        __update_load_avg_cfs_rq();
      567 us |   0)   kworker-13   |  d... |   2.765 us    |      }
      568 us |   0)   kworker-13   |  d... | + 10.077 us   |    }
      569 us |   0)   kworker-13   |  d... |   0.000 us    |  __schedule();
kworker/-13      0d...  593us : <stack trace>
 => schedule
 => worker_thread
 => kthread
 => ret_from_fork
      593 us |   0)   kworker-13   |  d... |               |  /*     13:120:I ==> [000]   339:100:R kworker/0:1H */

Changbin Du (5):
  function_graph: Support displaying relative timestamp
  sched/tracing: Show more info for funcgraph wakeup tracers
  sched/tracing: Put a margin between flags and duration for wakeup
    tracers
  sched/tracing: Show stacktrace for wakeup tracers
  trace/doc: Add latency tracer funcgraph example

 Documentation/trace/ftrace.rst       | 51 ++++++++++++++++++++++++++++
 kernel/trace/trace.h                 |  9 ++---
 kernel/trace/trace_functions_graph.c | 30 ++++++++++++++--
 kernel/trace/trace_irqsoff.c         |  2 +-
 kernel/trace/trace_sched_wakeup.c    | 11 ++++--
 5 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.17.1

