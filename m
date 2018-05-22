Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1741794-1526958833-2-8454716128880446575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526958833; b=AxGRtzCp2ShncVRT+ZNpvHKMaJ4aeN6cqe5snd/BXzao9Vduef
    DSBd8mDnTEPgO2J9TKaqaCWCSMgfG/dGFAk4TD/ttuTUSZrzPCfYP5zZj/YZHZjR
    1hJ41DJC9WLLJm1Cg8z5OfZlyXzJAJB5Ytc2bU2kHaQJfiV83pmwIlq9ebASpWOf
    wrutVyfdXrqwWR0JANKc1ftfM1DQYlMDNRxFrhQ+6gxCLQRRKM9spL6+Peu3Y4g5
    +ErIRsDs+Y0yKA8W+/DQFfDITNFBzkaByUvsnIyD8f93dXisdl1KBwkLeEoHTCR2
    cHkt1m9wVOmXJ7hBm7iOMgh+O86XsPBcOLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526958833; bh=
    9oH7Q1rLGKKo5Do39X20UrsUhst8schfwFK8CmhAA1U=; b=RPKwL0EYhc/zK2PK
    iTow/zh15NP03w44sEV0dDv3AFTjbgmmnKUzOn7GKgJUjxPrpkQTRdzKDxnGkDAv
    Cwjmfkwe46ODv/t5X8DEXpgIerZvBLeMxSLO76nN6TDpRjxFZAsrkIsnPIQy/KAl
    wsAbEuKE4O8TA0fxUfZMTTfvwHHMPXE87g4JJCLeHav6UFc7mv89npuYnOOv9BHe
    boivn0L5Desq1XLgG6R+uLnkyd5rTCUUKI2+TSjpnH6MDcTk+FuB2pYQjUoCnDFG
    Ecx6vNrzkxLx7kvla+OptH0caW7q8hRq0+c/ZLKVusrn+kaRalzstLRBsTWTRI1g
    SQHqlg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOJUrx/aIvO6IlYVJv/hdGAryJdLMZ4WVpRDpT/NFLEJIF0LGhWirK0ccbobNtWpbMxu6QrkuskTWWy3U7cehmPP/PbcesfIeSaT60CzEyIiPCh6rOCJ
    9+nQ5p6MsTxKs9HMmsOri4xwh7xGdM65017OfTWiXfvguLwD/LyNdnWU8WJJVyLtVoR4sqqZnvD4bCZvausKDSslFwxWdq4rCQBon9JnMRnex0AeNXE3MTF2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
    a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=CxaZg77CAAAA:8 a=pGLkceISAAAA:8
    a=kFzenB0EbMRLnV9L55wA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=HxQw6O0h_v37Y3_G5fB_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEVDNu (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 23:13:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:55066 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751967AbeEVDNP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 May 2018 23:13:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="41795477"
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH V3 1/3] x86/efi: Call efi_delete_dummy_variable() after creating efi_rts_wq
Date: Mon, 21 May 2018 20:13:02 -0700
Message-Id: <1526958784-14688-2-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Create a workqueue named efi_rts_wq (efi runtime services workqueue), so
that all efi_runtime_services() are executed in kthread context.

Invoking efi_runtime_services() through efi_rts_wq means all accesses to
efi_runtime_services() should be done after efi_rts_wq has been created.
efi_delete_dummy_variable() calls set_variable(), hence
efi_delete_dummy_variable() should be called after efi_rts_wq has been
created.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 arch/x86/platform/efi/efi.c        | 15 +++++++++------
 drivers/firmware/efi/arm-runtime.c |  3 +++
 drivers/firmware/efi/efi.c         | 25 +++++++++++++++++++++++++
 include/linux/efi.h                |  4 ++++
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9061babfbc83..adcc55cd25ce 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -893,9 +893,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
@@ -1015,9 +1012,6 @@ static void __init __efi_enter_virtual_mode(void)
 	 * necessary relocation fixups for the new virtual addresses.
 	 */
 	efi_runtime_update_mappings();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 }
 
 void __init efi_enter_virtual_mode(void)
@@ -1031,6 +1025,15 @@ void __init efi_enter_virtual_mode(void)
 		__efi_enter_virtual_mode();
 
 	efi_dump_pagetable();
+
+	if (!efi_create_rts_wq())
+		return;
+
+	/*
+	 * Clean DUMMY object calls EFI Runtime Service, set_variable(), so
+	 * it should be invoked only after efi_rts_wq is ready.
+	 */
+	efi_delete_dummy_variable();
 }
 
 static int __init arch_parse_efi_cmdline(char *str)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..6fb06130b53f 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -139,6 +139,9 @@ static int __init arm_enable_runtime_services(void)
 		return -ENOMEM;
 	}
 
+	if (!efi_create_rts_wq())
+		return 0;
+
 	/* Set up runtime services function pointers */
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 232f4915223b..b9103caa03b4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -84,6 +84,8 @@ struct mm_struct efi_mm = {
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 };
 
+struct workqueue_struct *efi_rts_wq;
+
 static bool disable_runtime;
 static int __init setup_noefi(char *arg)
 {
@@ -337,6 +339,13 @@ static int __init efisubsys_init(void)
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
 
+	/*
+	 * If we failed to create efi_rts_wq, EFI_RUNTIME_SERVICES would
+	 * have been be cleared, check for that condition.
+	 */
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
 	/* We register the efi directory at /sys/firmware/efi */
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
@@ -971,3 +980,19 @@ static int register_update_efi_random_seed(void)
 }
 late_initcall(register_update_efi_random_seed);
 #endif
+
+bool __init efi_create_rts_wq(void)
+{
+	/*
+	 * Since we process only one efi_runtime_service() at a time, an
+	 * ordered workqueue (which creates only one execution context)
+	 * should suffice all our needs.
+	 */
+	efi_rts_wq = alloc_ordered_workqueue("efi_rts_wq", 0);
+	if (!efi_rts_wq) {
+		pr_err("Creating efi_rts_wq failed, EFI runtime services disabled.\n");
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+		return false;
+	}
+	return true;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 3016d8c456bc..565955010b18 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -987,6 +987,7 @@ extern void efi_map_pal_code (void);
 extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
+extern bool __init efi_create_rts_wq(void);
 #ifdef CONFIG_X86
 extern void efi_late_init(void);
 extern void efi_free_boot_services(void);
@@ -1651,4 +1652,7 @@ struct linux_efi_tpm_eventlog {
 
 extern int efi_tpm_eventlog_init(void);
 
+/* Workqueue to queue EFI Runtime Services */
+extern struct workqueue_struct *efi_rts_wq;
+
 #endif /* _LINUX_EFI_H */
-- 
2.7.4

