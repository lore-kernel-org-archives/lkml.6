Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB71218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsAEy7c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfAAPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 10:48:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37020 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfAAPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 10:47:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so13583655plr.4;
        Tue, 01 Jan 2019 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KeTsfRE1MMPHeu6rOMP2OLvHPbjgni//nZHAqE+l8E0=;
        b=fsAEy7c5I2M2EFgF0srDQ8P5M9S62rbe2mc1u8flsu16AXMEMBNFKBtXNxiSs4nyNi
         N4HdXIwo1z+l5+jKlDFzIEZ4gjmUXMeRQHc3pyIOh9/tXfgdoXNELXEu0jdPzu19vPDq
         lsku4DtEny/wOUih7oXMI20WBccBsUPPopZHv3xK0vbIVl6hhq5WqZcIfEm6JaT/te1V
         hUyV9dX23qfM1xiL/Pv8xkgM/7/GlXNs5M91Us+GRQE00YykXwfTfcZHGIm7M29vai7d
         64Ct4q8eyaEsVcix2E2HMHmgW2QE9wlXPzY56w8mw6Slxw2KiWYs245WbMqOUWyiYKbD
         zjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KeTsfRE1MMPHeu6rOMP2OLvHPbjgni//nZHAqE+l8E0=;
        b=dbNgLkQRY51YkiXqUn6T/GJCssQD+XgKZkPrZrAmuUnUpNvz1VdrD/7i1Fj9MeMdHi
         THzo1ty0NYuL06idIFizGRolWQS152Se3naQHh0tUpTFRbzV+9kPxLA2ODeCVEetES6y
         hfiHhj0ah3fqqCeup2lggXwpWOiXfY/I5y9jEF/r6pQ0HEmPgGSEdyd+5LOYOkst1OPS
         M9L+nKrJRJD4HnRWDrd/sbONuYbv+E1zlq+xMk6hx1NTw3nl6XJ4aPnxbG1l2smFor+u
         dAnTpRWLWeFvfTzMKRDHa/DrkW4SCxaiU89VHnhQ5zK18By5pyLxhLaLvix3PqXufMHf
         ISgw==
X-Gm-Message-State: AJcUuke9ApyjsALs+xHjK7KmWy/QoVBQ8eky/NQ8IQ3KfsFmDzZloini
        1M166U8SF6g+QG951HrvW3A=
X-Google-Smtp-Source: ALg8bN4FV6gMZ16g3RquLFfFjYfEgtSKe/05SG8U/IIvWIgVbmJoycj4XLOHVnPdj/gJRu5DwhkJig==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr41397419plo.205.1546357677748;
        Tue, 01 Jan 2019 07:47:57 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id m3sm84122386pff.173.2019.01.01.07.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 07:47:57 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 5/5] trace/doc: Add latency tracer funcgraph example
Date:   Tue,  1 Jan 2019 23:46:14 +0800
Message-Id: <20190101154614.8887-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101154614.8887-1-changbin.du@gmail.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add an example about how to use funcgraph with latency tracers.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/trace/ftrace.rst | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 0131df7f5968..6ce2763a2a3e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1396,6 +1396,57 @@ enabling function tracing, we incur an added overhead. This
 overhead may extend the latency times. But nevertheless, this
 trace has provided some very helpful debugging information.
 
+If we prefer function graph output instead of function, we can set
+display-graph option::
+ with echo 1 > options/display-graph
+
+  # tracer: irqsoff
+  #
+  # irqsoff latency trace v1.1.5 on 4.20.0-rc6+
+  # --------------------------------------------------------------------
+  # latency: 3751 us, #274/274, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:4)
+  #    -----------------
+  #    | task: bash-1507 (uid:0 nice:0 policy:0 rt_prio:0)
+  #    -----------------
+  #  => started at: free_debug_processing
+  #  => ended at:   return_to_handler
+  #
+  #
+  #                                       _-----=> irqs-off
+  #                                      / _----=> need-resched
+  #                                     | / _---=> hardirq/softirq
+  #                                     || / _--=> preempt-depth
+  #                                     ||| /
+  #   REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
+  #      |          |     |    |        ||||      |   |                     |   |   |   |
+          0 us |   0)   bash-1507    |  d... |   0.000 us    |  _raw_spin_lock_irqsave();
+          0 us |   0)   bash-1507    |  d..1 |   0.378 us    |    do_raw_spin_trylock();
+          1 us |   0)   bash-1507    |  d..2 |               |    set_track() {
+          2 us |   0)   bash-1507    |  d..2 |               |      save_stack_trace() {
+          2 us |   0)   bash-1507    |  d..2 |               |        __save_stack_trace() {
+          3 us |   0)   bash-1507    |  d..2 |               |          __unwind_start() {
+          3 us |   0)   bash-1507    |  d..2 |               |            get_stack_info() {
+          3 us |   0)   bash-1507    |  d..2 |   0.351 us    |              in_task_stack();
+          4 us |   0)   bash-1507    |  d..2 |   1.107 us    |            }
+  [...]
+       3750 us |   0)   bash-1507    |  d..1 |   0.516 us    |      do_raw_spin_unlock();
+       3750 us |   0)   bash-1507    |  d..1 |   0.000 us    |  _raw_spin_unlock_irqrestore();
+       3764 us |   0)   bash-1507    |  d..1 |   0.000 us    |  tracer_hardirqs_on();
+      bash-1507    0d..1 3792us : <stack trace>
+   => free_debug_processing
+   => __slab_free
+   => kmem_cache_free
+   => vm_area_free
+   => remove_vma
+   => exit_mmap
+   => mmput
+   => flush_old_exec
+   => load_elf_binary
+   => search_binary_handler
+   => __do_execve_file.isra.32
+   => __x64_sys_execve
+   => do_syscall_64
+   => entry_SYSCALL_64_after_hwframe
 
 preemptoff
 ----------
-- 
2.17.1

