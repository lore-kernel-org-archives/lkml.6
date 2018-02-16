Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964845AbeBPLYb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:24:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47757 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935544AbeBPLX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:23:29 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180216112327euoutp021ca74b11a1703b59d8358609333181ba~Tyo0vsdNq2415924159euoutp02g
X-AuditID: cbfec7f5-f95739c0000028a9-62-5a86bf2c20a5
From: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH 3/7 RESEND] arm64: introduce get_swbp_insn() instead of
 static assignment
Date: Fri, 16 Feb 2018 12:23:07 +0100
Message-id: <1518780191-31094-4-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO/de766j2W0beHxgMArCSssKT08qRC5YmNBfK6trXlR0U3ad
        thDTUNmWZgrlAxXNUvOBOd9p0w1tiqioZJamqFDkHz4yEZ/ldfrf55zP9/c9h8OhcOka4UpF
        qGM5jZqNUpBiounz2sCpkx1pytOGCRkyTraQSG/Kc0B1ubUOaKEsHaDu/i0MJf8pxJFpdtQB
        jXwsIJH11SeA2jOrSFTT9UOEhjuLMfSsrJFAjR2pANkyOjH0e6mHuEYz1UXVgBkZHcKZ+gpP
        xlRpIJmi3iCm/u1TxjLfjjEL5i8k86KhEjDLJo/bYqX4cigXFRHHabyvPhSHd5Zn4zHWw48H
        Z6rxJDDtZASOFKTPwZ6padwIxJSUrgBQb/wnsi+WAZwb3gT7qe1mC2kXZQCm5+eIBCGllwDs
        1ocITNK+sLk7hRBYTvvDsWQ9Jgzg9AgGR3qeY4KQ0XfhWn0rKTBBH4NFq4u7RRI6ENo6+/dO
        84DfBgy4wI70bTjV0EAIRZBeIOFqQfFeyA+2jVXhdpbBOVuDyM7u0KC3YHbOBNAy7mYfzgWw
        cWGGsItLcLMya/cWOO0Es5tydoqonX0J1KdJ7REGTr3O3uu5Dt8MWPceqRTAtiYz8RK4FoMD
        lcCZ0/KqMI4/q+bivXhWxWvVYV6PolUmsPMh+rZtKy3AvBliBTQFFAclHzJSlVIHNo7XqawA
        UrhCLvmek6aUSkJZ3RNOE/1Ao43ieCtwowiFs+T+8USllA5jY7lIjovhNPsWoxxdk8B5HzFR
        AWbHCtflNf7qON3KUZ8VND4YMB7896LOkHJiMSTjPRM98e5WJhsc2eq+ofUtCdD9xC+4fC25
        2bcZnlV6xc+FYhs3FPJJH+f53myRHzRsNf/qmcsrvxMaZF5PTJiPmXOSxdTWDd1T4d6H4o1M
        1/z0kfb8QFuC9kbrtILgw9kznriGZ/8DhnNpmAwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t/xy7pa+9uiDLp2GFh03dvBZtGxaSar
        xcYZ61kt3i/rYbQ4evYvk0Xjp7nMFpseX2O1uLxrDpvFoal7GS329K9ms1h75C67xaUDC5gs
        mpZtZbHYur+V0eJ47wEmi5cfT7A4CHismbeG0ePytYvMHptXaHlsWtXJ5jHvZKDH5iX1Hgff
        7WHyeL/vKptH35ZVjB6fN8kFcEVx2aSk5mSWpRbp2yVwZRxYPom54JBgxflHa5gbGB/ydTFy
        ckgImEj8236QrYuRi0NIYAmjxPnNm1ggnM+MEhd27mMHqWITMJfYfrSFBcQWEXCTuNHYwQRS
        xCxwmUni84K9rCAJYYFoifYpf5lAbBYBVYl53z+ANfMK+EscP3CWEWKdnMTNc53MIDanQIDE
        /S1bwIYKAdWsXfSLZQIjzwJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBQbzt2M/NOxgv
        bQw+xCjAwajEw7uhtzVKiDWxrLgy9xCjBAezkghv8L62KCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2Msod/P3dQYiz+eVPjFEONiIXXpetRi9c9Cu6+
        GDCPz1RZ9Z/s87iLa3df/1E4/dLCZVmLWJsebnmtvL3rht61Z8/+da5bP4/L5NbcI8Xv3vy7
        OlmbfbaNrJS+Qh9z3IKzh69f+/qAf5plxqnlT12m63kvO7A64Hs0c/Nu5e8C4pd4VWR2FE/I
        uKXEUpyRaKjFXFScCAD6R18fXgIAAA==
X-CMS-MailID: 20180216112322eucas1p2b170bbf0687ebbc03110e42ff807342f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180216112322eucas1p2b170bbf0687ebbc03110e42ff807342f
X-RootMTR: 20180216112322eucas1p2b170bbf0687ebbc03110e42ff807342f
References: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180216112322eucas1p2b170bbf0687ebbc03110e42ff807342f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In uprobes generic code, an arch specific software breakpoint instruction
is statically assigned with a #define statement. It does not allow to examine
the context and set the proper arch on runtime, which is the case of uprobing
either a 32 or 64 bit app on a 64-bit kernel. Introduce get_swbp_insn() with
weak attribute that will allow to be redefined in ARM64 uprobes code.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..ef61d79 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -117,6 +117,7 @@ struct uprobes_state {
 
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern uprobe_opcode_t get_swbp_insn(void);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 267f6ef..cb7a573 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -216,6 +216,16 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
+ * get_swbp_insn - return breakpoint instruction.
+ * Default implementation of get_swbp_insn
+ * Returns architecture-dependent breakpoint instruction opcode
+ */
+uprobe_opcode_t __weak get_swbp_insn(void)
+{
+	return UPROBE_SWBP_INSN;
+}
+
+/**
  * is_swbp_insn - check if instruction is breakpoint instruction.
  * @insn: instruction to be checked.
  * Default implementation of is_swbp_insn
@@ -1178,7 +1188,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	uprobe_opcode_t insn = get_swbp_insn();
 	struct xol_area *area;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
-- 
2.7.4
