Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB27C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883512064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJVLW4am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883512064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeKAWrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:47:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46727 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeKAWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:47:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so1124382plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Aq2ismV06kUtMdw76a7jFmIWugJfYMfogF8ILYQJUog=;
        b=jJVLW4amcVwJPGMl/daHOL2njI+fc8edDKbJsYSBA6Vkrzp9Y+77w71RTzDSTlCxp0
         QABG4L1A/5FRtQRYvEk9GdUfvLP2OygTuYSbRovKbPFpwILs6/5ys/i4hF2pqfNmaRgY
         WXbJ/3Grb5YkCEIfpV6s4T5ipdSVQ5q0thlSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aq2ismV06kUtMdw76a7jFmIWugJfYMfogF8ILYQJUog=;
        b=syVluu+K4OnAQ8d02vRMRlWazidnw5CycJKaRSFSNhpzpDckuFp5Ait3ktc+LMtfOh
         jXxn33XBctfsAAU+2HOdwn4Je0jKu/taZ5GiazQ5QzyrTc3kxIYiJoXbkymefl5inWpL
         tGnLTMiRfhxoOMyWz4gtH8PelJwxLXTpTFu95+HdRKf8JFbObUnaNXImNnoYIHHMqdj+
         lO0m2M3FX0ZvjGs+yj+ZexoDG67dAlrb43IkJzeS7tZtgSmMxXoaqZfwlrNWTc4ap3+v
         ZIbaIR32jUzLoq80TqFI1pvC4rcZB5SGi2BfcfS8OVfUeXoof3RSjIlrDMSpBMPdzrVs
         9FLQ==
X-Gm-Message-State: AGRZ1gKhql0IcuBufER354cT2aS7xPyuwFh0BvpE3YJjYml7mvaSQKIK
        lWQHu3umN5Ks7wSeUVMklwY/SA==
X-Google-Smtp-Source: AJdET5cyaOZ5m/Kx0+kfcuvNw5kzfvjchEJEzCoS2Ch0bKtsdq5aOb6GoKOd7n1d5s9tgL4s1lkTKQ==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr7589560pld.59.1541079851055;
        Thu, 01 Nov 2018 06:44:11 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id r23-v6sm36359299pgm.48.2018.11.01.06.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:44:10 -0700 (PDT)
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
Subject: [PATCH v2 0/5] alpha: system call table generation support
Date:   Thu,  1 Nov 2018 19:13:32 +0530
Message-Id: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for ia64, m68k, 
microblaze, mips, parisc, powerpc, sh sparc and xtensa.
Below mentioned git repository contains more details 
about the workflow.

 https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to solve
Y2038 issue. So this patch series will help to add new 
system calls easily by adding new entry in the syscall.tbl.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.

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
 arch/alpha/kernel/syscalls/syscalltbl.sh |  36 ++
 arch/alpha/kernel/systbls.S              | 542 +------------------------------
 11 files changed, 600 insertions(+), 1027 deletions(-)
 create mode 100644 arch/alpha/kernel/syscalls/Makefile
 create mode 100644 arch/alpha/kernel/syscalls/syscall.tbl
 create mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

