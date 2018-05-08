Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1860721-1525739912-2-6391659216770565742
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525739911; b=k9J8pIkNPx5atC13XD1RhYKoMV52nV5RnB68+HGCn7Mf2oYJeZ
    GWVkFUrARpgFuse9nv4Zqu89bEfRFThKea0zR87llPXzZ08Wn/9D5GMyyKTMhL3O
    mwZ5hAyiL4N4iF9weRXoDj8hofAjemkbHay47qHuaOSXG6r6j+ryESP2KMz7bdWu
    Rotw/7vzWDs47xhqOjHaUCDEGoagbx5P4Z0yRWMEXVTOUD3xWZMd4xMJFPTyRhgm
    fFwzezquZcyrdNbTYNYuGUQ0nWlysAtfBIkAq8TnvNVoTja6MUQrb6po+8Wxnk6Y
    w7IWTDtnjJKaMXr6UEWjlgPvNroXJDI57LuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525739911; bh=aGr7ZWQ+3yqWdxnSQc0jlpmNudo53enI6QHxzz98O/A=; b=g
    TaSokgxAi/uH600lQJoSYgzZYy7QdjyCeaA2XIyQB8BHyYcTPWZe0uSFBi3Civby
    THonEDDnVMz5jbJZgOsNaBuq94MFXNsQ/JtAOjlA3O398YK1k8g6GwX/UY1r3CpC
    1DjfuwMtGst8MKyTXtTnuSil0CUrnZDlrStK3wgdxkTwLNQmtVLT4QTEirB/NFKk
    OzsurJmgTwcOBrrfB1VgnHgSwi+WRnIlqQrtvJSTzzz/ZZGOFs88HpPSBDNw+a1z
    n+cCnfq2PrjY/ufmNGaBbxcYj9tcMZMghrgiGn6rcBB6MxfMsOtnuEYVlmeI5NCi
    +5fryCoYRfYWaXj494ZVQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=sW1ZDWZn x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gAJ9vX7L;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=sW1ZDWZn x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gAJ9vX7L;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCuqZzKsYF9MudFqutx0fxN5fnSbeUb6s08sm3FYXVEW570ssRLppPk1EHm3pME3mYRDbp07uFKtNxG2YhUBkNE4ny8N15opoYrilE8bFvVaKxyTWTHX
    gzSaL6bJvM20Evsu4zxGNZzv/x5unutRHyc3y2I4ZmFflZLSsmLMsmiAE4R8Gt20Wuzu6Xxe/3ZQtNQQeRlspbGUyh/joF62gEhKwrXLombKw2eohS0Wzobk
    1kb5rhObm6PTcatvgpuhgg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=b8aGf-dT0oUA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=brckm4iaJ07kpfa81X0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqXJfO8CA4e1DU6AZsGoKyI9ntW0ye+7u6EhAgiM4y8zYyBYCYq1ewTZ8uRx6elYrbxuA8fMQ==
From: mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, kys@microsoft.com
Subject: [PATCH char-misc 2/2] Drivers: hv: vmbus: Make TLFS #define names
 architecture neutral
Date: Mon,  7 May 2018 17:37:31 -0700
Message-Id: <1525739851-54919-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
References: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: mikelley@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mikelley@microsoft.com>

The Hyper-V feature and hint flags in hyperv-tlfs.h are all defined
with the string "X64" in the name.  Some of these flags are indeed
x86/x64 specific, but others are not.  For the ones that are used
in architecture independent Hyper-V driver code, or will be used in
the upcoming support for Hyper-V for ARM64, this patch removes the
"X64" from the name.

This patch changes the flags that are currently known to be
used on multiple architectures. Hyper-V for ARM64 is still a
work-in-progress and the Top Level Functional Spec (TLFS) has not
been separated into x86/x64 and ARM64 areas.  So additional flags
may need to be updated later.

This patch only changes symbol names.  There are no functional
changes.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c          |  4 ++--
 arch/x86/include/asm/hyperv-tlfs.h | 12 ++++++------
 arch/x86/kernel/cpu/mshyperv.c     |  4 ++--
 drivers/hv/hv.c                    | 10 +++++-----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cfecc22..3db8729 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -302,7 +302,7 @@ void hyperv_init(void)
 	 * Register Hyper-V specific clocksource.
 	 */
 #ifdef CONFIG_HYPERV_TSCPAGE
