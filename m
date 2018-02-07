Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeBGM76 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:59:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:61853 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754059AbeBGM7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:59:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="16284038"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/5] x86: Enumerate TME and PCONFIG, add MKTME_KEY_PROG helper
Date: Wed,  7 Feb 2018 15:59:41 +0300
Message-Id: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset does some ground work for MKTME enabling:
  - Adds two new cpufeatures: TME and PCONFIG;
  - Detects if BIOS enabled TME and MKTME;
  - Enumerates what PCONFIG targets are supported;
  - Provides helper to program encryption keys into CPU;

As part of TME enumeration we check of how many bits from physical address
are claimed for encryption key ID. This may be critical as we or guest VM
must not use these bits for physical address.

Please review and consider applying.

v2:
  - Fixes for TME enumeration;
  - Add PCONFIG CPUID leaf support;
  - Add MKTME_KEY_PROG helper;

[1] https://software.intel.com/sites/default/files/managed/a5/16/Multi-Key-Total-Memory-Encryption-Spec.pdf

Kirill A. Shutemov (5):
  x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
  x86/tme: Detect if TME and MKTME is activated by BIOS
  x86/cpufeatures: Add Intel PCONFIG cpufeature
  x86/pconfig: Detect PCONFIG targets
  x86/pconfig: Provide defines and helper to run MKTME_KEY_PROG leaf

 arch/x86/include/asm/cpufeatures.h   |  2 +
 arch/x86/include/asm/intel_pconfig.h | 65 +++++++++++++++++++++++++
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel.c          | 94 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_pconfig.c  | 82 +++++++++++++++++++++++++++++++
 5 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/intel_pconfig.h
 create mode 100644 arch/x86/kernel/cpu/intel_pconfig.c

-- 
2.15.1
