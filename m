Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERB7K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:59:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35143 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeERB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:59:08 -0400
X-Google-Smtp-Source: AB8JxZqgNTxOMi0QawyBh2FjQ6g0ExTJA56iViy76QDh0+OG2qTdNLBaPcpzdQl9uXkS071zB1aLYQ==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>, Julia Cartwright <julia@ni.com>,
        kernel-team@android.com
Subject: [PATCH RFC 0/2] Tests for preemptoff and irqsoff tracers
Date: Thu, 17 May 2018 18:59:00 -0700
Message-Id: <20180518015902.131427-1-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Hi,
Here is test code and kselftest for testing the preemptoff and irqsoff
tracers. I am posting it separately just for early feedback since its
the first time I'm writing a kselftest.

I am planning to include these tests in the next series posting of
"Centralize and unify usage of preempt/irq tracepoints" [1]

By the way, other than these I have also completed testing with Ingo's
locking API test suite for [1]. I will include these and other results
in the v7 posting of [1].

[1] http://lkml.iu.edu/hypermail/linux/kernel/1805.0/04948.html

Joel Fernandes (Google) (2):
  lib: Add module to simulate atomic sections for testing
    {preempt,irqs}off tracers
  kselftests: ftrace: Add tests for the preemptoff and irqsoff tracers

 lib/Kconfig.debug                             |  9 +++
 lib/Makefile                                  |  1 +
 lib/test_atomic_sections.c                    | 80 +++++++++++++++++++
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 lib/test_atomic_sections.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Erick Reyes <erickreyes@google.com>
Cc: Julia Cartwright <julia@ni.com>
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

-- 
2.17.0.441.gb46fe60e1d-goog
