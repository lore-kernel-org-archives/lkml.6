Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C8C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC2320665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jordan-borgner.de header.i=@jordan-borgner.de header.b="D4VCXUSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC2320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jordan-borgner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJ1VzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:55:20 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:35787 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1VzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:55:20 -0400
X-Greylist: delayed 711 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Oct 2018 17:55:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540732239;
        s=strato-dkim-0002; d=jordan-borgner.de;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=HqXJ1scQ3eaqUAt+8aRxWhRL8Zw0LPiuJpGU4289DoA=;
        b=D4VCXUSF00wmDwu965aMylh/pTAAryexUuKizMl/GKGMURYuzI6VtVEJmWHbzCqRcw
        ziIwL2wZl+/dsyNrggCxuZDNF5SkD7l8lOB8ly3s0bkrYLrqz6MQvLHY0P3zupMERDYx
        TXvzxIicatCVhYhjRSmTDW1K8W7X64TZXm1IMgUGvwjlLKT+eNx7jHxxn+rsupqPqs17
        WpLtuVJ894dgS2J0WvdZRMxjdMvnBlcVBW9thy8qAXVaPTZDHYcCcC3xF5DApwyc0/G7
        rD3gHvnsMWdNEWBVX34re/ZmqKenKLX87JAe8W7nEFziwAhLJBwGnsG8boDIVBJn+eiY
        9V0A==
X-RZG-AUTH: ":IW0NeWCidO14P1liib3FUweRdVVCz7ay1c0SPzCKsLZUvHozh80V6gGoQeGJaantMcUcRJe5mIbtCrgHkxiccBaMa+VKYZNxzaaeoDv7K+jgyw=="
X-RZG-CLASS-ID: mo00
Received: from JordanDesktop
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id z07cbcu9SCwTtZ9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 28 Oct 2018 13:58:29 +0100 (CET)
Date:   Sun, 28 Oct 2018 12:58:28 +0000
From:   Jordan Borgner <mail@jordan-borgner.de>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: [PATCH] arch: x86: Touched up patterns of 'sizeof' functions
Message-ID: <20181028125828.7rgammkgzep2wpam@JordanDesktop>
MIME-Version: 1.0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arch-x86-Touched-up-patterns-of-sizeof-funcitons.patch"
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addded missing parentheses to 'sizeof()' functions in arch/x86/.

Like this:
Before: 'sizeof x'
After:  'sizeof(x)'

Done by motivation of Ingo Molnar.

Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>
---
 linux-4.19/arch/x86/boot/cpucheck.c             |  2 +-
 linux-4.19/arch/x86/boot/early_serial_console.c |  4 +--
 linux-4.19/arch/x86/boot/edd.c                  |  6 ++--
 linux-4.19/arch/x86/boot/main.c                 |  4 +--
 linux-4.19/arch/x86/boot/memory.c               |  2 +-
 linux-4.19/arch/x86/boot/regs.c                 |  2 +-
 linux-4.19/arch/x86/boot/video-vesa.c           |  6 ++--
 linux-4.19/arch/x86/boot/video.c                |  2 +-
 linux-4.19/arch/x86/events/intel/core.c         |  2 +-
 linux-4.19/arch/x86/kernel/cpu/common.c         |  4 +--
 linux-4.19/arch/x86/kernel/cpu/mcheck/mce.c     |  2 +-
 linux-4.19/arch/x86/kernel/cpu/mtrr/generic.c   |  2 +-
 linux-4.19/arch/x86/kernel/cpu/mtrr/if.c        |  6 ++--
 linux-4.19/arch/x86/kernel/head64.c             |  2 +-
 linux-4.19/arch/x86/kernel/msr.c                |  8 ++---
 linux-4.19/arch/x86/kvm/emulate.c               | 22 ++++++-------
 linux-4.19/arch/x86/kvm/lapic.c                 |  2 +-
 linux-4.19/arch/x86/kvm/x86.c                   | 42 ++++++++++++-------------
 linux-4.19/arch/x86/tools/relocs.c              |  4 +--
 linux-4.19/arch/x86/um/asm/elf.h                |  2 +-
 20 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/linux-4.19/arch/x86/boot/cpucheck.c b/linux-4.19/arch/x86/boot/cpucheck.c
