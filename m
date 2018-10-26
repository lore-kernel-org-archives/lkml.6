Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE07C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D785A20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKj77Ysq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeJZNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:42:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38937 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZNmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:42:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so4910408plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p9aMVaunxqt5375Wn53pZcPfpkGFKw4d+XwT+ySEfD0=;
        b=CKj77YsqiHzNFj3O5jGt/vNepkIoPe50fWpvqEPbJUF+7sDz5kbP183oXb+MRbbF2a
         5f0KgaxmZFbVfbLiSKd7rgtojTQ63pK/F1WTA/9z9lp9frGwlmV3XXSoPr6Sg4AIi1x0
         G7+5lZtqpBSi7LMruLpzHrPPpSYsutg6zO3kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p9aMVaunxqt5375Wn53pZcPfpkGFKw4d+XwT+ySEfD0=;
        b=L7yYIM//9OkJzmghWX7QNIu2jCrr80UhShU3GodFh2THaHmBGo6K6OePPKZOquN0mu
         qZWiHy9Q3r4vXCao256Yr7jp0rX9rHchuFLdjQVRGoYVpKuqAT/aCiqDKilThu/MpKIO
         7oFdLPubj3ihTGZko5qGVY6YiI91vnPxDjS063+JsprnpIA3yCQ70oMAFv1lwhX3f4yb
         aeTjsHcHCTGHjN2btSEbhKAKSuaqZ4gmvBe//lG7/Pq+Z0/XUamIrwc2ER7b9q0bI9Ct
         BrWzfBeV+IkehaOp2e3Avki2k9fr1rKT9TjYTmX0f6SzVm0uX0QISSRU9CVG72TUuwy0
         HUtw==
X-Gm-Message-State: AGRZ1gIaHA94BMH6046GCnrwhxmU+S9oGhOtpaSWrQcVmV6fXxsEinFs
        ZcB+83ZcwDzfmjDkdaSRrh7c/w==
X-Google-Smtp-Source: AJdET5ePge+C4ugxtKZQzlcsGcJMlfBqUmRlCfe/pFKzHFak+md3T5zTVuCM7zm1Bvn+d9o+gLOUtw==
X-Received: by 2002:a17:902:7142:: with SMTP id u2-v6mr2101752plm.154.1540530407615;
        Thu, 25 Oct 2018 22:06:47 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m18-v6sm12800626pfk.149.2018.10.25.22.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:06:47 -0700 (PDT)
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
Subject: [PATCH v4 0/4] m68k: system call table generation support
Date:   Fri, 26 Oct 2018 10:36:13 +0530
Message-Id: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is, we can easily add/modify/delete
system call table support by changing entry in syscall.tbl file 
instead of manually changing many files. The other goal is to unify 
the system call table generation support implementation across all 
the architectures. 

The system call tables are in different format in all architecture. 
It will be difficult to manually add, modify or delete the system 
calls in the respective files manually. To make it easy by keeping
a script and which'll generate uapi header file and syscall table 
file.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, ia64, microblaze,
mips, parisc, powerpc, sh, sparc, and xtensa. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038 issue. We need 
to add two dozen of system calls to solve Y2038 issue. So this patch
series will help to add new system calls easily by adding new entry 
in the syscall.tbl.

Firoz Khan (4):
  m68k: rename system call table file name
  m68k: add __NR_syscalls along with NR_syscalls
  m68k: add system call table generation support
  m68k: generate uapi header and syscall table header files

 arch/m68k/Makefile                      |   3 +
 arch/m68k/include/asm/Kbuild            |   1 +
 arch/m68k/include/asm/unistd.h          |   3 +-
 arch/m68k/include/uapi/asm/Kbuild       |   1 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
 arch/m68k/kernel/Makefile               |   2 +-
 arch/m68k/kernel/syscall_table.S        |  26 +++
 arch/m68k/kernel/syscalls/Makefile      |  38 +++
 arch/m68k/kernel/syscalls/syscall.tbl   | 389 ++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  32 +++
 arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
 12 files changed, 529 insertions(+), 790 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalltable.S

-- 
1.9.1

