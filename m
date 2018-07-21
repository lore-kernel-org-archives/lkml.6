Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D83ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C0620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIsGJzuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C0620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeGUUEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46727 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so14098238wra.13;
        Sat, 21 Jul 2018 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lTo2MlEG2+LXPVqtHWbj85T6ZaBnPlWK9eJyQLqBpgI=;
        b=rIsGJzuQwzrjCEsHX+ZuyNH4AjeucEs3XX7febsA2713nisDzEv6gu8gW+CYtK/8z7
         yEMm+jCexdo9mlFblPuYkCcU/rOB5O/a6QX1Q0c5UiCRuldG3Tw/ze57KT9Ycb93t4dE
         hlwO9grP+W237UDakawlfXDRs9Tbo4OGLgRFUS5cuf4yisuwxgxWI4HmaiKB3KYeY+e2
         NvZ15FxwvtDN7eoylTY9OpNGAnZFGYqgmIOkJIbFd0zsvLMNWY2AuzE7Dr15gtfkpc00
         Sr+WEQ+6bK/vLqjijrv6V4b+IqmXxbXca4TxztSnwDWXcZtIT1KzyvDqhcgaVu5Hytyu
         Wl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lTo2MlEG2+LXPVqtHWbj85T6ZaBnPlWK9eJyQLqBpgI=;
        b=TV58ooWZl1LdTVAIVzDTWl/gTGDhSCh4NcotWUaLqMHNnIeckJC0SLnQUttjwSOLKy
         bdN6mnSsfGcPX/IJ2EktffrlgPBBNk8WU6iRyg/x5s8IZ8eJ8naOp0V3rKLpgfatiO9f
         JYqhg7/QSMg0Qd7pIYX98xO0B+qfpIK/BBDp8Nqbhis7sDp2Id7d9c3Z0Tj62u1obfmt
         /oC7WBwE4ZhQZChCifCcr9R3XjStEOd5SIUrJzStkTtnx25RmYGYsQ3zgIk7VFhJBG0k
         E3/rUIRCkEM8oejwftjh4NPVnJX2oU2s/vgxmIxby5J2SH4sqU3xaot60rhbWeXxCjpE
         8ODw==
X-Gm-Message-State: AOUpUlF4wyK562Via12Y2fqbMxadQnSVwzcqSysq22I8ll5hbXYfNnRv
        H6GJxc3ou9g4iCLubgvVpwg=
X-Google-Smtp-Source: AAOMgpeQvGu5QkeuTZbP9wPzz5DpP6Wd9CdCBICYblRvf++mHhxgW/uo4sXSpqWWK3iZMcTBYk9yGg==
X-Received: by 2002:adf:ab14:: with SMTP id q20-v6mr4372572wrc.239.1532200255668;
        Sat, 21 Jul 2018 12:10:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:55 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] touchscreen: melfas: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:48 +0530
Message-Id: <20180721191029.25658-7-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
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

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
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

