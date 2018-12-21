Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E16F2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="SphlE1vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbeLUTKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:10:49 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53852 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbeLUTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:10:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1735FCBA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 19:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TMX1ROehLsg3 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 13:10:46 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id DF16ECCC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:10:46 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id u2so5302740iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yy2/4a+ag6m7ATAsbo+6+iGfjYwWjT+Z5BCSnIA0FJE=;
        b=SphlE1viJQPCKS9vzHNT97u3mU0UUw+7JFpMYHTQypzwYPfgRCpw8DfORPcloev60C
         T16WNTrqqkXMwo6cMYVcqQNs5LAzuSxia3l1E/2N7satIkmJGJrXxic5gAfHer1pkr2d
         TMwvWexqxxPTwlEJJaqlJA0MepTzRLgrj7RHeSK3kwVETvGkSia6BHKkphdfV+1qLGgP
         B1YHO31WRBipgt+Uiv9Yxc9pC0XPa5LXzN8pAXdB3hXQ5k7YuaoDTM7feWk5DcDOJihw
         Rb4fJhlmP458vDFLK2WLz9eIZ30EFSpdlq5vcB3NGB/kZ+yppDOT1/r4/hiJSrJhsFMP
         Xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yy2/4a+ag6m7ATAsbo+6+iGfjYwWjT+Z5BCSnIA0FJE=;
        b=eQdiR91oNkcM7qwjJ8Ru6wutgXdBRIrbLGtKjEe+sjTC84faeetAhPzBCNvrO9WQCf
         BYpXhc4Ms50p8bQaIKDXcaBmQNsZKSHLXBpibOaLScppf+lAdNl3hbFM3YS66BeYjudM
         ICZzkt7DBKFgavK8TQrmX2zgetr7vUAlTQgmWEr6Pr01+h9nnQNP3nk4sIyRLhoplN58
         /Pi3804xmo1M7p6hK2qr8g0laSjwNf6VbdE7U8vTphYM5VRrUuNmAk1G7ff3Qf18YtFm
         rZlaJVDnaV0d5tdTOgVFr8xek45/Up7hW2wMyJFQDhh2C+zEG8DHPmZI/l9i7XuoX3cL
         p0TQ==
X-Gm-Message-State: AA+aEWaKEi/WqwdQUIOSMnx8GP+cZZg9Rxg6dLxakmHW3tLqkUwmEIf4
        Ldd7JbZpg7zYbJxn5LtLUk1t0m5ZIlJC03qCC3VXKMWFW1TzYZ/IQ9wwn3rzFG6ap0tBv+QUsqc
        og989F/mOTWRz+G+HcVj+X27q/EFu
X-Received: by 2002:a02:1885:: with SMTP id 5mr2543511jar.110.1545419446237;
        Fri, 21 Dec 2018 11:10:46 -0800 (PST)
X-Google-Smtp-Source: AFSGD/U6b9FsC3mfRmMpH52tiHgYujKHtFvPkHksUlnEn9vcbrn1r8tvQZ7UV8B8gezUQHYkhcXZEw==
X-Received: by 2002:a02:1885:: with SMTP id 5mr2543469jar.110.1545419445145;
        Fri, 21 Dec 2018 11:10:45 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id h8sm585454ioj.9.2018.12.21.11.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:10:44 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (lm80) fix a missing check of bus read in lm80 probe
Date:   Fri, 21 Dec 2018 13:10:39 -0600
Message-Id: <20181221191039.1519-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lm80_probe(), if lm80_read_value() fails, it returns a negative
error number which is stored to data->fan[f_min] and will be further
used. We should avoid using the data if the read fails.

The fix checks if lm80_read_value() fails, and if so, returns with the
error number.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hwmon/lm80.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index d91333557f04..85f797501aaf 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -627,6 +627,7 @@ static int lm80_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct lm80_data *data;
+	int rv;
 
 	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
 	if (!data)
@@ -639,8 +640,14 @@ static int lm80_probe(struct i2c_client *client,
 	lm80_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
-	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+	if (rv < 0)
+		return rv;
+	data->fan[f_min][0] = rv;
+	rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	if (rv < 0)
+		return rv;
+	data->fan[f_min][1] = rv;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, lm80_groups);
-- 
2.17.1

