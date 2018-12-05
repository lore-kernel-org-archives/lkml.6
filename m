Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E71C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB882064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeTmxt1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB882064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeLEQ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:26:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33371 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:26:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so10265946pfb.0;
        Wed, 05 Dec 2018 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Dv9seiVmrxmRkDh68icIM5zWEW8jniWB4IAM4K9EcU=;
        b=YeTmxt1uoscVxx2DwfyyGffct4JW/meO5D+/kpy1hGUw3FnZkxqFJuklKtmOjCM3AU
         AFpWsnp1h64tPWOPnRdK6n+p8hc9m7zO4zLZPT7VcLSl4kS+AtdkGbMJN3kF/CRviUiw
         4+VOuODNOBQr9tmcWeVKDmM0Pyv+fs454Ezgsodq/hXcmzFALuwC2vMLGqbi/vkxz4bC
         rusdkuakOX+OqYxwxqXzVMD3hNrX1jaiK93q/zbkwlCZfFFHyF+6nn67PyD3Y3di3jWM
         PDKdhiJq/zqiKivASNF85RE59dD/T3qNboFCP74KRHyb6BzTcmEer9B9yoHdtYqeHosO
         PqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Dv9seiVmrxmRkDh68icIM5zWEW8jniWB4IAM4K9EcU=;
        b=K7penzvR0xjgBZI5Dw2cjz9uR5hq4IHf0l0SiroCjTzsJesL1+6/Dvf/ZkYQ4CYqDI
         V+O/1RfdTfZjKfJA64ZltMDfVm/nBuNttM2yDkk66SbaOsZQRMoYep5w3CmyzV8nMSJU
         llFHCG48TMNsqYJmFdk1GurLVOoFe5VsGT1nDzfUGF5qlo6EDRGLk3SKMZk6UnqkSY0l
         526NpJv4FHxbixbHjDJC3rv1jvBf094tE+V6cL7q06/N/0pWoA2Z3E+FEoj4iN+sbPQN
         ITHr7Fxl4DFzuykBVd4v2evRzXlvmr/7euevC+Vj7h27RWp2nf48kd8VVcZptf8+I2WN
         imaw==
X-Gm-Message-State: AA+aEWYyS1TWxhSlzyrfTMFs/nS95DtrybQFEWbfycUet0Z4U6ItBglG
        Rfo+AnLpsZ/Kp9lw9j2IrOM=
X-Google-Smtp-Source: AFSGD/VtiSF+rK8Ukv8WiWURRVIYmARkLpF2X/2SEzUGLruIGL233RQmhN9u2Z1Rjz2OHS3hll2/QA==
X-Received: by 2002:a63:2744:: with SMTP id n65mr20923402pgn.65.1544027202594;
        Wed, 05 Dec 2018 08:26:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b185sm33379456pga.85.2018.12.05.08.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:26:41 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] USB: gadget: udc: s3c2410_udc: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 11:26:39 -0500
Message-Id: <20181205162639.16557-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/usb/gadget/udc/s3c2410_udc.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 8bf5ad7a59ad..af3e63316ace 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -119,7 +119,7 @@ static void dprintk(int level, const char *fmt, ...)
 }
 #endif
 
-static int s3c2410_udc_debugfs_seq_show(struct seq_file *m, void *p)
+static int s3c2410_udc_debugfs_show(struct seq_file *m, void *p)
 {
 	u32 addr_reg, pwr_reg, ep_int_reg, usb_int_reg;
 	u32 ep_int_en_reg, usb_int_en_reg, ep0_csr;
@@ -168,20 +168,7 @@ static int s3c2410_udc_debugfs_seq_show(struct seq_file *m, void *p)
 
 	return 0;
 }
-
-static int s3c2410_udc_debugfs_fops_open(struct inode *inode,
-					 struct file *file)
-{
-	return single_open(file, s3c2410_udc_debugfs_seq_show, NULL);
-}
-
-static const struct file_operations s3c2410_udc_debugfs_fops = {
-	.open		= s3c2410_udc_debugfs_fops_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(s3c2410_udc_debugfs);
 
 /* io macros */
 
-- 
2.17.0

