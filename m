Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbeBMTMy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:12:54 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32820 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754261AbeBMTMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:12:41 -0500
X-Google-Smtp-Source: AH8x225oXkQ3CM74Bd6o/s1y8zS7gO3XpJMxkJjG9vQBm+/F4ZhYDC9X+o0IpyOje0+s9VstuA3y2g==
From: Matt Turner <mattst88@gmail.com>
To: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/2] x86: msr-index.h: Correct SNB_C1/C3_AUTO_UNDEMOTE defines
Date: Tue, 13 Feb 2018 11:12:05 -0800
Message-Id: <20180213191205.7057-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180213191205.7057-1-mattst88@gmail.com>
References: <20180213191205.7057-1-mattst88@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Intel Software Developers' Manual, Vol. 4, Order No.
335592, these macros have been reversed since they were added in the
initial turbostat commit. The reversed definitions were presumably
copied from turbostat.c to this file.

Fixes: 9c63a650bb10 ("tools/power/x86/turbostat: share kernel MSR #defines")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/x86/include/asm/msr-index.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c9084dedfcfa..5c6aa44568c4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -60,8 +60,8 @@
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
 #define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
-#define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
-#define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
+#define SNB_C3_AUTO_UNDEMOTE		(1UL << 27)
+#define SNB_C1_AUTO_UNDEMOTE		(1UL << 28)
 
 #define MSR_MTRRcap			0x000000fe
 
-- 
2.13.6
