Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86FAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ABD2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ABD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeIFKu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:50:26 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:36711 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeIFKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:50:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5b90c63f7db-fe8be; Thu, 06 Sep 2018 14:16:31 +0800 (CST)
X-RM-TRANSID: 2eeb5b90c63f7db-fe8be
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45b90c63d9bc-d617f;
        Thu, 06 Sep 2018 14:16:30 +0800 (CST)
X-RM-TRANSID: 2ee45b90c63d9bc-d617f
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: zfcp: remove redundant put_device
Date:   Thu,  6 Sep 2018 14:16:27 +0800
Message-Id: <1536214587-32500-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_unregister will put device, do not need to do it one more time

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/s390/scsi/zfcp_unit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
index 1bf0a09..6b50084 100644
--- a/drivers/s390/scsi/zfcp_unit.c
+++ b/drivers/s390/scsi/zfcp_unit.c
@@ -249,8 +249,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
 		scsi_device_put(sdev);
 	}
 
-	put_device(&unit->dev);
-
 	device_unregister(&unit->dev);
 
 	return 0;
-- 
1.9.1



