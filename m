Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C75DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6298520844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc/gWkPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfBATlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:41:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfBATlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:41:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so6757128lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0lL3M42CHIl+Fwt4DuYPMm43GjPZI/Jy7D1Hego9bNs=;
        b=Tc/gWkPhL/zZoVjwK5z3iKS8WFqdmXZGqcKd34UnI965SsW2Ufgk4IYLCWGB3lK67e
         hr86BEbC4lxjQY3tMWcW3+QDml0BWheEs9n/fanh7bTDTrDHAGhOhNALX8fscu/UJt5P
         ybnOfUynVenSOMXo9/w6TZv0TFrZKUNgGq3JrpP7fn6PHx18uPbpDMfuNdfd9cum9vOo
         RoPGDruJjHc+Om3LzVP/MmBcPg4CpRUpR6NYidl8wavXxAooL8v7hB5+K6lvd3tSzyjj
         7p0xv+aSN224x65ZC4EvCT1mRH8hE1IZZgok8HPkDLFNoirMJ2LICQI4VfkdKlL1yFkD
         Hp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0lL3M42CHIl+Fwt4DuYPMm43GjPZI/Jy7D1Hego9bNs=;
        b=T5x/Gn5qJ/rstWo9fvrQ1xx8GQ1oxvPxwmBowB2TMCiJ6F3Z9TCXApdSY3atCBK6nt
         EsOrvrKYyrZmW0l9brNbYGHqdfgSicUW5JnGdCxygaxOPNUQOAjFyYvnWNcV6pV/Xijd
         WTg9X5Trf6siZzLiVxcWI2Ry9PFCjr56On/g+awwmObl1gz9GCjPL2+ghjX4xKYGDRvw
         PBwfRHxFsLHGV+5j1MqDnLlg0jr9tl+HHjhHVhFt/0ZG9pMQg0xWT1mig56V47u5iQDU
         9X6IlnJGT4OPReXP55ffxCxnlo07/uY3YWmYequOVksScbph1iSFC11mIvtVRayKHoPY
         COdA==
X-Gm-Message-State: AHQUAuZafyDdQgGWL/lGQsEhCfB2DVxmxNzBBdFMP13JZnhBGA9YW/yj
        X5/DMJkMCb9kRGkcvx4Vcww=
X-Google-Smtp-Source: AHgI3IbjFs0iRCS6Vow3aYePAmcbyRflgg0cg9N+s2llc7ExhFvetyGjRXBxTTFqTpp5MFJZaVUVjQ==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr9512565ljk.109.1549050065674;
        Fri, 01 Feb 2019 11:41:05 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id o25sm1540738lfd.29.2019.02.01.11.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:41:04 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/9] xtensa fixes for v5.0-rc5
Date:   Fri,  1 Feb 2019 11:40:47 -0800
Message-Id: <20190201194047.13667-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of fixes for the Xtensa architecture.

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190201

for you to fetch changes up to 25384ce5f9530def39421597b1457d9462df6455:

  xtensa: SMP: limit number of possible CPUs by NR_CPUS (2019-01-27 10:04:30 -0800)

----------------------------------------------------------------
xtensa fixes for v5.0-rc5

- fix ccount_timer_shutdown for secondary CPUs;
- fix secondary CPU initialization;
- fix secondary CPU reset vector clash with double exception vector;
- fix present CPUs when booting with 'maxcpus' parameter;
- limit possible CPUs by configured NR_CPUS;
- issue a warning if xtensa PIC is asked to retrigger anything other
  than software IRQ;
- fix masking/unmasking of the first two IRQs on xtensa MX PIC;
- fix typo in Kconfig description for user space unaligned access
  feature;
- fix Kconfig warning for selecting BUILTIN_DTB.

----------------------------------------------------------------
Corentin Labbe (2):
      xtensa: Fix typo use space=>user space
      xtensa: rename BUILTIN_DTB to BUILTIN_DTB_SOURCE

Max Filippov (7):
      xtensa: SMP: fix ccount_timer_shutdown
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      drivers/irqchip: xtensa: add warning to irq_retrigger
      drivers/irqchip: xtensa-mx: fix mask and unmask
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

 arch/xtensa/Kconfig                         |  4 +--
 arch/xtensa/boot/dts/Makefile               |  6 ++---
 arch/xtensa/configs/audio_kc705_defconfig   |  2 +-
 arch/xtensa/configs/cadence_csp_defconfig   |  2 +-
 arch/xtensa/configs/generic_kc705_defconfig |  2 +-
 arch/xtensa/configs/nommu_kc705_defconfig   |  2 +-
 arch/xtensa/configs/smp_lx200_defconfig     |  3 ++-
 arch/xtensa/kernel/head.S                   |  5 +++-
 arch/xtensa/kernel/smp.c                    | 41 +++++++++++++++++++----------
 arch/xtensa/kernel/time.c                   |  2 +-
 drivers/irqchip/irq-xtensa-mx.c             | 40 +++++++++++++++++-----------
 drivers/irqchip/irq-xtensa-pic.c            |  6 ++++-
 12 files changed, 73 insertions(+), 42 deletions(-)

-- 
Thanks.
-- Max
