Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FECECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F76D21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F76D21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbeIXSP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:15:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeIXSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:15:26 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F089109C;
        Mon, 24 Sep 2018 12:13:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 033/173] media: ov5645: Supported external clock is 24MHz
Date:   Mon, 24 Sep 2018 13:51:07 +0200
Message-Id: <20180924113118.403611617@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todor Tomov <todor.tomov@linaro.org>

[ Upstream commit 4adb0a0432f489c5eb802b33dae7737f69e6fd7a ]

The external clock frequency was set to 23.88MHz by mistake
because of a platform which cannot get closer to 24MHz.
The supported by the driver external clock is 24MHz so
set it correctly and also fix the values of the pixel
clock and link clock.
However allow 1% tolerance to the external clock as this
difference is small enough to be insignificant.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov5645.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -510,8 +510,8 @@ static const struct reg_value ov5645_set
 };
 
 static const s64 link_freq[] = {
-	222880000,
-	334320000
+	224000000,
+	336000000
 };
 
 static const struct ov5645_mode_info ov5645_mode_info_data[] = {
@@ -520,7 +520,7 @@ static const struct ov5645_mode_info ov5
 		.height = 960,
 		.data = ov5645_setting_sxga,
 		.data_size = ARRAY_SIZE(ov5645_setting_sxga),
-		.pixel_clock = 111440000,
+		.pixel_clock = 112000000,
 		.link_freq = 0 /* an index in link_freq[] */
 	},
 	{
@@ -528,7 +528,7 @@ static const struct ov5645_mode_info ov5
 		.height = 1080,
 		.data = ov5645_setting_1080p,
 		.data_size = ARRAY_SIZE(ov5645_setting_1080p),
-		.pixel_clock = 167160000,
+		.pixel_clock = 168000000,
 		.link_freq = 1 /* an index in link_freq[] */
 	},
 	{
@@ -536,7 +536,7 @@ static const struct ov5645_mode_info ov5
 		.height = 1944,
 		.data = ov5645_setting_full,
 		.data_size = ARRAY_SIZE(ov5645_setting_full),
-		.pixel_clock = 167160000,
+		.pixel_clock = 168000000,
 		.link_freq = 1 /* an index in link_freq[] */
 	},
 };
@@ -1157,7 +1157,8 @@ static int ov5645_probe(struct i2c_clien
 		return ret;
 	}
 
-	if (xclk_freq != 23880000) {
+	/* external clock must be 24MHz, allow 1% tolerance */
+	if (xclk_freq < 23760000 || xclk_freq > 24240000) {
 		dev_err(dev, "external clock frequency %u is not supported\n",
 			xclk_freq);
 		return -EINVAL;


