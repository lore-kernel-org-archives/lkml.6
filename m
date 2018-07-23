Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA623ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFDB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d08syMKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFDB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbeGWOVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37256 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so694570wrd.4;
        Mon, 23 Jul 2018 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2lBRNt3VS0Qb/OG643x3L/xzzUlcGhJNVOiSivemA4I=;
        b=d08syMKrWbhuyQ9970IhjwlhgLA7QMBT4Rghe7By7+4dYVfCYx0SEaGYIgWX8cJssS
         hTrdSYQcdR5psXpwPabpu9LaqfY88W+FdwXQp3zrqr9xtpFH0jK43JPT5T6jhCplce1w
         QKTFLKin2MNSe3hDLxKw9qeua+cWpk5hkyo/3KmvGrK1ZJfp6DzqEPVzBS6sprq3JNBU
         Z7EcFHBcyW4vG48MEVL9r9LBh1C1F7UsM0gCNOoBDYMDGiN/fJ4b8WtGJ5bxQQsMj3Nn
         /szkqV0qhyNaY8yAsXCbka5QuvRr0OhTB+/mPB8RgmmKzORzgrOMxxYFjIR4HIlCe26s
         vSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2lBRNt3VS0Qb/OG643x3L/xzzUlcGhJNVOiSivemA4I=;
        b=a0tg7J/Z3eDVGa9ZnEa0FC5W7uQvcx58xEkT75QU6xhSe/p9a5daLuNl4w5hxRO22P
         OH9/UGzmG8O/k6fiR8eqpTFbobwpHvGzHswNHB1Tnz0pfNvMk9UTrb43SD5kD/pFys7g
         6ISQWrFM2Btj/sDHpH4farWkqkQDGx6a9zr9IryFq+JiXY3JE+uT5yJP8xfMZUWEcwXN
         +/g0dzCq9D+rWZm/IraP7aiC/Ey9rGvUCcc9IIAKHdGXR3OoTzPGGJGIMU//wQiyuphU
         jrS3pL1ELUB57/hnAgJ2jhMGub81sOvlnvb/MxjmTKQyvT9Dntb9s5K97TjtYyjNfRTp
         +tqA==
X-Gm-Message-State: AOUpUlEHJHqAZKdqxSNSgFiiVlF2yPFmBDr9jEx0XNd4/+SsEGYbKy32
        Z/pwZT5sgC+klGnWMYWpgHc=
X-Google-Smtp-Source: AAOMgpdqf1bNy7WuVpq1LFo1nEOSof0KqEW36uzxxNSqpPUURcys9Ow0aEPSiAjdZ1H+YNs3s4tSxw==
X-Received: by 2002:a5d:4e92:: with SMTP id e18-v6mr790091wru.32.1532352026426;
        Mon, 23 Jul 2018 06:20:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:25 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] touchscreen: melfas: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:23 +0530
Message-Id: <20180723131954.30739-7-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mip4_sysfs_fw_update);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(product_id, S_IRUGO, mip4_sysfs_read_product_id, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 430a2bc5f7ca..f7fd940e61ea 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1332,7 +1332,7 @@ static ssize_t mip4_sysfs_fw_update(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mip4_sysfs_fw_update);
+static DEVICE_ATTR(update_fw, 0200, NULL, mip4_sysfs_fw_update);
 
 static ssize_t mip4_sysfs_read_fw_version(struct device *dev,
 					  struct device_attribute *attr,
@@ -1354,7 +1354,7 @@ static ssize_t mip4_sysfs_read_fw_version(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);
+static DEVICE_ATTR(fw_version, 0444, mip4_sysfs_read_fw_version, NULL);
 
 static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
 					  struct device_attribute *attr,
@@ -1379,7 +1379,7 @@ static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);
+static DEVICE_ATTR(hw_version, 0444, mip4_sysfs_read_hw_version, NULL);
 
 static ssize_t mip4_sysfs_read_product_id(struct device *dev,
 					  struct device_attribute *attr,
@@ -1398,7 +1398,7 @@ static ssize_t mip4_sysfs_read_product_id(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(product_id, S_IRUGO, mip4_sysfs_read_product_id, NULL);
+static DEVICE_ATTR(product_id, 0444, mip4_sysfs_read_product_id, NULL);
 
 static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
 					  struct device_attribute *attr,
@@ -1418,7 +1418,7 @@ static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);
+static DEVICE_ATTR(ic_name, 0444, mip4_sysfs_read_ic_name, NULL);
 
 static struct attribute *mip4_attrs[] = {
 	&dev_attr_fw_version.attr,
-- 
2.17.1

