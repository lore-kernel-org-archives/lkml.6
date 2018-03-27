Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4156032-1522167373-2-4976719910414951856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167372; b=MSe2RW9cT7r8BpFh3aWwWCRJBxACEusmTFQvOUk3j5ZtYQd
    G6Z7eFpkwL6iCMtMb/zOqD9ixZ9T+KNHohRZmxDLzPiS5vU5Ud+GxfmSJIebx3Iu
    vyT8R2XVWMAGZEvO/nhUeI+UpYnO2wxuRwL6GTOPtN5CQuV6ml7cuTvcNYWHrnea
    LTOp3gbyt5K5Q6zrhTeBG4o8q06TMGi7gX+j7zx/oq0UN4YyCzblyFxC9Y7dWvkf
    GQEI4KKoyr9uPWuAqRQhvGon+tR2o7BzjC/phfyhKjjLey69CorxO58AOZDADmjT
    RsHpF9nU4+0W/yH3JKNNAFb0sHUWtbufILRbPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1522167372; bh=jQMZNrOYFX6ClupHOqVAsW0FVr
    LjfCIfVdwYTA9GNTs=; b=dLZsKTrbgNGLLbruRigm//nwWqGuHnjUVOwUhW1tRM
    ZFpnBmACx3jKq1W0+KSZij0NwCaRO2TVSh/+TVMR/x2bareshVdZIxv+inVHRS/U
    YELMGQ84wN9vgUGvncJ4rYINOSMOFMBh8xmV5GIHHES9998H3Oy/z9/2ml4JJVIK
    KCf2dmAcZsyVcbtRmSZkRRewq3x2U7WqkvhgsQuGwzUsD1roY6tdUN4hR1wbgiXG
    BqkgHQ16pMhH7bM5az21jS/PyGSy75bkGbm/zYl3oy8+Xahri1HlDwumeWwRb+nr
    WE82GyOMI+g/csamO0U2jKJCyHwXCkMsl3qQXAIIRh7Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPwVtZr/2p5KmymrrtIq+mczuZ7RbLuJxSNkdBM5nskPJQ6yTDTMFxznpz/jKBiAVHywE8sjxI/bQAH8R3XkfylTKrjgKlbgRSHWRyAKtdMtO5Z1a9Jx
    tjeKgtk/3CStCWxYWwU5LYlqQK575l+tPdANmmEi0V5xs3U6VeZT7rpzXPNt32x61da0uPR01ebT4N8jVcDPwF9yC4cY92ShCXiT3wSsZJ+f9x851kouGsxy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=9Mm5lHf22o5fkmFzS0AA:9 a=A9HF50JnEaomlV2-:21
    a=-Rej1Iy57fi8_VYf:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeC0QQJ convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 27 Mar 2018 12:16:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:53330 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeC0QQB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 12:16:01 -0400
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.17 00/21] Restartable sequences and CPU op vector
Date: Tue, 27 Mar 2018 12:05:21 -0400
Message-Id: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
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

I'm respinning this series for another RFC round. It is based on the
v4.16-rc7 tag. I am now targeting the 4.17 merge window.

This series contains:

- Restartable sequences system call (x86 32/64, powerpc 32/64, arm 32),
- CPU operation vector system call (x86 32/64, powerpc 32/64, arm 32).

The main changes introduced in this updated version are:

- new cpu_opv flag to query the number of operations supported by the
  system call (added associated test-cases),
- Fix error handling when cpu_opv receives a cpu number not part of the
  allowed cpu mask (added associated test-cases).

Feedback is welcome!

Thanks,

Mathieu

Boqun Feng (2):
  powerpc: Add support for restartable sequences
  powerpc: Wire up restartable sequences system call

