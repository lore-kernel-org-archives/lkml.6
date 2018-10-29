Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB3B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB3B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeJ2UXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:23:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJ2UXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:23:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9TBY2sX1519734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Oct 2018 04:34:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9TBY0ru1519731;
        Mon, 29 Oct 2018 04:34:00 -0700
Date:   Mon, 29 Oct 2018 04:34:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jordan Borgner <tipbot@zytor.com>
Message-ID: <tip-0e96f31ea4249b1e94e266fe4dff908c2983a9b3@git.kernel.org>
Cc:     mail@jordan-borgner.de, bp@alien8.de, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
          mail@jordan-borgner.de, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20181028125828.7rgammkgzep2wpam@JordanDesktop>
References: <20181028125828.7rgammkgzep2wpam@JordanDesktop>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Clean up 'sizeof x' => 'sizeof(x)'
Git-Commit-ID: 0e96f31ea4249b1e94e266fe4dff908c2983a9b3
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

Commit-ID:  0e96f31ea4249b1e94e266fe4dff908c2983a9b3
Gitweb:     https://git.kernel.org/tip/0e96f31ea4249b1e94e266fe4dff908c2983a9b3
Author:     Jordan Borgner <mail@jordan-borgner.de>
AuthorDate: Sun, 28 Oct 2018 12:58:28 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Oct 2018 07:13:28 +0100

x86: Clean up 'sizeof x' => 'sizeof(x)'

"sizeof(x)" is the canonical coding style used in arch/x86 most of the time.
Fix the few places that didn't follow the convention.

(Also do some whitespace cleanups in a few places while at it.)

