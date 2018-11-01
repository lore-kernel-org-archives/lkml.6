Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03891C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA85B20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeKAL2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:28:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbeKAL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:28:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C66F34528E62D;
        Thu,  1 Nov 2018 10:27:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 10:27:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux-edac@vger.kernel.org>, <ravi@jetztechnologies.com>,
        <arvino55@gmail.com>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] edac: i82975x: remove set but not used variable 'dtype'
Date:   Thu, 1 Nov 2018 10:26:04 +0800
Message-ID: <20181101022604.7312-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/i82975x_edac.c:378:16: warning:
 variable ‘dtype’ set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
084a4fccef39 ("edac: move dimm properties to struct dimm_info")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/edac/i82975x_edac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 892815e..ae0d8fa 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -375,7 +375,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
 	u32 cumul_size, nr_pages;
 	int index, chan;
 	struct dimm_info *dimm;
-	enum dev_type dtype;
 
 	last_cumul_size = 0;
 
@@ -413,7 +412,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
 		 *   [0-7] for single-channel; i.e. csrow->nr_channels = 1
 		 *   [0-3] for dual-channel; i.e. csrow->nr_channels = 2
 		 */
-		dtype = i82975x_dram_type(mch_window, index);
 		for (chan = 0; chan < csrow->nr_channels; chan++) {
 			dimm = mci->csrows[index]->channels[chan]->dimm;
 
-- 
2.7.0


