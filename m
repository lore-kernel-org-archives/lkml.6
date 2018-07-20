Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4684ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679C120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bsysk3Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679C120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbeGTTU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:20:59 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:38564 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbeGTTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:20:59 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 53ED824E251C;
        Fri, 20 Jul 2018 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532111490; bh=JPO25kQtAR2FZs3ZjEEjiEqQqz7dZL/BNc1oCVqwu+o=;
        h=To:CC:From:Subject:Date:From;
        b=bsysk3Y7MApaqgpkAwtAaBnvZ2281BfZbhOMqRVLHmAAnlqi9Hl6CRo0HnwXfrRhz
         1nT1pEAWjcqizr6BuNHzVZnhAojzfiW4uqc5K0Yr4j1mn28Qmue9zJqnxch3PHizyl
         Dooz1HeSk5VISjQfcQW8cbhY9ZoNDU4sV8KBGi4/rWOcGPn0h54VLnyXGx/UcyokW0
         tBPYPPkdeF6wOCGNrUTNA8BDs7MShw0zXERpOnEvz9sT2mlYZi+gT8VJVrYHNa6fMx
         5yqflU3MS/+UmUqRQGbRHF9Fi1VEw6MexI1nxFhtW7+w72APz4jYGAqxd8eDmHcPBw
         O6p7oexRQQZBA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3E3E85A2B;
        Fri, 20 Jul 2018 11:31:30 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 20 Jul 2018 11:31:29 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sat, 21 Jul 2018 00:01:27 +0530
Received: from [10.10.161.98] (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sat, 21 Jul 2018 00:01:26 +0530
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [GIT PULL] ARC updates for 4.18-rc6
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <8299319b-bd3a-6a65-e404-e8b7c12d0810@synopsys.com>
Date:   Fri, 20 Jul 2018 11:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Hope you are enjoying the summer.

ARC is back after radio silence in 4.17. Please pull changes for 4.18, bunch of
them are stable fodder.

Thx,
-Vineet
------------->
The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.18-rc6

for you to fetch changes up to af1fc5baa724c63ce1733dfcf855bad5ef6078e3:

  ARCv2: [plat-hsdk]: Save accl reg pair by default (2018-07-19 10:36:45 -0700)

----------------------------------------------------------------
ARC fixes for 4.18-rc6

 - Fix CONFIG_SWAP [Alexey]

 - Robistify cmpxchg emulation for systems w/o atomics [Alexey / PeterZ]

 - Allow mprotext(PROT_EXEC) for stack mappings [Vineet]

 - HSDK platform enable PCIe, APG GPIO [Gustavo]

 - miscll other fixes, config updates etc

----------------------------------------------------------------
Alexey Brodkin (4):
      ARC: Explicitly add -mmedium-calls to CFLAGS
      ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP
      ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs
      ARC: Fix CONFIG_SWAP

Anders Roxell (1):
      ARC: configs: remove no longer needed CONFIG_DEVPTS_MULTIPLE_INSTANCES

Gustavo Pimentel (2):
      ARC: [plat-hsdk] Add PCIe support
      ARC: [plat-hsdk]: Configure APB GPIO controller on ARC HSDK platform

Peter Zijlstra (1):
      ARC: Improve cmpxchg syscall implementation

Vineet Gupta (3):
      ARC: [arcompact] entry.S: minor code movement
      ARC: mm: allow mprotect to make stack mappings executable
      ARCv2: [plat-hsdk]: Save accl reg pair by default

 arch/arc/Kconfig                           |  2 +-
 arch/arc/Makefile                          | 15 +-------
 arch/arc/configs/axs101_defconfig          |  1 -
 arch/arc/configs/axs103_defconfig          |  1 -
 arch/arc/configs/axs103_smp_defconfig      |  1 -
 arch/arc/configs/haps_hs_defconfig         |  1 -
 arch/arc/configs/haps_hs_smp_defconfig     |  1 -
 arch/arc/configs/hsdk_defconfig            |  1 -
 arch/arc/configs/nsim_700_defconfig        |  1 -
 arch/arc/configs/nsim_hs_defconfig         |  1 -
 arch/arc/configs/nsim_hs_smp_defconfig     |  1 -
 arch/arc/configs/nsimosci_defconfig        |  1 -
 arch/arc/configs/nsimosci_hs_defconfig     |  1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig |  1 -
 arch/arc/configs/tb10x_defconfig           |  1 -
 arch/arc/include/asm/entry-compact.h       |  6 +++
 arch/arc/include/asm/entry.h               |  3 --
 arch/arc/include/asm/mach_desc.h           |  2 -
 arch/arc/include/asm/page.h                |  2 +-
 arch/arc/include/asm/pgtable.h             |  2 +-
 arch/arc/kernel/irq.c                      |  2 +-
 arch/arc/kernel/process.c                  | 47 ++++++++++++++++------
 arch/arc/plat-hsdk/Kconfig                 |  3 ++
 arch/arc/plat-hsdk/platform.c              | 62 ++++++++++++++++++++++++++++++
 24 files changed, 112 insertions(+), 47 deletions(-)
