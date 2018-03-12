Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCLIpb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:45:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35681 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeCLIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:45:27 -0400
X-Google-Smtp-Source: AG47ELtPqL94II8NDr6o/LjZZbCtqo3zmQmSR43TkFGiHFVknMUc6r8LpSZz8+eHhrFMvB3l4MlKMQ==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "Lee, Chun-Yi" <jlee@suse.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>
Subject: [GIT PULL 0/5] more EFI changes for v4.17
Date: Mon, 12 Mar 2018 08:44:55 +0000
Message-Id: <20180312084500.10764-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f779ca740f25c8a6a72d951334f9efc3158a318b:

  efi: Make const array 'apple' static (2018-03-09 09:30:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to a6072c0ecf3a39e9eadfaea1477533fd24261b05:

  efi: use string literals for efi_char16_t variable initializers (2018-03-10 11:05:19 +0000)

----------------------------------------------------------------
Second batch of EFI changes for v4.17:
- take 2 of 'use efi_switch_mm() on x86 instead of manipulating %cr3 directly'
- fix early memremap leak in ESRT code
- switch to L"xxx" notation for wide string literals

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/esrt: fix handling of early ESRT table mapping
      efi: use string literals for efi_char16_t variable initializers

Sai Praneeth (3):
      efi: Use efi_mm in x86 as well as ARM
      x86/efi: Replace efi_pgd with efi_mm.pgd
      x86/efi: Use efi_switch_mm() rather than manually twiddling with %cr3

 arch/x86/boot/compressed/eboot.c          |  3 +-
 arch/x86/include/asm/efi.h                | 26 ++++++--------
 arch/x86/platform/efi/efi_64.c            | 59 +++++++++++++++++--------------
 arch/x86/platform/efi/efi_thunk_64.S      |  2 +-
 arch/x86/platform/efi/quirks.c            |  8 +++--
 drivers/firmware/efi/arm-runtime.c        |  9 -----
 drivers/firmware/efi/efi.c                |  9 +++++
 drivers/firmware/efi/esrt.c               | 17 +++------
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/secureboot.c | 12 ++-----
 drivers/firmware/efi/libstub/tpm.c        |  7 ++--
 include/linux/efi.h                       |  2 ++
 12 files changed, 72 insertions(+), 84 deletions(-)
