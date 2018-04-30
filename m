Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525128287-2-12775333764898902367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525128286; b=Vqy+4gv83j6QDvzGEsHI6uAwrxkRc1llkXZ/XjABhrvCWyEu9X
    E3OZLZ1+C4lZWYfrD1Eg1M2INT+6WiymHj/nhjLoQSYnEKddPsX8pj7KOdIP3lsl
    Chdfx5CryZS8dTpORo9NJl3fJxHLT8+gew3sF6ev0juoNICjePrLWJBWeMWHSvPf
    bDHXbVEOmb75kL28HkrAAbx/nnWQ59lhqr1H/euIMOU7NeSJZ2cAikvsYsLNNCkl
    5YVqErNW1VOytKpSISQk38fNtS6rrPIZpFE4Vx+cawQRuZhlaYRPk5QFuKSv8DQ/
    dOIKmgXh8H4tpsmDv13lr4ODU968OezoJQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525128286; bh=jOybbBW3sxBWffjmvV1ZPuj5kNyAr4
    IpkASpjyVeDSQ=; b=jG4jOTUukCjRdG09boeiiowM0ycly849O78Hhxsh5YMhGX
    RJAzYJuba/tQUA53s9zp7oaYAtzpMr2Lw+5qVfydBa0LcvyFQC8la+ekQHKX4V3M
    GBsC9ifoyaMCQzc4XvX/3t+Ul1yuQXe557OP9Os9UFhHzksx4uWsGw0QUueHl/je
    yDXgNQ5bXnhhNzYzG+buLlGzxuEm9JGdjCBzaNYLKgEOT9SzLZocTDQOSSxDT86s
    j3GeHbP7Q7edQKv2inB9DPtLA3p5V2d9rjlC3pABINB7MESMPOuZxIKdL69mH5te
    gIz6cIc+dSLxd8W5IwjKvjJtYXink2Xr0qd0tQNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMVVpXuNxqUl7riNw9mjNJEPPXj47SU5kW7mSk9gSLEDyCj1ooXXuLdrSfM0oeLgZZoN00B0ulxA1HtJsaEsGuSt0PRorJy6CVQvA4UMqCdAMGOMklIh
    DbILD0Sd3+nzf3RiCxoWKpGJ/bGg27NYNSpcIRQmH36M5VQUBB13/FjXLHpFGmRhZajydUQQ+KicSWQwyawnSX8kbo94/0azwNNJ0vV5RUfzSWF3gBiHK37q
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=N_nMYajPPhd9ZY2YM8IA:9 a=9Ezdby6lLaRpk1Aa:21
    a=XgvKcM0dqJgIEnen:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeD3Woo convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 30 Apr 2018 18:44:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:52780 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755282AbeD3Won (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Apr 2018 18:44:43 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 00/14] Restartable Sequences
Date: Mon, 30 Apr 2018 18:44:19 -0400
Message-Id: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Here is an updated RFC round of the Restartable Sequences patchset
based on kernel 4.17-rc3. Based on feedback from Linus, I'm introducing
only the rseq system call, keeping the rest for later.

This already enables speeding up the Facebook jemalloc and arm64 PMC
read from user-space use-cases, as well as speedup of use-cases relying
on getting the current cpu number from user-space. We'll have to wait
until a more complete solution is introduced before the LTTng-UST
tracer can replace its ring buffer atomic instructions with rseq
though. But let's proceed one step at a time.

The main change introduced by the removal of cpu_opv from this series
in terms of library use from user-space is that APIs that previously
took a CPU number as argument now only act on the current CPU.

So for instance, this turns:

  int cpu = rseq_per_cpu_lock(lock, target_cpu);
  [...]
  rseq_per_cpu_unlock(lock, cpu);

into

  int cpu = rseq_this_cpu_lock(lock);
  [...]
  rseq_per_cpu_unlock(lock, cpu);

and:

  per_cpu_list_push(list, node, target_cpu);
  [...]
  per_cpu_list_pop(list, node, target_cpu);

into

  this_cpu_list_push(list, node, &cpu);  /* cpu is an output parameter. */
  [...]
  node = this_cpu_list_pop(list, &cpu);  /* cpu is an output parameter. */

Eventually integrating cpu_opv or some alternative will allow passing
the cpu number as parameter rather than requiring the algorithm to work
on the current CPU.

