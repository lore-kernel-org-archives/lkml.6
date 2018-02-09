Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeBJAUD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:20:03 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:15100 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753300AbeBJAUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:20:02 -0500
From: Nadav Amit <namit@vmware.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, <linux-kernel@vger.kernel.org>,
        <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH] x86: Fix PTI comment in entry_SYSCALL_64
Date: Fri, 9 Feb 2018 09:06:38 -0800
Message-ID: <20180209170638.15161-1-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is confusing since the path is taken when
PAGE_TABLE_ISOLATION is disabled (while the comment says it is not
taken).

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4a9bef6aca34..f4d4107a93b3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -213,7 +213,7 @@ ENTRY(entry_SYSCALL_64)
 
 	swapgs
 	/*
-	 * This path is not taken when PAGE_TABLE_ISOLATION is disabled so it
+	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
 	 * is not required to switch CR3.
 	 */
 	movq	%rsp, PER_CPU_VAR(rsp_scratch)
-- 
2.14.1
