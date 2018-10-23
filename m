Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7AEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14B420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJWUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:42:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJWUme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:42:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1D288ACC333B;
        Tue, 23 Oct 2018 20:19:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Oct 2018 20:19:15 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <axboe@kernel.dk>, <mlombard@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] cdrom: remove set but not used variable 'tocuse'
Date:   Tue, 23 Oct 2018 20:06:37 +0800
Message-ID: <1540296397-23835-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tocuse is not used after setting its value. It is safe to remove
the unused variable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/cdrom/gdrom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 757e85b..b45c543 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -327,15 +327,15 @@ static int get_entry_track(int track)
 static int gdrom_get_last_session(struct cdrom_device_info *cd_info,
 	struct cdrom_multisession *ms_info)
 {
-	int fentry, lentry, track, data, tocuse, err;
+	int fentry, lentry, track, data, err;
+
 	if (!gd.toc)
 		return -ENOMEM;
-	tocuse = 1;
+
 	/* Check if GD-ROM */
 	err = gdrom_readtoc_cmd(gd.toc, 1);
 	/* Not a GD-ROM so check if standard CD-ROM */
 	if (err) {
-		tocuse = 0;
 		err = gdrom_readtoc_cmd(gd.toc, 0);
 		if (err) {
 			pr_info("Could not get CD table of contents\n");
-- 
1.7.12.4

