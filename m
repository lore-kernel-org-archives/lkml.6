Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038DDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B999D23FD6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkRfxKsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B999D23FD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbeLNNW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45111 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLNNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so4224896lfa.12;
        Fri, 14 Dec 2018 05:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KVQAMYtSk3kTC8WUhk9uJTZ+iHzEPKOa2DOw3MKqAw=;
        b=hkRfxKsM1mpK6uF+LIOJZQXQdEh6bAgVtoczOPFH8HDy3POU4V/o77NyHerSnCDnpB
         zDy2JsGyiW7+/dbkojQIHh23cOD/thplXG5Vkuwy5Yudph+0Jm9QBTIyJ3LCI9ZoFQKU
         Ia9OLBB4MkZigrvd9lZO254NdXtFScPnq1ISt92AOj41omxMZHLXYbf5pseD/wt8pJC9
         acW5xATBLymdR8aKLFlEGeW02rFSXZxumo8+OGBJRa3oNwNx60Fdcp0ySSeCz353gsFW
         1Qboam3z5jcG5fg6RQcKoXtoMNEiwkpmuFHa1dJUazNHXjuJmO6JgPKotmrdsMAhFGjR
         IPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KVQAMYtSk3kTC8WUhk9uJTZ+iHzEPKOa2DOw3MKqAw=;
        b=H9+kNNdSLEV5DzNQLby1ldHFY7VlB6hXqyWvOsJW5iWFAJjMPS+RlODF5BWYoGUGI3
         0IO6cjbgVY+GHzWBILC/HMv0Zd6WbAtiPsyA3/FDTfaPGAzdURciw7UmbLuSaYd/Xig5
         bclk32Y3OiveAXRXVXcSsXhHakIL0yS3r+PjqVguPVs80iS8rzSqscRXJj4xDId4i+4c
         Ap39T9wHGw6TQhpVZoCyrJ/xUQNXtFjczpMKZdXNmlkpeggzgO0LHQIcSsp0nM+6jR1I
         rHh4WUTaERlfyFqTdBjsVboEOElJygs/IUaNRw4rJGnGBNzruGj414xdFZm7fJuQxibA
         UBFg==
X-Gm-Message-State: AA+aEWZmTpX7M0Gdm7IWUKfYSuRlZa/GuWdRgJu2PjxsACrP0dvFbezQ
        0ZimQCg34AfvIQLmGCD5UWT/V24r9OinbgYY
X-Google-Smtp-Source: AFSGD/VSJMS/sJg8k9EHGpxVbOa1MrN5P4dykUHL2wh6wQf27U+Gn9DvrxPXpaDrUqrm/MctUvjHew==
X-Received: by 2002:a19:9653:: with SMTP id y80mr1828139lfd.66.1544793741773;
        Fri, 14 Dec 2018 05:22:21 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:21 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 1/6] scsi: hpsa: Add function to check if device is a disk or a zoned device
Date:   Fri, 14 Dec 2018 18:21:10 +0500
Message-Id: <20181214132115.21440-2-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check is used multiple times within the driver. New function makes
conditional statements a bit shorter and more readable.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/hpsa.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c9cccf35e9d7..fc06b790f16b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -768,6 +768,11 @@ static ssize_t sas_address_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%016llx\n", sas_address);
 }
 
+static inline bool is_disk_or_zbc(const struct hpsa_scsi_dev_t *hdev)
+{
+	return hdev->devtype == TYPE_DISK || hdev->devtype == TYPE_ZBC;
+}
+
 static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
 	     struct device_attribute *attr, char *buf)
 {
@@ -788,7 +793,7 @@ static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
 	offload_enabled = hdev->offload_enabled;
 	spin_unlock_irqrestore(&h->lock, flags);
 
-	if (hdev->devtype == TYPE_DISK || hdev->devtype == TYPE_ZBC)
+	if (is_disk_or_zbc(hdev))
 		return snprintf(buf, 20, "%d\n", offload_enabled);
 	else
 		return snprintf(buf, 40, "%s\n",
@@ -855,8 +860,7 @@ static ssize_t path_info_show(struct device *dev,
 				PAGE_SIZE - output_len,
 				"PORT: %.2s ",
 				phys_connector);
-		if ((hdev->devtype == TYPE_DISK || hdev->devtype == TYPE_ZBC) &&
-			hdev->expose_device) {
+		if (is_disk_or_zbc(hdev) && hdev->expose_device) {
 			if (box == 0 || box == 0xFF) {
 				output_len += scnprintf(buf + output_len,
 					PAGE_SIZE - output_len,
@@ -1715,8 +1719,7 @@ static void hpsa_figure_phys_disk_ptrs(struct ctlr_info *h,
 		for (j = 0; j < ndevices; j++) {
 			if (dev[j] == NULL)
 				continue;
-			if (dev[j]->devtype != TYPE_DISK &&
-			    dev[j]->devtype != TYPE_ZBC)
+			if (!is_disk_or_zbc(dev[j]))
 				continue;
 			if (is_logical_device(dev[j]))
 				continue;
@@ -1770,8 +1773,7 @@ static void hpsa_update_log_drive_phys_drive_ptrs(struct ctlr_info *h,
 	for (i = 0; i < ndevices; i++) {
 		if (dev[i] == NULL)
 			continue;
-		if (dev[i]->devtype != TYPE_DISK &&
-		    dev[i]->devtype != TYPE_ZBC)
+		if (!is_disk_or_zbc(dev[i]))
 			continue;
 		if (!is_logical_device(dev[i]))
 			continue;
@@ -3965,9 +3967,8 @@ static int hpsa_update_device_info(struct ctlr_info *h,
 			scsi_device_type(this_device->devtype),
 			this_device->model);
 
-	if ((this_device->devtype == TYPE_DISK ||
-		this_device->devtype == TYPE_ZBC) &&
-		is_logical_dev_addr_mode(scsi3addr)) {
+	if (is_disk_or_zbc(this_device) &&
+			is_logical_dev_addr_mode(scsi3addr)) {
 		unsigned char volume_offline;
 
 		hpsa_get_raid_level(h, scsi3addr, &this_device->raid_level);
-- 
2.19.2

