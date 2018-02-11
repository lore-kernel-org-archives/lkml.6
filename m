Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325071-2-10308569403335529608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325070; b=YA3/bRH8SFHovtBDTllWGgf9/YG4Od/HZB4eUX/t6ciwjnF
    hHapEDFxJh8kA0SIE7xgQJ928DU4+nt7EYq9eupiQcMeF2xmX/e+ue6dl0H/sSEl
    FW0ZxijOejaDTCi2a8n5DnpZtBlsU8k/7Xb3eyLwV7ttVpQB4Sb3mLDfunJrOW6w
    wJpMgLe3fRz4V1YwY4vqzpuboRPKTmWaqxGS2NyrlZH+nqxJn9TW0F7meXqZJicS
    z5GbBiLoSlXwDKsVFsgBwT0Bb6mrn8uLy1TyuMP71K5aJw7gXrzR5049jjr2ndj1
    KRyxBLio+fBO9xdWeWz+OkXVij8jzDOKGDMP2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325070; bh=+OiZuIwI9mQCdk3uOxA
    63MexV7d1ahWSc7uhx9Lone8=; b=E1BXk7SwKcKeh9w6tpkrh4BB3tdWJ4UCZ4L
    NJ6nRYUDvY5TR95zdVA1YV302OW2gBFkCaERf0wnkCDRnPV5Qt5O0/i0l3BeRZPU
    kqYyrP/WwnP/W5e043AoQ+wpsi9Tdgz/rfA6q/hnGI5segH2fG/yz4OTacrRNRkx
    dwzZI/wh0UOaouT2JMFZZIdM4nOxQl4qdl/7BtvkhjxO+gw3iFsj4F1PzirUMJLP
    OjI9TyvEDiwyjeA5eb2XLI9IGGsU+qHvIfwvtAFRcviq+yNXaNl6BiucfHczV52m
    +4PUQI0OkR96Fg5jIV4OFTzg0GwcvoXOgLOhXNk0RPEQ3mZeT/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeBKEz6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:55:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41709 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752796AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Brian Gerst" <brgerst@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.705119318@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 131/136] x86/vdso: Get pvclock data from the vvar VMA
 instead of the fixmap
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit dac16fba6fc590fa7239676b35ed75dae4c4cd2b upstream.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/9d37826fdc7e2d2809efe31d5345f97186859284.1449702533.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/vdso/vclock_gettime.c  | 20 ++++++++------------
 arch/x86/vdso/vdso-layout.lds.S |  3 ++-
 arch/x86/vdso/vdso2c.c          |  3 +++
 arch/x86/vdso/vma.c             | 13 +++++++++++++
 arch/x86/include/asm/pvclock.h  |  9 +++++++++
 arch/x86/include/asm/vdso.h     |  1 +
 arch/x86/kernel/kvmclock.c      |  5 +++++
 7 files changed, 41 insertions(+), 13 deletions(-)

--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -36,6 +36,11 @@ static notrace cycle_t vread_hpet(void)
 }
 #endif
 
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern u8 pvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
 #ifndef BUILD_VDSO32
 
 #include <linux/kernel.h>
@@ -62,23 +67,14 @@ notrace static long vdso_fallback_gtod(s
 
 #ifdef CONFIG_PARAVIRT_CLOCK
 
-static notrace const struct pvclock_vsyscall_time_info *get_pvti(int cpu)
+static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
 {
-	const struct pvclock_vsyscall_time_info *pvti_base;
-	int idx = cpu / (PAGE_SIZE/PVTI_SIZE);
-	int offset = cpu % (PAGE_SIZE/PVTI_SIZE);
-
-	BUG_ON(PVCLOCK_FIXMAP_BEGIN + idx > PVCLOCK_FIXMAP_END);
-
-	pvti_base = (struct pvclock_vsyscall_time_info *)
-		    __fix_to_virt(PVCLOCK_FIXMAP_BEGIN+idx);
-
-	return &pvti_base[offset];
+	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
 }
 
 static notrace cycle_t vread_pvclock(int *mode)
 {
-	const struct pvclock_vcpu_time_info *pvti = &get_pvti(0)->pvti;
+	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
 	cycle_t ret;
 	u64 tsc, pvti_tsc;
 	u64 last, delta, pvti_system_time;
--- a/arch/x86/vdso/vdso-layout.lds.S
+++ b/arch/x86/vdso/vdso-layout.lds.S
@@ -25,7 +25,7 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 2 * PAGE_SIZE;
+	vvar_start = . - 3 * PAGE_SIZE;
 	vvar_page = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
@@ -36,6 +36,7 @@ SECTIONS
 #undef EMIT_VVAR
 
 	hpet_page = vvar_start + PAGE_SIZE;
+	pvclock_page = vvar_start + 2 * PAGE_SIZE;
 
 	. = SIZEOF_HEADERS;
 
--- a/arch/x86/vdso/vdso2c.c
+++ b/arch/x86/vdso/vdso2c.c
@@ -23,6 +23,7 @@ enum {
 	sym_vvar_start,
 	sym_vvar_page,
 	sym_hpet_page,
+	sym_pvclock_page,
 	sym_VDSO_FAKE_SECTION_TABLE_START,
 	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
@@ -30,6 +31,7 @@ enum {
 const int special_pages[] = {
 	sym_vvar_page,
 	sym_hpet_page,
+	sym_pvclock_page,
 };
 
 struct vdso_sym {
@@ -41,6 +43,7 @@ struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", true},
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_hpet_page] = {"hpet_page", true},
+	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
 		"VDSO_FAKE_SECTION_TABLE_START", false
 	},
--- a/arch/x86/vdso/vma.c
+++ b/arch/x86/vdso/vma.c
@@ -113,6 +113,7 @@ static int map_vdso(const struct vdso_im
 		.name = "[vvar]",
 		.pages = no_pages,
 	};
+	struct pvclock_vsyscall_time_info *pvti;
 
 	if (calculate_addr) {
 		addr = vdso_addr(current->mm->start_stack,
@@ -182,6 +183,18 @@ static int map_vdso(const struct vdso_im
 	}
 #endif
 
+	pvti = pvclock_pvti_cpu0_va();
+	if (pvti && image->sym_pvclock_page) {
+		ret = remap_pfn_range(vma,
+				      text_start + image->sym_pvclock_page,
+				      __pa(pvti) >> PAGE_SHIFT,
+				      PAGE_SIZE,
+				      PAGE_READONLY);
+
+		if (ret)
+			goto up_fail;
+	}
+
 up_fail:
 	if (ret)
 		current->mm->context.vdso = NULL;
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -4,6 +4,15 @@
 #include <linux/clocksource.h>
 #include <asm/pvclock-abi.h>
 
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void);
+#else
+static inline struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
+{
+	return NULL;
+}
+#endif
+
 /* some helper functions for xen and kvm pv clock sources */
 cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
 u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src);
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -22,6 +22,7 @@ struct vdso_image {
 
 	long sym_vvar_page;
 	long sym_hpet_page;
+	long sym_pvclock_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -44,6 +44,11 @@ early_param("no-kvmclock", parse_no_kvmc
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock wall_clock;
 
+struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
+{
+	return hv_clock;
+}
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
