Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACC1ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF612150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF612150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeJRAFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:05:01 -0400
Received: from mail2.skidata.com ([91.230.2.91]:38548 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRAFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:05:01 -0400
X-IronPort-AV: E=Sophos;i="5.54,393,1534802400"; 
   d="scan'208";a="1732772"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 4/8] Input: sx8654 - add sx8655 and sx8656 to compatibles
Date:   Wed, 17 Oct 2018 14:51:12 +0200
Message-ID: <20181017125116.20077-5-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sx865[456] share the same datasheet and differ only in the
presence of a "capacitive proximity detection circuit" and a "haptics
motor driver for LRA/ERM" add them to the compatbiles. As the driver
doesn't implement these features it should be no problem.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 238f56b1581b..afa4da138fe9 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -293,6 +293,8 @@ static int sx8654_probe(struct i2c_client *client,
 #ifdef CONFIG_OF
 static const struct of_device_id sx8654_of_match[] = {
 	{ .compatible = "semtech,sx8654", },
+	{ .compatible = "semtech,sx8655", },
+	{ .compatible = "semtech,sx8656", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sx8654_of_match);
@@ -300,6 +302,8 @@ MODULE_DEVICE_TABLE(of, sx8654_of_match);
 
 static const struct i2c_device_id sx8654_id_table[] = {
 	{ "semtech_sx8654", 0 },
+	{ "semtech_sx8655", 0 },
+	{ "semtech_sx8656", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
-- 
2.11.0

