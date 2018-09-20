Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725AEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BC421526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0toVegQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC421526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeITUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:50:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36762 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeITUuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:50:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so4492445plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K2RQxGZKyXtMtWyGJE3WIpbleM3eQi9cj2TAc+0eZi8=;
        b=J0toVegQoKcUL07PNhjWlVaP0QbceAFqcwjilF2gQgzelQ2o7fGzwxjxiD3tOLJD0l
         u5CwVMgQZlmD3Ws1JeGmfS+Cu4CRA1cs9rCXNDUjFcqa0P5XFlqCUpfzt3zV5h0xLlmI
         GdcE15xTiiI+F57FhfRbG20uQvzkOJB606png=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K2RQxGZKyXtMtWyGJE3WIpbleM3eQi9cj2TAc+0eZi8=;
        b=m6Tsut3fVM7Vfg68s6+HsK6DTb+oLrBaS1dipg13L3q6Ac2iEfhfPZSjULtQ2zlpW+
         GTsrpCyd2q1214LJdBPj4wjqGFdb2PYsiOPg3//5JBC0BUUuUHHermhFXjFTVB105yx/
         pmW8sSFFcMRNKMWAhB57y/oqqPXn21p2XbIFbuAicnR7tLE/mDlzz8HMz3xUvbN3vCKF
         8gIFD7/mFtVORA0BR89c/tJDCoJx4qmjrTTIT1dSnG8/jvB/j9ZOu8aAEkkFZOolzCuA
         0uRjdiiTFS0hpYqGuuZR/YWkidRy/UVIRthMHHdKFRdS4ym3Tta/ErZrIledAu6SrCEd
         6/0g==
X-Gm-Message-State: APzg51AK113eUR5u4NPIWHo3Hoa+oBP2LuV5eyxXEoL0tjN5beyMLwU0
        qILn6xQy6PCyqqqyKOtfAxllbA==
X-Google-Smtp-Source: ANB0VdahNmrBLlJeJbkvHUka+XzTo1F60AMNxt4lALJL/RvG0tgWlFwTY7lNuSHW0aYOQD8NL8j91g==
X-Received: by 2002:a17:902:f213:: with SMTP id gn19mr39976413plb.266.1537456002845;
        Thu, 20 Sep 2018 08:06:42 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.107.142])
        by smtp.gmail.com with ESMTPSA id k64-v6sm36222991pfg.141.2018.09.20.08.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 08:06:42 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 0/5] System call table generation support
Date:   Thu, 20 Sep 2018 20:36:08 +0530
Message-Id: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for alpha, microblaze, sparc,
mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Added an extra patch to keep __IGNORE* entries in asm/unistd.h.

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (5):
  m68k: Rename system call table file name
  m68k: Replace NR_syscalls macro from asm/unistd.h
  m68k: Added system call table generation support
  m68k: uapi header and system call table file generation
  m68k: added __IGNORE* entries in asm/unistd.h

 arch/m68k/Makefile                      |   3 +
 arch/m68k/include/asm/Kbuild            |   1 +
 arch/m68k/include/asm/unistd.h          |  10 +-
 arch/m68k/include/uapi/asm/Kbuild       |   1 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
 arch/m68k/kernel/Makefile               |   2 +-
 arch/m68k/kernel/syscall_table.S        |  14 ++
 arch/m68k/kernel/syscalls/Makefile      |  37 +++
 arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  39 ++++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
 arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
 12 files changed, 502 insertions(+), 790 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalltable.S

-- 
1.9.1

