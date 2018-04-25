Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755498AbeDYRRA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:17:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36898 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754552AbeDYRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:16:57 -0400
X-Google-Smtp-Source: AIpwx49sSfAkpu8T05LhQ7GLOG+SDqbSn2wXlx+8sKoC+W1PeCDJlJwHEVHaJLfFz1TK/n0sPTtKHw==
Date: Wed, 25 Apr 2018 10:16:55 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Apr 2018 10:16:53 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 4.17-rc3
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        patches@groups.riscv.org
From: Palmer Dabbelt <palmer@sifive.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ef6ff42c-a1bb-4a98-b1fe-4d27d49e82c3@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.17-rc3

for you to fetch changes up to 85602bea297fc4e5223adbf7006dcce9aa694f17:

  RISC-V: build vdso-dummy.o with -no-pie (2018-04-24 10:54:46 -0700)

----------------------------------------------------------------
RISC-V Fixes for 4.17-rc3

This pull request contains three small fixes related to the RISC-V port
that I'd like to target for 4.17-rc3:

* A Kconfig cleanup to select DMA_DIRECT_OPS instead of redefining it in
  arch/riscv.
* The removal of asm/handle_irq.h, which doesn't exist, from our arch
  header list.
* The addition of "-no-pie" the link rules for our VDSO-related files,
  which fixes the build on systems where PIE is enabled by default.

----------------------------------------------------------------
Aurelien Jarno (1):
      RISC-V: build vdso-dummy.o with -no-pie

Christoph Hellwig (2):
      riscv: select DMA_DIRECT_OPS instead of redefining it
      riscv: there is no <asm/handle_irq.h>

 arch/riscv/Kconfig              | 4 +---
 arch/riscv/include/asm/Kbuild   | 1 -
 arch/riscv/kernel/vdso/Makefile | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)
