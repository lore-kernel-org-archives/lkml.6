Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeEPIBv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:01:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:9085 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752524AbeEPIBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:01:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="49645449"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 for v4.17 0/2] Fix two crashes in the decomression code
Date: Wed, 16 May 2018 11:01:27 +0300
Message-Id: <20180516080131.27913-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated version of two crash fixes in early boot code.

Kirill A. Shutemov (2):
  x86/boot/compressed/64: Set up GOT for paging_prepare() and
    cleanup_trampoline()
  x86/boot/compressed/64: Fix moving page table out of trampoline memory

 arch/x86/boot/compressed/head_64.S    | 79 ++++++++++++++++++++++-----
 arch/x86/boot/compressed/pgtable_64.c | 14 +----
 2 files changed, 69 insertions(+), 24 deletions(-)

-- 
2.17.0
