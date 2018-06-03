Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeFCM3o (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeFCM2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 28/29] objtool: header file sync-up
Date: Sun,  3 Jun 2018 14:26:51 +0200
Message-Id: <20180603122652.17453-29-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building tools/objtool/ it rightly complains about a number of
files being out of sync.  Fix this up by syncing them properly with the
relevant in-kernel versions.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/arch/x86/include/asm/inat.h         | 10 ----------
 tools/objtool/arch/x86/include/asm/orc_types.h    |  2 +-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt     | 15 +++------------
 .../objtool/arch/x86/tools/gen-insn-attr-x86.awk  |  1 -
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/arch/x86/include/asm/inat.h b/tools/objtool/arch/x86/include/asm/inat.h
index 1c78580e58be..02aff0867211 100644
--- a/tools/objtool/arch/x86/include/asm/inat.h
+++ b/tools/objtool/arch/x86/include/asm/inat.h
@@ -97,16 +97,6 @@
 #define INAT_MAKE_GROUP(grp)	((grp << INAT_GRP_OFFS) | INAT_MODRM)
 #define INAT_MAKE_IMM(imm)	(imm << INAT_IMM_OFFS)
 
-/* Identifiers for segment registers */
-#define INAT_SEG_REG_IGNORE	0
-#define INAT_SEG_REG_DEFAULT	1
-#define INAT_SEG_REG_CS		2
-#define INAT_SEG_REG_SS		3
-#define INAT_SEG_REG_DS		4
-#define INAT_SEG_REG_ES		5
-#define INAT_SEG_REG_FS		6
-#define INAT_SEG_REG_GS		7
-
 /* Attribute search APIs */
 extern insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode);
 extern int inat_get_last_prefix_id(insn_byte_t last_pfx);
diff --git a/tools/objtool/arch/x86/include/asm/orc_types.h b/tools/objtool/arch/x86/include/asm/orc_types.h
index 9c9dc579bd7d..7dc777a6cb40 100644
--- a/tools/objtool/arch/x86/include/asm/orc_types.h
+++ b/tools/objtool/arch/x86/include/asm/orc_types.h
@@ -88,7 +88,7 @@ struct orc_entry {
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
-} __packed;
+};
 
 /*
  * This struct is used by asm and inline asm code to manually annotate the
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
index e0b85930dd77..1754e094bc28 100644
--- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
@@ -607,7 +607,7 @@ fb: psubq Pq,Qq | vpsubq Vx,Hx,Wx (66),(v1)
 fc: paddb Pq,Qq | vpaddb Vx,Hx,Wx (66),(v1)
 fd: paddw Pq,Qq | vpaddw Vx,Hx,Wx (66),(v1)
 fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
-ff: UD0
+ff:
 EndTable
 
 Table: 3-byte opcode 1 (0x0f 0x38)
@@ -717,7 +717,7 @@ AVXcode: 2
 7e: vpermt2d/q Vx,Hx,Wx (66),(ev)
 7f: vpermt2ps/d Vx,Hx,Wx (66),(ev)
 80: INVEPT Gy,Mdq (66)
-81: INVVPID Gy,Mdq (66)
+81: INVPID Gy,Mdq (66)
 82: INVPCID Gy,Mdq (66)
 83: vpmultishiftqb Vx,Hx,Wx (66),(ev)
 88: vexpandps/d Vpd,Wpd (66),(ev)
@@ -970,15 +970,6 @@ GrpTable: Grp9
 EndTable
 
 GrpTable: Grp10
-# all are UD1
-0: UD1
-1: UD1
-2: UD1
-3: UD1
-4: UD1
-5: UD1
-6: UD1
-7: UD1
 EndTable
 
 # Grp11A and Grp11B are expressed as Grp11 in Intel SDM
@@ -1018,7 +1009,7 @@ GrpTable: Grp15
 1: fxstor | RDGSBASE Ry (F3),(11B)
 2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
 3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
-4: XSAVE | ptwrite Ey (F3),(11B)
+4: XSAVE
 5: XRSTOR | lfence (11B)
 6: XSAVEOPT | clwb (66) | mfence (11B)
 7: clflush | clflushopt (66) | sfence (11B)
diff --git a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a3d2c62fd805 100644
--- a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
@@ -1,5 +1,4 @@
 #!/bin/awk -f
-# SPDX-License-Identifier: GPL-2.0
 # gen-insn-attr-x86.awk: Instruction attribute table generator
 # Written by Masami Hiramatsu <mhiramat@redhat.com>
 #
-- 
2.17.1
