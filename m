Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB077214F1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g22DLIFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB077214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeLEJzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbeLEJzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:55:33 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F7220661;
        Wed,  5 Dec 2018 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003733;
        bh=eHP0HQ+EF6MmSWj9H37qXKHUQCq/JdTfPOVMz5nWSh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g22DLIFD2agg6724TmNU24jdJ0aSUmbyLwOiG94E+RaJ1cs4B233spX8Sy4bb4VsG
         JDUTMrl15cgSKjvMQTUN4IejN1VI5aDynIux8fOQGNC4d6nk6usjiZzBEJPAMbGXAw
         QmzFX8vVWR2y4X+ztffjvPhBVZDQzoiFj9x8s8RY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 05/26] hwmon: (w83795) temp4_type has writable permission
Date:   Wed,  5 Dec 2018 04:54:09 -0500
Message-Id: <20181205095430.8019-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095430.8019-1-sashal@kernel.org>
References: <20181205095430.8019-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

[ Upstream commit 09aaf6813cfca4c18034fda7a43e68763f34abb1 ]

Both datasheet and comments of store_temp_mode() tell us that temp1~4_type
is writable, so fix it.

Signed-off-by: Yao Wang <wangyao@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Fixes: 39deb6993e7c (" hwmon: (w83795) Simplify temperature sensor type handling")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/w83795.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 21894131190f..9b838fff7e4d 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -1693,7 +1693,7 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
  * somewhere else in the code
  */
 #define SENSOR_ATTR_TEMP(index) {					\
-	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
+	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 5 ? S_IWUSR : 0), \
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
 		NULL, TEMP_READ, index - 1),				\
-- 
2.17.1

