Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08F821BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb2mnZAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08F821BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeHIHvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:51:18 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:46009 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHIHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:51:17 -0400
Received: by mail-pl0-f41.google.com with SMTP id j8-v6so2033844pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DX6oKqQDGvXLBtQ1ojTfhFwoM5QJ0gMDN73r8KQdwv4=;
        b=Eb2mnZAXSnr5SDIbw0OAaZa9XHadC7/oUyUJTCSzIZbwaOw1zoAaVQ5Sml6Ni2EneC
         yXiBRAt0Ye3EpbOkAPfvYvbXDZC5cfB44v/7kic/ubfhMwNYvDg7hyzjlJx5a0zSlxQ9
         6Xm2JFUolQpfITnyOdnOHud/ij7VFWhr6986M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DX6oKqQDGvXLBtQ1ojTfhFwoM5QJ0gMDN73r8KQdwv4=;
        b=MEv3N4T15D+GRZ2CtuFR0EP5OkgK1l2iZstp+mJ4Mdn/ws4WAdvtpp1rpa8BLKip8C
         Gdjsw3Eg70kEJB6Y+SyTw+GuZoR++ykF2ubXyNXBI+jH55SnrEasTh+coRmBzKedTtK9
         pC9B5RNeUE6g2qk61jHXYgCKz6uj9CPHdw1+6wwri2KScU9n89Qt1kxsmrsJ5xSVUZou
         7XYe0wzpoQkVTwHf2yY1Ht/iTN9BzrDsdBgsWUCVJVX/mTn/0PEYRMN7xMrjFoKQlLJD
         V6ZZ+5dxTfzQks6vKXvIZUtsSGmqKzd9MFkmMPZ3W5/nsYSexQHdSB5ri9Q6LRmzOM/c
         6GTw==
X-Gm-Message-State: AOUpUlGk8nirzAkdTr91YpZKJmYoKleT6qwDrLV91xms5tl447x5b0Ei
        E3627Ahp0w+Ve7AhB9g7x7KeWg==
X-Google-Smtp-Source: AA+uWPwheXVJee6nhDfMapcsVxfyhan21zCrJW0VmPV2D5CXtyaUFZ38YSFjlmq6XErm6AhkEIvlKQ==
X-Received: by 2002:a17:902:5856:: with SMTP id f22-v6mr688202plj.266.1533792495598;
        Wed, 08 Aug 2018 22:28:15 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id q65-v6sm12318676pfj.127.2018.08.08.22.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:28:15 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/3] System call table generation support
Date:   Thu,  9 Aug 2018 10:57:43 +0530
Message-Id: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
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
manually in the respective files. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify the implementation across all architectures.

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

I have done the same support for work for alpha, ia64,m68k, mips,
parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

I started working system call table generation on 4.17-rc1. I used 
marcin's script - https://github.com/hrw/syscalls-table to generate 
the syscall.tbl file. And this will be the input to the system call 
table generation script. But there are couple system call got add 
in the latest rc release. If run Marcin's script on latest release,
it will generate a different syscall.tbl. But I still use the old 
file - syscall.tbl and once all review got over I'll update 
syscall.tbl alone w.r.to the tip of the kernel. The impact of this
is, few of the system call won't work.

Firoz Khan (3):
  microblaze: Replace NR_syscalls macro from asm/unistd.h
  microblaze: Added system call table generation support
  microblaze: uapi header and system call table file generation

 arch/microblaze/Makefile                      |   3 +
 arch/microblaze/include/asm/Kbuild            |   2 +
 arch/microblaze/include/asm/unistd.h          |   2 -
 arch/microblaze/include/uapi/asm/Kbuild       |   2 +
 arch/microblaze/include/uapi/asm/unistd.h     | 407 +-------------------------
 arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
 arch/microblaze/kernel/syscalls/Makefile      |  37 +++
 arch/microblaze/kernel/syscalls/syscall.tbl   | 404 +++++++++++++++++++++++++
 arch/microblaze/kernel/syscalls/syscallhdr.sh |  33 +++
 arch/microblaze/kernel/syscalls/syscalltbl.sh |  28 ++
 10 files changed, 514 insertions(+), 810 deletions(-)
 create mode 100644 arch/microblaze/kernel/syscalls/Makefile
 create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
 create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

