Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeAaNyW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:54:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:5253 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752220AbeAaNyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:54:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,440,1511856000";
   d="scan'208";a="13975217"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 0/3] x86/mm/encrypt: Cleanup and switching between paging modes<Paste>
Date: Wed, 31 Jan 2018 16:54:01 +0300
Message-Id: <20180131135404.40692-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patcheset is a preparation set for boot-time switching between
paging modes. Please review and consider applying.

Code around sme_populate_pgd() is unnecessary complex and hard to modify.

This patchset rewrites it in more stream-lined way to add support of
boot-time switching between paging modes.

I haven't tested the patchset on hardware capable of memory encryption.

v4:
 - Move sev_enabled declaration to <linux/mem_encrypt.h>
 - Fix few typos in commit messages
 - Reviewed/Tested-by from Tom
v3:
 - Move all page table related functions into mem_encrypt_identity.c
v2:
 - Rebased to up-to-date tip

Kirill A. Shutemov (3):
  x86/mm/encrypt: Move page table helpers into separate translation unit
  x86/mm/encrypt: Rewrite sme_populate_pgd() and
    sme_populate_pgd_large()
  x86/mm/encrypt: Rewrite sme_pgtable_calc()

 arch/x86/include/asm/mem_encrypt.h |   1 +
 arch/x86/mm/Makefile               |  14 +-
 arch/x86/mm/mem_encrypt.c          | 578 +------------------------------------
 arch/x86/mm/mem_encrypt_identity.c | 564 ++++++++++++++++++++++++++++++++++++
 4 files changed, 575 insertions(+), 582 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_identity.c

-- 
2.15.1
