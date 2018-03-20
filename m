Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeCTXCU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:02:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34541 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeCTXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:19 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 0/5] ARM: clang support
Date: Wed, 21 Mar 2018 00:02:01 +0100
Message-Id: <20180320230206.25289-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some remaining issues when building the ARM
architecture using LLVM/clang.  The patchset requires the following
kbuild change:
https://lkml.org/lkml/2018/3/19/1756

With that patch and this patchset applied and I can successfully
build the multi_v7_defconfig with 4.16-rc5 using clang 5.0.1.

So far I mainly tested with ARMv7 architectures. A brief test with
ARMv6 enabled (multi platform configuraiton) failed with an error
from the assembler:
/tmp/empty-96a4d6.s: Assembler messages:
/tmp/empty-96a4d6.s:4: Error: unknown cpu `arm1176j-s'

It seems that clang emits a non-existig cpu name:
https://reviews.llvm.org/D18086

Stefan Agner (5):
  bus: arm-cci: use asm unreachable
  efi/libstub/arm: add support for building with clang
  ARM: trusted_foundations: do not use naked function
  ARM: drop no-thumb-interwork in EABI mode
  ARM: add support for building ARM kernel with clang

 arch/arm/Makefile                       |  4 ++--
 arch/arm/boot/compressed/Makefile       |  2 +-
 arch/arm/firmware/trusted_foundations.c | 12 +++++++-----
 drivers/bus/arm-cci.c                   |  3 +--
 drivers/firmware/efi/libstub/Makefile   |  3 ++-
 5 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.16.2
