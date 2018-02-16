Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935564AbeBPLXd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:23:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47729 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935542AbeBPLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:23:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180216112325euoutp02b430ba6ca8a746e8c80920ebd3e9e3c3~TyozKK9Gr2463224632euoutp02B
X-AuditID: cbfec7f5-b45ff700000028a9-5e-5a86bf2a434f
From: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH 1/7 RESEND] arm64: move arm uprobes code to be reused by
 arm64
Date: Fri, 16 Feb 2018 12:23:05 +0100
Message-id: <1518780191-31094-2-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djPc7pa+9uiDDp+CFp03dvBZtGxaSar
        xcYZ61kt3i/rYbQ4evYvk0Xjp7nMFpseX2O1uLxrDpvFoal7GS329K9ms1h75C67xaUDC5gs
        mpZtZbHYur+V0eJ47wEmi5cfT7A4CHismbeG0ePytYvMHptXaHlsWtXJ5jHvZKDH5iX1Hgff
        7WHyeL/vKptH35ZVjB6fN8kFcEVx2aSk5mSWpRbp2yVwZSzZtYG54K1jxYkre5gbGF+bdTFy
        ckgImEjM7Wlm6WLk4hASWMEo8WzFcWYI5zOjxIJF3xlhqm7NmsIEkVjGKPF4wwkWkISQwEdG
        iYmHi0FsNgFzie1HW8DiIgJuEjcaO8AamAUuM0lcPtHNBJIQFgiQmH1rITuIzSKgKrFi61yw
        Bl4Bf4lrLfuYILbJSdw818kMYnMC1d/fsgXsPgmB52wS+z/dgzrJRWLhia1QtrDEq+Nb2CFs
        GYnLk7tZIOx+RomDt6UhmmcwSmx9/wgqYS3xZ9VENhCbWYBPYtK26UDbOIDivBIdbUIQJR4S
        Nw8cZoWwHSV6NsyHhstiRok7X+czTmCUWsDIsIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93
        EyMwQZz+d/zrDsZ9f5IOMQpwMCrx8G7obY0SYk0sK67MPcQowcGsJMJ7a3pblBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHeOI26KCGB9MSS1OzU1ILUIpgsEwenVAPjtdctWx9vSGv1vvnpd7aG
        ptfBF9N7fjUdf2NTqp7yQ//QOr8XrXWOzJYW77xNgsw32lx1Ltt/zHfqReaqZzPaH24rUZkj
        vcm0L1PxyEPXadKhltPmbPqgHW7nkJK0vGTf5rg14XtP9+hIeWXkLzprH7r3yr6DC5j3ME0S
        e5m75qhF2f9rFwWWKrEUZyQaajEXFScCAODIcpEMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xy7oa+9uiDBbcNbfoureDzaJj00xW
        i40z1rNavF/Ww2hx9OxfJovGT3OZLTY9vsZqcXnXHDaLQ1P3Mlrs6V/NZrH2yF12i0sHFjBZ
        NC3bymKxdX8ro8Xx3gNMFi8/nmBxEPBYM28No8flaxeZPTav0PLYtKqTzWPeyUCPzUvqPQ6+
        28Pk8X7fVTaPvi2rGD0+b5IL4IrisklJzcksSy3St0vgyliyawNzwVvHihNX9jA3ML4262Lk
        5JAQMJG4NWsKUxcjF4eQwBJGibbVz9ghnM+MEscWzWIFqWITMJfYfrSFBcQWEXCTuNHYAdbB
        LHCZSeLzgr1ARRwcwgJ+EpfngtWwCKhKrNgKYfMK+Etca9nHBLFNTuLmuU5mEJtTIEDi/pYt
        YDVCQDVrF/1imcDIs4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgCG879nPLDsaud8GH
        GAU4GJV4eDf0tkYJsSaWFVfmHmKU4GBWEuEN3tcWJcSbklhZlVqUH19UmpNafIhRmoNFSZz3
        vEFllJBAemJJanZqakFqEUyWiYNTqoFRJ+JJTu+/hXk8x0xENe5Yst84+CfQsvqVw3qBcvee
        aVuuPBTouGv3LO+d+NUXmqutisK36OrdvfLKa/M/7+v8BlEK97szxKVOWdX+TJY4dD/kwCYG
        meVld08EtGodfK7Kd09mykSWgi1m214fs7jqd/rDDyGeN8WKsWeuhKTw1aiY9RiG9CcrsRRn
        JBpqMRcVJwIA6Ssm7F0CAAA=
