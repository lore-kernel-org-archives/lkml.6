Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeCLDib (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:38:31 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32904 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933213AbeCLDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:38:29 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <fbc2f7d0023fa792731c001bd09286ee33e273ca.1520825708.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1520825708.git.fthain@telegraphics.com.au>
References: <cover.1520825708.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 1/3] m68k/mac: Clean up whitespace and remove redundant
 parentheses
Date: Sun, 11 Mar 2018 23:38:28 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
This uses the same spaces-after-tabs style that I've used elsewhere
in this file. Please let me know if you'd prefer a variation that
keeps checkpatch quiet.
---
 arch/m68k/mac/misc.c | 68 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 4956edaac926..1cae14e140d3 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -43,18 +43,19 @@ static long cuda_read_time(void)
 	while (!req.complete)
 		cuda_poll();
 
-	time = (req.reply[3] << 24) | (req.reply[4] << 16)
-		| (req.reply[5] << 8) | req.reply[6];
+	time = (req.reply[3] << 24) | (req.reply[4] << 16) |
+	       (req.reply[5] << 8) | req.reply[6];
 	return time - RTC_OFFSET;
 }
 
 static void cuda_write_time(long data)
 {
 	struct adb_request req;
+
 	data += RTC_OFFSET;
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
-			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			(data >> 8) & 0xFF, data & 0xFF) < 0)
+	                 (data >> 24) & 0xFF, (data >> 16) & 0xFF,
+	                 (data >> 8) & 0xFF, data & 0xFF) < 0)
 		return;
 	while (!req.complete)
 		cuda_poll();
@@ -63,8 +64,9 @@ static void cuda_write_time(long data)
 static __u8 cuda_read_pram(int offset)
 {
 	struct adb_request req;
+
 	if (cuda_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
+	                 (offset >> 8) & 0xFF, offset & 0xFF) < 0)
 		return 0;
 	while (!req.complete)
 		cuda_poll();
@@ -74,8 +76,9 @@ static __u8 cuda_read_pram(int offset)
 static void cuda_write_pram(int offset, __u8 data)
 {
 	struct adb_request req;
+
 	if (cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
+	                 (offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
 		return;
 	while (!req.complete)
 		cuda_poll();
@@ -98,18 +101,19 @@ static long pmu_read_time(void)
 	while (!req.complete)
 		pmu_poll();
 
-	time = (req.reply[1] << 24) | (req.reply[2] << 16)
-		| (req.reply[3] << 8) | req.reply[4];
+	time = (req.reply[1] << 24) | (req.reply[2] << 16) |
+	       (req.reply[3] << 8) | req.reply[4];
 	return time - RTC_OFFSET;
 }
 
 static void pmu_write_time(long data)
 {
 	struct adb_request req;
+
 	data += RTC_OFFSET;
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
-			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			(data >> 8) & 0xFF, data & 0xFF) < 0)
+	                (data >> 24) & 0xFF, (data >> 16) & 0xFF,
+	                (data >> 8) & 0xFF, data & 0xFF) < 0)
 		return;
 	while (!req.complete)
 		pmu_poll();
