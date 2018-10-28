Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DABC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449820665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQZif+m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJ1VzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:55:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39588 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1VzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:55:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so2683771pfe.6;
        Sun, 28 Oct 2018 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a+uZnQjGCbsXseSwUo5wUtoaCf6Nw0+ZZ3aq20GQFyM=;
        b=DQZif+m6q/Y9+aJtbFY/tv5O0rjYtjChPttY+vlar+LiCtfBeF1kPecN42FespMjeV
         RjqXuVgnRJn00oi/8i22rABoxzKzQZiWlpXF8dnBt6qn0HUpPEQHlqRxxzFTJQDbQGbW
         c1Eki2bEZ5bPa2u+2BF/VsoJQr6juNc8bq0O1TQm02UNNwCm8E+ko9nu8+zV24lUu0TJ
         9vafOwr0ELic0VxHnLrJa/ykFmwkwGLraIRDKizpP+WR8jDilkP1ig6h5RBH20c6yyK5
         OFaOYPjNuprG0eDf2QuUzjDAi1cFkWupoZnsxBS1iDcOCZVaPLStPh7+BbsnCJ89/h6B
         umOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a+uZnQjGCbsXseSwUo5wUtoaCf6Nw0+ZZ3aq20GQFyM=;
        b=rAQJSJQ3aMAgwcyKMpMLpZkZMdxyTdvZWOhho1gxbC2Mr9wtwuG+Po76ct/4uIXk35
         TmZ7oFv98yFy1/CNB93geSMl6jwMgkc+oDLvpPMLT8a7Lk7wmok0Juq8anZKpnuj3LxR
         W60HBgYxxOJhCaNT2GBeLrFo4QduH7+FyiXnmsibP3BRsktnulStNGlaXlR0SK2flZ+y
         YZE3hcImTUX4pidcd53QiyPAT7NWrqFtPRIZehtZcFWRG/ACfvOxBdcjJpnftnSXnJuL
         gVeIfL1bNkH2XKc/hyEqp60jaPRPymro8DoPc4NdejzfZ5FlJ5zNg9BO6ocLtcI/gyPF
         lSHw==
X-Gm-Message-State: AGRZ1gJf+XC22HjpusA0Xr5wDh8HzbgN74cjWIyq94Q8+vWP0oO0i1JF
        bQN57O7M/v7Bub9zBJ1/Ckw=
X-Google-Smtp-Source: AJdET5cevle15cUqqywgMXQ+37HiZ1QqzE+wlln/nJHmgAGQDVK4+aI1KT2PfibXDE+OZ3MgqOqrrg==
X-Received: by 2002:a65:620f:: with SMTP id d15-v6mr1128471pgv.120.1540732226251;
        Sun, 28 Oct 2018 06:10:26 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id e3-v6sm24520585pgc.71.2018.10.28.06.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 06:10:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 0/4] kernel hacking: GCC optimization for better debug experience (-Og)
Date:   Sun, 28 Oct 2018 13:09:41 +0000
Message-Id: <20181028130945.23581-1-changbin.du@gmail.com>
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
kernel relies on GCC optimization to remove some dead code, so '-O0' just
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

v3:
  o Take suggestions from Masahiro Yamada.
v2:
  o rebase on top of mainline.

Changbin Du (4):
  x86/mm: declare check_la57_support() as inline
  kernel hacking: new config NO_AUTO_INLINE to disable compiler
    auto-inline optimizations
  ARM: mm: fix build error in fix_to_virt with
    CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
  kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
    optimization

 Makefile                     | 11 +++++++++++
 arch/arm/mm/mmu.c            |  2 +-
 arch/x86/kernel/head64.c     |  2 +-
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 20 ++++++++++++++++++++
 kernel/configs/tiny.config   |  1 +
 lib/Kconfig.debug            | 17 +++++++++++++++++
 8 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.17.1

