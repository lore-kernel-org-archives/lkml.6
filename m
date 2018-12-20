Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E52C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0026521852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbeLTPRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:17:39 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:59312 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733107AbeLTPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:17:39 -0500
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id EFHd1z01G3XaVaC01FHdlm; Thu, 20 Dec 2018 16:17:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ga04v-00006F-QM; Thu, 20 Dec 2018 16:17:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ga04v-0006vs-P0; Thu, 20 Dec 2018 16:17:37 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 4.21
Date:   Thu, 20 Dec 2018 16:17:36 +0100
Message-Id: <20181220151736.26607-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v4.21-tag1

for you to fetch changes up to 005e13a96c0ed1437cb7f113d5d0f07ad9590962:

  m68k: Generate uapi header and syscall table header files (2018-12-04 09:47:55 +0100)

----------------------------------------------------------------
m68k updates for v4.21

  - Generate syscall headers,
  - Small improvements and cleanups,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      m68k: Remove redundant 'default n' from Kconfig

Finn Thain (1):
      m68k: Unroll raw_outsb() loop

Firoz Khan (3):
      m68k: Add __NR_syscalls along with NR_syscalls
      m68k: Add system call table generation support
      m68k: Generate uapi header and syscall table header files

Geert Uytterhoeven (1):
      m68k/defconfig: Update defconfigs for v4.20-rc1

 arch/m68k/Kconfig.machine               |   2 -
 arch/m68k/Makefile                      |   3 +
 arch/m68k/configs/amiga_defconfig       | 103 +++++----
 arch/m68k/configs/apollo_defconfig      |  93 ++++----
 arch/m68k/configs/atari_defconfig       | 109 +++++----
 arch/m68k/configs/bvme6000_defconfig    |  89 ++++----
 arch/m68k/configs/hp300_defconfig       |  91 ++++----
 arch/m68k/configs/mac_defconfig         |  93 ++++----
 arch/m68k/configs/multi_defconfig       | 123 +++++-----
 arch/m68k/configs/mvme147_defconfig     |  87 +++----
 arch/m68k/configs/mvme16x_defconfig     |  89 ++++----
 arch/m68k/configs/q40_defconfig         |  89 ++++----
 arch/m68k/configs/sun3_defconfig        |  81 ++++---
 arch/m68k/configs/sun3x_defconfig       |  83 ++++---
 arch/m68k/include/asm/Kbuild            |   1 +
 arch/m68k/include/asm/raw_io.h          |  39 +++-
 arch/m68k/include/asm/unistd.h          |   3 +-
 arch/m68k/include/uapi/asm/Kbuild       |   1 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +------------------------------
 arch/m68k/kernel/syscalls/Makefile      |  38 ++++
 arch/m68k/kernel/syscalls/syscall.tbl   | 389 ++++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  32 +++
 arch/m68k/kernel/syscalltable.S         | 387 +------------------------------
 24 files changed, 1161 insertions(+), 1285 deletions(-)
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
