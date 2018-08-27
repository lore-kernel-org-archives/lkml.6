Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47D7208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47D7208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeH1BMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:12:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53057 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeH1BMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:12:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 50EBF207B0; Mon, 27 Aug 2018 23:23:51 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C35C206A6;
        Mon, 27 Aug 2018 23:23:51 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: rv8803: add Epson RX8803 support
Date:   Mon, 27 Aug 2018 23:23:44 +0200
Message-Id: <20180827212344.9779-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827212344.9779-1-alexandre.belloni@bootlin.com>
References: <20180827212344.9779-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Epson rx8803 is mostly similar to the Microcrystal RV8803 but the size
of the offset register is 4 bits vs 6 bits but it has a configurable
temperature compensation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 17ccef5d5db1..450a0b831a2d 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -615,6 +615,7 @@ static int rv8803_probe(struct i2c_client *client,
 
 static const struct i2c_device_id rv8803_id[] = {
 	{ "rv8803", rv_8803 },
+	{ "rx8803", rv_8803 },
 	{ "rx8900", rx_8900 },
 	{ }
 };
@@ -625,6 +626,10 @@ static const struct of_device_id rv8803_of_match[] = {
 		.compatible = "microcrystal,rv8803",
 		.data = (void *)rv_8803
 	},
+	{
+		.compatible = "epson,rx8803",
+		.data = (void *)rv_8803
+	},
 	{
 		.compatible = "epson,rx8900",
 		.data = (void *)rx_8900
-- 
2.18.0

