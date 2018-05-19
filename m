Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeESWI0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:08:26 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49438 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbeESWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:48 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] x86/microcode/AMD: Add a reminder about PATCH_MAX_SIZE macro
Date: Sun, 20 May 2018 00:07:21 +0200
Message-Id: <2d8846f7146df1aaf40397025ad4bc94c792b8ff.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526767245.git.mail@maciej.szmigiero.name>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PATCH_MAX_SIZE macro should contain the maximum of all family patch
sizes.
Since these sizes are defined in an other place than this macro, let's add
a reminder to them so people will remember to verify PATCH_MAX_SIZE
correctness when modifying a family patch size or adding a new family.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/include/asm/microcode_amd.h | 1 +
 arch/x86/kernel/cpu/microcode/amd.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 209492849566..8ea477fbc65f 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,6 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
+/* Maximum patch size of all supported families */
 #define PATCH_MAX_SIZE PAGE_SIZE
 
 #ifdef CONFIG_MICROCODE_AMD
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 764dac82c03f..cc38182c76d2 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -199,6 +199,10 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
 
 	patch_size = hdr[1];
 
+/*
+ * If you modify these values or add a new one also check whether
+ * PATCH_MAX_SIZE in include/asm/microcode_amd.h needs updating, too.
+ */
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
 #define F15H_MPB_MAX_SIZE 4096
