Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E26207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqvyMeBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E26207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeJZNrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:47:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43696 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeJZNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:47:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so4914641plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k8JL1g3woiiKaimfddLgG722nPrW6K3PY1HWBJoweZc=;
        b=OqvyMeBzzydNL+wteXueSeXUYHxOz6WcReT37ODpTnErT6uIAe63YL87YHzQUx3rIF
         L54mBqZV/SDhT8N4q3i5KkKdxBrHqFZ1mY2HiudZw+t0cPHZCd7EXrtSTnj0LM/eNgbb
         kXasClzBXNSAkCDa2kRyjy+rNubuBctV1ct7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k8JL1g3woiiKaimfddLgG722nPrW6K3PY1HWBJoweZc=;
        b=ARDa5peBFOZVi0PEwX0QZB0/q+2z/aCkWMMgOfSQ3okAn9/bgYfp2l0cqnj9Rq0bj8
         xXDStRs2CV239oeiU/CYgGGJ+Tkwpr8vDNW9stXGNBrtf4oIpoaC+oYaxaVOsWkQ0559
         xmqKHZEyoPZ1z48eef7QLxjg9p3vI7ZidscdZKLGz8axQPNo3WGiwvKugy7Ld50p3IHc
         s9N44p4XA1/vZSawm32e4F0cmMNZ5nNB8w2xXP3HDcstH1v3G5kg29iXlqRAmQQzTPkk
         kNmgbCARV3waEnl2S06rIP4Mxz0p7x6cK9T1KLfhJU+86DPltNGUkhJtFFFEiZmdHA6G
         lw3w==
X-Gm-Message-State: AGRZ1gL5054+xbNjHDj4S/Qwe4N4hjrnauILFbHVipOatBeJT0fwmAib
        i07Gr/tfNZJMfa1thp5+kZdx4Q==
X-Google-Smtp-Source: AJdET5eqUSsHU3rx4jRSrY4nkibMMCWx5/TGM6iigVvsWor54l5fX48CvF8TPECogoqydIAKjlNEwg==
X-Received: by 2002:a17:902:b106:: with SMTP id q6-v6mr2102386plr.238.1540530701491;
        Thu, 25 Oct 2018 22:11:41 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id u13-v6sm9608912pgp.18.2018.10.25.22.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:11:40 -0700 (PDT)
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
Subject: [PATCH v4 0/5] ia64: system call table generation support
Date:   Fri, 26 Oct 2018 10:41:09 +0530
Message-Id: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for alpha, m68k, microblaze,
mips, parisc, powerpc, sh, sparc, and xtensa. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038 issue. We need 
to add two dozen of system calls to solve Y2038 issue. So this patch
series will help to add new system calls easily by adding new entry 
in the syscall.tbl.

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
 10 files changed, 457 insertions(+), 660 deletions(-)
 create mode 100644 arch/ia64/kernel/syscalls/Makefile
 create mode 100644 arch/ia64/kernel/syscalls/syscall.tbl
 create mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

