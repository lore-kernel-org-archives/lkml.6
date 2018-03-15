Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933063AbeCOXIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:19 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47740 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933048AbeCOXIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:15 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 05/10] x86/microcode/AMD: Add a reminder about
 PATCH_MAX_SIZE macro
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <fdda5856-9d88-c5c1-a1e1-255e6804fc4c@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1521150415.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
index 8e8df37f2f1b..eba9e3c8aa17 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -477,6 +477,10 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
 {
 	u32 max_size;
 
+/*
+ * If you modify these values or add a new one also check whether
+ * PATCH_MAX_SIZE in include/asm/microcode_amd.h needs updating, too.
+ */
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
 #define F15H_MPB_MAX_SIZE 4096
