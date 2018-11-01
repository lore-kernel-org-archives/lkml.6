Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05426C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF262081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bg3hQDpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF262081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeKAW7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:59:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeKAW7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:59:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so5879544pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qj0H6KSKOBtfKDabJ0HskYVa1VvjJFP6J9GaMlrOBZ4=;
        b=Bg3hQDpAjwAKACpnuTe0mnU8qY5rd5YNP1Hd1kSbUYBexjYfepj+/HTllLctenVNj4
         HDh0QN3j/g5a/s5qtmTxUdZbWJd21kCtjRazRZpRtnRWbPKsG/v92CY/Ak9ZqMyLpIAO
         XS5EMdpLwhAl+Dps5a4udmU/gB0QNsdBDHvEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qj0H6KSKOBtfKDabJ0HskYVa1VvjJFP6J9GaMlrOBZ4=;
        b=d61Zhwd5XSgqMW9aMVdoML7hY/eio96rtmHfOG0pDXZL9B970dBvV5h+TR4t7QpRV2
         hOI09JHu7x9sUim9F0RnYJ24DYAKZWvWywV80I+Qa95GEl7osdT93CGERPoMpUBWpy6i
         9CwKYUjJ0r4n5mkG7B7QGh8Ln6f/nzgWjrOgUhsrOJgNdM7K9iM2ZXZ2LOBZ5dwiwQjz
         Vr63OJar78yP0O30zpKWeLylWUBrlVPpoa0/m1MXqxJFwpk2uZbN5ZXnoLJmNf20kKYZ
         LaD7W9FAn7PZIfe0Aqar0TRSKnzyq3wn8uRgyG5aSv7queop5XRd5PeiLd31uscePd6L
         J2iA==
X-Gm-Message-State: AGRZ1gKJpEpLpzH+53dzr0S202GyOVG9/SPuZc3hbZMJ60ZZeFi2rvxb
        NCncNhJK8xN6rrzkPssPgr3qsw==
X-Google-Smtp-Source: AJdET5eovoRRCBWd3Fxu/kHNBN5QIs0Ubgtw34FPwUJ8iTWSFkzAN+CuJsOpoNNSRVW+kqMsYCtESQ==
X-Received: by 2002:a63:6643:: with SMTP id a64-v6mr4498655pgc.15.1541080610216;
        Thu, 01 Nov 2018 06:56:50 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id m18-v6sm39076169pfk.149.2018.11.01.06.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:56:49 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v1 0/4] xtensa: system call table generation support
Date:   Thu,  1 Nov 2018 19:26:17 +0530
Message-Id: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
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
ilar support. I leverage their implementation to come
up with a generic solution.

I have done the same support for work for alpha, ia64,
m68k, microblaze, mips, parisc, powerpc, sh and sparc.
Below mentioned git repository contains more details 
about the workflow.

 https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to solve
Y2038 issue. So this patch series will help to add new 
system calls easily by adding new entry in the syscall.tbl.

Firoz Khan (4):
  xtensa: move SYS_XTENSA_* macros to non uapi header
  xtensa: add __NR_syscalls along with __NR_syscall_count
  xtensa: add system call table generation support
  xtensa: generate uapi header and syscall table header files

 arch/xtensa/Makefile                      |   3 +
 arch/xtensa/include/asm/Kbuild            |   1 +
 arch/xtensa/include/asm/unistd.h          |  20 +
 arch/xtensa/include/uapi/asm/Kbuild       |   1 +
 arch/xtensa/include/uapi/asm/unistd.h     | 798 +-----------------------------
 arch/xtensa/kernel/syscall.c              |   5 +-
 arch/xtensa/kernel/syscalls/Makefile      |  38 ++
 arch/xtensa/kernel/syscalls/syscall.tbl   | 374 ++++++++++++++
 arch/xtensa/kernel/syscalls/syscallhdr.sh |  36 ++
 arch/xtensa/kernel/syscalls/syscalltbl.sh |  32 ++
 10 files changed, 510 insertions(+), 798 deletions(-)
 create mode 100644 arch/xtensa/kernel/syscalls/Makefile
 create mode 100644 arch/xtensa/kernel/syscalls/syscall.tbl
 create mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

