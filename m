Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA41C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121BC21934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405052AbeLVU1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 15:27:49 -0500
Received: from sauhun.de ([88.99.104.3]:52654 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388396AbeLVU0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 15:26:34 -0500
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
        by pokefinder.org (Postfix) with ESMTPSA id E27E42E3560;
        Sat, 22 Dec 2018 21:26:31 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 1/9] PM / core: add helper to return suspend status of a device
Date:   Sat, 22 Dec 2018 21:26:15 +0100
Message-Id: <20181222202623.4521-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C core would like this to reject transfers on an already suspended
adapter.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..e63d3e06989f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1138,6 +1138,11 @@ static inline int device_is_registered(struct device *dev)
 	return dev->kobj.state_in_sysfs;
 }
 
+static inline bool device_is_suspended(struct device *dev)
+{
+	return dev->power.is_suspended;
+}
+
 static inline void device_enable_async_suspend(struct device *dev)
 {
 	if (!dev->power.is_prepared)
-- 
2.19.1

