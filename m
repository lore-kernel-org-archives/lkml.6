Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-722281-1525689853-2-4336420727055840023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525689852; b=CZTanBQZyyKjKLo2mGVWpwRp4j2aAqvualgfpTp30+sepZ/AUQ
    qLnIteHXJ/Qrr7pG2mKigq0iKomMZj5gsbnRFITKdfvqlf0zhBl+1A7g1nGH6yRG
    2IzTFAxhnKfBMCnD+9+s+MoKsS80xTgNgD7EN8mLUrtE5zhzZjjjhCpje/IkqFaN
    JLItmwgPGq+/Pt03kruwxsXG5t+Dhm5WanEdjVGmO5MmOVhBk8VuoiTdz1HxlAb7
    BBDKtghowViAjX2R+CT2qzBwrY5uWIQ/1HgS25wBl0eIDm7Ark7hBmVfGldnELN4
    bDrbqf/zBOH/8U013kiN3GWcnHoAzsxVouQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525689852; bh=Bp7vDzpz+pCdXECXxzQEAEvfW/rRUr
    h/y5k1GLReFz8=; b=iVlhIm3wjHx9lsKZ6Vuw1zucm5SR/DIKZ8d6LPdh9Kr62G
    q0SnNOyl/WmaYoTQAD71SsVMmA1lProJesJcWKH97A6GW4OPxri2WAQzqFRlJ/eO
    7Th5zCmsgjxoGDSpInElP+1RCSmML52nMNFdzwugajtfoIDWt24HfL+mDJeyKZeM
    E8rMDWH00T8IBuiOCu63TjeZw87pmdNKQ8saQvA3QsGzxcLxztHa8ORotuSgSDwX
    LCEIP+C42g5gWiBPwoRGoZ7nyWyniR/JrGIDhPV0mKqiIR4s9uD1WEeF+Oa0anUj
    ZbsnclL4eXIrEjTeuzhF50jw5l2UrI+dpAhIjqNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
    header.i=@amarulasolutions.com header.b=Vn99hAZf x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=t3wQERZD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amarulasolutions.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
      header.i=@amarulasolutions.com header.b=Vn99hAZf x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=t3wQERZD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amarulasolutions.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBW9pBQdFq/CIbaV+9wA5ll71LBj2r4UY3h6bwl56VXpaHKT+38Cd0Rfg2qbWgw/oFnbIUSMMKZAiLE9/rNtdjKykqukHkJh5RjbDYXtg5UqgUm2i4FJ
    5/rFb3Df2HXWcwNaxKhWH7jGcg98VGByZ5YBiTf3zs/pbDTJFyefmkWhUFdhFzm8F4IWvyBvRRy5NVrkkKhB+hrAjJA9RaSlntrniQG9KmLYAGAy2qaJN+gn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=iP-xVBlJAAAA:8 a=TbXG2AUtMZl5eaOsZIgA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=lHLH-nfn2y1bM_0xSXwp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeEGKoK (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 06:44:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51774 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeEGKoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 06:44:09 -0400
X-Google-Smtp-Source: AB8JxZrU0iSCIr1WI1iuRk2UE2hrH0GSp0MHob+CT0SGrQ3Bcu6pu0YB0ta29Q0VBrATdgP/1kZ5Og==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 0/6] Documentation/features: Provide and apply 'features-refresh.sh'
Date: Mon,  7 May 2018 12:43:37 +0200
Message-Id: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This series provides the script 'features-refresh.sh', which operates on
the arch support status files, and it applies this script to refresh the
status files in place; previous discussions about this series are at [1].

The series is organized as follows.

  - Patch 1/6 adds the script to 'Documentation/features/scripts/'.

  - Patch 2/6 presents the results of running the script; this run
    also printed the messages

       WARNING: 'HAVE_BPF_JIT' is not a valid Kconfig
       WARNING: '__HAVE_ARCH_STRNCASECMP' is not a valid Kconfig
       WARNING: 'Optimized asm/rwsem.h' is not a valid Kconfig
       WARNING: '__HAVE_ARCH_PTE_SPECIAL' is not a valid Kconfig

    to standard output.

  - Patches 3-6/6 fix each of these warnings.

(Applies on -rc4.)

Cheers,
  Andrea

[1] http://lkml.kernel.org/r/1523205027-31786-1-git-send-email-andrea.parri@amarulasolutions.com
    http://lkml.kernel.org/r/1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com
    http://lkml.kernel.org/r/20180328122211.GA25420@andrea

Changes in v3:
  - rebase on -rc4

