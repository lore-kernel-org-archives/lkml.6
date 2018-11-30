Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E71C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D8C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D8C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeK3VIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:08:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK3VIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:08:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9xDJl3262035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:59:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9xDPx3262032;
        Fri, 30 Nov 2018 01:59:13 -0800
Date:   Fri, 30 Nov 2018 01:59:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth Prakhya <tipbot@zytor.com>
Message-ID: <tip-47c33a095e1fae376d74b4160a0d73c1a4e73969@git.kernel.org>
Cc:     dave.hansen@intel.com, julien.thierry@arm.com,
        matt@codeblueprint.co.uk, mingo@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, bp@alien8.de, jonathanh@nvidia.com,
        eric.snowberg@oracle.com, sedat.dilek@gmail.com,
        peterz@infradead.org, tglx@linutronix.de, marc.zyngier@arm.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        sai.praneeth.prakhya@intel.com, hdegoede@redhat.com,
        joe@perches.com, arend.vanspriel@broadcom.com,
        natechancellor@gmail.com, bhsharma@redhat.com,
        zhuyifei1999@gmail.com, ard.biesheuvel@linaro.org
Reply-To: sedat.dilek@gmail.com, tglx@linutronix.de, peterz@infradead.org,
          marc.zyngier@arm.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, joe@perches.com,
          hdegoede@redhat.com, sai.praneeth.prakhya@intel.com,
          bhsharma@redhat.com, arend.vanspriel@broadcom.com,
          natechancellor@gmail.com, ard.biesheuvel@linaro.org,
          zhuyifei1999@gmail.com, dave.hansen@intel.com,
          julien.thierry@arm.com, mingo@kernel.org,
          matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
          hpa@zytor.com, jonathanh@nvidia.com, eric.snowberg@oracle.com,
          bp@alien8.de
In-Reply-To: <20181129171230.18699-7-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-7-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/efi: Move efi_<reserve/free>_boot_services() to
 arch/x86
Git-Commit-ID: 47c33a095e1fae376d74b4160a0d73c1a4e73969
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  47c33a095e1fae376d74b4160a0d73c1a4e73969
Gitweb:     https://git.kernel.org/tip/47c33a095e1fae376d74b4160a0d73c1a4e73969
Author:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
AuthorDate: Thu, 29 Nov 2018 18:12:25 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:31 +0100

x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86

efi_<reserve/free>_boot_services() are x86 specific quirks and as such
should be in asm/efi.h, so move them from linux/efi.h. Also, call
efi_free_boot_services() from __efi_enter_virtual_mode() as it is x86
specific call and ideally shouldn't be part of init/main.c

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-7-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/efi.h  | 2 ++
 arch/x86/platform/efi/efi.c | 2 ++
 include/linux/efi.h         | 3 ---
 init/main.c                 | 4 ----
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index eea40d52ca78..d1e64ac80b9c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -141,6 +141,8 @@ extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
+extern void efi_free_boot_services(void);
+extern void efi_reserve_boot_services(void);
 
 struct efi_setup_data {
 	u64 fw_vendor;
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 7ae939e353cd..e1cb01a22fa8 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -993,6 +993,8 @@ static void __init __efi_enter_virtual_mode(void)
 		panic("EFI call to SetVirtualAddressMap() failed!");
 	}
 
+	efi_free_boot_services();
+
 	/*
 	 * Now that EFI is in virtual mode, update the function
 	 * pointers in the runtime service table to the new virtual addresses.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 100ce4a4aff6..2b3b33c83b05 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1000,13 +1000,11 @@ extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #ifdef CONFIG_X86
-extern void efi_free_boot_services(void);
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
 extern void efi_find_mirror(void);
 #else
-static inline void efi_free_boot_services(void) {}
 
 static inline efi_status_t efi_query_variable_store(u32 attributes,
 						    unsigned long size,
@@ -1046,7 +1044,6 @@ extern void efi_mem_reserve(phys_addr_t addr, u64 size);
 extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 		struct resource *data_resource, struct resource *bss_resource);
-extern void efi_reserve_boot_services(void);
 extern int efi_get_fdt_params(struct efi_fdt_params *params);
 extern struct kobject *efi_kobj;
 
diff --git a/init/main.c b/init/main.c
index ee147103ba1b..ccefcd8e855f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -737,10 +737,6 @@ asmlinkage __visible void __init start_kernel(void)
 	arch_post_acpi_subsys_init();
 	sfi_init_late();
 
-	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
-		efi_free_boot_services();
-	}
-
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 }
