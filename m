Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeEGGxq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:53:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41356 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:53:43 -0400
X-Google-Smtp-Source: AB8JxZpeVXzTPENPZjWb6t7f0DFqxYpcvPKpFc26MK0kzVeW/QWon8HSVqiWaZlSCIXiS2MrA4r1rg==
Subject: [PATCH 1/3] scsi: arcmsr: Add driver parameter cmd_timeout,
 default value is ARCMSR_DEFAULT_TIMEOUT
From: Ching Huang <ching2048@areca.com.tw>
To: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 May 2018 14:53:39 +0800
Message-ID: <1525676019.8876.15.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From Ching Huang <ching2048@areca.com.tw>

Add driver parameter cmd_timeout, default value is ARCMSR_DEFAULT_TIMEOUT

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 2e51ccc..62eeef5 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -82,6 +82,7 @@ struct device_attribute;
 #endif
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
+#define ARCMSR_DEFAULT_TIMEOUT		90
 /*
 **********************************************************************************
 **
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 732b5d9..f6ddaec 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -95,6 +95,10 @@ static int set_date_time = 0;
 module_param(set_date_time, int, S_IRUGO);
 MODULE_PARM_DESC(set_date_time, " send date, time to iop(0 ~ 1), set_date_time=1(enable), default(=0) is disable");
 
+static int cmd_timeout = ARCMSR_DEFAULT_TIMEOUT;
+module_param(cmd_timeout, int, S_IRUGO);
+MODULE_PARM_DESC(cmd_timeout, " scsi cmd timeout(0 ~ 120 sec.), default is 90");
+
 #define	ARCMSR_SLEEPTIME	10
 #define	ARCMSR_RETRYCOUNT	12
 
