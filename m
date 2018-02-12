Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeBLW7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:59:03 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37521 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeBLWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:17 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 04/45] rtc: nvmem: disallow registering nvmem more than once
Date: Mon, 12 Feb 2018 23:47:18 +0100
Message-Id: <20180212224759.15999-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make rtc_nvmem_register return -EBUSY when an nvmem is already registered
for that RTC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/nvmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 293df6db7c42..fd1c39a5ade5 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -87,6 +87,9 @@ static void rtc_nvram_unregister(struct rtc_device *rtc)
 int rtc_nvmem_register(struct rtc_device *rtc,
 		       struct nvmem_config *nvmem_config)
 {
+	if (!IS_ERR_OR_NULL(rtc->nvmem))
+		return -EBUSY;
+
 	if (!nvmem_config)
 		return -ENODEV;
 
-- 
2.16.1
