Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA600C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E8221565
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk9JevsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8221565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeI0G1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:27:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeI0G1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:27:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so649203wrh.7;
        Wed, 26 Sep 2018 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bQbsamm/LYhlgXhcl5giMo3OUz1T8eeEzrnPWLqAKw=;
        b=kk9JevsIVGIszGB11BajytRUzGLaL9OG4aw/XHPterEPDLUegTlWCPhTBJ5SgaQQxw
         hXIUhSlrvV8H23UXdCO2yyjbYJICmIvk4Z79t4LjRPCFuVV5kZdC3YlkPzjQF8tAqucw
         Zx9brxzHz5iHu8puyoaiKtCLYMDIaavR3zX9inqDibLh18xcr4ioVneNFD37251PbvDt
         ymjZ/YmCNdreYl+0xpo4M/nj8MS2saHPFKaj+Z2QiGHiC0Y1zUup3oz/EGHeYtVUBcFi
         l9eaycaVg4P5Lc0i9ujD2N9vEFT/lo45iks15KQInKCPMfAncQvkf/jjiA5zJis/jVO7
         8HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bQbsamm/LYhlgXhcl5giMo3OUz1T8eeEzrnPWLqAKw=;
        b=hZz4pErLt/sb8L6Uq/aNUFTS6JgmuaDMYI9aDMhHLHrcloKixOSExH6WA6EoVld8m7
         Joz5jrZKmuhrsq0Z1oS6YpxR+QDWyBQs9d2KZXhyEhLe01uTgiSbiSXb0R6RkLHkozcw
         YMYZdFSZR23INOj1W+tTR95eAwOX8pj1yShPwYPtuQRYB+mlQiVKrtS55XhGG4r6u9er
         cwPvCDuPQHIuOIUVbv/WlSSfQVVbf7V5/jX4GKmHDQUFEcuOnOO3MsM0u4Ugx7KV4ceP
         nY9NqxVCz1KWTDx0jSVmaMhuBAnPPhlQPCVEvb7DX40kWnbzuEv5xkkMlSUzlJz9i4DA
         DYqQ==
X-Gm-Message-State: ABuFfojAVBZc8wFEFapJSPX3TV5kOTtUyA8PnC/RLqMIL2zzTLn9dLNF
        ZyuCMtWLPS0Y1oB5wCgJ4q0=
X-Google-Smtp-Source: ACcGV60P7Ooa06mVKSWVDkc8vlkIpZzo7b3sIn3dEFEkT/FpaRYHdGG9ngI/F4qufc/JVsY8/LK5xw==
X-Received: by 2002:a5d:54cb:: with SMTP id x11-v6mr7161288wrv.150.1538007123239;
        Wed, 26 Sep 2018 17:12:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l40-v6sm416615wre.38.2018.09.26.17.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:12:02 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: isci: Change sci_controller_start_task's return type to sci_status
Date:   Wed, 26 Sep 2018 17:12:00 -0700
Message-Id: <20180927001200.26343-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when an enumerated type is implicitly converted to another.

drivers/scsi/isci/request.c:3476:13: warning: implicit conversion from
enumeration type 'enum sci_task_status' to different enumeration type
'enum sci_status' [-Wenum-conversion]
                        status = sci_controller_start_task(ihost,
                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/isci/host.c:2744:10: warning: implicit conversion from
enumeration type 'enum sci_status' to different enumeration type 'enum
sci_task_status' [-Wenum-conversion]
                return SCI_SUCCESS;
                ~~~~~~ ^~~~~~~~~~~
drivers/scsi/isci/host.c:2753:9: warning: implicit conversion from
enumeration type 'enum sci_status' to different enumeration type 'enum
sci_task_status' [-Wenum-conversion]
        return status;
        ~~~~~~ ^~~~~~

Avoid all of these implicit conversion by just making
sci_controller_start_task use sci_status. This silences
Clang and has no functional change since sci_task_status
has all of its values mapped to something in sci_status.

Link: https://github.com/ClangBuiltLinux/linux/issues/153
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/isci/host.c | 8 ++++----
 drivers/scsi/isci/host.h | 2 +-
 drivers/scsi/isci/task.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index 1ee3868ade07..7b5deae68d33 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -2717,9 +2717,9 @@ enum sci_status sci_controller_continue_io(struct isci_request *ireq)
  *    the task management request.
  * @task_request: the handle to the task request object to start.
  */
-enum sci_task_status sci_controller_start_task(struct isci_host *ihost,
-					       struct isci_remote_device *idev,
-					       struct isci_request *ireq)
+enum sci_status sci_controller_start_task(struct isci_host *ihost,
+					  struct isci_remote_device *idev,
+					  struct isci_request *ireq)
 {
 	enum sci_status status;
 
@@ -2728,7 +2728,7 @@ enum sci_task_status sci_controller_start_task(struct isci_host *ihost,
 			 "%s: SCIC Controller starting task from invalid "
 			 "state\n",
 			 __func__);
-		return SCI_TASK_FAILURE_INVALID_STATE;
+		return SCI_FAILURE_INVALID_STATE;
 	}
 
 	status = sci_remote_device_start_task(ihost, idev, ireq);
diff --git a/drivers/scsi/isci/host.h b/drivers/scsi/isci/host.h
index b3539928073c..6bc3f022630a 100644
--- a/drivers/scsi/isci/host.h
+++ b/drivers/scsi/isci/host.h
@@ -489,7 +489,7 @@ enum sci_status sci_controller_start_io(
 	struct isci_remote_device *idev,
 	struct isci_request *ireq);
 
-enum sci_task_status sci_controller_start_task(
+enum sci_status sci_controller_start_task(
 	struct isci_host *ihost,
 	struct isci_remote_device *idev,
 	struct isci_request *ireq);
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 6dcaed0c1fc8..fb6eba331ac6 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -258,7 +258,7 @@ static int isci_task_execute_tmf(struct isci_host *ihost,
 				 struct isci_tmf *tmf, unsigned long timeout_ms)
 {
 	DECLARE_COMPLETION_ONSTACK(completion);
-	enum sci_task_status status = SCI_TASK_FAILURE;
+	enum sci_status status = SCI_FAILURE;
 	struct isci_request *ireq;
 	int ret = TMF_RESP_FUNC_FAILED;
 	unsigned long flags;
@@ -301,7 +301,7 @@ static int isci_task_execute_tmf(struct isci_host *ihost,
 	/* start the TMF io. */
 	status = sci_controller_start_task(ihost, idev, ireq);
 
-	if (status != SCI_TASK_SUCCESS) {
+	if (status != SCI_SUCCESS) {
 		dev_dbg(&ihost->pdev->dev,
 			 "%s: start_io failed - status = 0x%x, request = %p\n",
 			 __func__,
-- 
2.19.0

