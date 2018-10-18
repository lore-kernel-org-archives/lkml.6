Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511EAC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6D52098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIhdb1wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6D52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeJSF64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:58:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSF64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:58:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so35285705wrt.2;
        Thu, 18 Oct 2018 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cedI6L2HxLnFCqRXETI1zk9gDFuUv7bXrQNvp4RiQ2k=;
        b=iIhdb1wbNUESeJRJ5i9wPxodlXitd8E0C6XCpRxA0qJsipyNbtIX5ajGZAQr/xjZbm
         RvaUxXNgj/WWIG2zkKsGHPuJ7J+uEDONEj/pHAQVGrjuMjsgG3enVJ056rhZD9XDYL7s
         ewDjKuL9TUpWrah5ajjTUqW0ZE0xp5nFDHDcC/g7IveRR7XCfDmPWJDijQKEmQ/LZC5b
         O4wzdOa6useRagCHMZXUB8vj8b6svtJUAjBzckDC06tyMGPHTs/PST7LOuGhOT9Yssl2
         c8/Wf/X839pWXbppm0XvF66f3Kn6DHb98y1jvGSzCdnqkcFJ/QrU2+gjUiapDwbZRPZD
         ugBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cedI6L2HxLnFCqRXETI1zk9gDFuUv7bXrQNvp4RiQ2k=;
        b=CqExqeLTiGVlctNvvq2ga63QVG/iRfna9fjPMfkrBfAYSy83xRd1mTXNb0Uv/CwCA2
         CywBF+OnyDYF2onSen2pjLTIBCbjUCAXe5guxSSuyyzjxYfRlOyrMciSXKTHNJpZzKQ6
         0Qjy3Wv8NvaO1t6jl9ez3+rDfaYKxO28xCc8TKj8aOI0zoOMbNC5hUABWvWExeSlKh0K
         2tr518MTAE95L3pMLR5m3pqRwo+10c45XHWdTE31e6P8ukFesJrtjzufVInIvolkOAwK
         NPE5jcmg1eUrK7eD7hhGtcz6LxmncQR8arxikgaQ2Mg+rF1Cs88G8Un6WJg2m79PMuq3
         P6Qg==
X-Gm-Message-State: ABuFfoiWLmkkQT9JkVd6USzYpd+hY9ZOSqHDIXFluoX3PbxavgarAOcf
        jIQkQgKaEkUmYioYGXKphkQCEXw9J8suPg==
X-Google-Smtp-Source: ACcGV63b1ubYawNDa3pdlLkkwra0/iUoIzdlpyIheIXdwYfl0QLhmw3PQaYEmAQpZZ7RfQOYfxoMZg==
X-Received: by 2002:adf:eb03:: with SMTP id s3-v6mr31954811wrn.281.1539899753948;
        Thu, 18 Oct 2018 14:55:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c24-v6sm34468140wre.44.2018.10.18.14.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 14:55:53 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: 3w-{sas,9xxx}: Use unsigned char for cdb
Date:   Thu, 18 Oct 2018 14:55:41 -0700
Message-Id: <20181018215541.4768-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns a few times:

drivers/scsi/3w-sas.c:386:11: warning: implicit conversion from 'int' to
'char' changes value from 128 to -128 [-Wconstant-conversion]
        cdb[4] = TW_ALLOCATION_LENGTH; /* allocation length */
               ~ ^~~~~~~~~~~~~~~~~~~~

Update cdb's type to unsigned char, which matches the type of the cdb
member in struct TW_Command_Apache.

Link: https://github.com/ClangBuiltLinux/linux/issues/158
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/3w-9xxx.c | 12 ++++++++----
 drivers/scsi/3w-sas.c  |  8 +++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 05293babb031..2d655a97b959 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -143,7 +143,9 @@ static int twa_poll_status_gone(TW_Device_Extension *tw_dev, u32 flag, int secon
 static int twa_post_command_packet(TW_Device_Extension *tw_dev, int request_id, char internal);
 static int twa_reset_device_extension(TW_Device_Extension *tw_dev);
 static int twa_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset);
-static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id, char *cdb, int use_sg, TW_SG_Entry *sglistarg);
+static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
+				   unsigned char *cdb, int use_sg,
+				   TW_SG_Entry *sglistarg);
 static void twa_scsiop_execute_scsi_complete(TW_Device_Extension *tw_dev, int request_id);
 static char *twa_string_lookup(twa_message_type *table, unsigned int aen_code);
 
@@ -278,7 +280,7 @@ static int twa_aen_complete(TW_Device_Extension *tw_dev, int request_id)
 static int twa_aen_drain_queue(TW_Device_Extension *tw_dev, int no_check_reset)
 {
 	int request_id = 0;
-	char cdb[TW_MAX_CDB_LEN];
+	unsigned char cdb[TW_MAX_CDB_LEN];
 	TW_SG_Entry sglist[1];
 	int finished = 0, count = 0;
 	TW_Command_Full *full_command_packet;
@@ -423,7 +425,7 @@ static void twa_aen_queue_event(TW_Device_Extension *tw_dev, TW_Command_Apache_H
 /* This function will read the aen queue from the isr */
 static int twa_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
 {
-	char cdb[TW_MAX_CDB_LEN];
+	unsigned char cdb[TW_MAX_CDB_LEN];
 	TW_SG_Entry sglist[1];
 	TW_Command_Full *full_command_packet;
 	int retval = 1;
@@ -1798,7 +1800,9 @@ static int twa_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_
 static DEF_SCSI_QCMD(twa_scsi_queue)
 
 /* This function hands scsi cdb's to the firmware */
-static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id, char *cdb, int use_sg, TW_SG_Entry *sglistarg)
+static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
+				   unsigned char *cdb, int use_sg,
+				   TW_SG_Entry *sglistarg)
 {
 	TW_Command_Full *full_command_packet;
 	TW_Command_Apache *command_packet;
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 266bdac75304..480cf82700e9 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -287,7 +287,9 @@ static int twl_post_command_packet(TW_Device_Extension *tw_dev, int request_id)
 } /* End twl_post_command_packet() */
 
 /* This function hands scsi cdb's to the firmware */
-static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id, char *cdb, int use_sg, TW_SG_Entry_ISO *sglistarg)
+static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
+				   unsigned char *cdb, int use_sg,
+				   TW_SG_Entry_ISO *sglistarg)
 {
 	TW_Command_Full *full_command_packet;
 	TW_Command_Apache *command_packet;
@@ -372,7 +374,7 @@ static int twl_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
 /* This function will read the aen queue from the isr */
 static int twl_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
 {
-	char cdb[TW_MAX_CDB_LEN];
+	unsigned char cdb[TW_MAX_CDB_LEN];
 	TW_SG_Entry_ISO sglist[1];
 	TW_Command_Full *full_command_packet;
 	int retval = 1;
@@ -554,7 +556,7 @@ static int twl_poll_response(TW_Device_Extension *tw_dev, int request_id, int se
 static int twl_aen_drain_queue(TW_Device_Extension *tw_dev, int no_check_reset)
 {
 	int request_id = 0;
-	char cdb[TW_MAX_CDB_LEN];
+	unsigned char cdb[TW_MAX_CDB_LEN];
 	TW_SG_Entry_ISO sglist[1];
 	int finished = 0, count = 0;
 	TW_Command_Full *full_command_packet;
-- 
2.19.1

