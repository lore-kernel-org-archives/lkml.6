Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF951217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975642;
	bh=B6mlu14fW1SVD+/37JQV7FF5J3Gf2jDLN6B9nZOHBmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9tapu9YWPqzqqSitml9W/dT1QMTgicEV7LBhlOiyjsYMFsbBM2x7fj1+rWnDCAoA
	 NfmA59/W9+YhGTO1NBy4aZ147kEO8RuBRgxdzDkvwj172Jw9YdRvYsdSfas2ZRHuJK
	 p+F67AR2M5KWnVlaV5Ei/4MCrVRVuXD5a0KMZE/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfAHT1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbfAHT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32CA32070B;
        Tue,  8 Jan 2019 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975636;
        bh=B6mlu14fW1SVD+/37JQV7FF5J3Gf2jDLN6B9nZOHBmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqbn5sbooLjRvenHyToIoNKYyexQnDdwrnfXZAD/EdMo47QielO3odx0HwAw5OU88
         66sEh1Hb1S6Gn6wBsYDN+vn5vCtmHjiXmeuWTqP1uTr3ANf8IdR3isuyEjYlyi04QW
         fB5UeUkbZ2dzioy6FqlBjmUnTXtIUF9IR6a5YpMs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 023/117] MIPS: Loongson: Add Loongson-3A R2.1 basic support
Date:   Tue,  8 Jan 2019 14:24:51 -0500
Message-Id: <20190108192628.121270-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

[ Upstream commit f3ade253615ae6d83aeb72d1c8a96f62a4b4b29b ]

Loongson-3A R2.1 is the bugfix revision of Loongson-3A R2.

All Loongson-3 CPU family:

Code-name         Brand-name       PRId
Loongson-3A R1    Loongson-3A1000  0x6305
Loongson-3A R2    Loongson-3A2000  0x6308
Loongson-3A R2.1  Loongson-3A2000  0x630c
Loongson-3A R3    Loongson-3A3000  0x6309
Loongson-3A R3.1  Loongson-3A3000  0x630d
Loongson-3B R1    Loongson-3B1000  0x6306
Loongson-3B R2    Loongson-3B1500  0x6307

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21128/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@mips.com>
Cc: Steven J . Hill <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cpu.h                               | 3 ++-
 arch/mips/include/asm/mach-loongson64/kernel-entry-init.h | 4 ++--
 arch/mips/kernel/cpu-probe.c                              | 3 ++-
 arch/mips/kernel/idle.c                                   | 2 +-
 arch/mips/loongson64/common/env.c                         | 3 ++-
 arch/mips/loongson64/loongson-3/smp.c                     | 3 ++-
 arch/mips/mm/c-r4k.c                                      | 2 +-
 drivers/platform/mips/cpu_hwmon.c                         | 3 ++-
 8 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index dacbdb84516a..532b49b1dbb3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -248,8 +248,9 @@
 #define PRID_REV_LOONGSON3A_R1		0x0005
 #define PRID_REV_LOONGSON3B_R1		0x0006
 #define PRID_REV_LOONGSON3B_R2		0x0007
-#define PRID_REV_LOONGSON3A_R2		0x0008
+#define PRID_REV_LOONGSON3A_R2_0	0x0008
 #define PRID_REV_LOONGSON3A_R3_0	0x0009
+#define PRID_REV_LOONGSON3A_R2_1	0x000c
 #define PRID_REV_LOONGSON3A_R3_1	0x000d
 
 /*
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index cbac603ced19..b5e288a12dfe 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -31,7 +31,7 @@
 	/* Enable STFill Buffer */
 	mfc0	t0, CP0_PRID
 	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
-	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2_0)
 	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
@@ -60,7 +60,7 @@
 	/* Enable STFill Buffer */
 	mfc0	t0, CP0_PRID
 	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
-	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2_0)
 	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d535fc706a8b..f70cf6447cfb 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1843,7 +1843,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON3A_R2:
+		case PRID_REV_LOONGSON3A_R2_0:
+		case PRID_REV_LOONGSON3A_R2_1:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 046846999efd..909b7a87c89c 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -183,7 +183,7 @@ void __init check_wait(void)
 		cpu_wait = r4k_wait;
 		break;
 	case CPU_LOONGSON3:
-		if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2)
+		if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2_0)
 			cpu_wait = r4k_wait;
 		break;
 
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 8f68ee02a8c2..72e5f8fb2b35 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -197,7 +197,8 @@ void __init prom_init_env(void)
 			cpu_clock_freq = 797000000;
 			break;
 		case PRID_REV_LOONGSON3A_R1:
-		case PRID_REV_LOONGSON3A_R2:
+		case PRID_REV_LOONGSON3A_R2_0:
+		case PRID_REV_LOONGSON3A_R2_1:
 		case PRID_REV_LOONGSON3A_R3_0:
 		case PRID_REV_LOONGSON3A_R3_1:
 			cpu_clock_freq = 900000000;
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index b5c1e0aa955e..8fba0aa48bf4 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -682,7 +682,8 @@ void play_dead(void)
 		play_dead_at_ckseg1 =
 			(void *)CKSEG1ADDR((unsigned long)loongson3a_r1_play_dead);
 		break;
-	case PRID_REV_LOONGSON3A_R2:
+	case PRID_REV_LOONGSON3A_R2_0:
+	case PRID_REV_LOONGSON3A_R2_1:
 	case PRID_REV_LOONGSON3A_R3_0:
 	case PRID_REV_LOONGSON3A_R3_1:
 		play_dead_at_ckseg1 =
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 05bd77727fb9..7e430b4d8778 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1352,7 +1352,7 @@ static void probe_pcache(void)
 					  c->dcache.ways *
 					  c->dcache.linesz;
 		c->dcache.waybit = 0;
-		if ((prid & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2)
+		if ((prid & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2_0)
 			c->options |= MIPS_CPU_PREFETCH;
 		break;
 
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index f66521c7f846..42efcb850722 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -25,9 +25,10 @@ int loongson3_cpu_temp(int cpu)
 	case PRID_REV_LOONGSON3A_R1:
 		reg = (reg >> 8) & 0xff;
 		break;
-	case PRID_REV_LOONGSON3A_R2:
 	case PRID_REV_LOONGSON3B_R1:
 	case PRID_REV_LOONGSON3B_R2:
+	case PRID_REV_LOONGSON3A_R2_0:
+	case PRID_REV_LOONGSON3A_R2_1:
 		reg = ((reg >> 8) & 0xff) - 100;
 		break;
 	case PRID_REV_LOONGSON3A_R3_0:
-- 
2.19.1

