Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD9C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBAA204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRJjQW2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBAA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeJKXeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:34:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36846 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJKXeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:34:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id l81-v6so4656211pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M0dg81e6IPG3nPdAFkGrW36Oiw4KJcaQA3atbwF/e1k=;
        b=fRJjQW2IRWPtueyL4gusQ7qilCszY0og7RAaxcC6UoT/rhyCb2fUL8oZZV5LXnMlZK
         OtC23QgeqltxWopTFVEnFnhIvJDLn+PQkTnhITxJgg8ddpT72AvVyxneg9qAVODzMt6Y
         6CnXaLNwvv9hdsfAMCA6LU1CTiaVudgImuQ9En8JmAr02p2NvsbIuY8cr+5RIUXTfygy
         XmuOuw4/LP6G9u/4xYHaCDubcFZPhp5FMbW1Mz9LaW6ucj9T6z45DsG0aLlJtSJYixqB
         v1zj34At13BuOrpxIJZfP5PNEZF/5cx5NqH5SHoccceOxKCH9X8sppnGA9Vz3y1NfNbm
         O1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M0dg81e6IPG3nPdAFkGrW36Oiw4KJcaQA3atbwF/e1k=;
        b=UN3gI3cTrK1eLa/n0GjVlPCaT0BX8t6NFvPxi4ChkjdbA7jLnQxfmUlkGqV+9JpNiv
         p0FY7sAW1ZZo0av3hFGRdevsItSG4cvnmoH+7AqEM7rmnfZKnwpsg23oB6po+6/VGVKH
         JLJbO39CMrJZ8wWkS/OZs8yOIk9ZPe6YZh7pZ99ayonaIAezMNONolDmNJfj1Z9axFla
         uGVlODzSZ3Qu/le5gDqzj3iSNqjWv0UmCJu9TuQ36JpR0QOs0n62yn+79PXpTtotaw71
         q36lwemd34heFbAAEhWHy/I5+lCWS9woiluApgdaCpV7H6gmOxbzpyVb2Efh5Eo+zeM0
         Wi+Q==
X-Gm-Message-State: ABuFfojjuYBY8W8TtDI8ucp5O4jOvXpleeWFnf/WxzJuRyJqiHdCkzkF
        ManlCZfQkhizVrZUk05L9iC/qWy5SUiptA==
X-Google-Smtp-Source: ACcGV62TqF23YPLhczJLUYWNTyYK/IGpMa3o6tXJT+58wufFQOmPta0LpwS0UmbLn3uTvSSZzT6EPg==
X-Received: by 2002:a62:c957:: with SMTP id k84-v6mr2199466pfg.205.1539273987228;
        Thu, 11 Oct 2018 09:06:27 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id v81-v6sm51158938pfj.25.2018.10.11.09.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:06:26 -0700 (PDT)
Date:   Thu, 11 Oct 2018 21:36:19 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: mt7621-mmc: Fix lines over 80 characters in dbg.c
Message-ID: <20181011160615.GA4767@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes lines over 80 characters in dbg.c.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 79 +++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 2bafb3bd026e..829d3d0e895e 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -5,7 +5,8 @@
  * is confidential and proprietary to MediaTek Inc. and/or its licensors.
  * Without the prior written permission of MediaTek inc. and/or its licensors,
  * any reproduction, modification, use or disclosure of MediaTek Software,
- * and information contained herein, in whole or in part, shall be strictly prohibited.
+ * and information contained herein, in whole or in part, shall be strictly
+ * prohibited.
  *
  * MediaTek Inc. (C) 2010. All rights reserved.
  *
@@ -17,20 +18,22 @@
  * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
  * NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
  * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
- * SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
- * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
- * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
- * CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
- * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
- * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
- * CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
- * AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
- * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
- * MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
+ * SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO
+ * SUCH THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY
+ * ACKNOWLEDGES THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY
+ * THIRD PARTY ALL PROPER LICENSES CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK
+ * SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK SOFTWARE RELEASES MADE TO
+ * RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR STANDARD OR OPEN
+ * FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
+ * CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED
+ * HEREUNDER WILL BE, AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK
+ * SOFTWARE AT ISSUE, OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE
+ * PAID BY RECEIVER TO MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
  *
