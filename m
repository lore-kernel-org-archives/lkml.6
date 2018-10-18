Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E92C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25E221476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ffNfOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25E221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeJSA16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:27:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36998 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSA16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:27:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so15118314pfi.4;
        Thu, 18 Oct 2018 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eswFvXY3QOXKeqz4iX0KykGT9Z/UnnIsiENX5EkGwfM=;
        b=e6ffNfOJp6ZDpEVjOd3pQmo9VP3kQcduFMURH5eeBPw5y/cCOANG/A65+Yc2jIUewE
         Gs4kl8TJA7lPCu2S41sk5a4W+DRUUITwx9FnlnwzVvIf2VE7Y0x+u+CluZCg4ccO1idK
         dwa+ygs2Q2WYzZJcnymmY5uEnivmjYAKzsx7fjT66Fyng5WLKzK7qrj7kWhJsK/9lgH7
         6K/pf+n2SATxkmXtJwAXPcJiTJyYGErtui79NHGtVuSnIUHzIqy1sW3oClKZslqY2Izk
         JRfNnl5KtvGsBWoYm4ASliEiUWbbLD4ESv8cV9VwFoeX1UQSsv3V6YH4OezNUtw2W00c
         mp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eswFvXY3QOXKeqz4iX0KykGT9Z/UnnIsiENX5EkGwfM=;
        b=nNKvQgn+xUqRdjM/M3k+aZRl5msO5Wf+n6t0Y0RaZPgQRJf3jyGP5c2ecQ/2BDgmki
         sm1e0l19Kn3J7/Ou4PTiSUdVy3xHVqUQOuf6q8UaiBAUMrDgkf/pV6qpPsSBzpir9vDY
         9dL3r47+6sWpxkdxjuHFTGawc9owChQHAsaHpHav9yUPdeXr3M1eJqs5wRzCKDGS/nE4
         gaTgUmiAFykqU3KUChSeZJntcmAMjm8YB+ZoaXY8lwZDEZPoO5oSPST9MiUWHfJb3a05
         KUBRBJgt1KHlj/YEfHvc6oO/4zGLQXkeDDIqAne+3F3d7ck7vcl7VNQoGv1iIzFsYQ39
         eBAg==
X-Gm-Message-State: ABuFfogxytPXyeQeulIJClKRbbvv5d7d80qJ4u2fMa5vExYFfyX2mpnw
        Ed4787pagzapnYB1Gg+rpx0=
X-Google-Smtp-Source: ACcGV63syWZzXMDeAgJBNjDc4ndj4WaPZqRWg1wPhylWtMU/lJ0xR38gkidKMTIYM5YvDPhDVqnKyA==
X-Received: by 2002:a63:6946:: with SMTP id e67-v6mr28935736pgc.119.1539879973377;
        Thu, 18 Oct 2018 09:26:13 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27813420pgt.83.2018.10.18.09.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:26:12 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, Du Changbin <changbin.du@gmail.com>
Subject: [PATCH 0/4] kernel hacking: GCC optimization for better debug experience (-Og)
Date:   Thu, 18 Oct 2018 16:25:44 +0000
Message-Id: <20181018162548.6399-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have posted this series several months ago but interrupted by personal
affairs. Now I get time to complete this task. Thanks for all of the
reviewers.

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


Changbin Du (4):
  x86/mm: surround level4_kernel_pgt with #ifdef
    CONFIG_X86_5LEVEL...#endif
  kernel hacking: new config NO_AUTO_INLINE to disable compiler
    auto-inline optimizations
  ARM: mm: fix build error in fix_to_virt with
    CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
  kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
    optimization

 Makefile                          | 11 +++++++++++
 arch/arm/mm/mmu.c                 |  2 +-
 arch/x86/include/asm/pgtable_64.h |  2 ++
 arch/x86/kernel/head64.c          | 13 ++++++-------
 include/linux/compiler-gcc.h      |  2 +-
 include/linux/compiler.h          |  2 +-
 init/Kconfig                      | 19 +++++++++++++++++++
 lib/Kconfig.debug                 | 25 +++++++++++++++++++++++++
 8 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.17.1

