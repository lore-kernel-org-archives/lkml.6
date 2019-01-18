Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D7F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt/puWrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfAROEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfARODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so15273423wrw.1;
        Fri, 18 Jan 2019 06:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUYEzC/vmFZgItCQvOymRNmQxHG9/z8q+s/lyY68E14=;
        b=Wt/puWrCW+zAnEqKzUdMLeqWq0K7shRYilkopyRSSqaUG4WD0389NBCYrRjlDfcCo8
         PunE6m8ZlvUeBnF6nYo8Y5cS7V0VHtsuYwi4o2vDXMfGUOMSePuM9Im5A2lcvELb8THQ
         x9W+9nDjRv8wyh1+o+4To17CF6RfbuY5F4LAh4j4Y39KzEh1YeqIZ9VO7a4tsrdKj4LK
         uRq04YKa2g4+PNv26eOsPVXlREjV++skVvTRKKEnZynNPQPVbRntE/vFgq9GcVTy8CSo
         4GrIxdLRy+ZZn0Qhp0A2YHI0gBUDkUeUUBId5BkHlFfHTC7wz7B/qT3I5Uj+ttCdetNk
         k6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUYEzC/vmFZgItCQvOymRNmQxHG9/z8q+s/lyY68E14=;
        b=d2y+qJ4NM71TDbHG0KGcFmAJgeddQpxsAfg86rhf4MUi/JSz3QZa8GmOHlS4OUZvz5
         8sJs2Quvoj3IqfqUTdBC/Wffsb2Co3HmwEd27jiRlummW7eVrawr76vOibkCEVTpx7Ic
         oOOGbPISSI3uy9/w/uEqnCDtbxxGMsWBfHjZKNX6gPX7Xdp8o96nD6FJcS1MgvUv+i+N
         7k5OSRS37nqmUQZoDgBgtwxw9IreNhF7AdQJXvc7Wg1B8Ru3VM/OM1WkKFrO/6kutQuc
         ogsJidUEd6+t4Oe/5nCIuW95ahlfQYmtmmNz3/DKHJzAnKcv5nnO3OEgGXutDcxMDZXT
         /o8Q==
X-Gm-Message-State: AJcUukfZ0PP/BmPDLW6dXI8KMBZDASjwFh6T08n8tgdjG/bFYEk+kXoG
        pf3nNVr+EZYLLkfsJw2YM4c=
X-Google-Smtp-Source: ALg8bN7H25nEZBKyEMbp24Ela+aOF+2ayivG3+FpXe7s5pVbXj8dKkkOzdlhrQFax49TKGoc+F7eqw==
X-Received: by 2002:adf:b201:: with SMTP id u1mr16428812wra.165.1547820219274;
        Fri, 18 Jan 2019 06:03:39 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:38 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 3/7] hwmon: adm1029: replace S_IXXX macros by their numeric values
Date:   Fri, 18 Jan 2019 15:03:25 +0100
Message-Id: <20190118140329.18970-4-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested by checkpatch, this patch replace S_IXXX macros by their numeric values.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 381bfae6b04b..092f16ad774f 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -250,32 +250,27 @@ static ssize_t set_fan_div(struct device *dev,
 	return count;
 }
 
-/*
- * Access rights on sysfs. S_IRUGO: Is Readable by User, Group and Others
- *			   S_IWUSR: Is Writable by User.
- */
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+/* Access rights on sysfs. */
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, 0444, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, 0444, show_temp, NULL, 2);
 
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp1_max, 0444, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp2_max, 0444, show_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp3_max, 0444, show_temp, NULL, 5);
 
-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO, show_temp, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO, show_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp1_min, 0444, show_temp, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp2_min, 0444, show_temp, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp3_min, 0444, show_temp, NULL, 8);
 
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan1_input, 0444, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, 0444, show_fan, NULL, 1);
 
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO, show_fan, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan1_min, 0444, show_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan2_min, 0444, show_fan, NULL, 3);
 
-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-			  show_fan_div, set_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-			  show_fan_div, set_fan_div, 1);
+static SENSOR_DEVICE_ATTR(fan1_div, 0644, show_fan_div, set_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, 0644, show_fan_div, set_fan_div, 1);
 
 static struct attribute *adm1029_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
-- 
2.19.2