Mathieu Desnoyers (19):
  uapi headers: Provide types_32_64.h
  rseq: Introduce restartable sequences system call (v12)
  arm: Add restartable sequences support
  arm: Wire up restartable sequences system call
  x86: Add support for restartable sequences
  x86: Wire up restartable sequence system call
  sched: Implement push_task_to_cpu (v2)
  cpu_opv: Provide cpu_opv system call (v6)
  x86: Wire up cpu_opv system call
  powerpc: Wire up cpu_opv system call
  arm: Wire up cpu_opv system call
  selftests: lib.mk: Introduce OVERRIDE_TARGETS
  cpu_opv: selftests: Implement selftests (v7)
  rseq: selftests: Provide rseq library (v5)
  rseq: selftests: Provide percpu_op API
  rseq: selftests: Provide basic test
  rseq: selftests: Provide basic percpu ops test
  rseq: selftests: Provide parametrized tests
  rseq: selftests: Provide Makefile, scripts, gitignore

 MAINTAINERS                                        |   20 +
 arch/Kconfig                                       |    7 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/kernel/signal.c                           |    7 +
 arch/arm/tools/syscall.tbl                         |    2 +
 arch/powerpc/Kconfig                               |    1 +
 arch/powerpc/include/asm/systbl.h                  |    2 +
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |    2 +
 arch/powerpc/kernel/signal.c                       |    3 +
 arch/x86/Kconfig                                   |    1 +
 arch/x86/entry/common.c                            |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    2 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    2 +
 arch/x86/kernel/signal.c                           |    6 +
 fs/exec.c                                          |    1 +
 include/linux/sched.h                              |  118 ++
 include/linux/syscalls.h                           |    6 +
 include/trace/events/rseq.h                        |   56 +
 include/uapi/linux/cpu_opv.h                       |  120 ++
 include/uapi/linux/rseq.h                          |  150 +++
 include/uapi/linux/types_32_64.h                   |   67 +
 init/Kconfig                                       |   31 +
 kernel/Makefile                                    |    2 +
 kernel/cpu_opv.c                                   | 1083 ++++++++++++++++
 kernel/fork.c                                      |    2 +
 kernel/rseq.c                                      |  358 +++++
 kernel/sched/core.c                                |   43 +
 kernel/sched/sched.h                               |   10 +
 kernel/sys_ni.c                                    |    4 +
 tools/testing/selftests/Makefile                   |    2 +
 tools/testing/selftests/cpu-opv/.gitignore         |    1 +
 tools/testing/selftests/cpu-opv/Makefile           |   17 +
 .../testing/selftests/cpu-opv/basic_cpu_opv_test.c | 1368 ++++++++++++++++++++
 tools/testing/selftests/cpu-opv/cpu-op.c           |  352 +++++
 tools/testing/selftests/cpu-opv/cpu-op.h           |   59 +
 tools/testing/selftests/lib.mk                     |    4 +
 tools/testing/selftests/rseq/.gitignore            |    7 +
 tools/testing/selftests/rseq/Makefile              |   37 +
 .../testing/selftests/rseq/basic_percpu_ops_test.c |  296 +++++
 tools/testing/selftests/rseq/basic_test.c          |   55 +
 tools/testing/selftests/rseq/param_test.c          | 1163 +++++++++++++++++
 tools/testing/selftests/rseq/percpu-op.h           |  163 +++
 tools/testing/selftests/rseq/rseq-arm.h            |  732 +++++++++++
 tools/testing/selftests/rseq/rseq-ppc.h            |  688 ++++++++++
 tools/testing/selftests/rseq/rseq-skip.h           |   82 ++
 tools/testing/selftests/rseq/rseq-x86.h            | 1149 ++++++++++++++++
 tools/testing/selftests/rseq/rseq.c                |  116 ++
 tools/testing/selftests/rseq/rseq.h                |  164 +++
 tools/testing/selftests/rseq/run_param_test.sh     |  130 ++
 50 files changed, 8694 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/rseq.h
 create mode 100644 include/uapi/linux/cpu_opv.h
 create mode 100644 include/uapi/linux/rseq.h
 create mode 100644 include/uapi/linux/types_32_64.h
 create mode 100644 kernel/cpu_opv.c
 create mode 100644 kernel/rseq.c
 create mode 100644 tools/testing/selftests/cpu-opv/.gitignore
 create mode 100644 tools/testing/selftests/cpu-opv/Makefile
 create mode 100644 tools/testing/selftests/cpu-opv/basic_cpu_opv_test.c
 create mode 100644 tools/testing/selftests/cpu-opv/cpu-op.c
 create mode 100644 tools/testing/selftests/cpu-opv/cpu-op.h
 create mode 100644 tools/testing/selftests/rseq/.gitignore
 create mode 100644 tools/testing/selftests/rseq/Makefile
 create mode 100644 tools/testing/selftests/rseq/basic_percpu_ops_test.c
 create mode 100644 tools/testing/selftests/rseq/basic_test.c
 create mode 100644 tools/testing/selftests/rseq/param_test.c
 create mode 100644 tools/testing/selftests/rseq/percpu-op.h
 create mode 100644 tools/testing/selftests/rseq/rseq-arm.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc.h
 create mode 100644 tools/testing/selftests/rseq/rseq-skip.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86.h
 create mode 100644 tools/testing/selftests/rseq/rseq.c
 create mode 100644 tools/testing/selftests/rseq/rseq.h
 create mode 100755 tools/testing/selftests/rseq/run_param_test.sh

-- 
2.11.0