Changes in v2:
  - support negation operators in Kconfig (suggested by Ingo Molnar)
  - reorder patches 2/6 and 3/6 (suggested by Ingo Molnar)
  - add patches 4-6/6 (suggested by Ingo Molnar)

Andrea Parri (6):
  Documentation/features: Add script that refreshes the arch support
    status files in place
  Documentation/features: Refresh the arch support status files in place
  Documentation/features/core: Add arch support status files for
    'cBPF-JIT' and 'eBPF-JIT'
  Documentation/features/locking: Use '!RWSEM_GENERIC_SPINLOCK' as
    Kconfig for 'rwsem-optimized'
  Documentation/features/lib: Remove arch support status file for
    'strncasecmp'
  Documentation/features/vm: Remove arch support status file for
    'pte_special'

 .../features/core/BPF-JIT/arch-support.txt         | 31 -------
 .../features/core/cBPF-JIT/arch-support.txt        | 33 ++++++++
 .../features/core/eBPF-JIT/arch-support.txt        | 33 ++++++++
 .../core/generic-idle-thread/arch-support.txt      |  4 +-
 .../features/core/jump-labels/arch-support.txt     |  2 +
 .../features/core/tracehook/arch-support.txt       |  2 +
 .../features/debug/KASAN/arch-support.txt          |  4 +-
 .../debug/gcov-profile-all/arch-support.txt        |  2 +
 Documentation/features/debug/kgdb/arch-support.txt |  4 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |  2 +
 .../features/debug/kprobes/arch-support.txt        |  4 +-
 .../features/debug/kretprobes/arch-support.txt     |  4 +-
 .../features/debug/optprobes/arch-support.txt      |  4 +-
 .../features/debug/stackprotector/arch-support.txt |  2 +
 .../features/debug/uprobes/arch-support.txt        |  6 +-
 .../debug/user-ret-profiler/arch-support.txt       |  2 +
 .../features/io/dma-api-debug/arch-support.txt     |  2 +
 .../features/io/dma-contiguous/arch-support.txt    |  4 +-
 .../features/io/sg-chain/arch-support.txt          |  2 +
 .../features/lib/strncasecmp/arch-support.txt      | 31 -------
 .../locking/cmpxchg-local/arch-support.txt         |  4 +-
 .../features/locking/lockdep/arch-support.txt      |  4 +-
 .../locking/queued-rwlocks/arch-support.txt        | 10 ++-
 .../locking/queued-spinlocks/arch-support.txt      |  8 +-
 .../locking/rwsem-optimized/arch-support.txt       | 10 ++-
 .../features/perf/kprobes-event/arch-support.txt   |  6 +-
 .../features/perf/perf-regs/arch-support.txt       |  4 +-
 .../features/perf/perf-stackdump/arch-support.txt  |  4 +-
 .../sched/membarrier-sync-core/arch-support.txt    |  2 +
 .../features/sched/numa-balancing/arch-support.txt |  6 +-
 Documentation/features/scripts/features-refresh.sh | 98 ++++++++++++++++++++++
 .../seccomp/seccomp-filter/arch-support.txt        |  6 +-
 .../time/arch-tick-broadcast/arch-support.txt      |  4 +-
 .../features/time/clockevents/arch-support.txt     |  4 +-
 .../time/context-tracking/arch-support.txt         |  2 +
 .../features/time/irq-time-acct/arch-support.txt   |  4 +-
 .../time/modern-timekeeping/arch-support.txt       |  2 +
 .../features/time/virt-cpuacct/arch-support.txt    |  2 +
 .../features/vm/ELF-ASLR/arch-support.txt          |  4 +-
 .../features/vm/PG_uncached/arch-support.txt       |  2 +
 Documentation/features/vm/THP/arch-support.txt     |  2 +
 Documentation/features/vm/TLB/arch-support.txt     |  2 +
 .../features/vm/huge-vmap/arch-support.txt         |  2 +
 .../features/vm/ioremap_prot/arch-support.txt      |  2 +
 .../features/vm/numa-memblock/arch-support.txt     |  4 +-
 .../features/vm/pte_special/arch-support.txt       | 31 -------
 46 files changed, 279 insertions(+), 128 deletions(-)
 delete mode 100644 Documentation/features/core/BPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/cBPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/eBPF-JIT/arch-support.txt
 delete mode 100644 Documentation/features/lib/strncasecmp/arch-support.txt
 create mode 100755 Documentation/features/scripts/features-refresh.sh
 delete mode 100644 Documentation/features/vm/pte_special/arch-support.txt

-- 
2.7.4
