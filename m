Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21756C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E1A224D5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="To3RnL1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E1A224D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933862AbeFUWd2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:33:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45755 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933622AbeFUWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:33:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so2038841pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y8KEp0r6n018OkQCFpfKMB1S5eQLFOrINRhm16WXZpk=;
        b=To3RnL1Pjbf2QpBMevWm3HPNkAkz71VWaWH6VMo7GlayFOHrqoN579zlPC2/oyIvYl
         WLgf8too08/4Vtrv5G4W9gsCfq9oYG3N2lMZ/w5bGlTEkd7Sr4jpjdiIzWE21Sbvhy3C
         cfiEsYGTOfbL15iqh92XOkE9ZEsfLz7Q4Nwfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y8KEp0r6n018OkQCFpfKMB1S5eQLFOrINRhm16WXZpk=;
        b=RPxcnAVEIL/d0tBqD/3x7muH2l/VgZeGvCTtlRaklsPrXx7PFZbLQbmoindIWes5um
         6ix6EXiN8xnBDsSomst0bzM9/Ej0tjy+DwS06u+PxdqVcTqpPdCuKxSnsRu7YWZcVCrB
         l8MR2YTcGbKtRbp70K8Nh456c/S4TzHw5gK3gUhWBIdryPtPNtl2cMLTt3EpEQ2nOoLi
         WwJgT/ou0DxXQsziOAEB77o6LkhYluCSFXPMb8E4AlQcQYv/zdlhZUdquz5sb0f+3kgX
         i1c6Q2ltaj5PQwg+yuuSuulc7hAMCQiz4MMyOl9N8P0OX0oUPIdvhFk1QEzBVyZ4AJZh
         sejA==
X-Gm-Message-State: APt69E2KKE62fRJ7psb/dMMHA21iMM23a5ySceswJomKs95jNn/P5hIf
        NMXBHTiIF6kwWlZH/+1bGprAHOns5ys=
X-Google-Smtp-Source: ADUXVKL393ljhN8oGkjlkW+cxfemJGQHQjh5mKDaMYPLy4jdeJGwn6RotT0akFqZku+1FP0XPsY70g==
X-Received: by 2002:a62:ccdc:: with SMTP id j89-v6mr29067613pfk.232.1529620405512;
        Thu, 21 Jun 2018 15:33:25 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x19-v6sm11060824pfi.5.2018.06.21.15.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:33:24 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 0/7] Centralize and unify usage of preempt/irq tracepoints
Date:   Thu, 21 Jun 2018 15:32:29 -0700
Message-Id: <20180621223236.211495-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This is a posting of v9 preempt/irq tracepoint clean up series rebased
onto v4.18-rc1. No changes in the series, just a rebase + repost.
Maintainers, this series has been well tested and is a simplification/
refactoring of existing code, along with giving a speed-up for
tracepoints using the rcu-idle API. I'm hoping for your consideration of
this series for the kernel. I am also eager for this so that our users
will find it easier to use tools depending on existing preempt
tracepoints since it simplifies the configuration for them.

All patches now have a Reviewed-by tag except for the kselftest script (7/7).
Peter, Ingo, Steve, others, your feedback and Acks are welcomed.

Introduction to the series:
The preempt/irq tracepoints exist but not everything in the kernel is using it
whenever they need to be notified that a preempt disable/enable or an irq
disable/enable has occurred.  This makes things not work simultaneously (for
example, only either lockdep or irqsoff trace-events can be used at a time).

This is particularly painful to deal with, since turning on lockdep breaks
tracers that install probes on IRQ events, such as the BCC atomic critical
section tracer [2]. This constraint also makes it not possible to use synthetic
events to trace irqsoff sections with lockdep simulataneously turned on.

This series solves that, and also results in a nice clean up of relevant parts
of the kernel. Several ifdefs are simpler, and the design is more unified and
better. Also as a result of this, we also speeded performance all rcuidle
tracepoints since their handling is simpler.

[1] https://lkml.org/lkml/2018/6/7/1135
[2] https://github.com/iovisor/bcc/pull/1801/

v8->v9:
- Small style changes to tracepoint code (Mathieu)
- Minor style fix to use PTR_ERR_OR_ZERO (0-day bot)
- Minor fix to test_atomic_sections to use unsigned long.
- Added Namhyung's, Mathieu's Reviewed-by to some patches.

v7->v8:
- Refactored irqsoff tracer probe defines (Namhyung)

v6->v7:
- Added a module to simulate an atomic section, a kselftest to load and
  and trigger it which verifies the preempt-tracer and this series.

- Fixed a new warning after I rebased in early boot, this is because
early_boot_irqs_disabled was set too early, I moved it after the lockdep
initialization.

- added back the softirq fix since it appears it wasn't picked up.

- Ran Ingo's locking API selftest suite which are passing with this
  series.

- Mathieu suggested ifdef'ing the tracepoint_synchronize_unregister
  function incase tracepoints aren't enabled, did that.

Joel Fernandes (Google) (6):
  srcu: Add notrace variant of srcu_dereference
  trace/irqsoff: Split reset into separate functions
  tracepoint: Make rcuidle tracepoint callers use SRCU
  tracing: Centralize preemptirq tracepoints and unify their usage
  lib: Add module to simulate atomic sections for testing preemptoff
    tracers
  kselftests: Add tests for the preemptoff and irqsoff tracers

Paul McKenney (1):
  srcu: Add notrace variants of srcu_read_{lock,unlock}

 include/linux/ftrace.h                        |  11 +-
 include/linux/irqflags.h                      |  11 +-
 include/linux/lockdep.h                       |   8 +-
 include/linux/preempt.h                       |   2 +-
 include/linux/srcu.h                          |  22 ++
 include/linux/tracepoint.h                    |  49 +++-
 include/trace/events/preemptirq.h             |  23 +-
 init/main.c                                   |   5 +-
 kernel/locking/lockdep.c                      |  35 +--
 kernel/sched/core.c                           |   2 +-
 kernel/trace/Kconfig                          |  22 +-
 kernel/trace/Makefile                         |   2 +-
 kernel/trace/trace_irqsoff.c                  | 253 ++++++------------
 kernel/trace/trace_preemptirq.c               |  71 +++++
 kernel/tracepoint.c                           |  16 +-
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/test_atomic_sections.c                    |  77 ++++++
 tools/testing/selftests/ftrace/config         |   3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       |  74 +++++
 20 files changed, 454 insertions(+), 241 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c
 create mode 100644 lib/test_atomic_sections.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

-- 
2.18.0.rc2.346.g013aa6912e-goog
