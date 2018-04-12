Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1658150-1523561305-2-6432711511273433244
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
    1523561305; b=FpWIgC1JPmzUhhqFHHZPyMvxoUbHq9QDyLGTPLCkRmZ0y42oJ1
    5uctjnGmGIYe+YxwU54/NDu+0xPXCsEixAnH/y41wBO4ipxLaDFol4jhtDMVkac5
    ek7JPBaDIi6aAjO2irSERSAviDJFyH+CAVR2OvtQr3gesqgc54slxY0Y6s0vQMCg
    phKDxXPRMSOnldWi7kzBhG/UtzUwF1WNtat/RA08/CISu0zQFS0rBc2BtYth1f/D
    M7r6m9CKq8NH+3FPIH047IR/VXrIUSKSImH76oJ/T9DGFOw9vx8FiZfV0jPAt2LB
    8VmuizS3Q9IZibbIvXtea4Vxjeel5bei/r2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523561305; bh=RX5B3CSWqenwMAzUATFGX8WdRw/k7I
    IgbOm5YTU36JE=; b=iVIOeoQEIboul5O0ZaBjN2J3Ce38JcJclTy6xERUOMaSDG
    aVDOyiZ4kNIvJXcjQyz5TZsmQnjYV17gvlh6zYcIhX4atqA1nKxqAeQf8Mtf8gYD
    +xyXxcczUHJLjHBo+R4LrL5PZC01tP0wsVv2iVKrveMfcQxpDMxN6SD9yfBm9eOF
    BBh+rr3S8+wesKsDrMI87d9Cf44cbdZFfnzVLNjKt2v9QU6rojVo60/EuORPQs69
    d7SW0WJIGKyUGD9xTUnuwf5TaotofcBPs++RSz1Q31xHmP2X/I19TRJNk/nJPfVp
    brNeIUoYWlznzk3iIo7xXELuSjXqA1Q3ZHrd43Mw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfAhzbA/T2gy62OFvULq4ijtUrMIo4VByqcCTbClMfEISmdANb4rBH+GQ4uR2+B+yOSPESoiMYs+i57aBN/1CyIJTzea0SMOeJpK4jPUP+NONBppw5rgl
    cG+Dt1GcSpVjf32a/FoNYcYuO29lXGoj3p+aTUze8OWEZ50PudMzZ1QDFs03PzKdg/63tMkNV3p5TO+4MGGtCaEnxYTq387A4Cfk5OXxnQerXiuwRshjMnfn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=p3aKP0e88t7EboU8qpwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeDLT2V convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 12 Apr 2018 15:28:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:45366 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeDLT2U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:28:20 -0400
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
Subject: [RFC PATCH for 4.18 00/23] Restartable sequences and CPU op vector
Date: Thu, 12 Apr 2018 15:27:37 -0400
Message-Id: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
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
v4.16 tag. Given that it is now very late in the 4.17 merge window, and
considering that some code changes were needed to address the last round
of feedback, I think it is safer to target the 4.18 merge window.

This series contains:

- Restartable sequences system call (x86 32/64, powerpc 32/64, arm 32),
- CPU operation vector system call (x86 32/64, powerpc 32/64, arm 32).

The main changes introduced in this updated version are:

- Return -1, errno=EFAULT if userspace pointers received as cpu_opv
  operation parameters target noncached memory. A new is_vma_noncached()
  is introduced in linux/mm.h to that effect.
- Introduce vm_map_user_ram, vm_unmap_user_ram, which allows creating
  mappings aliased to a user-space mapping with the same cache coloring
  as the userspace mapping. Allow the kernel to load from and store to
  pages shared with user-space through its own mapping in kernel virtual
  addresses while ensuring cache conherency between kernel and userspace
  mappings for virtually aliased architectures.
- Use vm_{map,unmap}_user_ram in cpu_opv.

Feedback is welcome!

Thanks,

Mathieu

Boqun Feng (2):
  powerpc: Add support for restartable sequences
  powerpc: Wire up restartable sequences system call

Mathieu Desnoyers (21):
  uapi headers: Provide types_32_64.h (v2)
  rseq: Introduce restartable sequences system call (v13)
  arm: Add restartable sequences support
  arm: Wire up restartable sequences system call
  x86: Add support for restartable sequences (v2)
  x86: Wire up restartable sequence system call
  sched: Implement push_task_to_cpu (v2)
  mm: Introduce vm_map_user_ram, vm_unmap_user_ram
  mm: Provide is_vma_noncached
  cpu_opv: Provide cpu_opv system call (v7)
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
 arch/x86/entry/common.c                            |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    2 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    2 +
 arch/x86/kernel/signal.c                           |    6 +
 fs/exec.c                                          |    1 +
 include/linux/mm.h                                 |   24 +
 include/linux/sched.h                              |  134 ++
 include/linux/syscalls.h                           |    6 +
 include/linux/vmalloc.h                            |    4 +
 include/trace/events/rseq.h                        |   56 +
 include/uapi/linux/cpu_opv.h                       |  120 ++
 include/uapi/linux/rseq.h                          |  150 +++
 include/uapi/linux/types_32_64.h                   |   67 +
 init/Kconfig                                       |   40 +
 kernel/Makefile                                    |    2 +
 kernel/cpu_opv.c                                   | 1107 ++++++++++++++++
 kernel/fork.c                                      |    2 +
 kernel/rseq.c                                      |  366 ++++++
 kernel/sched/core.c                                |   44 +
 kernel/sched/sched.h                               |    9 +
 kernel/sys_ni.c                                    |    4 +
 mm/vmalloc.c                                       |   66 +
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
 tools/testing/selftests/rseq/param_test.c          | 1167 +++++++++++++++++
 tools/testing/selftests/rseq/percpu-op.h           |  163 +++
 tools/testing/selftests/rseq/rseq-arm.h            |  732 +++++++++++
 tools/testing/selftests/rseq/rseq-ppc.h            |  688 ++++++++++
 tools/testing/selftests/rseq/rseq-skip.h           |   82 ++
 tools/testing/selftests/rseq/rseq-x86.h            | 1149 ++++++++++++++++
 tools/testing/selftests/rseq/rseq.c                |  116 ++
 tools/testing/selftests/rseq/rseq.h                |  164 +++
 tools/testing/selftests/rseq/run_param_test.sh     |  131 ++
 53 files changed, 8852 insertions(+), 1 deletion(-)
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

