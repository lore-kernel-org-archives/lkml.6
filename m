Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEBE216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwjWDv0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEBE216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI0Ue0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:34:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0Ue0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:34:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so2043810pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5v5WcGr49kGaN0XeDr98CS5NbxRg0/ym6KRtx0aZm4A=;
        b=EwjWDv0uQViylzYWaOafc7yx0Irg+1oTSUitjJbYt+Q8++JTn0muSJHAG/0Kg6P3tO
         bjHXpgcnp51FVs2bTbKddVpeJ2o9PvhmnxR4L6K3qyam9BQdW1YxsAHzogsTe6NA1+nz
         UcYLp+uYiTs7Y07/Fc80B4r+9FEmiCJGFT6kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5v5WcGr49kGaN0XeDr98CS5NbxRg0/ym6KRtx0aZm4A=;
        b=NMp4wuv/ceHhs/25gVHOb48DwoTUcrAUEn+lIrMYqHvZCoQsSuxroFrNUByDbkHC5b
         dB9S4UgFHlg/jCC3stH1Do7ZdQhlnGbzl9U+480wVRwt1QvmJEOCY6VNSBMTbeGM4nCI
         xoaYrVnW2V9KqNFaXZzzmSnCcQj9FAw9UOl70sYgO0LQSSUGf+Eii4cIWXHINcDuHqA+
         DBZ4J6upECYWWLyZPCa5y/Rtmfv+eevi4JRJG0X866XKl7X8af26ReUsd/rXbESLQVvm
         5u9q6VlPuJgtuJe3iInEKFLJaeOt+SfLT7tHovXLrP/CTev0Y9d2S3ea0atlOUfwQ+IX
         px4g==
X-Gm-Message-State: ABuFfogjxzR1Mkbjo9ACw+CeZLFUqqgfuWgu5X+gi/F1k83ESoTPeAyS
        5xVw23r35wXwc78WBE9slPjaHw==
X-Google-Smtp-Source: ACcGV61pN6PSapDs4PWCgTkK9FpNAQGJDyMj7Zx35eUYvdc64pPgTvLXdUnwqBSTYlfw04W8OcUWuA==
X-Received: by 2002:a17:902:509:: with SMTP id 9-v6mr11434653plf.155.1538057757899;
        Thu, 27 Sep 2018 07:15:57 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id m20-v6sm110399pfj.171.2018.09.27.07.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:15:57 -0700 (PDT)
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
Subject: [PATCH v2 0/7] System call table generation support
Date:   Thu, 27 Sep 2018 19:45:13 +0530
Message-Id: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
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

Added an extra patch to add __NR_old_getpagesize macro.
Added an extra patch to keep __IGNORE* entries in asm/unistd.h.

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (7):
  ia64: add __NR_old_getpagesize macro
  ia64: replace NR_syscalls macro from asm/unistd.h
  ia64: add an offset for system call number
  ia64: replace the system call table entries from entry.S
  ia64: add system call table generation support
  ia64: uapi header and system call table file generation
  ia64: add __IGNORE* entries in asm/unistd.h

 arch/ia64/Makefile                      |   3 +
 arch/ia64/include/asm/Kbuild            |   1 +
 arch/ia64/include/asm/unistd.h          |  13 +-
 arch/ia64/include/uapi/asm/Kbuild       |   1 +
 arch/ia64/include/uapi/asm/unistd.h     | 334 +-------------------------------
 arch/ia64/kernel/entry.S                | 333 +------------------------------
 arch/ia64/kernel/syscall_table.S        |  12 ++
 arch/ia64/kernel/syscalls/Makefile      |  40 ++++
 arch/ia64/kernel/syscalls/syscall.tbl   | 328 +++++++++++++++++++++++++++++++
 arch/ia64/kernel/syscalls/syscallhdr.sh |  35 ++++
 arch/ia64/kernel/syscalls/syscalltbl.sh |  34 ++++
 11 files changed, 469 insertions(+), 665 deletions(-)
 create mode 100644 arch/ia64/kernel/syscall_table.S
 create mode 100644 arch/ia64/kernel/syscalls/Makefile
 create mode 100644 arch/ia64/kernel/syscalls/syscall.tbl
 create mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

