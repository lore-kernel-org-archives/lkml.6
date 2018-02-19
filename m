Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeBSRuq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:50:46 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:40407 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeBSRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:50:45 -0500
X-Google-Smtp-Source: AH8x225K0gXl+COYqSICpI0aTan8fdEryP3jAbiY8sWXstxvLyoXxl08HzMa3ZKZ0yRinNkXkeiOm1IFXw==
MIME-Version: 1.0
Date: Mon, 19 Feb 2018 18:50:39 +0100
Message-Id: <20180219175039.253089-1-jannh@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Subject: [PATCH] x86/mm: remove stale comment about kmemcheck
From: Jann Horn <jannh@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment referred to a conditional call to kmemcheck_hide() that was
here until commit 4950276672fc ("kmemcheck: remove annotations"). Now that
kmemcheck has been removed, it doesn't make sense anymore.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/mm/fault.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 800de815519c..c88573d90f3e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1248,10 +1248,6 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	tsk = current;
 	mm = tsk->mm;
 
-	/*
-	 * Detect and handle instructions that would cause a page fault for
-	 * both a tracked kernel page and a userspace page.
-	 */
 	prefetchw(&mm->mmap_sem);
 
 	if (unlikely(kmmio_fault(regs, address)))
-- 
2.16.1.291.g4437f3f132-goog
