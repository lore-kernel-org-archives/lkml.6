Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935612AbeBPLY3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:24:29 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47768 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935546AbeBPLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:23:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180216112327euoutp0254635a192336bdf09e928099be8523f2~Tyo1kfIK22418824188euoutp02c
X-AuditID: cbfec7f4-713ff700000043e4-e3-5a86bf2dd353
From: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH 4/7 RESEND] arm64: change arm64 probes handler prototype
Date: Fri, 16 Feb 2018 12:23:08 +0100
Message-id: <1518780191-31094-5-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87q6+9uiDJa+5bToureDzaJj00xW
        i40z1rNavF/Ww2hx9OxfJovGT3OZLTY9vsZqcXnXHDaLQ1P3Mlrs6V/NZrH2yF12i0sHFjBZ
        NC3bymKxdX8ro8Xx3gNMFi8/nmBxEPBYM28No8flaxeZPTav0PLYtKqTzWPeyUCPzUvqPQ6+
        28Pk8X7fVTaPvi2rGD0+b5IL4IrisklJzcksSy3St0vgypj55AdLwX2bihf9b1kbGD8adTFy
        ckgImEhMW3GRtYuRi0NIYAWjROelf8wQzmdGiVMPVzHCVE1unsIEkVjGKLHv0V82COcjo8TG
        HYdZQarYBMwlth9tYQGxRQTcJG40doB1MAtcZpK4fKKbCSQhLOAhsb55LzuIzSKgKrH+7m2g
        ZnYOXgF/ibOiEMvkJG6e62QGsTkFAiTub9nCAjJGQuA1m8S317/YIIpcJHYc3g9lC0u8Or6F
        HcKWkbg8uZsFwu5nlDh4WxqieQajxNb3j6AS1hJ/Vk0Ea2YW4JOYtG060DYOoDivREebEESJ
        h8Sal89ZIWxHibXtd8DOFxJYzCix7ofUBEapBYwMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS
        83M3MQKTw+l/x7/sYNz1J+kQowAHoxIP74be1igh1sSy4srcQ4wSHMxKIrzB+9qihHhTEiur
        Uovy44tKc1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhh5ef0E1zA8qM8we2z7
        86N7jAR/Wr+escbFnXf1G1ht78w8GV1q+a2z6MrKh8tTXb2VXvDz7tHUc3dVs34ybdJhuWP3
        2oP05jNaHQlfW/3z8GVF4YLfbn+uFF/m7Hx3qMRoxcHsi6EmDWXLZU8z7Db6ExGldaFqWZnS
        dQ6Gkv4Kp7NXNWMOnFRiKc5INNRiLipOBADpRmbkCgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xq7ra+9uiDJ6e07boureDzaJj00xW
        i40z1rNavF/Ww2hx9OxfJovGT3OZLTY9vsZqcXnXHDaLQ1P3Mlrs6V/NZrH2yF12i0sHFjBZ
        NC3bymKxdX8ro8Xx3gNMFi8/nmBxEPBYM28No8flaxeZPTav0PLYtKqTzWPeyUCPzUvqPQ6+
        28Pk8X7fVTaPvi2rGD0+b5IL4IrisklJzcksSy3St0vgypj55AdLwX2bihf9b1kbGD8adTFy
        ckgImEhMbp7CBGILCSxhlJi60bOLkQvI/swo8WPCQ2aQBJuAucT2oy0sILaIgJvEjcYOJpAi
        ZoHLTBKfF+xlBUkIC3hIrG/eyw5iswioSqy/exsozs7BK+AvcVYUYpecxM1znWAjOQUCJO5v
        2cICsddfYu2iXywTGHkWMDKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAzfbcd+btnB2PUu
        +BCjAAejEg/vht7WKCHWxLLiytxDjBIczEoivMH72qKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MG6bfFLlW45rxa3MBxu2MGi1r9Ty7uj7KCbotSPp
        9jXNSd5vnK9cn7jtTlW5TKrNlXDGk0mKl5bPl/7bM1l4Xwrz02w52+u+atNtLO2n917isDxr
        8Py7U4ls0c0GNz+BM32lFVsn93I23Du24siNgzumPvb8+fFB2JxcuyiP5wy/VtTZ19vJRSix
        FGckGmoxFxUnAgAkjRTfWwIAAA==
