Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC62C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575320866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnaBsW3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5575320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeINNkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:40:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42785 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeINNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:40:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so3855967plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xgvBC8CKG1XfG1Xc4QhAuPKleHXf+h1dW+V2YwUIXNQ=;
        b=LnaBsW3nSn2IUjm91vgdenzQLIs5ZjtTxknBqMYLu/jcUgPY8bN2+STD30sUfNot/M
         7+HwRKC7yA+Y2rVeCEeYs6BlumUAXTp4CupZ+dLbfwynbaiTIiEnc3aMPdUBhNMRJ54E
         5N9RrL0o3pX9a1h8fAR0kFsqGz0Avt3JFsl0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xgvBC8CKG1XfG1Xc4QhAuPKleHXf+h1dW+V2YwUIXNQ=;
        b=qo2bQrhuNGiVKSqI4PMhThUUThGPvlAqhg5UCc1ptQ1DOINAQRDSRa9NVJ8sYGWXxU
         rFoVOZCfrRImgOr1SlHE2dFN9zZC7HugTTWRoCuK/d9xNf/s9aTuO51sJ+AQ0/SXlkc+
         J7aeUSrqk4YpXmIEfqU7RMcPsoK8Uoxt6HwgY/oBnkMblX87DH6JprxJcmFV2caQY7AM
         BbvrQQYEjmPw3soA9oLJnLL/zmQ8AvTnUIOJos5+hylM6X4K+QfEbHjlLxsN0d4/R/Ae
         q+ksXyXV91R7Ck6+ahoWHekQIGheB8Jfz0Jh4CVp5A/evmvMrdt2+a7xkN5XwdTZrRD6
         WtoQ==
X-Gm-Message-State: APzg51Dyl/Gmbt+Hh+TZPzPun7/p4gzIDzu+GVEoR6hVuGvuYzFyt9IT
        migMOd/Yc/6P+ntfF7hvdx40bg==
X-Google-Smtp-Source: ANB0VdZtUfZ9YP3G1yXOgcRtRXI2jOG8Ent5g9/NUjGF3o0xFgvufvXCN6f0uBnXlPtSGD7+PXVZDQ==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1-v6mr11018070plb.86.1536913637608;
        Fri, 14 Sep 2018 01:27:17 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id q80-v6sm8919855pfd.15.2018.09.14.01.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:27:17 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Thibaut Varene <T-Bone@parisc-linux.org>,
        linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/4] System call table generation support
Date:   Fri, 14 Sep 2018 13:56:39 +0530
Message-Id: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is:
1. We can easily add/modify/delete system call by changing entry 
in syscall.tbl file. No need to manually edit many files.

2. It is easy to unify the system call implementation across all 
the architectures. 

The system call tables are in different format in all architecture 
and it will be difficult to manually add or modify the system calls
in the respective files manually. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify them across all architectures.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
        - Compat entry name, if required.

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, m68k, microblaze, 
ia64, mips, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

I started working system call table generation on 4.17-rc1. I used 
marcin's script - https://github.com/hrw/syscalls-table to generate 
the syscall.tbl file. And this will be the input to the system call 
table generation script. But there are couple system call got add 
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file - 
syscall.tbl and once all review got over I'll update syscall.tbl 
alone w.r.to the tip of the kernel. The impact of this thing, few 
of the system call won't work. 

Firoz Khan (4):
  parisc: Move __IGNORE* entries to non uapi header
  parisc: Replace __NR_Linux_syscalls macro with __NR_syscalls
  parisc: Add system call table generation support
  parisc: uapi header and system call table file generation

 arch/parisc/Makefile                       |   4 +
 arch/parisc/include/asm/Kbuild             |   3 +
 arch/parisc/include/asm/unistd.h           |   8 +
 arch/parisc/include/uapi/asm/Kbuild        |   2 +
 arch/parisc/include/uapi/asm/unistd.h      | 377 +----------------------
 arch/parisc/kernel/syscall.S               |  14 +-
 arch/parisc/kernel/syscall_table.S         | 459 -----------------------------
 arch/parisc/kernel/syscall_table_32.S      |  11 +
 arch/parisc/kernel/syscall_table_64.S      |  19 ++
 arch/parisc/kernel/syscalls/Makefile       |  52 ++++
 arch/parisc/kernel/syscalls/syscall_32.tbl | 358 ++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscall_64.tbl | 357 ++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh  |  38 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh  |  36 +++
 14 files changed, 896 insertions(+), 842 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscall_table_32.S
 create mode 100644 arch/parisc/kernel/syscall_table_64.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

