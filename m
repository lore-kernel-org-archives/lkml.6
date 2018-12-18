Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DCEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0662E217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLRIhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:37:09 -0500
Received: from mail2.skidata.com ([91.230.2.91]:29920 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeLRIhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:37:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539640800"; 
   d="scan'208";a="1873950"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <mark.rutland@arm.com>
CC:     <robh+dt@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <richard.leitner@skidata.com>
Subject: [RESEND PATCH v2 4/8] Input: sx8654 - add sx8655 and sx8656 to compatibles
Date:   Tue, 18 Dec 2018 09:36:02 +0100
Message-ID: <20181218083606.25795-5-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181218083606.25795-1-richard.leitner@skidata.com>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
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

