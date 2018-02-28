Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeB1K3X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:29:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeB1K3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:16 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] x86/microcode: Improve late loading
Date: Wed, 28 Feb 2018 11:28:39 +0100
Message-Id: <20180228102846.13447-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here are a bunch of patches which improve microcode late loading.

Before you read any further: the early loading method is still the
preferred one and you should always do that. This patchset is improving
the late loading mechanism for long running jobs and cloud use cases -
i.e., use cases where early loading is, hm, a bit problematic.

Ashok Raj (4):
  x86/microcode/intel: Check microcode revision before updating sibling
    threads
  x86/microcode/intel: Writeback and invalidate caches before updating
    microcode
  x86/microcode: Do not upload microcode if CPUs are offline
  x86/microcode: Synchronize late microcode loading

Borislav Petkov (3):
  x86/microcode: Get rid of struct apply_microcode_ctx
  x86/microcode/intel: Look into the patch cache first
  x86/microcode: Request microcode on the BSP

 arch/x86/kernel/cpu/microcode/core.c  | 158 +++++++++++++++++++++++++---------
 arch/x86/kernel/cpu/microcode/intel.c |  48 +++++++++--
 2 files changed, 159 insertions(+), 47 deletions(-)

-- 
2.13.0
