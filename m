Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADBFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D765422419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/MV6fiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D765422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbeKMT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:29:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37641 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbeKMT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:29:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so5725435pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fSR/dgGGAx64INZQhuJJoz0fYjyw+R3P/dJMarV8PZs=;
        b=H/MV6fiBX7ArMsF9B5XAAx2+AuQC7fTMA6ePnj9hWQkaXgUk3K89AgPfF67x+IEdpL
         0F8s3RKDvJScUuCgv4SCn2Rj6c3yn6wn9U/hCjFBxNrkn7XVjusYVypEtedzkoHl5bez
         gJ6ZFyDF5IPMDhpffF5lAtfLRkMkZQhUk36/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fSR/dgGGAx64INZQhuJJoz0fYjyw+R3P/dJMarV8PZs=;
        b=YWLWQsBGfF23NbQRjEDV5Dwpk0/78e49VJh7UTEY0HivrVqp1XOA1/U91gUDeQzy7B
         z1dzwJxDSwSgnBNhMK2ODsNn+zlnn11EU4S9Z8sk4ekPpY5SFXnkkhg3Bv5ATjADIx6h
         fx11WbX6976DcqCdyAqJN8/SEH5jDP2Y9eTtzeuEBaFo0ZUB9uSRydPxZmCADGvTju0y
         LjDlgs4u5FcOyzHwsnIJBodE2Glrb3oVpqaNT+ccNF9pAnnDfbYtwyR0s1J0xAvYgJ31
         9/av+i1a0xgi/mgzAI9r4ZnCbniM2n50+tyXu0GYkNycCkJPkDJyNq33KjolpvuWNsXF
         r3JA==
X-Gm-Message-State: AGRZ1gLEmha9goeamnPwCo7ldhIuaAsks1EBRCdDWQuRO/sItVCX2EDq
        ydVHJw1WnYEjU+E7IFckS7m5wA==
X-Google-Smtp-Source: AJdET5eF7t8+8OAbO8iFfEgCKtghCh++5aempIPawzU5L2FB9ZHUEtobKZjATJ9BjFQxMCMVBfNdZA==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33-v6mr4417208plh.268.1542101541723;
        Tue, 13 Nov 2018 01:32:21 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u6sm19902462pgr.79.2018.11.13.01.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:32:20 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 0/5] alpha: system call table generation support
Date:   Tue, 13 Nov 2018 15:01:48 +0530
Message-Id: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for ia64, m68k, 
microblaze, mips, parisc, powerpc, sh, sparc and xtensa.
Below mentioned git repository contains more details
about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

changes since v2:
 - changed from generic-y to generated-y in Kbuild.
 - made changes in syscall.tbl for removing entry - 
   alpha_ni_syscall.

changes since v1:
 - optimized/updated the syscall table generation
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.
 - enclosed __NR_sycalls macro with __KERNEL__.
 - added missing new line.

Firoz Khan (5):
  alpha: move __IGNORE* entries to non uapi header
  alpha: remove CONFIG_OSF4_COMPAT flag from syscall table
  alpha: add __NR_syscalls along with NR_SYSCALLS
  alpha: add system call table generation support
  alpha: generate uapi header and syscall table header files

 arch/alpha/Makefile                      |   3 +
 arch/alpha/include/asm/Kbuild            |   2 +-
 arch/alpha/include/asm/unistd.h          |  23 +-
 arch/alpha/include/uapi/asm/Kbuild       |   1 +
 arch/alpha/include/uapi/asm/unistd.h     | 484 +--------------------------
 arch/alpha/kernel/osf_sys.c              |   9 +-
 arch/alpha/kernel/syscalls/Makefile      |  38 +++
 arch/alpha/kernel/syscalls/syscall.tbl   | 453 ++++++++++++++++++++++++++
 arch/alpha/kernel/syscalls/syscallhdr.sh |  36 ++
 arch/alpha/kernel/syscalls/syscalltbl.sh |  32 ++
 arch/alpha/kernel/systbls.S              | 542 +------------------------------
 11 files changed, 596 insertions(+), 1027 deletions(-)
 create mode 100644 arch/alpha/kernel/syscalls/Makefile
 create mode 100644 arch/alpha/kernel/syscalls/syscall.tbl
 create mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