The second effect of not having the cpu_opv fallback is that
line and instruction single-stepping with a debugger transforms rseq
critical sections based on retry loops into never-ending loops.
Debuggers need to use the __rseq_table section to skip those critical
sections in order to correctly behave when single-stepping a thread
which uses rseq in a retry loop. However, applications which use an
alternative fallback method rather than retrying on rseq fast-path abort
won't be affected by this kind of single-stepping issue.

Feedback is welcome!

Thanks,

Mathieu

Boqun Feng (2):
  powerpc: Add support for restartable sequences
  powerpc: Wire up restartable sequences system call

Mathieu Desnoyers (12):
  uapi headers: Provide types_32_64.h (v2)
  rseq: Introduce restartable sequences system call (v13)
  arm: Add restartable sequences support
  arm: Wire up restartable sequences system call
  x86: Add support for restartable sequences (v2)
  x86: Wire up restartable sequence system call
  selftests: lib.mk: Introduce OVERRIDE_TARGETS
  rseq: selftests: Provide rseq library (v5)
  rseq: selftests: Provide basic test
  rseq: selftests: Provide basic percpu ops test (v2)
  rseq: selftests: Provide parametrized tests (v2)
  rseq: selftests: Provide Makefile, scripts, gitignore (v2)

 MAINTAINERS                                        |   12 +
 arch/Kconfig                                       |    7 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/kernel/signal.c                           |    7 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/powerpc/Kconfig                               |    1 +
 arch/powerpc/include/asm/systbl.h                  |    1 +
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |    1 +
 arch/powerpc/kernel/signal.c                       |    3 +
 arch/x86/Kconfig                                   |    1 +
 arch/x86/entry/common.c                            |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 arch/x86/kernel/signal.c                           |    6 +
 fs/exec.c                                          |    1 +
 include/linux/sched.h                              |  134 +++
 include/linux/syscalls.h                           |    4 +-
 include/trace/events/rseq.h                        |   56 +
 include/uapi/linux/rseq.h                          |  150 +++
 include/uapi/linux/types_32_64.h                   |   67 ++
 init/Kconfig                                       |   23 +
 kernel/Makefile                                    |    1 +
 kernel/fork.c                                      |    2 +
 kernel/rseq.c                                      |  366 ++++++
 kernel/sched/core.c                                |    2 +
 kernel/sys_ni.c                                    |    3 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/lib.mk                     |    4 +
 tools/testing/selftests/rseq/.gitignore            |    6 +
 tools/testing/selftests/rseq/Makefile              |   29 +
 .../testing/selftests/rseq/basic_percpu_ops_test.c |  312 +++++
 tools/testing/selftests/rseq/basic_test.c          |   55 +
 tools/testing/selftests/rseq/param_test.c          | 1259 ++++++++++++++++++++
 tools/testing/selftests/rseq/rseq-arm.h            |  732 ++++++++++++
 tools/testing/selftests/rseq/rseq-ppc.h            |  688 +++++++++++
 tools/testing/selftests/rseq/rseq-skip.h           |   82 ++
 tools/testing/selftests/rseq/rseq-x86.h            | 1149 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq.c                |  116 ++
 tools/testing/selftests/rseq/rseq.h                |  164 +++
 tools/testing/selftests/rseq/run_param_test.sh     |  120 ++
 41 files changed, 5572 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/rseq.h
 create mode 100644 include/uapi/linux/rseq.h
 create mode 100644 include/uapi/linux/types_32_64.h
 create mode 100644 kernel/rseq.c
 create mode 100644 tools/testing/selftests/rseq/.gitignore
 create mode 100644 tools/testing/selftests/rseq/Makefile
 create mode 100644 tools/testing/selftests/rseq/basic_percpu_ops_test.c
 create mode 100644 tools/testing/selftests/rseq/basic_test.c
 create mode 100644 tools/testing/selftests/rseq/param_test.c
 create mode 100644 tools/testing/selftests/rseq/rseq-arm.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc.h
 create mode 100644 tools/testing/selftests/rseq/rseq-skip.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86.h
 create mode 100644 tools/testing/selftests/rseq/rseq.c
 create mode 100644 tools/testing/selftests/rseq/rseq.h
 create mode 100755 tools/testing/selftests/rseq/run_param_test.sh

-- 
2.11.0

