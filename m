Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeCNBdB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 21:33:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44732 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeCNBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 21:32:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180314013256epoutp046f547495986dc72e0036f88a63d573e4~bpWq2NCrG3172031720epoutp04P
X-AuditID: b6c32a37-433ff70000001029-ee-5aa87bc8027d
Mime-Version: 1.0
Subject: [PATCH v2] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Reply-To: jinb.park@samsung.com
From: Jinbum Park <jinb.park@samsung.com>
To: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
Date: Wed, 14 Mar 2018 10:32:56 +0900
X-CMS-MailID: 20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmvu6J6hVRBv96pS3+TjrGbvFl0jt2
        i/fLehgtNj2+xmpxedccNoul1y8yWcyY/JLNgd1jzbw1jB6/f01i9Ni8pN6jb8sqRo/Pm+Q8
        Xu8/xBjAFpVqk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVina0NBIz9DAXM/IyEjPxDjWysgUqCQh
        NWPL1X2MBT9EK9YskWtg7BbqYuTgkBAwkfj1SbeLkYtDSGAHo8TuFe/YQOK8AoISf3cIdzFy
        cggLOEl8/72XDcQWEpCXuPVvMhtEXFvi8J5vjCA2m4CmxOVnZ9lA5ogITGGU+LLrGjuIwyzw
        ilHi8svTTCBVEgK8EjPan7JA2NIS25dvZYSwRSVurn7LDmO/PzYfKi4i0XrvLDOELSjx4Odu
        qLiUxN7N76Hi+RITJy6AildIHN52AmqOvsTs24sZIZ7xlTi3TQUkzCKgKnHzbisrRImLxN2Z
        7WCnMQM9tv3tHGaQcmagZ9bv0ocosZXo37qPHaKET+Ld1x5WmE92zHsC9ZWyxMkvh6AukJQ4
        M3ce1GUeEpeP/oSqcZSYvLiJCRKGgRKz7y5kncCoMAsR0rOQHDEL4YgFjMyrGMVSC4pz01OL
        DQuM9YoTc4tL89L1kvNzNzGCU6OW+Q7GDed8DjEKcDAq8fBGXFoeJcSaWFZcmXuIUYKDWUmE
        d6vMiigh3pTEyqrUovz4otKc1OJDjKbAsJjILCWanA9M23kl8YYmlgYmZkbA9GZpaKgkzhsQ
        4BIlJJCeWJKanZpakFoE08fEwSnVwMhjKKNlenm3e7NsM9dSi2lLnG5eK3WeYK+gN2Xa3S8L
        n556ePuDePkDG6YzYbxsHrPnaD4PtVdesmvfe5c0I8Wcj9IbMmZ1zf8cK2Pc4PS7JO7lgr86
        5W9yz+33TFNg5WEWtXzbmXCbJy+8a1O6e4LxBrW7z1U+pC7yZVO4u3z96+cV5eV/bimxFGck
        GmoxFxUnAgCQBIZ8owMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9
X-RootMTR: 20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9
References: <CGME20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.

Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.

Used compiler is gcc 5.5.0 in [2] (2017.10).

It would be a resend patch for [1] from Seung-Woo Kim.
There was some problems when [1] submitted before.

  P1) show -Warray-bounds that is not seen without UBSAN
  P2) too large stack size in crypto/serpent_generic.c
  P3) link error of ____ilog2_NaN, __aeabi_uldivmod

I've tried to build locally with allmodconfig to ensure that above errors are fixed.
The result is that P2), P3) have fixed, but P1) appears at diffent location.
But, Since gcc closed P1) issue as won't fix [3],
and It can be a helpful warning to user, we don't have to worry about P1).

build-environment that I used is as belows.

  - config: arm allmodconfig
  - compiler: gcc 5.5.0 in [2] (2017.10)
  - ubsan flag: UBSAN, UBSAN_SANITIZE_ALL, UBSAN_ALIGNMENT, UBSAN_NULL
  - linux version: linux/arm 4.16.0-rc4
  - CONFIG_FRAME_WARN: 1024 (default value)

[1] https://patchwork.kernel.org/patch/9189575/
[2] https://releases.linaro.org/components/toolchain/binaries/latest-5/arm-linux-gnueabi/
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78678

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jinbum Park <jinb.park@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
v2: Add sign of Seung-Woo Kim.
    Add commit message about history, build environment.
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
