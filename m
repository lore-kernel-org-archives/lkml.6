Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BA5214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789570;
	bh=htANuAWMWOIIE8+dLp29M+hBE29xTwgc5JjF6H4jVco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iY/KG1F8lqJReNsm7Zv/GhsQrkvL1E85pRVrf61mL3zuOXW7ukxumfpjsZXnrJPFd
	 n9FYaWuZGYK0pvzV26vFaz2yqC9EnJNpPfyGLFMt9inomFbL38RdmMuCJnhiKycG7f
	 ugyW7T/T49UNCZRPkOuVcZzD1LqpmyEMMW4iqChk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BA5214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeLNMMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731653AbeLNMMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC690214DE;
        Fri, 14 Dec 2018 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789564;
        bh=htANuAWMWOIIE8+dLp29M+hBE29xTwgc5JjF6H4jVco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nc1bLzINjdazVaXYSB6kLqxmLBFm1mcQZmvi9fFnBzN6+qHdqKdpcbfxYwmk/BjNx
         GYiKX2S8agY3UfmwTgBQeNkOYSNmV+XL/bJ1iMtZBSENETiO8w+xUZLCGbfMwzrnHR
         CPFsIfQdttGCtWgXgGETerjY+eb293kUBq+wMKnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Wang <wangyao@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/51] hwmon: (w83795) temp4_type has writable permission
Date:   Fri, 14 Dec 2018 13:00:22 +0100
Message-Id: <20181214115715.287478698@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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



