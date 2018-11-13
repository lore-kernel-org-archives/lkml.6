Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03122C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDDE21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu0aT1zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDDE21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeKMQyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:54:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34766 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeKMQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:54:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so5547667plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VprZa0DdQPTH1MCx6zBDuDimJ12mnc/WHhTmG+Rc2ic=;
        b=cu0aT1zMxJM8KtLYAaaOU2E5f1quA0UP2uE+6D2bfuv6ZhbrX/dRg0Z6QGkonO+11d
         NLsRqaCdbCxybTTCWIdzpKkjVMa04gtGToXoQmtY29JMghFuq5IDMmWmR87DgN2slVzB
         1pxzBD6hihL2lQ0CTKjbfAU6RuVg0VMNDVPdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VprZa0DdQPTH1MCx6zBDuDimJ12mnc/WHhTmG+Rc2ic=;
        b=p/AdkLadW19E7rVCo1JJbamcYRipX7+v8ibCWDo4SP0wi/8x0kME74Bjn8RUxRkL6z
         M3Ffuw3SELdzL4K6QOOu+hAJ8DIh7m4Jzip1/9AdPZBDFxOSdshFjYx07LnHizr0iOac
         HRwYUt/Fdn4a/Yddqe8gIwsHetzcWPXXXAe9unlESzL0Dwdbm+uJ6hYwb7LnQBvawhfd
         Pgj0aEdb63yAUeFbrdL6e8qCCY5WTVr9ze+nFWjeBZo6Y7hOOVUyfnG4AonjVV4AT5AR
         GuIrgd5/5Qm9k49aafCGi+c7gAYeXjYJ5izrLx1PoI35G/sWEEN1q7zRxcUOdBZSbvVU
         s0jw==
X-Gm-Message-State: AGRZ1gIsCvmO50/6FpL8WONQO110pV429nenIDrOly1cAbmKaQulfLUe
        MGQ707Zas3E/UDWAJ5xoNZeazg==
X-Google-Smtp-Source: AJdET5eOAQJXzs9yfzlnN4ixITrC4DLBt+OD34N8Ql0fi3RLJsn4HOt2mYYdurQukyEredtoZB1qjQ==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9-v6mr4006993plt.106.1542092291297;
        Mon, 12 Nov 2018 22:58:11 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id s186-v6sm42437935pfs.164.2018.11.12.22.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:58:10 -0800 (PST)
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
Subject: [PATCH v5 0/5] ia64: system call table generation support
Date:   Tue, 13 Nov 2018 12:27:40 +0530
Message-Id: <1542092265-20956-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is, we can easily
add/modify/delete system call table support by cha-
nging entry in syscall.tbl file instead of manually
changing many files. The other goal is to unify the
system call table generation support implementation
across all the architectures.

The system call tables are in different format in
all architecture. It will be difficult to manually
add, modify or delete the system calls in the resp-
ective files manually. To make it easy by keeping a
script and which'll generate uapi header file and
syscall table file.

syscall.tbl contains the list of available system
calls along with system call number and correspond-
ing entry point. Add a new system call in this arch-
itecture will be possible by adding new entry in the
syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to
come up with a generic solution.

I have done the same support for work for alpha, m68k,
microblaze, mips, parisc, powerpc, sh, sparc and xtensa.
Below mentioned git repository contains more details
about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

changes since v4:
 - changed from generic-y to generated-y in Kbuild.

changes since v3:
 - optimized/updated the syscall table generation
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.
 - removed __IGNORE entries which was added in v2
   to suppress the warning.

changes since v2:
 - fixed the offset logic in the script.
 - added missing new line.

changes since v1:
 - enclosed __NR_sycalls macro with __KERNEL__.

Firoz Khan (5):
  ia64: add __NR_old_getpagesize in uapi header file
  ia64: add __NR_syscalls along with NR_syscalls
  ia64: add an offset for system call number
  ia64: add system call table generation support
  ia64: generate uapi header and system call table files

 arch/ia64/Makefile                      |   3 +
 arch/ia64/include/asm/Kbuild            |   1 +
 arch/ia64/include/asm/unistd.h          |   4 +-
 arch/ia64/include/uapi/asm/Kbuild       |   1 +
 arch/ia64/include/uapi/asm/unistd.h     | 332 +------------------------------
 arch/ia64/kernel/entry.S                | 331 +------------------------------
 arch/ia64/kernel/syscalls/Makefile      |  40 ++++
 arch/ia64/kernel/syscalls/syscall.tbl   | 337 ++++++++++++++++++++++++++++++++
 arch/ia64/kernel/syscalls/syscallhdr.sh |  36 ++++
 arch/ia64/kernel/syscalls/syscalltbl.sh |  32 +++
 10 files changed, 458 insertions(+), 659 deletions(-)
 create mode 100644 arch/ia64/kernel/syscalls/Makefile
 create mode 100644 arch/ia64/kernel/syscalls/syscall.tbl
 create mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

