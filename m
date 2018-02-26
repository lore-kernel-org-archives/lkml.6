Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeBZSFE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:05:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:5190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeBZSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:05:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="33751153"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/5] x86/boot/compressed/64: Prepare trampoline memory
Date: Mon, 26 Feb 2018 21:04:46 +0300
Message-Id: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's re-split of the patch that prepares trampoline memory, but doesn't
actually uses it yet. The original patch turned out to be problematic.
Splitting the patch should help to pin down the issue.

The functionality should match the original patch (although I've moved a
bit more into C).

Borislav, could you check which patch breaks boot for you (if any)?

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