@@ -118,6 +122,7 @@ static void pmu_write_time(long data)
 static __u8 pmu_read_pram(int offset)
 {
 	struct adb_request req;
+
 	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
 			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
 		return 0;
@@ -129,6 +134,7 @@ static __u8 pmu_read_pram(int offset)
 static void pmu_write_pram(int offset, __u8 data)
 {
 	struct adb_request req;
+
 	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
 			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
 		return;
@@ -151,8 +157,8 @@ static void pmu_write_pram(int offset, __u8 data)
 
 static __u8 via_pram_readbyte(void)
 {
-	int	i,reg;
-	__u8	data;
+	int i, reg;
+	__u8 data;
 
 	reg = via1[vBufB] & ~VIA1B_vRTCClk;
 
@@ -178,7 +184,7 @@ static __u8 via_pram_readbyte(void)
 
 static void via_pram_writebyte(__u8 data)
 {
-	int	i,reg,bit;
+	int i, reg, bit;
 
 	reg = via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
 
@@ -204,7 +210,7 @@ static void via_pram_writebyte(__u8 data)
 static void via_pram_command(int command, __u8 *data)
 {
 	unsigned long flags;
-	int	is_read;
+	int is_read;
 
 	local_irq_save(flags);
 
@@ -298,10 +304,10 @@ static long via_read_time(void)
 static void via_write_time(long time)
 {
 	union {
-		__u8  cdata[4];
-		long  idata;
+		__u8 cdata[4];
+		long idata;
 	} data;
-	__u8	temp;
+	__u8 temp;
 
 	/* Clear the write protect bit */
 
@@ -343,10 +349,10 @@ static void oss_shutdown(void)
 }
 
 #ifdef CONFIG_ADB_CUDA
-
 static void cuda_restart(void)
 {
 	struct adb_request req;
+
 	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_RESET_SYSTEM) < 0)
 		return;
 	while (!req.complete)
@@ -356,6 +362,7 @@ static void cuda_restart(void)
 static void cuda_shutdown(void)
 {
 	struct adb_request req;
+
 	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_POWERDOWN) < 0)
 		return;
 
@@ -372,7 +379,6 @@ static void cuda_shutdown(void)
 	while (!req.complete)
 		cuda_poll();
 }
-
 #endif /* CONFIG_ADB_CUDA */
 
 #ifdef CONFIG_ADB_PMU68K
@@ -419,13 +425,15 @@ void mac_pram_read(int offset, __u8 *buffer, int len)
 	__u8 (*func)(int);
 	int i;
 
-	switch(macintosh_config->adb_type) {
+	switch (macintosh_config->adb_type) {
 	case MAC_ADB_PB1:
 	case MAC_ADB_PB2:
-		func = pmu_read_pram; break;
+		func = pmu_read_pram;
+		break;
 	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
-		func = cuda_read_pram; break;
+		func = cuda_read_pram;
+		break;
 	default:
 		func = via_read_pram;
 	}
@@ -441,13 +449,15 @@ void mac_pram_write(int offset, __u8 *buffer, int len)
 	void (*func)(int, __u8);
 	int i;
 
-	switch(macintosh_config->adb_type) {
+	switch (macintosh_config->adb_type) {
 	case MAC_ADB_PB1:
 	case MAC_ADB_PB2:
-		func = pmu_write_pram; break;
+		func = pmu_write_pram;
+		break;
 	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
-		func = cuda_write_pram; break;
+		func = cuda_write_pram;
+		break;
 	default:
 		func = via_write_pram;
 	}
@@ -531,6 +541,7 @@ void mac_reset(void)
 		unsigned long phys = virt_to_phys(mac_reset);
 		unsigned long addr = (phys&0xFF000000)|0x8777;
 		unsigned long offset = phys-virt;
+
 		local_irq_disable(); /* lets not screw this up, ok? */
 		__asm__ __volatile__(".chip 68030\n\t"
 				     "pmove %0,%/tt0\n\t"
@@ -538,7 +549,7 @@ void mac_reset(void)
 				     : : "m" (addr));
 		/* Now jump to physical address so we can disable MMU */
 		__asm__ __volatile__(
-                    ".chip 68030\n\t"
+		    ".chip 68030\n\t"
 		    "lea %/pc@(1f),%/a0\n\t"
 		    "addl %0,%/a0\n\t"/* fixup target address and stack ptr */
 		    "addl %0,%/sp\n\t"
@@ -627,9 +638,8 @@ static void unmktime(unsigned long time, long offset,
 		long int yg = y + days / 365 - (days % 365 < 0);
 
 		/* Adjust DAYS and Y to match the guessed year.  */
-		days -= ((yg - y) * 365
-			 + LEAPS_THRU_END_OF (yg - 1)
-			 - LEAPS_THRU_END_OF (y - 1));
+		days -= (yg - y) * 365 +
+		        LEAPS_THRU_END_OF(yg - 1) - LEAPS_THRU_END_OF(y - 1);
 		y = yg;
 	}
 	*yearp = y - 1900;
-- 
2.16.1
