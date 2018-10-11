Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2042AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D489820835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZmeZyRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D489820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJKLuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:50:50 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33449 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeJKLuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:50:50 -0400
Received: by mail-pg1-f171.google.com with SMTP id y18-v6so3543200pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IGRta191+Hdnfralo1BVH6Wiw1AVtQE2iK5bpidzpsw=;
        b=jZmeZyRiy8ggMTqeUcmCRofAOYv768eI2FFBywuDjDHBpN3DciCD5C2FhZoIYsFAGT
         8AjvskTw0aRZW8YkIKirum7GsdYe8B2et+pyneF66TGsyCAvd7aXAEk6vi4fBeB8hnu8
         4s7YISLtJVg9tMnJvRev9EdC2REV64W0WnaME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IGRta191+Hdnfralo1BVH6Wiw1AVtQE2iK5bpidzpsw=;
        b=jpIK5/It2Ps/Bj2/k/R6Ju7HW6Ow3e/Kkqd7LxT68vp2kFQ/8FAMaNJgbwmADScqqP
         dJJHrcxkH5dXOJvUBo0fCTqzYaUs2AYGvKWX7cNT+XojHoFfxZAGhp3GTlk75s4n2BdQ
         Pu33C8RbwRHJg5QKodY/3XcafBF3i7j7Nf5wW8OmQfQY2BCJYfOuvGO9CajGwR6MarPa
         bctPmYlPtbwFNhC/YwoFu0hDnkapSLGcPUivdMCVG8+R8901lwd2Rl3T+9frYrw6YBR9
         TlpCnUMTpdU7WVJAMdnvcYHF5m6U4Lz1Wa/sk3trtJMLAY6ip4QO6VQBUNzkziAch3Rn
         ktFw==
X-Gm-Message-State: ABuFfoi2y4fiiDkcHtyzt9fj8XHuYsGaNTlonZS0R6S6VUYKsBCvQ73G
        Of2uy2PJPnSCm8JReyDnbl2APw==
X-Google-Smtp-Source: ACcGV61FSinSkZNMXtZcKYmekovsZ17pUm1oI181u8XyRCYgyVKaQv8ozJjYL35I1bMIEYU0heEUdA==
X-Received: by 2002:a62:7d8d:: with SMTP id y135-v6mr37330536pfc.245.1539231926284;
        Wed, 10 Oct 2018 21:25:26 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n63-v6sm26113748pfn.9.2018.10.10.21.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 21:25:25 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 0/7] ia64: system call table generation support
Date:   Thu, 11 Oct 2018 09:54:48 +0530
Message-Id: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
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

In v3 patch series, I wired up perf_event_open, seccomp, pkey_
mprotect, pkey_alloc, pkey_free, statx, io_pgetevents and rseq 
system calls. This require an architecture specific implementation 
as it not present now.

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (7):
  ia64: add __NR_old_getpagesize in uapi/asm/unistd.h
  ia64: replace NR_syscalls macro from asm/unistd.h
  ia64: add an offset for system call number
  ia64: replace the system call table entries from entry.S
  ia64: add system call table generation support
  ia64: uapi header and system call table file generation
  ia64: wire up system calls

 arch/ia64/Makefile                      |   3 +
 arch/ia64/include/asm/Kbuild            |   1 +
 arch/ia64/include/asm/unistd.h          |   4 +-
 arch/ia64/include/uapi/asm/Kbuild       |   1 +
 arch/ia64/include/uapi/asm/unistd.h     | 332 +-----------------------------
 arch/ia64/kernel/entry.S                | 333 +-----------------------------
 arch/ia64/kernel/syscall_table.S        |   9 +
 arch/ia64/kernel/syscalls/Makefile      |  39 ++++
 arch/ia64/kernel/syscalls/syscall.tbl   | 353 ++++++++++++++++++++++++++++++++
 arch/ia64/kernel/syscalls/syscallhdr.sh |  35 ++++
 arch/ia64/kernel/syscalls/syscalltbl.sh |  37 ++++
 11 files changed, 483 insertions(+), 664 deletions(-)
 create mode 100644 arch/ia64/kernel/syscall_table.S
 create mode 100644 arch/ia64/kernel/syscalls/Makefile
 create mode 100644 arch/ia64/kernel/syscalls/syscall.tbl
 create mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

