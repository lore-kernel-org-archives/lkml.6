Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1392B20862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1392B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH2G6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:58:06 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37526 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeH2G6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:58:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55b860cfbe8c-3c8e6; Wed, 29 Aug 2018 11:03:23 +0800 (CST)
X-RM-TRANSID: 2ee55b860cfbe8c-3c8e6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85b860cfa1ce-9d9b1;
        Wed, 29 Aug 2018 11:03:23 +0800 (CST)
X-RM-TRANSID: 2ee85b860cfa1ce-9d9b1
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: Fix bool function return value
Date:   Wed, 29 Aug 2018 11:03:20 +0800
Message-Id: <1535511800-25075-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csio_scsi_itnexus_loss_error is bool type, so the return value
should be true or false.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/csiostor/csio_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index dab0d3f..aae7abc 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -147,9 +147,9 @@ static int csio_do_abrt_cls(struct csio_hw *,
 	case FW_ERR_RDEV_LOST:
 	case FW_ERR_RDEV_LOGO:
 	case FW_ERR_RDEV_IMPL_LOGO:
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
-- 
1.9.1



