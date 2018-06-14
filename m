Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 594B3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60D208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60D208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755389AbeFNP0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:26:05 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60891 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755092AbeFNP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:26:04 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 11:26:03 EDT
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 17C0458C5BC;
        Thu, 14 Jun 2018 17:20:49 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Thu, 14 Jun 2018 17:20:49 +0200
From:   Henriette Hofmeier <passt@h-hofmeier.de>
To:     devel@linuxdriverproject.org
Cc:     zbr@ioremap.net, arvind.yadav.cs@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Florian Harbecke <florian.harbecke@fau.de>
Subject: [PATCH 1/3] ds2490.c: Add required spaces
Date:   Thu, 14 Jun 2018 17:20:39 +0200
Message-Id: <1528989641-20284-2-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
References: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces in for- and while-loops
reported missing by checkpatch.

Signed-off-by: Henriette Hofmeier <passt@h-hofmeier.de>
Signed-off-by: Florian Harbecke <florian.harbecke@fau.de>
---
 drivers/w1/masters/ds2490.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index c423bdb..917a5f1 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -236,7 +236,7 @@ static void ds_dump_status(struct ds_device *dev, unsigned char *buf, int count)
 	int i;
 
 	pr_info("0x%x: count=%d, status: ", dev->ep[EP_STATUS], count);
-	for (i=0; i<count; ++i)
+	for (i = 0; i < count; ++i)
 		pr_info("%02x ", buf[i]);
 	pr_info("\n");
 
@@ -358,7 +358,7 @@ static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
 		int i;
 
 		printk("%s: count=%d: ", __func__, count);
-		for (i=0; i<count; ++i)
+		for (i = 0; i < count; ++i)
 			printk("%02x ", buf[i]);
 		printk("\n");
 	}
@@ -404,7 +404,7 @@ int ds_stop_pulse(struct ds_device *dev, int limit)
 			if (err)
 				break;
 		}
-	} while(++count < limit);
+	} while (++count < limit);
 
 	return err;
 }
@@ -447,7 +447,7 @@ static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 		if (err >= 0) {
 			int i;
 			printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], err);
-			for (i=0; i<err; ++i)
+			for (i = 0; i < err; ++i)
 				printk("%02x ", dev->st_buf[i]);
 			printk("\n");
 		}
-- 
2.7.4

