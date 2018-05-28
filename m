Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490781-2-12102229777928037110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490781; b=YaevpI2J8WedkN5Oh1yEoolWGih9VD8T9BgjIv3AhjErNIWuX6
    gnaPbAAhcfLRNUeNbselgwmgEeENynY6KQW4tGXn1dz+9GM3jDYP8TxSL2bhcnoC
    LR2H57iGaBI0eiIe8Ug1scy0Xzo//Slt9BFGSpAApvPNsFpQXn4AW1uUwJkfl7S9
    xYPF8xlI2pMx36bTN8ieqnIc20j7KIGv6dvVkYiaR5fC/pkx5k416n8Mjbh8AEYa
    2uIo7+lbpTRF5lmpGp8bNHWEg7xHnXpg/oBT+Mtgg6XfLIVDrqfy4oufwl0tx2Nl
    oXPZxiPTU8zbksAdyo9KjAlcu8naniqLC32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527490781; bh=p2hCCis4kF0uDmlyVNj6VXYG/vvKe1
    ft+yUwlZQvBiI=; b=LL0XzT1gEVh/UuXa642nXCmNmGct3HX16Ci2s/T9PcRAbd
    2kC6Kmr3dFeqY7VqufY51pmGU1pKDXc+G7hNMrRaASMmuOv/gLBA/kk2BhzQteB/
    f6dcLrlVsHZYK4n9eyxmvqylsZ8rm4KevRSwE9RJPjJiwoFYNOXgCzPmgQXdZ3sN
    VcnvQ3IHdhARON3kZlOcILQgvEdJ5DEmS/oBVJtQeGcPaDBvAzr0aWK+GhIFIxcD
    CjVZIsxVf7kp+6q7OTNHNSw9G9o33ERG78sJVlJxSuATEr3A5k5GCrQaQNGYLU2l
    EmQw9fl0e3gMQ5eVq7zt5Rb3riDQzpF7EIBhmT0A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QQfi1uyo header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=QQfi1uyo header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB6ePLDse83eYXjFgEWFjegISN3a7aN53vLQVtswUV8k08pZ5ERf1kJQfv5o3AwTCcNXJkBzGLSnZ+IlkxsU6SZqAl+YyD/nKmftMsy1FIv5ePsj6cec
    ekFaQOGONE0wVsXpWd8IG0M8Age0fkkkVwKsgJTqD6JVtNmFI/g4Ug7MejYv1INEhpruSMsQcJ1Py/Wf8HYfwpfbRg+ci8LQBZCuRxeYFmNtX3g5zdvXkoj7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=PVlTmr12USHje_F057EA:9 a=QEXdDO2ut3YA:10
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeE1G7i (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 02:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbeE1G7h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 02:59:37 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org
Subject: [PATCH -tip v4 00/27] kprobes: Cleanup jprobe implementation
Date: Mon, 28 May 2018 15:59:09 +0900
Message-Id: <152749074878.15132.16693721906742461289.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

Since we decided to remove jprobe from kernel last year,
its APIs are disabled and we worked on moving in-kernel
jprobe users to kprobes or trace-events. And now no jprobe
users are here anymore.

This is the 4th version of the series for removing jprobe.
Previous version is here:

 https://lkml.org/lkml/2018/5/16/1052

Unlike previous versions, this version removes jprobe from
all architectures, as Ingo asked me in the previous thread.

I marked this as RFC again because it introduced changes for
many arch. It should be reviewed by some arch which is not
simply removing code (e.g. powerpc, arm).

BTW, this series are based on -tip tree as same as its
previous version, and I'm sure it can be applied to
linus tree/linux-next too.

Series structure
=====
Basically this series introduces 3 major changes;

- Remove jprobe implementation ([2/27] - [12/27])

- Remove break_handler() related code ([13/27] - [23/27])
  This should be done after (or with) removing jprobe
  because break_handler is only used by jprobe.
 (I'm not so sure, should I merge above patches into one
  arch-wide patch as next one does?)

- Clean current_kprobe and enable preempt if pre_handler()
  returns !0 ([24/27] and [25/27]<- x86 specific update)
  This also depends on above patches because those
  current_kprobe and preemption are expected to be adjusted
  by jprobe implementation via break_handler.

And some minor changes;

- Document cleanup and update ([1/27], [26/27])

And finally remove jprobe stub APIs and break_handler
from kprobes.h ([27/27]). Of course this depends on
above patches.

Since removing jprobes and break_handler related code
involve archtecture specific changes in some archs,
I splitted it for each arch. But "clean current_kprobe and
enable preempt if pre_handler() returns !0" patch modifies
all architectures, since it changes expected kprobe
handler behavior. I think this would be better done in
one patch for consistency.

Result
=====
I've tested it with kprobe sanity test on x86-64, and arm64
but for other archs, I just did cross-build test.

With this series, we finally cleanup all jprobe code
and break_handler as below.

$ git grep -wi break_handler | wc -l
0
$ git grep -wi jprobe | wc -l
0

Actually, there is one place where mentioning jprobe,
Documentation/kprobes.txt explains jprobe is deprecated
and how to migrate jprobe user to ftrace or kprobe.
I didn't remove it because it might be useful for
some users.

Thank you,

---

Masami Hiramatsu (27):
      Documentation/kprobes: Fix to remove remaining jprobe
      kprobes: Remove jprobe API implementation
      kprobes/x86: Remove jprobe implementation
      ARC: kprobes: Remove jprobe implementation
      ARM: kprobes: Remove jprobe arm implementation
      arm64: kprobes: Remove jprobe implementation
      powerpc/kprobes: Remove jprobe powerpc implementation
      ia64: kprobes: Remove jprobe implementation
      MIPS: kprobes: Remove jprobe implementation
      s390/kprobes: Remove jprobe implementation
      sh: kprobes: Remove jprobe implementation
      sparc64: kprobes: Remove jprobe implementation
      kprobes: Don't check the ->break_handler() in generic kprobes code
      kprobes/x86: Don't call ->break_handler() in x86 kprobes
      ARC: kprobes: Don't call the ->break_handler() in ARC kprobes code
      ARM: kprobes: Don't call the ->break_handler() in arm kprobes code
      arm64: kprobes: Don't call the ->break_handler() in arm kprobes code
      powerpc/kprobes: Don't call the ->break_handler() in arm kprobes code
      ia64: kprobes: Don't call the ->break_handler() in ia64 kprobes code
      MIPS: kprobes: Don't call the ->break_handler() in MIPS kprobes code
      s390/kprobes: Don't call the ->break_handler() in s390 kprobes code
      sh: kprobes: Don't call the ->break_handler() in SH kprobes code
      sparc64: kprobes: Don't call the ->break_handler() in sparc64 kprobes code
      bpf: error-inject: kprobes: Clear current_kprobe and enable preempt in kprobe
      x86: kprobes: Do not disable preempt on int3 path
      Documentation: kprobes: Add how to change the execution path
      kprobes: Remove jprobe stub API


 Documentation/kprobes.txt                      |   35 +++++-
 arch/arc/include/asm/kprobes.h                 |    2 
 arch/arc/kernel/kprobes.c                      |   50 +--------
 arch/arm/include/asm/kprobes.h                 |    2 
 arch/arm/include/asm/probes.h                  |    1 
 arch/arm/probes/kprobes/core.c                 |  135 +-----------------------
 arch/arm64/include/asm/kprobes.h               |    1 
 arch/arm64/kernel/probes/kprobes.c             |   86 +--------------
 arch/ia64/include/asm/kprobes.h                |    2 
 arch/ia64/include/uapi/asm/break.h             |    1 
 arch/ia64/kernel/Makefile                      |    2 
 arch/ia64/kernel/jprobes.S                     |   90 ----------------
 arch/ia64/kernel/kprobes.c                     |   93 +----------------
 arch/mips/include/asm/kprobes.h                |   13 --
 arch/mips/kernel/kprobes.c                     |   70 ++----------
 arch/powerpc/include/asm/kprobes.h             |   12 --
 arch/powerpc/kernel/kprobes-ftrace.c           |   31 +-----
 arch/powerpc/kernel/kprobes.c                  |   92 +++-------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 +------
 arch/s390/include/asm/kprobes.h                |    2 
 arch/s390/kernel/kprobes.c                     |   86 +--------------
 arch/sh/include/asm/kprobes.h                  |    4 -
 arch/sh/kernel/kprobes.c                       |   72 +------------
 arch/sparc/include/asm/kprobes.h               |    1 
 arch/sparc/kernel/kprobes.c                    |   65 +-----------
 arch/x86/include/asm/kprobes.h                 |    5 -
 arch/x86/kernel/kprobes/common.h               |   10 --
 arch/x86/kernel/kprobes/core.c                 |  119 +--------------------
 arch/x86/kernel/kprobes/ftrace.c               |   31 ++----
 arch/x86/kernel/kprobes/opt.c                  |    1 
 include/linux/kprobes.h                        |   53 ---------
 kernel/fail_function.c                         |    3 -
 kernel/kprobes.c                               |  115 +-------------------
 kernel/test_kprobes.c                          |   94 -----------------
 kernel/trace/trace_kprobe.c                    |   11 +-
 lib/Kconfig.debug                              |    2 
 36 files changed, 125 insertions(+), 1306 deletions(-)
 delete mode 100644 arch/ia64/kernel/jprobes.S

--
Masami Hiramatsu (Linaro)
