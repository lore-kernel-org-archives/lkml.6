Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D7CECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850ED214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850ED214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeISGua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:50:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33560 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbeISGua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:50:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C6A1B20798; Wed, 19 Sep 2018 03:15:11 +0200 (CEST)
Received: from localhost (unknown [65.155.82.100])
        by mail.bootlin.com (Postfix) with ESMTPSA id 16BDA20714;
        Wed, 19 Sep 2018 03:15:00 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: tx4939: fixup nvmem name and register size
Date:   Wed, 19 Sep 2018 03:14:58 +0200
Message-Id: <20180919011458.4231-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default word_size and stride of 1 are correct for the tx4939. Also fix
the nvmem folder name.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 08dbefc79520..61c110b2045f 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -253,9 +253,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq, ret;
 	struct nvmem_config nvmem_cfg = {
-		.name = "rv8803_nvram",
-		.word_size = 4,
-		.stride = 4,
+		.name = "tx4939_nvram",
 		.size = TX4939_RTC_REG_RAMSIZE,
 		.reg_read = tx4939_nvram_read,
 		.reg_write = tx4939_nvram_write,
-- 
2.19.0