[ mingo: Rewrote the changelog. ]

Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181028125828.7rgammkgzep2wpam@JordanDesktop
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/cpucheck.c             |  2 +-
 arch/x86/boot/early_serial_console.c |  4 ++--
 arch/x86/boot/edd.c                  |  6 +++---
 arch/x86/boot/main.c                 |  4 ++--
 arch/x86/boot/memory.c               |  2 +-
 arch/x86/boot/regs.c                 |  2 +-
 arch/x86/boot/video-vesa.c           |  6 +++---
 arch/x86/boot/video.c                |  2 +-
 arch/x86/events/intel/core.c         |  2 +-
 arch/x86/kernel/cpu/common.c         |  4 ++--
 arch/x86/kernel/cpu/mcheck/mce.c     |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c   |  2 +-
 arch/x86/kernel/cpu/mtrr/if.c        |  6 +++---
 arch/x86/kernel/head64.c             |  2 +-
 arch/x86/kernel/msr.c                |  8 +++----
 arch/x86/kvm/emulate.c               | 22 +++++++++----------
 arch/x86/kvm/lapic.c                 |  2 +-
 arch/x86/kvm/x86.c                   | 42 ++++++++++++++++++------------------
 arch/x86/tools/relocs.c              |  4 ++--
 arch/x86/um/asm/elf.h                |  2 +-
 20 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index 8f0c4c9fc904..51079fc9298f 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -113,7 +113,7 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32 **err_flags_ptr)
 {
 	int err;
 
-	memset(&cpu.flags, 0, sizeof cpu.flags);
+	memset(&cpu.flags, 0, sizeof(cpu.flags));
 	cpu.level = 3;
 
 	if (has_eflag(X86_EFLAGS_AC))
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index b25c53527a94..023bf1c3de8b 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -50,7 +50,7 @@ static void parse_earlyprintk(void)
 	int pos = 0;
 	int port = 0;
 
-	if (cmdline_find_option("earlyprintk", arg, sizeof arg) > 0) {
+	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
 		char *e;
 
 		if (!strncmp(arg, "serial", 6)) {
@@ -124,7 +124,7 @@ static void parse_console_uart8250(void)
 	 * console=uart8250,io,0x3f8,115200n8
 	 * need to make sure it is last one console !
 	 */
-	if (cmdline_find_option("console", optstr, sizeof optstr) <= 0)
+	if (cmdline_find_option("console", optstr, sizeof(optstr)) <= 0)
 		return;
 
 	options = optstr;
diff --git a/arch/x86/boot/edd.c b/arch/x86/boot/edd.c
index 223e42527077..6c176b6a42ad 100644
--- a/arch/x86/boot/edd.c
+++ b/arch/x86/boot/edd.c
@@ -76,7 +76,7 @@ static int get_edd_info(u8 devno, struct edd_info *ei)
 {
 	struct biosregs ireg, oreg;
 
-	memset(ei, 0, sizeof *ei);
+	memset(ei, 0, sizeof(*ei));
 
 	/* Check Extensions Present */
 
@@ -133,7 +133,7 @@ void query_edd(void)
 	struct edd_info ei, *edp;
 	u32 *mbrptr;
 
-	if (cmdline_find_option("edd", eddarg, sizeof eddarg) > 0) {
+	if (cmdline_find_option("edd", eddarg, sizeof(eddarg)) > 0) {
 		if (!strcmp(eddarg, "skipmbr") || !strcmp(eddarg, "skip")) {
 			do_edd = 1;
 			do_mbr = 0;
@@ -166,7 +166,7 @@ void query_edd(void)
 		 */
 		if (!get_edd_info(devno, &ei)
 		    && boot_params.eddbuf_entries < EDDMAXNR) {
-			memcpy(edp, &ei, sizeof ei);
+			memcpy(edp, &ei, sizeof(ei));
 			edp++;
 			boot_params.eddbuf_entries++;
 		}
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index 9bcea386db65..73532543d689 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -36,8 +36,8 @@ static void copy_boot_params(void)
 	const struct old_cmdline * const oldcmd =
 		(const struct old_cmdline *)OLD_CL_ADDRESS;
 
-	BUILD_BUG_ON(sizeof boot_params != 4096);
-	memcpy(&boot_params.hdr, &hdr, sizeof hdr);
+	BUILD_BUG_ON(sizeof(boot_params) != 4096);
+	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));
 
 	if (!boot_params.hdr.cmd_line_ptr &&
 	    oldcmd->cl_magic == OLD_CL_MAGIC) {
diff --git a/arch/x86/boot/memory.c b/arch/x86/boot/memory.c
index d9c28c87e477..7df2b28207be 100644
--- a/arch/x86/boot/memory.c
+++ b/arch/x86/boot/memory.c
@@ -26,7 +26,7 @@ static int detect_memory_e820(void)
 
 	initregs(&ireg);
 	ireg.ax  = 0xe820;
-	ireg.cx  = sizeof buf;
+	ireg.cx  = sizeof(buf);
 	ireg.edx = SMAP;
 	ireg.di  = (size_t)&buf;
 
diff --git a/arch/x86/boot/regs.c b/arch/x86/boot/regs.c
index c0fb356a3092..2fe3616ba161 100644
--- a/arch/x86/boot/regs.c
+++ b/arch/x86/boot/regs.c
@@ -21,7 +21,7 @@
 
 void initregs(struct biosregs *reg)
 {
-	memset(reg, 0, sizeof *reg);
+	memset(reg, 0, sizeof(*reg));
 	reg->eflags |= X86_EFLAGS_CF;
 	reg->ds = ds();
 	reg->es = ds();
diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c
index ba3e100654db..3ecc11a9c440 100644
--- a/arch/x86/boot/video-vesa.c
+++ b/arch/x86/boot/video-vesa.c
@@ -62,7 +62,7 @@ static int vesa_probe(void)
 		if (mode & ~0x1ff)
 			continue;
 
-		memset(&vminfo, 0, sizeof vminfo); /* Just in case... */
+		memset(&vminfo, 0, sizeof(vminfo)); /* Just in case... */
 
 		ireg.ax = 0x4f01;
 		ireg.cx = mode;
@@ -109,7 +109,7 @@ static int vesa_set_mode(struct mode_info *mode)
 	int is_graphic;
 	u16 vesa_mode = mode->mode - VIDEO_FIRST_VESA;
 
-	memset(&vminfo, 0, sizeof vminfo); /* Just in case... */
+	memset(&vminfo, 0, sizeof(vminfo)); /* Just in case... */
 
 	initregs(&ireg);
 	ireg.ax = 0x4f01;
@@ -241,7 +241,7 @@ void vesa_store_edid(void)
 	struct biosregs ireg, oreg;
 
 	/* Apparently used as a nonsense token... */
-	memset(&boot_params.edid_info, 0x13, sizeof boot_params.edid_info);
+	memset(&boot_params.edid_info, 0x13, sizeof(boot_params.edid_info));
 
 	if (vginfo.version < 0x0200)
 		return;		/* EDID requires VBE 2.0+ */
diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
index 77780e386e9b..ac89b6624a40 100644
--- a/arch/x86/boot/video.c
+++ b/arch/x86/boot/video.c
@@ -115,7 +115,7 @@ static unsigned int get_entry(void)
 		} else if ((key >= '0' && key <= '9') ||
 			   (key >= 'A' && key <= 'Z') ||
 			   (key >= 'a' && key <= 'z')) {
-			if (len < sizeof entry_buf) {
+			if (len < sizeof(entry_buf)) {
 				entry_buf[len++] = key;
 				putchar(key);
 			}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0fb8659b20d8..273c62e81546 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4535,7 +4535,7 @@ __init int intel_pmu_init(void)
 		}
 	}
 
-	snprintf(pmu_name_str, sizeof pmu_name_str, "%s", name);
+	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
 
 	if (version >= 2 && extra_attr) {
 		x86_pmu.format_attrs = merge_attr(intel_arch3_formats_attr,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 660d0b22e962..3a4eb2b25d71 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1074,7 +1074,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 #endif
 	c->x86_cache_alignment = c->x86_clflush_size;
 
-	memset(&c->x86_capability, 0, sizeof c->x86_capability);
+	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 	c->extended_cpuid_level = 0;
 
 	if (!have_cpuid_p())
@@ -1317,7 +1317,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_virt_bits = 32;
 #endif
 	c->x86_cache_alignment = c->x86_clflush_size;
-	memset(&c->x86_capability, 0, sizeof c->x86_capability);
+	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 
 	generic_identify(c);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8cb3c02980cf..8c66d2fc8f81 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2215,7 +2215,7 @@ static int mce_device_create(unsigned int cpu)
 	if (dev)
 		return 0;
 
-	dev = kzalloc(sizeof *dev, GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	dev->id  = cpu;
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e12ee86906c6..86e277f8daf4 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -798,7 +798,7 @@ static void generic_set_all(void)
 	local_irq_restore(flags);
 
 	/* Use the atomic bitops to update the global mask */
-	for (count = 0; count < sizeof mask * 8; ++count) {
+	for (count = 0; count < sizeof(mask) * 8; ++count) {
 		if (mask & 0x01)
 			set_bit(count, &smp_changes_mask);
 		mask >>= 1;
diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 40eee6cc4124..2e173d47b450 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -174,12 +174,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	case MTRRIOC_SET_PAGE_ENTRY:
 	case MTRRIOC_DEL_PAGE_ENTRY:
 	case MTRRIOC_KILL_PAGE_ENTRY:
-		if (copy_from_user(&sentry, arg, sizeof sentry))
+		if (copy_from_user(&sentry, arg, sizeof(sentry)))
 			return -EFAULT;
 		break;
 	case MTRRIOC_GET_ENTRY:
 	case MTRRIOC_GET_PAGE_ENTRY:
-		if (copy_from_user(&gentry, arg, sizeof gentry))
+		if (copy_from_user(&gentry, arg, sizeof(gentry)))
 			return -EFAULT;
 		break;
 #ifdef CONFIG_COMPAT
@@ -332,7 +332,7 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	switch (cmd) {
 	case MTRRIOC_GET_ENTRY:
 	case MTRRIOC_GET_PAGE_ENTRY:
-		if (copy_to_user(arg, &gentry, sizeof gentry))
+		if (copy_to_user(arg, &gentry, sizeof(gentry)))
 			err = -EFAULT;
 		break;
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5dc377dc9d7b..7663a8eb602b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -385,7 +385,7 @@ static void __init copy_bootdata(char *real_mode_data)
 	 */
 	sme_map_bootdata(real_mode_data);
 
-	memcpy(&boot_params, real_mode_data, sizeof boot_params);
+	memcpy(&boot_params, real_mode_data, sizeof(boot_params));
 	sanitize_boot_params(&boot_params);
 	cmd_line_ptr = get_cmd_line_ptr();
 	if (cmd_line_ptr) {
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index ef688804f80d..4588414e2561 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -115,14 +115,14 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EBADF;
 			break;
 		}
-		if (copy_from_user(&regs, uregs, sizeof regs)) {
+		if (copy_from_user(&regs, uregs, sizeof(regs))) {
 			err = -EFAULT;
 			break;
 		}
 		err = rdmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
-		if (copy_to_user(uregs, &regs, sizeof regs))
+		if (copy_to_user(uregs, &regs, sizeof(regs)))
 			err = -EFAULT;
 		break;
 
@@ -131,14 +131,14 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EBADF;
 			break;
 		}
-		if (copy_from_user(&regs, uregs, sizeof regs)) {
+		if (copy_from_user(&regs, uregs, sizeof(regs))) {
 			err = -EFAULT;
 			break;
 		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
-		if (copy_to_user(uregs, &regs, sizeof regs))
+		if (copy_to_user(uregs, &regs, sizeof(regs)))
 			err = -EFAULT;
 		break;
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 34edf198708f..78e430f4e15c 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1509,7 +1509,7 @@ static int read_interrupt_descriptor(struct x86_emulate_ctxt *ctxt,
 		return emulate_gp(ctxt, index << 3 | 0x2);
 
 	addr = dt.address + index * 8;
-	return linear_read_system(ctxt, addr, desc, sizeof *desc);
+	return linear_read_system(ctxt, addr, desc, sizeof(*desc));
 }
 
 static void get_descriptor_table_ptr(struct x86_emulate_ctxt *ctxt,
@@ -1522,7 +1522,7 @@ static void get_descriptor_table_ptr(struct x86_emulate_ctxt *ctxt,
 		struct desc_struct desc;
 		u16 sel;
 
-		memset (dt, 0, sizeof *dt);
+		memset(dt, 0, sizeof(*dt));
 		if (!ops->get_segment(ctxt, &sel, &desc, &base3,
 				      VCPU_SREG_LDTR))
 			return;
@@ -1586,7 +1586,7 @@ static int write_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	return linear_write_system(ctxt, addr, desc, sizeof *desc);
+	return linear_write_system(ctxt, addr, desc, sizeof(*desc));
 }
 
 static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
@@ -1604,7 +1604,7 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 	u16 dummy;
 	u32 base3 = 0;
 
-	memset(&seg_desc, 0, sizeof seg_desc);
+	memset(&seg_desc, 0, sizeof(seg_desc));
 
 	if (ctxt->mode == X86EMUL_MODE_REAL) {
 		/* set real mode segment descriptor (keep limit etc. for
@@ -3075,17 +3075,17 @@ static int task_switch_16(struct x86_emulate_ctxt *ctxt,
 	int ret;
 	u32 new_tss_base = get_desc_base(new_desc);
 
-	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
 	save_state_to_tss16(ctxt, &tss_seg);
 
-	ret = linear_write_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_write_system(ctxt, old_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
-	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
@@ -3094,7 +3094,7 @@ static int task_switch_16(struct x86_emulate_ctxt *ctxt,
 
 		ret = linear_write_system(ctxt, new_tss_base,
 					  &tss_seg.prev_task_link,
-					  sizeof tss_seg.prev_task_link);
+					  sizeof(tss_seg.prev_task_link));
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 	}
@@ -3216,7 +3216,7 @@ static int task_switch_32(struct x86_emulate_ctxt *ctxt,
 	u32 eip_offset = offsetof(struct tss_segment_32, eip);
 	u32 ldt_sel_offset = offsetof(struct tss_segment_32, ldt_selector);
 
-	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
@@ -3228,7 +3228,7 @@ static int task_switch_32(struct x86_emulate_ctxt *ctxt,
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
-	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
@@ -3237,7 +3237,7 @@ static int task_switch_32(struct x86_emulate_ctxt *ctxt,
 
 		ret = linear_write_system(ctxt, new_tss_base,
 					  &tss_seg.prev_task_link,
-					  sizeof tss_seg.prev_task_link);
+					  sizeof(tss_seg.prev_task_link));
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 	}
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3cd227ff807f..89db20f8cb70 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2409,7 +2409,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	r = kvm_apic_state_fixup(vcpu, s, true);
 	if (r)
 		return r;
-	memcpy(vcpu->arch.apic->regs, s->regs, sizeof *s);
+	memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
 
 	recalculate_apic_map(vcpu->kvm);
 	kvm_apic_set_version(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 66d66d77caee..5cd5647120f2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2924,7 +2924,7 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
 	unsigned size;
 
 	r = -EFAULT;
-	if (copy_from_user(&msrs, user_msrs, sizeof msrs))
+	if (copy_from_user(&msrs, user_msrs, sizeof(msrs)))
 		goto out;
 
 	r = -E2BIG;
@@ -3091,11 +3091,11 @@ long kvm_arch_dev_ioctl(struct file *filp,
 		unsigned n;
 
 		r = -EFAULT;
-		if (copy_from_user(&msr_list, user_msr_list, sizeof msr_list))
+		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
 			goto out;
 		n = msr_list.nmsrs;
 		msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
-		if (copy_to_user(user_msr_list, &msr_list, sizeof msr_list))
+		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
 			goto out;
 		r = -E2BIG;
 		if (n < msr_list.nmsrs)
@@ -3117,7 +3117,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 		struct kvm_cpuid2 cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 
 		r = kvm_dev_ioctl_get_cpuid(&cpuid, cpuid_arg->entries,
@@ -3126,7 +3126,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			goto out;
 
 		r = -EFAULT;
-		if (copy_to_user(cpuid_arg, &cpuid, sizeof cpuid))
+		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
 			goto out;
 		r = 0;
 		break;
@@ -3894,7 +3894,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_interrupt irq;
 
 		r = -EFAULT;
-		if (copy_from_user(&irq, argp, sizeof irq))
+		if (copy_from_user(&irq, argp, sizeof(irq)))
 			goto out;
 		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
 		break;
@@ -3912,7 +3912,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_cpuid cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 		r = kvm_vcpu_ioctl_set_cpuid(vcpu, &cpuid, cpuid_arg->entries);
 		break;
@@ -3922,7 +3922,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_cpuid2 cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 		r = kvm_vcpu_ioctl_set_cpuid2(vcpu, &cpuid,
 					      cpuid_arg->entries);
@@ -3933,14 +3933,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_cpuid2 cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
 					      cpuid_arg->entries);
 		if (r)
 			goto out;
 		r = -EFAULT;
-		if (copy_to_user(cpuid_arg, &cpuid, sizeof cpuid))
+		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
 			goto out;
 		r = 0;
 		break;
@@ -3961,13 +3961,13 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_tpr_access_ctl tac;
 
 		r = -EFAULT;
-		if (copy_from_user(&tac, argp, sizeof tac))
+		if (copy_from_user(&tac, argp, sizeof(tac)))
 			goto out;
 		r = vcpu_ioctl_tpr_access_reporting(vcpu, &tac);
 		if (r)
 			goto out;
 		r = -EFAULT;
-		if (copy_to_user(argp, &tac, sizeof tac))
+		if (copy_to_user(argp, &tac, sizeof(tac)))
 			goto out;
 		r = 0;
 		break;
@@ -3980,7 +3980,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!lapic_in_kernel(vcpu))
 			goto out;
 		r = -EFAULT;
-		if (copy_from_user(&va, argp, sizeof va))
+		if (copy_from_user(&va, argp, sizeof(va)))
 			goto out;
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_lapic_set_vapic_addr(vcpu, va.vapic_addr);
@@ -3991,7 +3991,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u64 mcg_cap;
 
 		r = -EFAULT;
-		if (copy_from_user(&mcg_cap, argp, sizeof mcg_cap))
+		if (copy_from_user(&mcg_cap, argp, sizeof(mcg_cap)))
 			goto out;
 		r = kvm_vcpu_ioctl_x86_setup_mce(vcpu, mcg_cap);
 		break;
@@ -4000,7 +4000,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_x86_mce mce;
 
 		r = -EFAULT;
-		if (copy_from_user(&mce, argp, sizeof mce))
+		if (copy_from_user(&mce, argp, sizeof(mce)))
 			goto out;
 		r = kvm_vcpu_ioctl_x86_set_mce(vcpu, &mce);
 		break;
@@ -4536,7 +4536,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (kvm->created_vcpus)
 			goto set_identity_unlock;
 		r = -EFAULT;
-		if (copy_from_user(&ident_addr, argp, sizeof ident_addr))
+		if (copy_from_user(&ident_addr, argp, sizeof(ident_addr)))
 			goto set_identity_unlock;
 		r = kvm_vm_ioctl_set_identity_map_addr(kvm, ident_addr);
 set_identity_unlock:
@@ -4620,7 +4620,7 @@ set_identity_unlock:
 		if (r)
 			goto get_irqchip_out;
 		r = -EFAULT;
-		if (copy_to_user(argp, chip, sizeof *chip))
+		if (copy_to_user(argp, chip, sizeof(*chip)))
 			goto get_irqchip_out;
 		r = 0;
 	get_irqchip_out:
@@ -4666,7 +4666,7 @@ set_identity_unlock:
 	}
 	case KVM_SET_PIT: {
 		r = -EFAULT;
-		if (copy_from_user(&u.ps, argp, sizeof u.ps))
+		if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
 			goto out;
 		r = -ENXIO;
 		if (!kvm->arch.vpit)
@@ -8205,7 +8205,7 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->efer = vcpu->arch.efer;
 	sregs->apic_base = kvm_get_apic_base(vcpu);
 
-	memset(sregs->interrupt_bitmap, 0, sizeof sregs->interrupt_bitmap);
+	memset(sregs->interrupt_bitmap, 0, sizeof(sregs->interrupt_bitmap));
 
 	if (vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft)
 		set_bit(vcpu->arch.interrupt.nr,
@@ -8509,7 +8509,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->last_opcode = fxsave->fop;
 	fpu->last_ip = fxsave->rip;
 	fpu->last_dp = fxsave->rdp;
-	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
+	memcpy(fpu->xmm, fxsave->xmm_space, sizeof(fxsave->xmm_space));
 
 	vcpu_put(vcpu);
 	return 0;
@@ -8530,7 +8530,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->fop = fpu->last_opcode;
 	fxsave->rip = fpu->last_ip;
 	fxsave->rdp = fpu->last_dp;
-	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
+	memcpy(fxsave->xmm_space, fpu->xmm, sizeof(fxsave->xmm_space));
 
 	vcpu_put(vcpu);
 	return 0;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 0b08067c45f3..b629f6992d9f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -130,7 +130,7 @@ static void regex_init(int use_real_mode)
 			      REG_EXTENDED|REG_NOSUB);
 
 		if (err) {
-			regerror(err, &sym_regex_c[i], errbuf, sizeof errbuf);
+			regerror(err, &sym_regex_c[i], errbuf, sizeof(errbuf));
 			die("%s", errbuf);
 		}
         }
@@ -405,7 +405,7 @@ static void read_shdrs(FILE *fp)
 	}
 	for (i = 0; i < ehdr.e_shnum; i++) {
 		struct section *sec = &secs[i];
-		if (fread(&shdr, sizeof shdr, 1, fp) != 1)
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read ELF section headers %d/%d: %s\n",
 			    i, ehdr.e_shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 413f3519d9a1..c907b20d4993 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -194,7 +194,7 @@ extern unsigned long um_vdso_addr;
 
 typedef unsigned long elf_greg_t;
 
-#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+#define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 typedef struct user_i387_struct elf_fpregset_t;