-	if (ms_hyperv.features & HV_X64_MSR_REFERENCE_TSC_AVAILABLE) {
+	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
 		union hv_x64_msr_hypercall_contents tsc_msr;
 
 		tsc_pg = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
@@ -331,7 +331,7 @@ void hyperv_init(void)
 	 */
 
 	hyperv_cs = &hyperv_cs_msr;
-	if (ms_hyperv.features & HV_X64_MSR_TIME_REF_COUNT_AVAILABLE)
+	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
 		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
 	return;
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 416cb0e..44657e0 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -35,9 +35,9 @@
 /* VP Runtime (HV_X64_MSR_VP_RUNTIME) available */
 #define HV_X64_MSR_VP_RUNTIME_AVAILABLE		(1 << 0)
 /* Partition Reference Counter (HV_X64_MSR_TIME_REF_COUNT) available*/
-#define HV_X64_MSR_TIME_REF_COUNT_AVAILABLE	(1 << 1)
+#define HV_MSR_TIME_REF_COUNT_AVAILABLE		(1 << 1)
 /* Partition reference TSC MSR is available */
-#define HV_X64_MSR_REFERENCE_TSC_AVAILABLE              (1 << 9)
+#define HV_MSR_REFERENCE_TSC_AVAILABLE		(1 << 9)
 
 /* A partition's reference time stamp counter (TSC) page */
 #define HV_X64_MSR_REFERENCE_TSC		0x40000021
@@ -60,7 +60,7 @@
  * Synthetic Timer MSRs (HV_X64_MSR_STIMER0_CONFIG through
  * HV_X64_MSR_STIMER3_COUNT) available
  */
-#define HV_X64_MSR_SYNTIMER_AVAILABLE		(1 << 3)
+#define HV_MSR_SYNTIMER_AVAILABLE		(1 << 3)
 /*
  * APIC access MSRs (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR)
  * are available
@@ -86,7 +86,7 @@
 #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE (1 << 10)
 
 /* stimer Direct Mode is available */
-#define HV_X64_STIMER_DIRECT_MODE_AVAILABLE	(1 << 19)
+#define HV_STIMER_DIRECT_MODE_AVAILABLE		(1 << 19)
 
 /*
  * Feature identification: EBX indicates which flags were specified at
@@ -160,9 +160,9 @@
 #define HV_X64_RELAXED_TIMING_RECOMMENDED	(1 << 5)
 
 /*
- * Virtual APIC support
+ * Recommend not using Auto End-Of-Interrupt feature
  */
-#define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
+#define HV_DEPRECATING_AEOI_RECOMMENDED		(1 << 9)
 
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 031082c..f99ce9d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -50,7 +50,7 @@ void hyperv_vector_handler(struct pt_regs *regs)
 	if (vmbus_handler)
 		vmbus_handler();
 
-	if (ms_hyperv.hints & HV_X64_DEPRECATING_AEOI_RECOMMENDED)
+	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		ack_APIC_irq();
 
 	exiting_irq();
@@ -300,7 +300,7 @@ static void __init ms_hyperv_init_platform(void)
 				hyperv_reenlightenment_vector);
 
 	/* Setup the IDT for stimer0 */
-	if (ms_hyperv.misc_features & HV_X64_STIMER_DIRECT_MODE_AVAILABLE)
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
 		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
 				hv_stimer0_callback_vector);
 #endif
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 96c403a..c72e8d7 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -64,7 +64,7 @@ int hv_init(void)
 		return -ENOMEM;
 
 	direct_mode_enabled = ms_hyperv.misc_features &
-			HV_X64_STIMER_DIRECT_MODE_AVAILABLE;
+			HV_STIMER_DIRECT_MODE_AVAILABLE;
 	return 0;
 }
 
@@ -302,7 +302,7 @@ int hv_synic_init(unsigned int cpu)
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
-	if (ms_hyperv.hints & HV_X64_DEPRECATING_AEOI_RECOMMENDED)
+	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		shared_sint.auto_eoi = false;
 	else
 		shared_sint.auto_eoi = true;
@@ -320,7 +320,7 @@ int hv_synic_init(unsigned int cpu)
 	/*
 	 * Register the per-cpu clockevent source.
 	 */
-	if (ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE)
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
 		clockevents_config_and_register(hv_cpu->clk_evt,
 						HV_TIMER_FREQUENCY,
 						HV_MIN_DELTA_TICKS,
@@ -335,7 +335,7 @@ void hv_synic_clockevents_cleanup(void)
 {
 	int cpu;
 
-	if (!(ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE))
+	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
 		return;
 
 	if (direct_mode_enabled)
@@ -394,7 +394,7 @@ int hv_synic_cleanup(unsigned int cpu)
 		return -EBUSY;
 
 	/* Turn off clockevent device */
-	if (ms_hyperv.features & HV_X64_MSR_SYNTIMER_AVAILABLE) {
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
 		struct hv_per_cpu_context *hv_cpu
 			= this_cpu_ptr(hv_context.cpu_context);
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
