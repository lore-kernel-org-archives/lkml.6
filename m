Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeEKMJI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:09:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:17154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeEKMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:09:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="40453444"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] 5-level paging changes from v4.18
Date: Fri, 11 May 2018 15:08:57 +0300
Message-Id: <20180511120859.26375-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of changes for v4.18. One fix for a non-critical bug and the new
kernel command line option to disable 5-level paging.

Kirill A. Shutemov (2):
  x86/boot/compressed/64: Fix trampoline page table address calculation
  x86/mm: Introduce 'no5lvl' kernel parameter

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/boot/compressed/cmdline.c              |  2 +-
 arch/x86/boot/compressed/head_64.S              |  1 +
 arch/x86/boot/compressed/pgtable_64.c           | 14 +++++++++++---
 arch/x86/kernel/cpu/common.c                    |  6 ++++++
 arch/x86/kernel/head64.c                        | 10 ++++++----
 6 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.17.0
