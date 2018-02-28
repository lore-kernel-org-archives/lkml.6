Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935603AbeB1Wua (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:50:30 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42303 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935514AbeB1Wu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:50:29 -0500
X-Google-Smtp-Source: AH8x226wjHxGYyFwf8dSuFWorNwrZ2DifA6aRO0cpVsN+6PmUu4jyjquOFMTd2qMNNUTbYqbC+uWFg==
Date: Wed, 28 Feb 2018 14:50:28 -0800 (PST)
X-Google-Original-Date: Wed, 28 Feb 2018 14:47:27 PST (-0800)
Subject: [GIT PULL] RISC-V: smb_mb() fix for 4.16-rc4
From: Palmer Dabbelt <palmer@sifive.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        patches@groups.riscv.org
Message-ID: <mhng-6fd686e5-2ed2-4fea-a3be-0c767232c445@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.16-rc4_smp_mb

for you to fetch changes up to ab4af60534107c55b00fa462eca0385dcef92384:

  riscv/barrier: Define __smp_{mb,rmb,wmb} (2018-02-26 08:44:50 -0800)

----------------------------------------------------------------
RISC-V: smb_mb() fix for 4.16-rc4

This week we have a single fix: replacing smp_mb() with __smp_mb().  We
were the only architecture with smp_mb() and it appears to just be
clearly wrong, so I think this is a pretty safe patch for an RC.

----------------------------------------------------------------
Andrea Parri (1):
      riscv/barrier: Define __smp_{mb,rmb,wmb}

 arch/riscv/include/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
