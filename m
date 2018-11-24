Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D4C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8F120874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="YXn5Ya5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8F120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeKYBFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:05:43 -0500
Received: from onstation.org ([52.200.56.107]:41768 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeKYBFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:05:42 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 19058967;
        Sat, 24 Nov 2018 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543069030;
        bh=JcoI+iLbax0W5GI5fln0p9Nfh/YwkwMMcf2hQeSRgk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXn5Ya5YRii06c/BgXaYD2j1T2mrWdDwuTXdLIJlu6kg7SWk4RnENZfmZEsxlIrPO
         yx+yQ7TqCaZ2CBEVw/LE02BVNQREQg46ibd0nnIh/tXeoCWbGVD7X6afSyb4Gt3Ry3
         Nnf4DYBxSnWa5Rdxk+R7AVthQfNk7H4kVH9FU9jU=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathan@marek.ca,
        ctatlor97@gmail.com
Subject: [PATCH 2/2] backlight: lm3630a: add backlight driver match_table
Date:   Sat, 24 Nov 2018 09:17:03 -0500
Message-Id: <20181124141703.29232-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181124141703.29232-1-masneyb@onstation.org>
References: <20181124141703.29232-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

Add device tree support to the lm3630a driver.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[masneyb@onstation.org: checkpatch fixes; add 'a' to compatible string]
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is part of upstreaming various components of the LG Nexus 5
(hammerhead) phone.

 drivers/video/backlight/lm3630a_bl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 2030a6b77a09..159d4013d9c2 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -470,11 +470,18 @@ static const struct i2c_device_id lm3630a_id[] = {
 	{}
 };
 
+static const struct of_device_id lm3630a_match_table[] = {
+	{ .compatible = "ti,lm3630a", },
+	{ },
+};
+
+
 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
 
 static struct i2c_driver lm3630a_i2c_driver = {
 	.driver = {
 		   .name = LM3630A_NAME,
+		   .of_match_table = lm3630a_match_table,
 		   },
 	.probe = lm3630a_probe,
 	.remove = lm3630a_remove,
-- 
2.17.2

