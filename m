Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3170921708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jh7WAag+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3170921708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeI0Une (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:43:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37646 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeI0Une (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:43:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so2097055pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ni/eVDa2Hujp+DsYcqwh+SM8Be5zik7hZCcPMihIUEA=;
        b=Jh7WAag+py26oqDj6xOuxjjGnozv3h/zkNrpCfO6khLoTQbXFJTKtS42ZtzcgxwjPm
         aJNpjX9466yjozwk17+IdMSpcXoTInyFhHZaTDGZfjGMzOKEt3lHMei/onc0ODjRKL3G
         iTxOO7LcBZM+L2mYI1/0AbdpZQmmOqu8p5TXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ni/eVDa2Hujp+DsYcqwh+SM8Be5zik7hZCcPMihIUEA=;
        b=ZfNMgRGT90fQYQgMqy9ju+BGbcPpdrRl3yMyHEryGX/mcGJ+/9tOAe8/AfOABX7ufw
         fpM7cI3rjpf3TwV2aRcxdFBLupsFS6KEIO43WOK6cUYBMYR7ST7WfxgEVx8ky79TQLH9
         /UppIeIGOPAdBdT68jT2N3E7dzIcCv6bcGmTiEr4g8txWsA7v100iNntu9ytH0CJxth+
         miU63RWEWU1YXnVYjyPGU31Q2oZRdQ85l1eH/kVHXP6Yv7Bc0iFTzhKNA3Qpl8E2uSHH
         +4+IiZkeb3qAHV/ezPH/4o5Epk8xYutYgtpbND43NVTAkQ1RRcupgpYhJCzorphH2suI
         clEg==
X-Gm-Message-State: ABuFfoifn9XXldaKboyU6IvSyjbzeEsscVJNR00HcD34hBeTeKfYbx1P
        2QcRpSD4yiKGxwEk5S5dYmvjYw==
X-Google-Smtp-Source: ACcGV60vVzNc6oCm0vz6eiOudxb0ecHaZfGOsl2vW0RH0qZ/luM10DJ446cL/oA0K0ayuCrI6jyDjA==
X-Received: by 2002:a17:902:9045:: with SMTP id w5-v6mr11603577plz.10.1538058303127;
        Thu, 27 Sep 2018 07:25:03 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id f81-v6sm9717421pfh.46.2018.09.27.07.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:25:02 -0700 (PDT)
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
Subject: [PATCH v2 0/5] System call table generation support
Date:   Thu, 27 Sep 2018 19:54:22 +0530
Message-Id: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
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
m68k, mips, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Added an extra patch to keep __IGNORE* entries in asm/unistd.h.

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (5):
  parisc: move __IGNORE* entries to non uapi header
  parisc: add __NR_Linux_syscalls macro with __NR_syscalls
  parisc: add system call table generation support
  parisc: uapi header and system call table file generation
  parisc: add __IGNORE* entries in asm/unistd.h

 arch/parisc/Makefile                       |   4 +
 arch/parisc/include/asm/Kbuild             |   3 +
 arch/parisc/include/asm/unistd.h           |   9 +
 arch/parisc/include/uapi/asm/Kbuild        |   2 +
 arch/parisc/include/uapi/asm/unistd.h      | 380 +-----------------------
 arch/parisc/kernel/syscall.S               |  12 +-
 arch/parisc/kernel/syscall_table.S         | 459 -----------------------------
 arch/parisc/kernel/syscall_table_32.S      |  13 +
 arch/parisc/kernel/syscall_table_64.S      |  20 ++
 arch/parisc/kernel/syscalls/Makefile       |  55 ++++
 arch/parisc/kernel/syscalls/syscall_32.tbl | 342 +++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscall_64.tbl | 342 +++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh  |  35 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh  |  42 +++
 14 files changed, 877 insertions(+), 841 deletions(-)
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

