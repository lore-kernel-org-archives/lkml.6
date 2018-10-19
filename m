Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FB5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EC72148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtTACl8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EC72148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJSUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:55:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45710 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJSUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:55:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so16424699pfn.12;
        Fri, 19 Oct 2018 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v53VOhpvdqD2goKHpsQ31/M2H7LSlO0Giftj6gqCpzg=;
        b=mtTACl8X76edZoze9nxR73GDDbGqUyhTRIlLL+bOUR6FPqocBwvlK9ofX9R7+3owJn
         vBH28NH6R/uCNbRoy5OcO+n1Bd/1mvIycd8OoK4D+ORQLAc+Nxbj7MgBSfPq+Ke0n7wO
         A4JBXPsdGR+pkGU/zU1jw5m9XMUnhaaiLfLfdOcnCFv5UeifWZs+turyAqRywX0SUA9g
         KlNdl3cYTzMgoGX3jUnCMYc3/OtZxATo3Z9SK0nDbdcKu3oJE3zrm+lFaufAgG53YF4b
         RSr6fRGiVVwjSd8zMyqa927bdkvs6jMK2VrRqgdU7veVqDTSVZ9W/ng7Vj+fk6X3tUHb
         BF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v53VOhpvdqD2goKHpsQ31/M2H7LSlO0Giftj6gqCpzg=;
        b=IM/Phuulid1rD+kd9nFCraWF141mJ7vVaBG0ekvrHmxRcvx2Uc2SLoI7A6WHjkJYa4
         BwVakXM4QDFKGttHFg2ZDR5Fo1QL7n0Kacl+gZ9eAJnxuZt14SKZT9GaAcQR87DxxFDN
         ah+veCRK+1gzT8i5GRFZxDV5RExgRHrH3h4P2sNmdulQ6z42QXU5apvpVJWu6VAfcrvW
         x5A7ECxlLG9vi9ZzO/wyoyZM+IrdEvbSN89hoE/0MT+IteiXsPKXEPTWsC41hI8qhMQA
         54brCnEY9+cBo0AdOceZxHdpmZrwsad9EbCddWZvymsUmjIyBE2KwdgoHLFFBamvqzRw
         YUfg==
X-Gm-Message-State: ABuFfogg/nUjdBzgihBfWCa/qISa/tI+MGvmCEXkPuzgSSxgRKqhpCfn
        6sFDUdbYlNiNCSEANX7k2/s=
X-Google-Smtp-Source: ACcGV62GrHLHqWuXwacnk9262+wvFsfGTCyUKFAgk/7+W+wpnMFkpyhD6XDhJJELjm4BkOn7xId0hA==
X-Received: by 2002:a63:4384:: with SMTP id q126-v6mr32510375pga.142.1539953371467;
        Fri, 19 Oct 2018 05:49:31 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id o131-v6sm33640679pgo.53.2018.10.19.05.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:49:30 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v2 0/4] kernel hacking: GCC optimization for better debug experience (-Og)
Date:   Fri, 19 Oct 2018 12:49:17 +0000
Message-Id: <20181019124921.13780-1-changbin.du@gmail.com>
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


Du Changbin (4):
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
 lib/Kconfig.debug                 | 17 +++++++++++++++++
 8 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.17.1

