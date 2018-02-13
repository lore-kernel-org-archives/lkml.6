Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbeBMTMl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:12:41 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32815 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeBMTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:12:40 -0500
X-Google-Smtp-Source: AH8x224TUoj2JffFWIwk1sLmQ/g2868EQ5v0NnWsNUcVGra76y4G+DQKijgeCz/JjI/rUcc1LdhAxQ==
From: Matt Turner <mattst88@gmail.com>
To: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/2] tools/power turbostat: Correct SNB_C1/C3_AUTO_UNDEMOTE defines
Date: Tue, 13 Feb 2018 11:12:04 -0800
Message-Id: <20180213191205.7057-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Intel Software Developers' Manual, Vol. 4, Order No.
335592, these macros have been reversed since they were added.

Fixes: 889facbee3e6 ("tools/power turbostat: v3.0: monitor Watts and Temperature")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..e55dc2e626c4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2071,8 +2071,8 @@ dump_nhm_cst_cfg(void)
 
 	get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
 
-#define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
-#define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
+#define SNB_C3_AUTO_UNDEMOTE              (1UL << 27)
+#define SNB_C1_AUTO_UNDEMOTE              (1UL << 28)
 
 	fprintf(outf, "cpu%d: MSR_PKG_CST_CONFIG_CONTROL: 0x%08llx", base_cpu, msr);
 
-- 
2.13.6