index 8f0c4c9..51079fc 100644
--- a/linux-4.19/arch/x86/boot/cpucheck.c
+++ b/linux-4.19/arch/x86/boot/cpucheck.c
@@ -113,7 +113,7 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32 **err_flags_ptr)
 {
 	int err;
 
-	memset(&cpu.flags, 0, sizeof cpu.flags);
+	memset(&cpu.flags, 0, sizeof(cpu.flags));
 	cpu.level = 3;
 
 	if (has_eflag(X86_EFLAGS_AC))
diff --git a/linux-4.19/arch/x86/boot/early_serial_console.c b/linux-4.19/arch/x86/boot/early_serial_console.c
index b25c535..023bf1c 100644
--- a/linux-4.19/arch/x86/boot/early_serial_console.c
+++ b/linux-4.19/arch/x86/boot/early_serial_console.c
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
diff --git a/linux-4.19/arch/x86/boot/edd.c b/linux-4.19/arch/x86/boot/edd.c
index 223e425..6c176b6 100644
--- a/linux-4.19/arch/x86/boot/edd.c
+++ b/linux-4.19/arch/x86/boot/edd.c
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
diff --git a/linux-4.19/arch/x86/boot/main.c b/linux-4.19/arch/x86/boot/main.c
index 9bcea38..7353254 100644
--- a/linux-4.19/arch/x86/boot/main.c
+++ b/linux-4.19/arch/x86/boot/main.c
@@ -36,8 +36,8 @@ static void copy_boot_params(void)
 	const struct old_cmdline * const oldcmd =
 		(const struct old_cmdline *)OLD_CL_ADDRESS;
 
-	BUILD_BUG_ON(sizeof boot_params != 4096);
-	memcpy(&boot_params.hdr, &hdr, sizeof hdr);
+	BUILD_BUG_ON(sizeof(boot_params) != 4096);
+	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));
 
 	if (!boot_params.hdr.cmd_line_ptr &&
 	    oldcmd->cl_magic == OLD_CL_MAGIC) {
diff --git a/linux-4.19/arch/x86/boot/memory.c b/linux-4.19/arch/x86/boot/memory.c
index d9c28c8..7df2b28 100644
--- a/linux-4.19/arch/x86/boot/memory.c
+++ b/linux-4.19/arch/x86/boot/memory.c
@@ -26,7 +26,7 @@ static int detect_memory_e820(void)
 
 	initregs(&ireg);
 	ireg.ax  = 0xe820;
-	ireg.cx  = sizeof buf;
+	ireg.cx  = sizeof(buf);
 	ireg.edx = SMAP;
 	ireg.di  = (size_t)&buf;
 
diff --git a/linux-4.19/arch/x86/boot/regs.c b/linux-4.19/arch/x86/boot/regs.c
index c0fb356..2fe3616 100644
--- a/linux-4.19/arch/x86/boot/regs.c
+++ b/linux-4.19/arch/x86/boot/regs.c
@@ -21,7 +21,7 @@
 
 void initregs(struct biosregs *reg)
 {
-	memset(reg, 0, sizeof *reg);
+	memset(reg, 0, sizeof(*reg));
 	reg->eflags |= X86_EFLAGS_CF;
 	reg->ds = ds();
 	reg->es = ds();
diff --git a/linux-4.19/arch/x86/boot/video-vesa.c b/linux-4.19/arch/x86/boot/video-vesa.c
index ba3e100..3ecc11a 100644
--- a/linux-4.19/arch/x86/boot/video-vesa.c
+++ b/linux-4.19/arch/x86/boot/video-vesa.c
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
diff --git a/linux-4.19/arch/x86/boot/video.c b/linux-4.19/arch/x86/boot/video.c
index 77780e3..ac89b66 100644
--- a/linux-4.19/arch/x86/boot/video.c
+++ b/linux-4.19/arch/x86/boot/video.c
@@ -115,7 +115,7 @@ static unsigned int get_entry(void)
 		} else if ((key >= '0' && key <= '9') ||
 			   (key >= 'A' && key <= 'Z') ||
 			   (key >= 'a' && key <= 'z')) {
-			if (len < sizeof entry_buf) {
+			if (len < sizeof(entry_buf)) {
 				entry_buf[len++] = key;
 				putchar(key);
 			}
diff --git a/linux-4.19/arch/x86/events/intel/core.c b/linux-4.19/arch/x86/events/intel/core.c
index 035c374..b3516cd 100644
--- a/linux-4.19/arch/x86/events/intel/core.c
+++ b/linux-4.19/arch/x86/events/intel/core.c
@@ -4349,7 +4349,7 @@ __init int intel_pmu_init(void)
 		}
 	}
 
-	snprintf(pmu_name_str, sizeof pmu_name_str, "%s", name);
+	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
 
 	if (version >= 2 && extra_attr) {
 		x86_pmu.format_attrs = merge_attr(intel_arch3_formats_attr,
diff --git a/linux-4.19/arch/x86/kernel/cpu/common.c b/linux-4.19/arch/x86/kernel/cpu/common.c
index 44c4ef3..72d5f80 100644
--- a/linux-4.19/arch/x86/kernel/cpu/common.c
+++ b/linux-4.19/arch/x86/kernel/cpu/common.c
@@ -1073,7 +1073,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 #endif
 	c->x86_cache_alignment = c->x86_clflush_size;
 
-	memset(&c->x86_capability, 0, sizeof c->x86_capability);
+	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 	c->extended_cpuid_level = 0;
 
 	/* cyrix could have cpuid enabled via c_identify()*/
@@ -1314,7 +1314,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_virt_bits = 32;
 #endif
 	c->x86_cache_alignment = c->x86_clflush_size;
-	memset(&c->x86_capability, 0, sizeof c->x86_capability);
+	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 
 	generic_identify(c);
 
diff --git a/linux-4.19/arch/x86/kernel/cpu/mcheck/mce.c b/linux-4.19/arch/x86/kernel/cpu/mcheck/mce.c
index 953b3ce..7173108 100644
--- a/linux-4.19/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/linux-4.19/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2205,7 +2205,7 @@ static int mce_device_create(unsigned int cpu)
 	if (dev)
 		return 0;
 
-	dev = kzalloc(sizeof *dev, GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	dev->id  = cpu;
diff --git a/linux-4.19/arch/x86/kernel/cpu/mtrr/generic.c b/linux-4.19/arch/x86/kernel/cpu/mtrr/generic.c
index e12ee86..86e277f 100644
--- a/linux-4.19/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/linux-4.19/arch/x86/kernel/cpu/mtrr/generic.c
@@ -798,7 +798,7 @@ static void generic_set_all(void)
 	local_irq_restore(flags);
 
 	/* Use the atomic bitops to update the global mask */
-	for (count = 0; count < sizeof mask * 8; ++count) {
+	for (count = 0; count < sizeof(mask) * 8; ++count) {
 		if (mask & 0x01)
 			set_bit(count, &smp_changes_mask);
 		mask >>= 1;
diff --git a/linux-4.19/arch/x86/kernel/cpu/mtrr/if.c b/linux-4.19/arch/x86/kernel/cpu/mtrr/if.c
index 40eee6c..2e173d4 100644
--- a/linux-4.19/arch/x86/kernel/cpu/mtrr/if.c
+++ b/linux-4.19/arch/x86/kernel/cpu/mtrr/if.c
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
diff --git a/linux-4.19/arch/x86/kernel/head64.c b/linux-4.19/arch/x86/kernel/head64.c
index ddee1f0..16b1cbd 100644
--- a/linux-4.19/arch/x86/kernel/head64.c
+++ b/linux-4.19/arch/x86/kernel/head64.c
@@ -385,7 +385,7 @@ static void __init copy_bootdata(char *real_mode_data)
 	 */
 	sme_map_bootdata(real_mode_data);
 
-	memcpy(&boot_params, real_mode_data, sizeof boot_params);
+	memcpy(&boot_params, real_mode_data, sizeof(boot_params));
 	sanitize_boot_params(&boot_params);
 	cmd_line_ptr = get_cmd_line_ptr();
 	if (cmd_line_ptr) {
diff --git a/linux-4.19/arch/x86/kernel/msr.c b/linux-4.19/arch/x86/kernel/msr.c
index ef68880..4588414 100644
--- a/linux-4.19/arch/x86/kernel/msr.c
+++ b/linux-4.19/arch/x86/kernel/msr.c
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
 
diff --git a/linux-4.19/arch/x86/kvm/emulate.c b/linux-4.19/arch/x86/kvm/emulate.c
index 106482d..5368819 100644
--- a/linux-4.19/arch/x86/kvm/emulate.c
+++ b/linux-4.19/arch/x86/kvm/emulate.c
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
@@ -3066,17 +3066,17 @@ static int task_switch_16(struct x86_emulate_ctxt *ctxt,
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
 
@@ -3085,7 +3085,7 @@ static int task_switch_16(struct x86_emulate_ctxt *ctxt,
 
 		ret = linear_write_system(ctxt, new_tss_base,
 					  &tss_seg.prev_task_link,
-					  sizeof tss_seg.prev_task_link);
+					  sizeof(tss_seg.prev_task_link));
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 	}
@@ -3207,7 +3207,7 @@ static int task_switch_32(struct x86_emulate_ctxt *ctxt,
 	u32 eip_offset = offsetof(struct tss_segment_32, eip);
 	u32 ldt_sel_offset = offsetof(struct tss_segment_32, ldt_selector);
 
-	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
@@ -3219,7 +3219,7 @@ static int task_switch_32(struct x86_emulate_ctxt *ctxt,
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
-	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof(tss_seg));
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
@@ -3228,7 +3228,7 @@ static int task_switch_32(struct x86_emulate_ctxt *ctxt,
 
 		ret = linear_write_system(ctxt, new_tss_base,
 					  &tss_seg.prev_task_link,
-					  sizeof tss_seg.prev_task_link);
+					  sizeof(tss_seg.prev_task_link));
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 	}
diff --git a/linux-4.19/arch/x86/kvm/lapic.c b/linux-4.19/arch/x86/kvm/lapic.c
index fbb0e6d..9ce7a7a 100644
--- a/linux-4.19/arch/x86/kvm/lapic.c
+++ b/linux-4.19/arch/x86/kvm/lapic.c
@@ -2386,7 +2386,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	r = kvm_apic_state_fixup(vcpu, s, true);
 	if (r)
 		return r;
-	memcpy(vcpu->arch.apic->regs, s->regs, sizeof *s);
+	memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
 
 	recalculate_apic_map(vcpu->kvm);
 	kvm_apic_set_version(vcpu);
diff --git a/linux-4.19/arch/x86/kvm/x86.c b/linux-4.19/arch/x86/kvm/x86.c
index ca71773..78458f6 100644
--- a/linux-4.19/arch/x86/kvm/x86.c
+++ b/linux-4.19/arch/x86/kvm/x86.c
@@ -2841,7 +2841,7 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
 	unsigned size;
 
 	r = -EFAULT;
-	if (copy_from_user(&msrs, user_msrs, sizeof msrs))
+	if (copy_from_user(&msrs, user_msrs, sizeof(msrs)))
 		goto out;
 
 	r = -E2BIG;
@@ -3005,11 +3005,11 @@ long kvm_arch_dev_ioctl(struct file *filp,
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
@@ -3031,7 +3031,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 		struct kvm_cpuid2 cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 
 		r = kvm_dev_ioctl_get_cpuid(&cpuid, cpuid_arg->entries,
@@ -3040,7 +3040,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			goto out;
 
 		r = -EFAULT;
-		if (copy_to_user(cpuid_arg, &cpuid, sizeof cpuid))
+		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
 			goto out;
 		r = 0;
 		break;
@@ -3763,7 +3763,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_interrupt irq;
 
 		r = -EFAULT;
-		if (copy_from_user(&irq, argp, sizeof irq))
+		if (copy_from_user(&irq, argp, sizeof(irq)))
 			goto out;
 		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
 		break;
@@ -3781,7 +3781,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_cpuid cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 		r = kvm_vcpu_ioctl_set_cpuid(vcpu, &cpuid, cpuid_arg->entries);
 		break;
@@ -3791,7 +3791,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_cpuid2 cpuid;
 
 		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof cpuid))
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
 		r = kvm_vcpu_ioctl_set_cpuid2(vcpu, &cpuid,
 					      cpuid_arg->entries);
@@ -3802,14 +3802,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -3830,13 +3830,13 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -3849,7 +3849,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!lapic_in_kernel(vcpu))
 			goto out;
 		r = -EFAULT;
-		if (copy_from_user(&va, argp, sizeof va))
+		if (copy_from_user(&va, argp, sizeof(va)))
 			goto out;
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_lapic_set_vapic_addr(vcpu, va.vapic_addr);
@@ -3860,7 +3860,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u64 mcg_cap;
 
 		r = -EFAULT;
-		if (copy_from_user(&mcg_cap, argp, sizeof mcg_cap))
+		if (copy_from_user(&mcg_cap, argp, sizeof(mcg_cap)))
 			goto out;
 		r = kvm_vcpu_ioctl_x86_setup_mce(vcpu, mcg_cap);
 		break;
@@ -3869,7 +3869,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_x86_mce mce;
 
 		r = -EFAULT;
-		if (copy_from_user(&mce, argp, sizeof mce))
+		if (copy_from_user(&mce, argp, sizeof(mce)))
 			goto out;
 		r = kvm_vcpu_ioctl_x86_set_mce(vcpu, &mce);
 		break;
@@ -4399,7 +4399,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (kvm->created_vcpus)
 			goto set_identity_unlock;
 		r = -EFAULT;
-		if (copy_from_user(&ident_addr, argp, sizeof ident_addr))
+		if (copy_from_user(&ident_addr, argp, sizeof(ident_addr)))
 			goto set_identity_unlock;
 		r = kvm_vm_ioctl_set_identity_map_addr(kvm, ident_addr);
 set_identity_unlock:
@@ -4483,7 +4483,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (r)
 			goto get_irqchip_out;
 		r = -EFAULT;
-		if (copy_to_user(argp, chip, sizeof *chip))
+		if (copy_to_user(argp, chip, sizeof(*chip)))
 			goto get_irqchip_out;
 		r = 0;
 	get_irqchip_out:
@@ -4529,7 +4529,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 	case KVM_SET_PIT: {
 		r = -EFAULT;
-		if (copy_from_user(&u.ps, argp, sizeof u.ps))
+		if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
 			goto out;
 		r = -ENXIO;
 		if (!kvm->arch.vpit)
@@ -8063,7 +8063,7 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->efer = vcpu->arch.efer;
 	sregs->apic_base = kvm_get_apic_base(vcpu);
 
-	memset(sregs->interrupt_bitmap, 0, sizeof sregs->interrupt_bitmap);
+	memset(sregs->interrupt_bitmap, 0, sizeof(sregs->interrupt_bitmap));
 
 	if (vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft)
 		set_bit(vcpu->arch.interrupt.nr,
@@ -8367,7 +8367,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->last_opcode = fxsave->fop;
 	fpu->last_ip = fxsave->rip;
 	fpu->last_dp = fxsave->rdp;
-	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
+	memcpy(fpu->xmm, fxsave->xmm_space, sizeof(fxsave->xmm_space));
 
 	vcpu_put(vcpu);
 	return 0;
@@ -8388,7 +8388,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->fop = fpu->last_opcode;
 	fxsave->rip = fpu->last_ip;
 	fxsave->rdp = fpu->last_dp;
-	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
+	memcpy(fxsave->xmm_space, fpu->xmm, sizeof(fxsave->xmm_space));
 
 	vcpu_put(vcpu);
 	return 0;
diff --git a/linux-4.19/arch/x86/tools/relocs.c b/linux-4.19/arch/x86/tools/relocs.c
index 3a6c8eb..8d0ab32 100644
--- a/linux-4.19/arch/x86/tools/relocs.c
+++ b/linux-4.19/arch/x86/tools/relocs.c
@@ -130,7 +130,7 @@ static void regex_init(int use_real_mode)
 			      REG_EXTENDED|REG_NOSUB);
 
 		if (err) {
-			regerror(err, &sym_regex_c[i], errbuf, sizeof errbuf);
+			regerror(err, &sym_regex_c[i], errbuf, sizeof(errbuf));
 			die("%s", errbuf);
 		}
         }
@@ -404,7 +404,7 @@ static void read_shdrs(FILE *fp)
 	}
 	for (i = 0; i < ehdr.e_shnum; i++) {
 		struct section *sec = &secs[i];
-		if (fread(&shdr, sizeof shdr, 1, fp) != 1)
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read ELF section headers %d/%d: %s\n",
 			    i, ehdr.e_shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
diff --git a/linux-4.19/arch/x86/um/asm/elf.h b/linux-4.19/arch/x86/um/asm/elf.h
index 5481972..cd13fcf 100644
--- a/linux-4.19/arch/x86/um/asm/elf.h
+++ b/linux-4.19/arch/x86/um/asm/elf.h
@@ -195,7 +195,7 @@ extern unsigned long um_vdso_addr;
 
 typedef unsigned long elf_greg_t;
 
-#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+#define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 typedef struct user_i387_struct elf_fpregset_t;
-- 
2.11.0

