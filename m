Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDDGpo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:45:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2490 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751264AbeDDGpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:45:42 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38601278"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <bp@suse.de>, <luto@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <keescook@chromium.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/processor: Remove two legacy function declaration
Date: Wed, 4 Apr 2018 14:45:27 +0800
Message-ID: <20180404064527.10562-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: ACD334D0EFE1.A3314
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the early_trap_init() and cpu_set_gdt() have been abandoned, so remove
them.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd4847a58..3ef3221107c3 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -739,13 +739,11 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-extern void early_trap_init(void);
 void early_trap_pf_init(void);
 
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void cpu_set_gdt(int);
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
-- 
2.14.3
