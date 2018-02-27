Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeB0Pm3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:42:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:60587 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753923AbeB0Pm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:42:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="34019963"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/5] x86/boot/compressed/64: Prepare trampoline memory
Date: Tue, 27 Feb 2018 18:42:12 +0300
Message-Id: <20180227154217.69347-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's re-split of the patch that prepares trampoline memory, but doesn't
actually uses it yet. The original patch turned out to be problematic.

The functionality should match the original patch (although I've moved a
bit more into C).

Please review and consider applying.

v2:
 - Add Tested-by from Borislav
 - s/__ASSEMBLER__/__ASSEMBLY__/

Kirill A. Shutemov (5):
  x86/boot/compressed/64: Describe the logic behind LA57 check
  x86/boot/compressed/64: Find a place for 32-bit trampoline
  x86/boot/compressed/64: Save and restore trampoline memory
  x86/boot/compressed/64: Set up trampoline memory
  x86/boot/compressed/64: Prepare new top-level page table for
    trampoline

 arch/x86/boot/compressed/head_64.S    |  13 +++-
 arch/x86/boot/compressed/misc.c       |   4 +
 arch/x86/boot/compressed/pgtable.h    |  20 +++++
 arch/x86/boot/compressed/pgtable_64.c | 133 +++++++++++++++++++++++++++++++++-
 4 files changed, 166 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pgtable.h

-- 
2.16.1
