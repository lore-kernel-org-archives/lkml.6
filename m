Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jMizGd+XGVvPfAAAmS7hNA
	; Thu, 07 Jun 2018 20:38:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D6D46074D; Thu,  7 Jun 2018 20:38:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5itmGRH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 78A3C60452;
	Thu,  7 Jun 2018 20:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78A3C60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeFGUiw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:38:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33635 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeFGUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:38:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id n10-v6so6862151plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XPt5YujdfZsiysYDWGSFfTMiw9NfNNEGK0vlrekDSbQ=;
        b=e5itmGRHtYjrymYPy1DHhQvxuirJ7a/PqwLSwo88Rv3AlxEnzoKu7c0udDNSqiarT2
         P7ULyH7AoMHBih2l/Tqj8j81+8MecA7+VQTw416XsnagvS3Oca4gkF6CAK63uAj6jm2R
         H2n083kcXj0YiQ08jglQ+T+4ka9l03m7FoMGqkbRnW0vyVpg28pDQe7UgWGh/qp2GVvg
         Lr/whZWZR1jh8Bi+mvwRlSHSI+DcN77vNo4ThiFtSTr0ZJnTGSvMkQFJ82CMUVwNc4sZ
         gE7NqNnldb/m6u/xO7od4Ap5ULEuaElfLyiYHxWg1qi6kF2WOtD6LwI89nuJDtMtoTB0
         ZH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XPt5YujdfZsiysYDWGSFfTMiw9NfNNEGK0vlrekDSbQ=;
        b=iOxQNP6/tN2QBUTcmYm4/ydw/atxBZ3rSOdmtp3M12RlHKarkUm3X6aDklPA21CjI0
         IH23W6mJ3YW45Wz+y4cXKSWw5LFDlpZJVCeIvoHdxCMdayYdCXrmJN1FYzsLI8JrE2xT
         YlErTIL6jWONcOcM60v6JLl4630HMYI2pgJBDr89B/X9AB7ONslLqbrQ3jKvFIR/P3jE
         WddxQ4m1ghHeFWJu7AnHkM2dW3KEckI3Jgi6yS4tFip1dkC+3ioSmYbxv3tbBBla6Un0
         tanJ48fcv4o30Rm+j1r591XD+OpUlWukf4ACzoovAKzhO6Q15kFXSrUjkHqLSCEAyXAy
         /CAw==
X-Gm-Message-State: APt69E3xc9uK31soC8PO02FrO7Xgt0I5tRsJEcx1KMunfZvuijAeuHIk
        V7f7RKr/PoZhYSD0q3DSkg+3cB/enXo=
X-Google-Smtp-Source: ADUXVKIQgerCtzY1Sjhdrah/A0mGx3RBe61V5JemGxp/Y8PiO3TUZL4uyl8yo2hYetD0CoKwqy/kag==
X-Received: by 2002:a17:902:20c9:: with SMTP id v9-v6mr3524161plg.206.1528403929139;
        Thu, 07 Jun 2018 13:38:49 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v27-v6sm10324174pfi.23.2018.06.07.13.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:38:48 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
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
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 0/7] Centralize and unify usage of preempt/irq
Date: Thu,  7 Jun 2018 13:38:08 -0700
Message-Id: <20180607203815.255845-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This is the next (hopefully close to final) revision of preempt/irq tracepoint
centralization and unified usage across the kernel. This revision mostly has
minor style corrections, reviewed-by tag additions and an improvement to the
test module. All patches now have a Reviewed-by tag except for the kselftest
script (patch 7/7). I have also now split out the softirq fix which really
should go into an -rc cycle and is independent of this series (see [1]).

The preempt/irq tracepoints exist but not everything in the kernel is using it
whenever they need to be notified that a preempt disable/enable or an irq
disable enable has occurred.  This makes things not work simultaneously (for
example, only either lockdep or irqsoff trace-events can be used at a time).

This is particular painful to deal with, since turning on lockdep breaks
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
2.17.1.1185.g55be947832-goog
