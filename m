Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966771AbeEJRiQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:38:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:61125 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966662AbeEJRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:38:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="227445357"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH for v4.17 0/2] Fix two crashes in decomression code
Date: Thu, 10 May 2018 20:38:04 +0300
Message-Id: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's two fixes in early boot code that leads to instant reboot.

Kirill A. Shutemov (2):
  x86/boot/compressed/64: Set up GOT for paging_prepare() and
    cleanup_trampoline()
  x86/boot/compressed/64: Fix moving page table out of trampoline memory

 arch/x86/boot/compressed/head_64.S    | 77 ++++++++++++++++++++++-----
 arch/x86/boot/compressed/pgtable_64.c | 14 ++---
 2 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.17.0
