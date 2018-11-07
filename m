Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3AAC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E2208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdAfYxZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5E2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbeKGL7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:59:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38659 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbeKGL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:59:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so7036333pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 18:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3EDKXwN0De2kNox+NL7O+gpdxFmlBR5WE3wKL9s5VG8=;
        b=DdAfYxZgSkn8D7VvRe0PjdD8zypD5ZgtfwtiR48IVNd5WqsBrPIoQFLOCHpcpx8wIy
         ZY3YVpiFWMZBE5dlzYAoS2RmL6L4uFPmAweQddyVL6r3v+5vIlD2qyozsRCKk6JdrVEg
         Csd1OguiIxdsooqAfd2qwSV83rELBOgI5swZR0kx2rftG8lcaxvNSXcJ2qMBBAgJRChT
         9eFhi9GyIT6cS4p/3Fuuve3t38sGuR295LP3nXp+k0Uqk0/B/RSPuZbhqtSnXqBpxBhk
         5EAH1+TFgA20k3B8JgdPxyYUpadw9lpIW3siPkp2etU+TefGSi7RDH/wr38uipLPwinJ
         VkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3EDKXwN0De2kNox+NL7O+gpdxFmlBR5WE3wKL9s5VG8=;
        b=dc+kQHQQLj7xap2C0WozNjyzwUdR1t5/Le/R4xbDqqgBA509b28sfzNHxjGe7gRtSM
         sk89qcf4CTZrsIGyXGed6WWj+KjBwvNVH46U0njj0wlb3A5gOy0mhY5LI11XFgJ5HG0J
         andemZapYGapmspoWZBM41ou4PCJYimiadgnmxPK69UrVuEJqeXJVBJQIR2dDfmg++fH
         5Wc7mH2cEJrwiOI6qfvWqKkb6M7RIhvx+I7LukO9bELVx/tIlJGlrJolSVXwa67c4RxU
         gJiTIPjJnlpGLmlTjdqTt2KNv5L1bPYEzPitW7yUrRcVpgJ6M11c4QDoyNLS4kvdT7Gb
         uCtA==
X-Gm-Message-State: AGRZ1gK1eN0kOwMPO5ZzwJmk02ZlVv4muz38INjaBHUVJCdlepmIzkvt
        AsJfNRIqBCZe292QavKfkvk=
X-Google-Smtp-Source: AJdET5erY7L2cmxRk+Zt9MaS5Wvy2HjeXqUeLN0+vKgVb6SLZ0S1tB4lcYOG0A/nVwcvYEFfPvB2Hw==
X-Received: by 2002:a62:96db:: with SMTP id s88-v6mr58785pfk.109.1541557847976;
        Tue, 06 Nov 2018 18:30:47 -0800 (PST)
Received: from ubuntu ([210.200.12.126])
        by smtp.gmail.com with ESMTPSA id m20-v6sm59035351pfj.171.2018.11.06.18.30.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 18:30:47 -0800 (PST)
Date:   Wed, 7 Nov 2018 10:30:43 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, astrachan@google.com,
        ghartman@google.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for examining
 the permissions of regions.
Message-ID: <20181107023043.GA18052@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a attribute called permissions under vsoc device node for examining
current granted permissions in vsoc_device.

This file will display permissions in following format:
  begin_offset  end_offset  owner_offset  owned_value
            %x          %x            %x           %x

Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/android/vsoc.c | 48 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 22571ab..8ce3604 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -128,9 +128,10 @@ struct vsoc_device {
 
 static struct vsoc_device vsoc_dev;
 
-/*
- * TODO(ghartman): Add a /sys filesystem entry that summarizes the permissions.
- */
+static ssize_t permissions_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+static DEVICE_ATTR_RO(permissions);
 
 struct fd_scoped_permission_node {
 	struct fd_scoped_permission permission;
@@ -718,6 +719,37 @@ static ssize_t vsoc_write(struct file *filp, const char __user *buffer,
 	return len;
 }
 
+static ssize_t permissions_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buffer)
+{
+	struct fd_scoped_permission_node *node;
+	char *row;
+	int ret;
+	ssize_t written = 0;
+
+	row = kzalloc(sizeof(char) * 128, GFP_KERNEL);
+	if (!row)
+		return 0;
+	mutex_lock(&vsoc_dev.mtx);
+	list_for_each_entry(node, &vsoc_dev.permissions, list) {
+		ret = snprintf(row, 128, "%x\t%x\t%x\t%x\n",
+			       node->permission.begin_offset,
+			       node->permission.end_offset,
+			       node->permission.owner_offset,
+			       node->permission.owned_value);
+		if (ret < 0)
+			goto done;
+		memcpy(buffer + written, row, ret);
+		written += ret;
+	}
+
+done:
+	mutex_unlock(&vsoc_dev.mtx);
+	kfree(row);
+	return written;
+}
+
 static irqreturn_t vsoc_interrupt(int irq, void *region_data_v)
 {
 	struct vsoc_region_data *region_data =
@@ -942,6 +974,15 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 		}
 		vsoc_dev.regions_data[i].device_created = true;
 	}
+	/*
+	 * Create permission attribute on device node.
+	 */
+	result = device_create_file(&pdev->dev, &dev_attr_permissions);
+	if (result) {
+		dev_err(&vsoc_dev.dev->dev, "device_create_file failed\n");
+		vsoc_remove_device(pdev);
+		return -EFAULT;
+	}
 	return 0;
 }
 
@@ -967,6 +1008,7 @@ static void vsoc_remove_device(struct pci_dev *pdev)
 	if (!pdev || !vsoc_dev.dev)
 		return;
 	dev_info(&pdev->dev, "remove_device\n");
+	device_remove_file(&pdev->dev, &dev_attr_permissions);
 	if (vsoc_dev.regions_data) {
 		for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
 			if (vsoc_dev.regions_data[i].device_created) {
-- 
2.7.4

