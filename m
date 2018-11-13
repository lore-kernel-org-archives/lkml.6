Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D7EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5772082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoctyuNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5772082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeKMQB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:01:29 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44535 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbeKMQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:01:28 -0500
Received: by mail-pl1-f182.google.com with SMTP id s5-v6so5458317plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3BRIUiiEvkKLDRvA06hY77+mTVUH+BMQOShtkUL+w6w=;
        b=YoctyuNQaS4HtzPfeFrkud6VEKEC7ADqlnHT+PU/x6mAifS/xaPQZI21rk5H0167s3
         O3w80sPHXRUKqHOF18LbZY+NGQV+kweKcKtyR8bEXWZtE6LU9J4RwuO5HfJfC8aLpR/o
         cXr6o7Z+f9x2LcRGJHjZtOyu4OcHQJ5+gRgXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3BRIUiiEvkKLDRvA06hY77+mTVUH+BMQOShtkUL+w6w=;
        b=In9Iq00633QrKRXCnm6inHwoLLoO29GT5OMHbHDeb4G1HBVVybz0PVboSklcOAMfvt
         xXH5332z6Dm7Pe2doRC+Erx7IzuAdxDuZHhm3ZzT4EfTNfYx8sxyoTqcFmccfPoPU73x
         9sylw0NDLDyP50IVsUPecnFVSGAFt0B4/AVvyeb/hAmSbQf6fX4dmcPTpttjZ+TIbgBh
         kNmYBBFsyJZ4hOYWMrhg8qjSSbcFPr2iJIfgJZNoX0ha+v9U93UYR3/7WDv87ejLtSFW
         bUyR5GQpc0R6diwYE1S/12x6Qa0XPvosgEqxjhi8TydtTJ1PbJFxze40UodDOmejjL2r
         yMcA==
X-Gm-Message-State: AGRZ1gIQCgOxoDZqIgLRbP5nzi2t93N2HoVyKy0J4oZnIswaL3ks6CJt
        v5Ho49fYdoAlVMeHd91qJsXhxg==
X-Google-Smtp-Source: AJdET5cjJDtZz1FAvm5eTDSAo69vo80WZXgXa7MsZDja5xgCtiJnP8PWNHXUdpnO0M4dR0sa96oY5A==
X-Received: by 2002:a17:902:e10f:: with SMTP id cc15-v6mr3877131plb.309.1542089097771;
        Mon, 12 Nov 2018 22:04:57 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id e23sm11429892pfh.68.2018.11.12.22.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:04:57 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 0/3] microblaze: system call table generation support
Date:   Tue, 13 Nov 2018 11:34:31 +0530
Message-Id: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for alpha, ia64,
m68k, mips, parisc, powerpc, sh, sparc and xtensa.
Below mentioned git repository contains more details
about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

changes since v3:
 - changed from generic-y to generated-y in Kbuild.

changes since v2:
 - optimized/updated the syscall table generation
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.

changes since v1:
 - enclosed __NR_sycalls macro with __KERNEL__.
 - added missing new line.

Firoz Khan (3):
  microblaze: move __NR_syscalls macro from asm/unistd.h
  microblaze: add system call table generation support
  microblaze: generate uapi header and system call table files

 arch/microblaze/Makefile                      |   3 +
 arch/microblaze/include/asm/Kbuild            |   1 +
 arch/microblaze/include/asm/unistd.h          |   2 -
 arch/microblaze/include/uapi/asm/Kbuild       |   1 +
 arch/microblaze/include/uapi/asm/unistd.h     | 407 +------------------------
 arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
 arch/microblaze/kernel/syscalls/Makefile      |  38 +++
 arch/microblaze/kernel/syscalls/syscall.tbl   | 410 ++++++++++++++++++++++++++
 arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 ++
 10 files changed, 526 insertions(+), 810 deletions(-)
 create mode 100644 arch/microblaze/kernel/syscalls/Makefile
 create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
 create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

