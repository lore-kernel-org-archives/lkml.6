Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE77ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42606208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRISZPDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42606208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeGPKvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:51:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36495 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeGPKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:51:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id m19-v6so7325856pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7zxb9x25D+o72PMUdhr2y2Hd7CM8FXJU04kdXZt7GfU=;
        b=WRISZPDVsrgDrxXZKgjiB/6QmYOv5+m6lekAl5R8NBpDpeENQY0j5Ac7LvzWsMgc+R
         UZiQuFiN502iIajjyhOPA4WP3mw9yHOsT22mfRYrYSm+7aA95Vn1HIjDkdnyNqHKEnG+
         szNoe8KIWqOMXT3KFZ3LGjAI1j1R1Tb6qArmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7zxb9x25D+o72PMUdhr2y2Hd7CM8FXJU04kdXZt7GfU=;
        b=ndxE48QRREsMLyrC+xat5FjKj3ECpWOVnkJoEm1DqHt4UttAuzgeaY+vPOnCGyGREa
         jNwomsbfGoQqL26W6tFDfQDNMqVxkceTaJhK9R3HXcer67LeuwqxFXCs9Sn0LsB4kNtv
         kh1O7hf4aiCbPplSRYf+rqeYI6GP50aCh1vgf2Z831odyKiA6HG/+irh+QNEcnU58Ox4
         SRao+f0bdXhFK4/UgQjcCREfZxV0qEEhe2OvJ6b9GX5+ULfNsUOidtOW5VEYdlaYj5il
         SjAEPrX4gEcDIfbkG0pAIiVhf48P9kyZCMZFUGwgL9yNE0IbiRHcfbb2QFUid/Vjz/yf
         xQiQ==
X-Gm-Message-State: AOUpUlFtxAL9ppiwZimv5OJZx8gTmcZqPgw0eYD7IlsywT4VgrQfs3wX
        nbX+FUjdLgSVp6AuUTrqaUBESw==
X-Google-Smtp-Source: AAOMgpfwGLEUVD+CyfKaTJiPOd4byTJU1p/WMC/RJb8zUUFX5nf6WrgHbAbn1cS+QPdAdwhi/BtQdw==
X-Received: by 2002:a63:dd09:: with SMTP id t9-v6mr15002887pgg.370.1531736669813;
        Mon, 16 Jul 2018 03:24:29 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17808087pfi.42.2018.07.16.03.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 03:24:29 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/6] System call table generation support
Date:   Mon, 16 Jul 2018 15:53:52 +0530
Message-Id: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch series is to easily add/modify/delete a
system call by changing entry in syscall.tbl file. No need
to manually edit many files.

The another goal of this patch series is to to unify the system
call implementation across all the architectures. ARM, s390 and 
x86 architecuture does have the similar support. I leverage their 
implementation to come up with a generic solution.

I have done the same support for work for ia64, m68k, microblaze, 
mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to change two dozen of system calls to solve Y2038 issue. So
this implementation will help to easily modify from existing system
call to Y2038 compatible system calls.

Firoz Khan (6):
  alpha: Move __IGNORE* entries to non uapi header
  alpha: Add CONFIG_OSF4_COMPAT for compat syscall support
  alpha: Unify the not-implemented system call entry name
  alpha: Replace NR_SYSCALLS macro from asm/unistd.h
  alpha: Add system call table generation support
  alpha: uapi header and system call table file generation

 arch/alpha/Makefile                      |   3 +
 arch/alpha/include/asm/Kbuild            |   3 +-
 arch/alpha/include/asm/unistd.h          |   7 +-
 arch/alpha/include/uapi/asm/Kbuild       |   2 +
 arch/alpha/include/uapi/asm/unistd.h     | 489 ---------------------------
 arch/alpha/kernel/Makefile               |   2 +-
 arch/alpha/kernel/entry.S                |   4 +-
 arch/alpha/kernel/osf_sys.c              |   9 +-
 arch/alpha/kernel/syscall.S              |  20 ++
 arch/alpha/kernel/syscalls/Makefile      |  37 +++
 arch/alpha/kernel/syscalls/syscall.tbl   | 450 +++++++++++++++++++++++++
 arch/alpha/kernel/syscalls/syscallhdr.sh |  33 ++
 arch/alpha/kernel/syscalls/syscalltbl.sh |  28 ++
 arch/alpha/kernel/systbls.S              | 552 -------------------------------
 14 files changed, 589 insertions(+), 1050 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/unistd.h
 create mode 100644 arch/alpha/kernel/syscall.S
 create mode 100644 arch/alpha/kernel/syscalls/Makefile
 create mode 100644 arch/alpha/kernel/syscalls/syscall.tbl
 create mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/alpha/kernel/systbls.S

-- 
2.7.4