X-CMS-MailID: 20180216112323eucas1p1fd0302348ff3c5f47f0aa8ef52b39401
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180216112323eucas1p1fd0302348ff3c5f47f0aa8ef52b39401
X-RootMTR: 20180216112323eucas1p1fd0302348ff3c5f47f0aa8ef52b39401
References: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180216112323eucas1p1fd0302348ff3c5f47f0aa8ef52b39401@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A probes_handler_t() handler function prototype differ between ARM32 and ARM64
arch subtrees. Make ARM64 prototype the same as ARM32 prototype and adjust the
ARM64 code to work with the new prototype.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/include/asm/probes.h          |  6 +++++-
 arch/arm64/kernel/probes/kprobes.c       |  2 +-
 arch/arm64/kernel/probes/simulate-insn.c | 32 ++++++++++++++++++++++++--------
 arch/arm64/kernel/probes/simulate-insn.h | 24 ++++++++++++++++--------
 arch/arm64/kernel/probes/uprobes.c       |  3 +--
 5 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 6a5b289..1747e9a 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -16,7 +16,11 @@
 #define _ARM_PROBES_H
 
 typedef u32 probe_opcode_t;
-typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
+struct arch_probe_insn;
+
+typedef void (probes_handler_t) (u32 opcode,
+			   struct arch_probe_insn *api,
+			   struct pt_regs *);
 
 /* architecture specific copy of original instruction */
 struct arch_probe_insn {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d98..fc9f67c 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -69,7 +69,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	if (p->ainsn.api.handler)
-		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);
+		p->ainsn.api.handler((u32)p->opcode, &p->ainsn.api, regs);
 
 	/* single step simulated, now go for post processing */
 	post_kprobe_handler(kcb, regs);
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index be05868..22dc7a7 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -92,9 +92,11 @@ static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
  * instruction simulation functions
  */
 void __kprobes
-simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
+simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	long imm, xn, val;
+	long addr = instruction_pointer(regs);
 
 	xn = opcode & 0x1f;
 	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
@@ -110,9 +112,11 @@ simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
+simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = bbl_displacement(opcode);
+	long addr = instruction_pointer(regs);
 
 	/* Link register is x30 */
 	if (opcode & (1 << 31))
@@ -122,9 +126,11 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
+simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (aarch32_opcode_cond_checks[opcode & 0xf](regs->pstate & 0xffffffff))
 		disp = bcond_displacement(opcode);
@@ -133,9 +139,11 @@ simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
+simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int xn = (opcode >> 5) & 0x1f;
+	long addr = instruction_pointer(regs);
 
 	/* update pc first in case we're doing a "blr lr" */
 	instruction_pointer_set(regs, get_x_reg(regs, xn));
@@ -146,9 +154,11 @@ simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
+simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (opcode & (1 << 24)) {
 		if (check_cbnz(opcode, regs))
@@ -161,9 +171,11 @@ simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
+simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (opcode & (1 << 24)) {
 		if (check_tbnz(opcode, regs))
@@ -176,11 +188,13 @@ simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
+simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	u64 *load_addr;
 	int xn = opcode & 0x1f;
 	int disp;
+	long addr = instruction_pointer(regs);
 
 	disp = ldr_displacement(opcode);
 	load_addr = (u64 *) (addr + disp);
@@ -194,11 +208,13 @@ simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
+simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	s32 *load_addr;
 	int xn = opcode & 0x1f;
 	int disp;
+	long addr = instruction_pointer(regs);
 
 	disp = ldr_displacement(opcode);
 	load_addr = (s32 *) (addr + disp);
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index 050bde6..31b3840 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -16,13 +16,21 @@
 #ifndef _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
 #define _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
 
-void simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
 
 #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 636ca01..a83642c 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -112,10 +112,9 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		return false;
 
 	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
-	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
-		auprobe->api.handler(insn, addr, regs);
+		auprobe->api.handler(insn, &auprobe->api, regs);
 
 	return true;
 }
-- 
2.7.4
