Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeCMEyD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 00:54:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:12379 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeCMEyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 00:54:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180313045359epoutp01b149e22519bfd63f36726ebb589c130a~bYc6zbpRu3274932749epoutp01n
X-AuditID: b6c32a38-ac3ff70000001054-42-5aa7596589a2
Mime-Version: 1.0
Subject: [PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Reply-To: jinb.park@samsung.com
From: Jinbum Park <jinb.park@samsung.com>
To: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Date: Tue, 13 Mar 2018 13:53:57 +0900
X-CMS-MailID: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmgW5q5PIog+3PVS2+THrHbvF+WQ+j
        xabH11gtLu+aw2ax9PpFJgdWjzXz1jB6bF5S7/F5k5zH6/2HGANYolJtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslaINDY30DA3M9YyMjPRMjGOtjEyBShJSM17s/8hc8I274sTBw6wNjC85uxg5
        OSQETCReXFjC2sXIxSEksINRYvHDc8xdjBwcvAKCEn93CIPUCAvYS/x6tY4JxBYSkJe49W8y
        G0RcW+Lwnm+MIDabgKbE5Wdn2UDmiAhMYZT4susaO0iCWWA+o8T0Pg2IZbwSM9qfskDY0hLb
        l29lhLBFJW6ufssOY78/Nh8qLiLReu8sM4QtKPHg526ouJTE3s3voeL5EhMnLoCKV0gc3nYC
        ao6+xOzbi8HivAK+Emc61oLtZRFQlfj9aycbRI2LRNvJZUwQd8pLbH87B+x3ZqBn1u/SBzEl
        BGwlZn03hajgk3j3tYcV5pMd854wQdjKEie/HIK6QFLizNx5UJd5SNxdfpgdYoyjxMJfnJAQ
        DJRovfqGdQKjwixEOM9CcsIshBMWMDKvYhRLLSjOTU8tNiww0StOzC0uzUvXS87P3cQITnla
        FjsY95zzOcQowMGoxMNr0LwsSog1say4MvcQowQHs5IIr/J/oBBvSmJlVWpRfnxRaU5q8SFG
        U2BITGSWEk3OB6bjvJJ4QxNLAxMzI2B6szQ0VBLnDQhwiRISSE8sSc1OTS1ILYLpY+LglGpg
        9Mq53b6rZa2yzoYb61RC+59tXKjdvvvOkogNRy/Km+3MZ0r3zUjLPLryVIbldZ/5c82NrFZ8
        Fgrj93h1b467UWPG1x31Svbsa2+uXtmcvHvB58lftx5b4D3n25SW4vqstzXRYg7bnl41Ujrg
        kvQ6Uk82ue5qcGzz7jWdO9iuVO3+6v6+79v3LiWW4oxEQy3mouJEAPxi9MqPAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
X-RootMTR: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
References: <CGME20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.

Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.

Signed-off-by: Jinbum Park <jinb.park@samsung.com>
---
 arch/arm/Kconfig                  | 1 +
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/vdso/Makefile            | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1878083..bdd1561 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,6 +7,7 @@ config ARM
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b..1b374ba 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
 endif
 
 GCOV_PROFILE		:= n
+UBSAN_SANITIZE		:= n
 
 #
 # Architecture dependencies
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index bb411821..05597f7 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -29,6 +29,7 @@ CFLAGS_vgettimeofday.o = -O2
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
-- 
1.9.1
