Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43F62409A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43F62409A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeGEMqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:46:52 -0400
Received: from mailgate2.uni-hannover.de ([130.75.2.114]:48194 "EHLO
        mailgate2.uni-hannover.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeGEMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:46:51 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 08:46:50 EDT
Received: from kolab.sra.uni-hannover.de (kolab.sra.uni-hannover.de [130.75.33.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgate2.uni-hannover.de (Postfix) with ESMTPS id AE5DA9FE2;
        Thu,  5 Jul 2018 14:41:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sra.uni-hannover.de
Received: from lab.sra.uni-hannover.de (aerobus.sra.uni-hannover.de
 [130.75.33.87])
 by kolab.sra.uni-hannover.de (Postfix) with SMTP id 181EF3E03BC;
 Thu,  5 Jul 2018 14:41:40 +0200 (CEST)
Received: (nullmailer pid 29824 invoked by uid 20080);
 Thu, 05 Jul 2018 12:41:43 -0000
From:   Sergej Perschin <ser.perschin@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Sergej Perschin <ser.perschin@gmail.com>,
        Marcel Budoj <marcel.budoj@gmail.com>
Subject: [PATCH] staging: mt7621-mmc: Fix printk() facility level
Date:   Thu,  5 Jul 2018 14:41:01 +0200
Message-Id: <1530794461-29763-1-git-send-email-ser.perschin@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following issue:
WARNING: printk() should include KERN_<LEVEL> facility level

Signed-off-by: Sergej Perschin <ser.perschin@gmail.com>
Signed-off-by: Marcel Budoj <marcel.budoj@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 6e4e223..6e518dc 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -91,11 +91,11 @@ u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32)
 		ret = new_L32 - old_L32;
 	} else if (new_H32 == (old_H32 + 1)) {
 		if (new_L32 > old_L32)
-			printk("msdc old_L<0x%x> new_L<0x%x>\n", old_L32, new_L32);
+			pr_debug("msdc old_L<0x%x> new_L<0x%x>\n", old_L32, new_L32);
 		ret = (0xffffffff - old_L32);
 		ret += new_L32;
 	} else {
-		printk("msdc old_H<0x%x> new_H<0x%x>\n", old_H32, new_H32);
+		pr_debug("msdc old_H<0x%x> new_H<0x%x>\n", old_H32, new_H32);
 	}
 
 	return ret;
@@ -106,34 +106,34 @@ void msdc_sdio_profile(struct sdio_profile *result)
 	struct cmd_profile *cmd;
 	u32 i;
 
-	printk("sdio === performance dump ===\n");
-	printk("sdio === total execute tick<%d> time<%dms> Tx<%dB> Rx<%dB>\n",
-		result->total_tc, result->total_tc / TICKS_ONE_MS,
-		result->total_tx_bytes, result->total_rx_bytes);
+	pr_debug("sdio === performance dump ===\n");
+	pr_debug("sdio === total execute tick<%d> time<%dms> Tx<%dB> Rx<%dB>\n",
+		 result->total_tc, result->total_tc / TICKS_ONE_MS,
+		 result->total_tx_bytes, result->total_rx_bytes);
 
 	/* CMD52 Dump */
 	cmd = &result->cmd52_rx;
-	printk("sdio === CMD52 Rx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n", cmd->count, cmd->tot_tc,
-	       cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count);
+	pr_debug("sdio === CMD52 Rx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n", cmd->count, cmd->tot_tc,
+		 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count);
 	cmd = &result->cmd52_tx;
-	printk("sdio === CMD52 Tx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n", cmd->count, cmd->tot_tc,
-	       cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count);
+	pr_debug("sdio === CMD52 Tx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n", cmd->count, cmd->tot_tc,
+		 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count);
 
 	/* CMD53 Rx bytes + block mode */
 	for (i = 0; i < 512; i++) {
 		cmd = &result->cmd53_rx_byte[i];
 		if (cmd->count) {
-			printk("sdio<%6d><%3dB>_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-			       cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-			       cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3dB>_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
+				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 	for (i = 0; i < 100; i++) {
 		cmd = &result->cmd53_rx_blk[i];
 		if (cmd->count) {
-			printk("sdio<%6d><%3d>B_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-			       cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-			       cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3d>B_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
+				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 
@@ -141,21 +141,21 @@ void msdc_sdio_profile(struct sdio_profile *result)
 	for (i = 0; i < 512; i++) {
 		cmd = &result->cmd53_tx_byte[i];
 		if (cmd->count) {
-			printk("sdio<%6d><%3dB>_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-			       cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-			       cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3dB>_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
+				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 	for (i = 0; i < 100; i++) {
 		cmd = &result->cmd53_tx_blk[i];
 		if (cmd->count) {
-			printk("sdio<%6d><%3d>B_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-			       cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-			       cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3d>B_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
+				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 
-	printk("sdio === performance dump done ===\n");
+	pr_debug("sdio === performance dump done ===\n");
 }
 
 //========= sdio command table ===========
@@ -176,7 +176,7 @@ void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks)
 		} else {
 			block = sizes / 512;
 			if (block >= 99) {
-				printk("cmd53 error blocks\n");
+				pr_err("cmd53 error blocks\n");
 				while (1)
 					;
 			}
@@ -247,7 +247,7 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 		return -EFAULT;
 
 	cmd_buf[count] = '\0';
-	printk("msdc Write %s\n", cmd_buf);
+	pr_debug("msdc Write %s\n", cmd_buf);
 
 	sscanf(cmd_buf, "%x %x %x", &cmd, &p1, &p2);
 
@@ -255,14 +255,14 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 		id = p1;
 		zone = p2;
 		zone &= 0x3ff;
-		printk("msdc host_id<%d> zone<0x%.8x>\n", id, zone);
+		pr_debug("msdc host_id<%d> zone<0x%.8x>\n", id, zone);
 		if (id >= 0 && id <= 3) {
 			sd_debug_zone[id] = zone;
 		} else if (id == 4) {
 			sd_debug_zone[0] = sd_debug_zone[1] = zone;
 			sd_debug_zone[2] = sd_debug_zone[3] = zone;
 		} else {
-			printk("msdc host_id error when set debug zone\n");
+			pr_err("msdc host_id error when set debug zone\n");
 		}
 	} else if (cmd == SD_TOOL_SDIO_PROFILE) {
 		if (p1 == 1) { /* enable profile */
-- 
2.7.4
