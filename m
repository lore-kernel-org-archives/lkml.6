Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83269C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B392075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ig/BnqbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B392075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeJLRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:16:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41975 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:16:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so5593855pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hO+T6MknqT/LahgUoawf8dcvMXowT/Io7/ToBlxAOls=;
        b=ig/BnqbC9pqFq9SBOB+nD+czhAsusHjqTZ6jBM9x72/+2ziVhqO+kD/wKCAdPgYPzZ
         tC52vMNDuDX2WpRhmL+7E8MzD6hzafN2pem9swstWvTIZeAPN9IDsoHVE5LG+Bcu4Yqu
         rUH7yyOY8gdIyIImqA23LT71TBfCirfRq8rzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hO+T6MknqT/LahgUoawf8dcvMXowT/Io7/ToBlxAOls=;
        b=MfWarrZHACQu++aHQ5pBVyMxKt8XfnvQ61BV7i73Pnyqf245xY+zuTsBnsEBwj0Pyk
         4uddezc4O8BHNJnYY/f/hDaP0tdt7L09+iYoqN+mAV0zl4hWC4INi6smNa11n59IgnI1
         OPx49DGOLawHrX6siZ2G/pKpxYWbf/Uizpps2jgVopLK8nOZTFUeJzlTdUE/wFMHiP2y
         FyWxQyC5I6FrMj3yljus9rg9z+kYOBam/ODRRTOnxkh+1EAbrF8rppEiyUnT3LAifjyz
         G/OsRqoeqDo0VcIp1MBUYPE7CJmXf6gKb9pQ9msCxXy9Q9BFjFau6cfXcliqmYXeFZOw
         yw1Q==
X-Gm-Message-State: ABuFfoi9ODyJHmEJpoj/5wA+npCOuRnHUUyG5YtYIToBlP1a+zUw5KAx
        NBR4JZnRpWoBB2bvRXMSdGAVEQ==
X-Google-Smtp-Source: ACcGV60ggTcu7IBV/L0k0OijG3crQL24gKnCW/T/GLAV//Uo1lkjt786avvr381m/byZ09Wbhxl7DQ==
X-Received: by 2002:a62:507:: with SMTP id 7-v6mr5342224pff.80.1539337481575;
        Fri, 12 Oct 2018 02:44:41 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.108.175])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1254191pfi.137.2018.10.12.02.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:44:41 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 0/6] parisc: system call table generation support
Date:   Fri, 12 Oct 2018 15:13:56 +0530
Message-Id: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
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

The system call tables are in different format in all architecture. It
will be difficult to manually add, modify or delete the system calls
in the respective files manually. To make it easy by keeping a script 
and which'll generate uapi header file and syscall table file.

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
m68k, mips, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add two dozen of system calls to solve Y2038 issue. So this
patch series will help to add new system calls easily by adding new
entry in the syscall.tbl.

Firoz Khan (6):
  parisc: move __IGNORE* entries to non uapi header
  parisc: add __NR_Linux_syscalls along with __NR_syscalls
  parisc: add system call table generation support
  parisc: uapi header and system call table file generation
  parisc: wire up rseq system call
  parisc: syscalls: Ignore nfsservctl for other architectures

 arch/parisc/Makefile                      |   4 +
 arch/parisc/include/asm/Kbuild            |   3 +
 arch/parisc/include/asm/unistd.h          |   8 +
 arch/parisc/include/uapi/asm/Kbuild       |   2 +
 arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
 arch/parisc/kernel/syscall.S              |  10 +-
 arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
 arch/parisc/kernel/syscalls/Makefile      |  55 ++++
 arch/parisc/kernel/syscalls/syscall.tbl   | 371 ++++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh |  35 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh |  46 +++
 scripts/checksyscalls.sh                  |   1 +
 12 files changed, 540 insertions(+), 836 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

