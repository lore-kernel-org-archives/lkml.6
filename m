Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394D92190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CNZTfTOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391529AbeLUTBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:01:44 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48830 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbeLUTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:01:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id CEB7818B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 19:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cGRMHzKRbBIO for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 13:01:41 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id A3ED3A28
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:01:41 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id x2so5242183ioa.23
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6InnuRFs/3FtDVfZcg8HTqgLbg/1l83RdmNhdBlAH2c=;
        b=CNZTfTOVC797hPAfWnicdd9K0lk0nPCwzpJAbS/WLqaoSYNpdJxc/8ejTSgScLwLp0
         iD1Y4kmjvKlg5bFX+YSktJlejfAbvKK3RoOpIOdKEWw9j5e+WbXnE7TD6398MtoKGtL5
         E0DXXR6gLbWpW2hoqVgiWQQbOkyCq4L2p84SMAeaGJRBT6kColm7f3arev+l8MgKserp
         aTK2kyGUHBhXlR7pSWwEnJRkAm1bs78ztQ6YgYsXDM1Tz8aUtCROvTMEjlCMlfaha/xW
         eXlcaNYQZmumMTowcz7oRi1oXjydcaxX3aEnLuJcg30o0gxE1VRN92OdkfviuXikwqZY
         zoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6InnuRFs/3FtDVfZcg8HTqgLbg/1l83RdmNhdBlAH2c=;
        b=lLxcdoTYrv9XTiISKjlvm5oyWbBEZLKCSaMjhyJ9aZIzs+1jJ/qZAenMbbeH6YKfmw
         X77kkCGGzOMZUv9FNHLO5Hczp+tNgke79TzDmz4HwXNLhQpzE532TUn2WMQoC+AwjcJu
         l5tP/EK/WwUXsftrSv00WCgENYnyoDYL4WccC2JWDwVNYC5EBMyf4Nfh38xYa2Whnmno
         PYJLYrNTSsQQivuWqGYDq36c8ApM9sPCvlMNuULB3WIS3/lkvPPQl3524FKGYRkuWCU8
         9T0zKTYf7d9DSucd4ru/5mV4VQuznTmmppWD8u/7saldek/gO9KDaYBJdY3VowG83VHL
         HGKQ==
X-Gm-Message-State: AA+aEWZJKu6TRVz/4bR3pGOGvr38vP8Z04Uc21itBxXyBqpmEvrcWrdH
        Bf2C+Q7Lf0bhNlOGJ1XoBkvKOiaHnfK+S+ysHxKGowrVkrTKdQMzxAXi7iUn5XJldAE+vUtwOaE
        2OJXkjz2hoR9UhcDR2BEA7pYQQtoI
X-Received: by 2002:a05:660c:914:: with SMTP id s20mr2720889itj.160.1545418900548;
        Fri, 21 Dec 2018 11:01:40 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UV8bf+b+66HjA5MSGCKflez99dtnv79nwDx8y8t4lV+yPgPRIa4vvqDd0vgj7GpYu38LxPcg==
X-Received: by 2002:a05:660c:914:: with SMTP id s20mr2720856itj.160.1545418900038;
        Fri, 21 Dec 2018 11:01:40 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id m37sm6723175iti.6.2018.12.21.11.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:01:39 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (lm80) fix a missing check of the status of SMBus read
Date:   Fri, 21 Dec 2018 13:01:33 -0600
Message-Id: <20181221190134.930-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If lm80_read_value() fails, it returns a negative number instead of the
correct read data. Therefore, we should avoid using the data if it
fails.

The fix checks if lm80_read_value() fails, and if so, returns with the
error number.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hwmon/lm80.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 08e3945a6fbf..d91333557f04 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -360,6 +360,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = data->client;
 	unsigned long min, val;
 	u8 reg;
+	int rv;
 	int err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
@@ -390,8 +391,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	reg = (lm80_read_value(client, LM80_REG_FANDIV) &
-	       ~(3 << (2 * (nr + 1)))) | (data->fan_div[nr] << (2 * (nr + 1)));
+	rv = lm80_read_value(client, LM80_REG_FANDIV);
+	if (rv < 0)
+		return rv;
+	reg = (rv & ~(3 << (2 * (nr + 1))))
+	    | (data->fan_div[nr] << (2 * (nr + 1)));
 	lm80_write_value(client, LM80_REG_FANDIV, reg);
 
 	/* Restore fan_min */
-- 
2.17.1

