Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37ADC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E61208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790822;
	bh=foQS5oF8pMRFG3QKpM7jbWLMCgaqs0qEPrRyZqH4SSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kcrzx+Q3BdlAB4gmGQhRTaO8LY7NudURET7+gjhiMu7waj2g4BpoaaJYC9NNrXi71
	 PpbEnUX11qOKnYf/nTCJgPtqCwW3oxSTBPERdiEBmhQWs+H7qdNwTAxJhexedK3my2
	 d7jspUd1QuJX4qSn8LRpHbVqZdwT7ukQvWEDl5wE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E61208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeLNMdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbeLNMI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B4B214C4;
        Fri, 14 Dec 2018 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789307;
        bh=foQS5oF8pMRFG3QKpM7jbWLMCgaqs0qEPrRyZqH4SSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QG8rE9D0qKeztzCPRglgdB7rjDsPsIYzy9u8NmvulkyQUbPggpkDRc2duriVYNOoq
         XoTOba3QYJh8ZuhPlVDRILaBMS26sKck6llhiTQ9WFHMY7AE5bJso7pR7v2JDCHEre
         0/jpass6WXkcKnPadSc2pGSe0WZMo96UNBj/Uw80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Wang <wangyao@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 32/89] hwmon: (w83795) temp4_type has writable permission
Date:   Fri, 14 Dec 2018 12:59:45 +0100
Message-Id: <20181214115731.271134014@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



