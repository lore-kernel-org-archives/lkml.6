Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeBUJ1e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:27:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44642 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeBUJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:23 -0500
X-Google-Smtp-Source: AH8x225zdJDV+pGJyM4eLJWhg5j6kWOFUcR56+Vofx8XF6M74WmSHPD4Q9BPa6re9/MrW9jJg+QJAg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 12/20] lightnvm: complete 2.0 values in sysfs
Date: Wed, 21 Feb 2018 10:26:50 +0100
Message-Id: <1519205218-26994-13-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing geometry values to sysfs. Namely, maxoc and maxocpu.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 70dc4740f0d3..88c71d0d0d8c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1059,6 +1059,10 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_min);
 	} else if (strcmp(attr->name, "ws_opt") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_opt);
+	} else if (strcmp(attr->name, "maxoc") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxoc);
+	} else if (strcmp(attr->name, "maxocpu") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxocpu);
 	} else if (strcmp(attr->name, "mw_cunits") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mw_cunits);
 	} else if (strcmp(attr->name, "write_typ") == 0) {
@@ -1158,6 +1162,8 @@ static NVM_DEV_ATTR_20_RO(chunks);
 static NVM_DEV_ATTR_20_RO(clba);
 static NVM_DEV_ATTR_20_RO(ws_min);
 static NVM_DEV_ATTR_20_RO(ws_opt);
+static NVM_DEV_ATTR_20_RO(maxoc);
+static NVM_DEV_ATTR_20_RO(maxocpu);
 static NVM_DEV_ATTR_20_RO(mw_cunits);
 static NVM_DEV_ATTR_20_RO(write_typ);
 static NVM_DEV_ATTR_20_RO(write_max);
@@ -1175,6 +1181,8 @@ static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_clba.attr,
 	&dev_attr_ws_min.attr,
 	&dev_attr_ws_opt.attr,
+	&dev_attr_maxoc.attr,
+	&dev_attr_maxocpu.attr,
 	&dev_attr_mw_cunits.attr,
 
 	&dev_attr_read_typ.attr,
-- 
2.7.4
