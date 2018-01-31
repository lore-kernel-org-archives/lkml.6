Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeAaJPY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:15:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:40813 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeAaJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:15:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,439,1511856000";
   d="scan'208";a="14272964"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/3] Enumerate TME and PCONFIG
Date: Wed, 31 Jan 2018 12:15:06 +0300
Message-Id: <20180131091509.26531-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enumerates two features required for Multi-Key Total Memory
Encryption enabling[1].

Apart from trivial cpufeatures bits, the patchset enumerates how many bits
from physical address are claimed for encryption key ID. This may be
critical as we or guest VM must not use these bits for physical address.

Please review and consider applying.

[1] https://software.intel.com/sites/default/files/managed/a5/16/Multi-Key-Total-Memory-Encryption-Spec.pdf

Kirill A. Shutemov (3):
  x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
  x86/tme: Detect if TME and MKTME is activated by BIOS
  x86/cpufeatures: Add Intel PCONFIG cpufeature

 arch/x86/include/asm/cpufeatures.h |  2 +
 arch/x86/kernel/cpu/intel.c        | 83 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
2.15.1
