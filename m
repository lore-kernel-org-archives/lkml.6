Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B45C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D162151B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789695;
	bh=LMSBCyueGi12ARYSytMibU2Y9n/7lz796ZXFrP+9uqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U5nZRtEPoWpBd08P4NzmUpwsB6lWpWzpR/3QKDHAqXY0V+5X+GOB221qMY9anwJBC
	 EOpHmwd3xx3UExObxMEyDgZYN0S6rtIyUsJlhCNjYdam0CnU4ZdOAky+vyMR+YGgNT
	 Q2GbLA7dpMNaXq6H+CYzc5uVvjBWvTD/L9pbqfvY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D162151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeLNMOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeLNMOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DF0214F1;
        Fri, 14 Dec 2018 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789689;
        bh=LMSBCyueGi12ARYSytMibU2Y9n/7lz796ZXFrP+9uqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9ZHtM1/xiAp5pjXCK7tj3phk+BR11zLodcSurW/MxA7/O8ZSnmaYAfAOiFGxMgOW
         iec04tYU4qB9y7oMeVqZumnAwXbOterfE1wGSuBaSa1J1aBsF+AYKgWGrRckB07CQ7
         hY7RL9bfX3KA0a/2uq+YxsTb1S4cBV67x2Eg1qvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Wang <wangyao@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 16/88] hwmon: (w83795) temp4_type has writable permission
Date:   Fri, 14 Dec 2018 12:59:50 +0100
Message-Id: <20181214115703.464186318@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 49276bbdac3d..1bb80f992aa8 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -1691,7 +1691,7 @@ store_sf_setup(struct device *dev, struct device_attribute *attr,
  * somewhere else in the code
  */
 #define SENSOR_ATTR_TEMP(index) {					\
-	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
+	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 5 ? S_IWUSR : 0), \
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
 		NULL, TEMP_READ, index - 1),				\
-- 
2.19.1



