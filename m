Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3620115-1526026812-2-78538892584164130
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526026812; b=LnrGnkQaD1FeZArek522swWtmzlV/0wP2d5eT9v2YQAID1F8rc
    FHYhDLnV1jHkKKZRDztxuzqeI35YG5h1UzFeuctJcJqUxmcyIWd13qAm3kt9LCqi
    XEn5XYKOFwKgV5Y17SezjE3Ky9B8xJzsfohYY+8WBthqsfgFDHFRZBOyBr19qZzy
    HnisjGiuQs2vmEivTJCB/OU6WIU9H5l7TaiE1J84T0fg3SWTxB3SYFz7A2Glj3Bl
    VHVT26RMLrgC6/Ed+3nfT5jOUl1Y0p2bPuV6IUXspJYrr/zX8STmuLWSnzsAzvHg
    1WTumaC0D6+hkQWb9cEzbpdja3z+EwKBpnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526026812; bh=Qa7FkYz6Mou702Hgjy3L7SZWjDCZ56
    i+V0mVw2Aarb8=; b=Hfwffwy/d1uSYfXPrt3iJjUgMzmob5gP5fxkoXvRPNlm4/
    QQ7N8wtSdesvdV3fhVbhXXb4GMhvTSaKRdu93VIZVA9veH3ZxXcAbzXuTIFJ3sIT
    ppiUi3KHPgOxAa8dibEt19UJCSperg1BmMLbY84tyDSbEkiBEB2mazhc3G9LDZ7P
    SzuJWgnky/LrymQB+VlzgbtrPYr+p10mtlYKZG4i+vOJdbXlWdp+pFU26SrhEb9w
    HnQQLji0Y/3p6RqwKddMZIMwA82LSba6lPhwBVQU/hxnQfU0YWWfoMGZJQrujOVG
    7rdPutnFduV/3z8ryxcLGkc61jABMDA1KYYCVJHg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK/uaE+NtiMgqALLPJoy4rL0s+lykFhTArShvmoH8s4zeOnYzDuQlbNfzOQ0iJpzCH524naGHZlMFBuVxOlszCQ7K8h4ESNEbGJsx5gmhdQ+DKaIzFZA
    m3hFxkd5Y4ULSWCBYCjpa40naEC9uAUMmt/nCKwHZx4ZpGppJ8EdW614r1uYPDx9oCp2Hb6zhvPgBHTQTs+v9kOh2FlU/T67mDYWhsD8Lkx/omN32l7vvB4b
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=D19gQVrFAAAA:8 a=6LfA-sCeOnnXfaMpjo4A:9 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeEKIUK (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 04:20:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:8561 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeEKIUJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 May 2018 04:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="55002580"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v5 0/4] kernel hacking: GCC optimization for better debug experience (-Og)
Date: Fri, 11 May 2018 16:09:43 +0800
Message-Id: <1526026187-11782-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

Hi all,
I know some kernel developers was searching for a method to dissable GCC
optimizations, probably they want to apply GCC '-O0' option. But since Linux
kernel replys on GCC optimization to remove some dead code, so '-O0' just
breaks the build. They do need this because they want to debug kernel with
qemu, simics, kgtp or kgdb.

Thanks for the GCC '-Og' optimization level introduced in GCC 4.8, which
offers a reasonable level of optimization while maintaining fast compilation
and a good debugging experience. It is similar to '-O1' while perferring to
keep debug ability over runtime speed. With '-Og', we can build a kernel with
better debug ability and little performance drop after some simple change.

In this series, firstly introduce a new config CONFIG_NO_AUTO_INLINE after two
fixes for this new option. With this option, only functions explicitly marked
with "inline" will  be inlined. This will allow the function tracer to trace
more functions because it only traces functions that the compiler has not
inlined.

Then introduce new config CC_OPTIMIZE_FOR_DEBUGGING which apply '-Og'
optimization level for whole kernel, with a simple fix in fix_to_virt().
Currently I have only tested this option on x86 and ARM platform. Other
platforms should also work but probably need some compiling fixes as what
having done in this series. I leave that to who want to try this debug
option.

Comparison of vmlinux size: a bit smaller.

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    22665554   9709674  2920908 35296136        21a9388 vmlinux

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    21499032   10102758 2920908 34522698        20ec64a vmlinux


Comparison of system performance: a bit drop (~6%).
    This benchmark of kernel compilation is suggested by Ingo Molnar.
    https://lkml.org/lkml/2018/5/2/74

    Preparation: Set cpufreq to 'performance'.
    for ((cpu=0; cpu<120; cpu++)); do
      G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
      [ -f $G ] && echo performance > $G
    done

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

     Performance counter stats for 'make -j8' (5 runs):

        219.764246652 seconds time elapsed                   ( +-  0.78% )

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

         233.574187771 seconds time elapsed                  ( +-  0.19% )

v5:
  o Exchange the position of last two patches to avoid compiling error.
v4:
  o Remove aready merged one "regulator: add dummy function of_find_regulator_by_node".

Changbin Du (4):
  x86/mm: surround level4_kernel_pgt with #ifdef
    CONFIG_X86_5LEVEL...#endif
  kernel hacking: new config NO_AUTO_INLINE to disable compiler
    auto-inline optimizations
  ARM: mm: fix build error in fix_to_virt with
    CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
  kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
    optimization

 Makefile                          | 10 ++++++++++
 arch/arm/mm/mmu.c                 |  2 +-
 arch/x86/include/asm/pgtable_64.h |  2 ++
 arch/x86/kernel/head64.c          | 13 ++++++-------
 include/linux/compiler-gcc.h      |  2 +-
 include/linux/compiler.h          |  2 +-
 init/Kconfig                      | 19 +++++++++++++++++++
 lib/Kconfig.debug                 | 17 +++++++++++++++++
 8 files changed, 57 insertions(+), 10 deletions(-)

-- 
2.7.4