- * The following software/firmware and/or related documentation ("MediaTek Software")
- * have been modified by MediaTek Inc. All revisions are subject to any receiver's
- * applicable license agreements with MediaTek Inc.
+ * The following software/firmware and/or related documentation
+ * ("MediaTek Software") have been modified by MediaTek Inc. All revisions
+ * are subject to any receiver's applicable license agreements with MediaTek
+ * Inc.
  */
 
 #include <linux/version.h>
@@ -74,7 +77,8 @@ u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32)
 		ret = new_L32 - old_L32;
 	} else if (new_H32 == (old_H32 + 1)) {
 		if (new_L32 > old_L32)
-			pr_debug("msdc old_L<0x%x> new_L<0x%x>\n", old_L32, new_L32);
+			pr_debug("msdc old_L<0x%x> new_L<0x%x>\n",
+				 old_L32, new_L32);
 		ret = (0xffffffff - old_L32);
 		ret += new_L32;
 	} else {
@@ -96,27 +100,33 @@ void msdc_sdio_profile(struct sdio_profile *result)
 
 	/* CMD52 Dump */
 	cmd = &result->cmd52_rx;
-	pr_debug("sdio === CMD52 Rx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n", cmd->count, cmd->tot_tc,
-		 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count);
+	pr_debug("sdio === CMD52 Rx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n",
+		 cmd->count, cmd->tot_tc, cmd->max_tc, cmd->min_tc,
+		 cmd->tot_tc / cmd->count);
 	cmd = &result->cmd52_tx;
-	pr_debug("sdio === CMD52 Tx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n", cmd->count, cmd->tot_tc,
-		 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count);
+	pr_debug("sdio === CMD52 Tx <%d>times tick<%d> Max<%d> Min<%d> Aver<%d>\n",
+		 cmd->count, cmd->tot_tc, cmd->max_tc, cmd->min_tc,
+		 cmd->tot_tc / cmd->count);
 
 	/* CMD53 Rx bytes + block mode */
 	for (i = 0; i < 512; i++) {
 		cmd = &result->cmd53_rx_byte[i];
 		if (cmd->count) {
-			pr_debug("sdio<%6d><%3dB>_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3dB>_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n",
+				 cmd->count, i, cmd->tot_tc, cmd->max_tc,
+				 cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes,
+				 (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 	for (i = 0; i < 100; i++) {
 		cmd = &result->cmd53_rx_blk[i];
 		if (cmd->count) {
-			pr_debug("sdio<%6d><%3d>B_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3d>B_Rx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n",
+				 cmd->count, i, cmd->tot_tc, cmd->max_tc,
+				 cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes,
+				 (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 
@@ -124,17 +134,21 @@ void msdc_sdio_profile(struct sdio_profile *result)
 	for (i = 0; i < 512; i++) {
 		cmd = &result->cmd53_tx_byte[i];
 		if (cmd->count) {
-			pr_debug("sdio<%6d><%3dB>_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3dB>_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n",
+				 cmd->count, i, cmd->tot_tc, cmd->max_tc,
+				 cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes,
+				 (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 	for (i = 0; i < 100; i++) {
 		cmd = &result->cmd53_tx_blk[i];
 		if (cmd->count) {
-			pr_debug("sdio<%6d><%3d>B_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n", cmd->count, i, cmd->tot_tc,
-				 cmd->max_tc, cmd->min_tc, cmd->tot_tc / cmd->count,
-				 cmd->tot_bytes, (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
+			pr_debug("sdio<%6d><%3d>B_Tx_<%9d><%9d><%6d><%6d>_<%9dB><%2dM>\n",
+				 cmd->count, i, cmd->tot_tc, cmd->max_tc,
+				 cmd->min_tc, cmd->tot_tc / cmd->count,
+				 cmd->tot_bytes,
+				 (cmd->tot_bytes / 10) * 13 / (cmd->tot_tc / 10));
 		}
 	}
 
@@ -205,7 +219,8 @@ static int msdc_debug_proc_read(struct seq_file *s, void *p)
 
 	seq_puts(s, "Index<3> + SDIO_PROFILE + TIME\n");
 	seq_puts(s, "-> echo 3 1 0x1E >msdc_bebug -> enable sdio_profile, 30s\n");
-	seq_printf(s, "-> SDIO_PROFILE<%d> TIME<%ds>\n", sdio_pro_enable, sdio_pro_time);
+	seq_printf(s, "-> SDIO_PROFILE<%d> TIME<%ds>\n",
+		   sdio_pro_enable, sdio_pro_time);
 	seq_puts(s, "=========================================\n\n");
 
 	return 0;
-- 
2.17.1