X-CMS-MailID: 20180216112320eucas1p157eae5e9830028e944f23cad1c81c6eb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180216112320eucas1p157eae5e9830028e944f23cad1c81c6eb
X-RootMTR: 20180216112320eucas1p157eae5e9830028e944f23cad1c81c6eb
References: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180216112320eucas1p157eae5e9830028e944f23cad1c81c6eb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ARM32 uprobes code from arch/arm/probes/ to a more common location -
lib/probes/arm/. This code will be used by ARM64 code when uprobing 32-bit
applications.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm/probes/Makefile                                  | 8 ++++----
 arch/arm/probes/kprobes/actions-arm.c                     | 2 +-
 arch/arm/probes/kprobes/checkers-arm.c                    | 4 ++--
 arch/arm/probes/kprobes/checkers-common.c                 | 4 ++--
 arch/arm/probes/kprobes/checkers-thumb.c                  | 2 +-
 arch/arm/probes/kprobes/checkers.h                        | 2 +-
 arch/arm/probes/kprobes/core.c                            | 2 +-
 arch/arm/probes/kprobes/core.h                            | 2 +-
 arch/arm/probes/uprobes/Makefile                          | 2 +-
 arch/arm/probes/uprobes/core.c                            | 4 ++--
 lib/Makefile                                              | 2 ++
 lib/probes/Makefile                                       | 1 +
 lib/probes/arm/Makefile                                   | 6 ++++++
 {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c | 4 ++--
 {arch/arm/probes => lib/probes/arm}/decode-arm.c          | 0
 {arch/arm/probes => lib/probes/arm}/decode-arm.h          | 0
 {arch/arm/probes => lib/probes/arm}/decode.c              | 0
 {arch/arm/probes => lib/probes/arm}/decode.h              | 0
 18 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 lib/probes/Makefile
 create mode 100644 lib/probes/arm/Makefile
 rename {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c (99%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.c (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.h (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode.c (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode.h (100%)

diff --git a/arch/arm/probes/Makefile b/arch/arm/probes/Makefile
index 8b0ea5a..9e22de6 100644
--- a/arch/arm/probes/Makefile
+++ b/arch/arm/probes/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o uprobes/
-obj-$(CONFIG_KPROBES)		+= decode.o kprobes/
+subdir-ccflags-y := -I$(srctree)/lib/probes/arm/
+
+obj-$(CONFIG_UPROBES)		+= uprobes/
+obj-$(CONFIG_KPROBES)		+= kprobes/
 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)		+= decode-thumb.o
-else
-obj-$(CONFIG_KPROBES)		+= decode-arm.o
 endif
diff --git a/arch/arm/probes/kprobes/actions-arm.c b/arch/arm/probes/kprobes/actions-arm.c
index b9056d6..fb1179e 100644
--- a/arch/arm/probes/kprobes/actions-arm.c
+++ b/arch/arm/probes/kprobes/actions-arm.c
@@ -62,7 +62,7 @@
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
 
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "core.h"
 #include "checkers.h"
 
diff --git a/arch/arm/probes/kprobes/checkers-arm.c b/arch/arm/probes/kprobes/checkers-arm.c
index 7b98173..29520a2 100644
--- a/arch/arm/probes/kprobes/checkers-arm.c
+++ b/arch/arm/probes/kprobes/checkers-arm.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "checkers.h"
 
 static enum probes_insn __kprobes arm_check_stack(probes_opcode_t insn,
diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 971119c..afc3a38 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "checkers.h"
 
 enum probes_insn checker_stack_use_none(probes_opcode_t insn,
diff --git a/arch/arm/probes/kprobes/checkers-thumb.c b/arch/arm/probes/kprobes/checkers-thumb.c
index d608e3b..847f1ee 100644
--- a/arch/arm/probes/kprobes/checkers-thumb.c
+++ b/arch/arm/probes/kprobes/checkers-thumb.c
@@ -14,7 +14,7 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
+#include "decode.h"
 #include "../decode-thumb.h"
 #include "checkers.h"
 
diff --git a/arch/arm/probes/kprobes/checkers.h b/arch/arm/probes/kprobes/checkers.h
index cf6c9e7..9bbab0d 100644
--- a/arch/arm/probes/kprobes/checkers.h
+++ b/arch/arm/probes/kprobes/checkers.h
@@ -17,7 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include "../decode.h"
+#include "decode.h"
 
 extern probes_check_t checker_stack_use_none;
 extern probes_check_t checker_stack_use_unknown;
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 52d1cd1..50c3fcb 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -33,7 +33,7 @@
 #include <linux/bug.h>
 #include <asm/patch.h>
 
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "../decode-thumb.h"
 #include "core.h"
 
diff --git a/arch/arm/probes/kprobes/core.h b/arch/arm/probes/kprobes/core.h
index ec5d1f2..4da60f0 100644
--- a/arch/arm/probes/kprobes/core.h
+++ b/arch/arm/probes/kprobes/core.h
@@ -20,7 +20,7 @@
 #define _ARM_KERNEL_KPROBES_H
 
 #include <asm/kprobes.h>
-#include "../decode.h"
+#include "decode.h"
 
 /*
  * These undefined instructions must be unique and
diff --git a/arch/arm/probes/uprobes/Makefile b/arch/arm/probes/uprobes/Makefile
index e1dc3d0..0d05ba9 100644
--- a/arch/arm/probes/uprobes/Makefile
+++ b/arch/arm/probes/uprobes/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_UPROBES)		+= core.o actions-arm.o
+obj-$(CONFIG_UPROBES)		+= core.o
diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index d1329f1..8681026 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -17,8 +17,8 @@
 #include <asm/opcodes.h>
 #include <asm/traps.h>
 
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "core.h"
 
 #define UPROBE_TRAP_NR	UINT_MAX
diff --git a/lib/Makefile b/lib/Makefile
index d11c48e..694886a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -124,6 +124,8 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd/
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd/
 obj-$(CONFIG_XZ_DEC) += xz/
 obj-$(CONFIG_RAID6_PQ) += raid6/
+obj-$(CONFIG_UPROBES) += probes/
+obj-$(CONFIG_KPROBES) += probes/
 
 lib-$(CONFIG_DECOMPRESS_GZIP) += decompress_inflate.o
 lib-$(CONFIG_DECOMPRESS_BZIP2) += decompress_bunzip2.o
diff --git a/lib/probes/Makefile b/lib/probes/Makefile
new file mode 100644
index 0000000..534a2b7
--- /dev/null
+++ b/lib/probes/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARM)		+= arm/
diff --git a/lib/probes/arm/Makefile b/lib/probes/arm/Makefile
new file mode 100644
index 0000000..1c97b8f
--- /dev/null
+++ b/lib/probes/arm/Makefile
@@ -0,0 +1,6 @@
+ccflags-y += -I$(srctree)/arch/arm/probes/uprobes/
+obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o actions-arm.o
+obj-$(CONFIG_KPROBES)		+= decode.o
+ifndef CONFIG_THUMB2_KERNEL
+obj-$(CONFIG_KPROBES)		+= decode-arm.o
+endif
diff --git a/arch/arm/probes/uprobes/actions-arm.c b/lib/probes/arm/actions-arm.c
similarity index 99%
rename from arch/arm/probes/uprobes/actions-arm.c
rename to lib/probes/arm/actions-arm.c
index 76eb449..a25795a 100644
--- a/arch/arm/probes/uprobes/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -13,8 +13,8 @@
 #include <linux/uprobes.h>
 #include <linux/module.h>
 
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "core.h"
 
 static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
diff --git a/arch/arm/probes/decode-arm.c b/lib/probes/arm/decode-arm.c
similarity index 100%
rename from arch/arm/probes/decode-arm.c
rename to lib/probes/arm/decode-arm.c
diff --git a/arch/arm/probes/decode-arm.h b/lib/probes/arm/decode-arm.h
similarity index 100%
rename from arch/arm/probes/decode-arm.h
rename to lib/probes/arm/decode-arm.h
diff --git a/arch/arm/probes/decode.c b/lib/probes/arm/decode.c
similarity index 100%
rename from arch/arm/probes/decode.c
rename to lib/probes/arm/decode.c
diff --git a/arch/arm/probes/decode.h b/lib/probes/arm/decode.h
similarity index 100%
rename from arch/arm/probes/decode.h
rename to lib/probes/arm/decode.h
-- 
2.7.4
