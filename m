Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964894AbeBPL0x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:26:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964872AbeBPL0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:26:52 -0500
From: Borislav Petkov <bp@alien8.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/microcode: Add a microcode loader callback
Date: Fri, 16 Feb 2018 12:26:37 +0100
Message-Id: <20180216112640.11554-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add a callback which the microcode loader calls after microcode has been
upgraded late to let the user know that any CPUID changes potentially
won't take effect.

One possible example for this is that late loading happens after
alternatives have run and thus patching which relies on those new CPUID
features won't happen.

@Ashok: I haven't added your tags yet because I did a small change to
run the callback only when no error has been encountered during loading.
Please run them on your setup to confirm everything's still fine.

Thanks.

Borislav Petkov (3):
  x86/microcode: Propagate return value from updating functions
  x86/CPU: Add a microcode loader callback
  x86/CPU: Check CPU feature bits after microcode upgrade

 arch/x86/include/asm/microcode.h      |  9 ++++++--
 arch/x86/include/asm/processor.h      |  1 +
 arch/x86/kernel/cpu/common.c          | 30 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/amd.c   | 10 ++++-----
 arch/x86/kernel/cpu/microcode/core.c  | 39 ++++++++++++++++++++---------------
 arch/x86/kernel/cpu/microcode/intel.c | 10 ++++-----
 6 files changed, 70 insertions(+), 29 deletions(-)

-- 
2.13.0
