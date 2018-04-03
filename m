Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx4+rujAbLx+mx7HQQdAZNUHqUS2bOMLPWcfpcZJK4hFCm58TKKM1r1w3ja6+oo5DACsUz8YL
ARC-Seal: i=1; a=rsa-sha256; t=1522747653; cv=none;
        d=google.com; s=arc-20160816;
        b=Uu8eXBJCN8s8HWZwOeiE87B6IOGZWlBSeEADg6lsVe0C5SV6h0LHML1FjqPxgJND3y
         eVi5dk60qFS9/07yPOLztey0OjALr+Fn90aAVjFTyptWjZwq+cp//oBz6Ag6GunGeZzl
         o/gt4RurFrqAPHJwoygJ1J93hB8TExYBpMlnVLIub8oxvHwMDGFAXqnPM1I9w34ORGoX
         mp8mAn/oOYn+8dmjKM+VcB0pDMPx+ehC7ksPVADoHV4wKRjZe57HF0FjhcVCb8vfZaB7
         DwEGqTyRQo0+U5RHs/4Q4i6vPo2nXhWt+ouOIwVBd2DO8COhwWsyV5miTu0itYaqeuQF
         ei1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=e1b+imr1M8GhPNxSwkPsOJ5wrunU8Z9s/8Nrs8+mdNs=;
        b=YbfrhylfPkDJQSNPxuKaUBoEtj6q8Vij61RpfWaCYrplBT05+GUZoow2iqDdcjnLBi
         isbOoOh0LKGOAdPzi31dk8ImQPzFpYZ5s5LH/LYMZyeXhgMfrZdn9NyyoWFYN7sYdycH
         UNx2g5F/A9EtVuHl6yYhoEP8xSPU3QvnMm12PWKoUEL7KXc1wEEZMo8oBL1sX7yQABr7
         m/zHx0jVOgKxJHlR6CCvvVxF2c4IV1agfGJ1h26Z2rCAP9oLTThyZ6viQa7RnR1e1Yoe
         d+ztwv2nvD9C67YKcaAygDkoj/vEGOQad8plFV3IjLxrd0QnU4MPXE+vaiJKGiiIXJWe
         CCOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
From: Matt Redfearn <matt.redfearn@mips.com>
To: Palmer Dabbelt <palmer@sifive.com>, Antony Pavlov
	<antonynpavlov@gmail.com>, James Hogan <jhogan@kernel.org>, Ralf Baechle
	<ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Paul Burton
	<paul.burton@mips.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Al Viro
	<viro@zeniv.linux.org.uk>
Subject: [PATCH v5 3/3] MIPS: use generic GCC library routines from lib/
Date: Tue, 3 Apr 2018 10:24:26 +0100
Message-ID: <1522747466-22081-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522747466-22081-1-git-send-email-matt.redfearn@mips.com>
References: <1522747466-22081-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522747462-452059-13822-47957-12
X-BESS-VER: 2018.4.1-r1803302241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191650
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
	0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596278698028411080?=
X-GMAIL-MSGID: =?utf-8?q?1596716643083850660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Antony Pavlov <antonynpavlov@gmail.com>

The commit b35cd9884fa5 ("lib: Add shared copies of some GCC library
routines") makes it possible to share generic GCC library routines by
several architectures.

This commit removes several generic GCC library routines from
arch/mips/lib/ in favour of similar routines from lib/.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
[Matt Redfearn] Use GENERIC_LIB_* named Kconfig entries
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org

---

Changes in v5:
  Actually delete the MIPS lib routines

Changes in v4:
  Rework to use the new GENERIC_LIB_ Kconfig entries

Changes in v3:
  Maintain alphabetical order of MIPS Kconfig

Changes in v2: None

 arch/mips/Kconfig       |  5 +++++
 arch/mips/lib/Makefile  |  3 +--
 arch/mips/lib/ashldi3.c | 30 ------------------------------
 arch/mips/lib/ashrdi3.c | 32 --------------------------------
 arch/mips/lib/cmpdi2.c  | 28 ----------------------------
 arch/mips/lib/lshrdi3.c | 30 ------------------------------
 arch/mips/lib/ucmpdi2.c | 22 ----------------------
 7 files changed, 6 insertions(+), 144 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8128c3b68d6b..98955a76c656 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -22,6 +22,11 @@ config MIPS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_UCMPDI2
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index e84e12655fa8..6537e022ef62 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -16,5 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
-	 ucmpdi2.o
+obj-y += bswapsi.o bswapdi.o multi3.o
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
deleted file mode 100644
index 24cd6903e797..000000000000
--- a/arch/mips/lib/ashldi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
deleted file mode 100644
index 23f5295af51e..000000000000
--- a/arch/mips/lib/ashrdi3.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high =
-		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
deleted file mode 100644
index 93cfc785927d..000000000000
--- a/arch/mips/lib/cmpdi2.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __cmpdi2(long long a, long long b)
-{
-	const DWunion au = {
-		.ll = a
-	};
-	const DWunion bu = {
-		.ll = b
-	};
-
-	if (au.s.high < bu.s.high)
-		return 0;
-	else if (au.s.high > bu.s.high)
-		return 2;
-
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-
-	return 1;
-}
-
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
deleted file mode 100644
index 914b971aca3b..000000000000
--- a/arch/mips/lib/lshrdi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__lshrdi3);
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
deleted file mode 100644
index c31c78ca4175..000000000000
--- a/arch/mips/lib/ucmpdi2.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-		return 0;
-	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-		return 2;
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-	return 1;
-}
-
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.7.4
