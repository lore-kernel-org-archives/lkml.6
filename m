Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCLKC6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:02:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:10663 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeCLKC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:02:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="37996176"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/4] x86/boot/compressed/64: Switch between paging modes using trampoline
Date: Mon, 12 Mar 2018 13:02:42 +0300
Message-Id: <20180312100246.89175-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes kernel decompression code to use trampoline to
switch between paging modes.

The patchset is replacement for previously reverted patch "Handle 5-level
paging boot if kernel is above 4G".

Please review and consider applying.

Kirill A. Shutemov (4):
  x86/boot/compressed/64: Make sure we have 32-bit code segment
  x86/boot/compressed/64: Use stack from trampoline memory
  x86/boot/compressed/64: Use page table in trampoline memory
  x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G

 arch/x86/boot/compressed/head_64.S | 128 ++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 38 deletions(-)

-- 
2.16.1
