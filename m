Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELtJUkNuX1WbT0NL/g79k5G6kmjkB/9J/PLcWbcoC8Ssp9F7/EZcYVAlUKHD5S72mxiWKpP5
ARC-Seal: i=1; a=rsa-sha256; t=1522137956; cv=none;
        d=google.com; s=arc-20160816;
        b=H0NTY+lq1K67EbXkyb9mD6JeOxMyIA57qnDXk4kHgxewg/N82TxWOWithDnjbnAVKG
         xSkPojMVaVys+vhlgkzj15njsKLATlqRMEK8RrlEspZYGt9+6QwymlN64hgqO/I4VBz1
         McGX9+9x3IT132s5cx1HkUfOLs9+w4+RDEWXbo0JgULawYetBpnBhBbjkiuDf+6d7OYD
         9WR5H9MsTF5xAuWB8j9knvCuBqxNdbgQddAh7pB2B+DaizTdhxIdZjRSg/XicpN6C7TJ
         BxYMWyCH82WZ85AKiZgWUc0o/vgDK0yuNIlIQeJ2rCVXPpQz19UeRyX/3neK0d1ih0uY
         yXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ziApIQPGObgMrbdOiDgYqAPYtjXAlc7BiRr65vOGABw=;
        b=nvjBJfgO+BiHYWUYL0XbibCZcduwXc+TTFWm0IbU0awWZH5stfW19jfTlrQUNl6JGn
         DnGMEw8sSo1hDiDFqRp5C2Yd3NIVo/Kye6OPs9+bFhQZsw3V4tEnpT6R7gIGKjt5UIIY
         9Go3gluiXeA5ML7NUHcCAt9Gc0CqL1awLVXnIY9gzl5vSsSASSDIw1/poEwzY+bSwAnF
         NLsffBVT2NxJE7EN8zRL2Ujv1D/3Dy4bP1ncmeeNFPJNuO/QoxjjCBKpS7VvqkCQPwHL
         Qh6p8pWDbl9r7bweyMVA2APDHV4odomfa+W8iS4g2B2qZnSao3WA4n+RMquVQTUV2Sik
         CKug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 2/7] platform/mellanox: mlxreg-hotplug: Document fixes for hotplug private data
Date: Tue, 27 Mar 2018 10:02:02 +0000
Message-Id: <1522144927-56512-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077329860971189?=
X-GMAIL-MSGID: =?utf-8?q?1596077329860971189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add missing description of dev, regmap, dwork_irq, after_probe in struct
mlxreg_hotplug_priv_data.

Remove dwork field from the structure mlxreg_hotplug_priv_data itself and
for the descriptions, since it is not used.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index ea9e7f4..b56953a 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -59,9 +59,11 @@
 /**
  * struct mlxreg_hotplug_priv_data - platform private data:
  * @irq: platform device interrupt number;
+ * @dev: basic device;
  * @pdev: platform device;
  * @plat: platform data;
- * @dwork: delayed work template;
+ * @regmap: register map handle;
+ * @dwork_irq: delayed work template;
  * @lock: spin lock;
  * @hwmon: hwmon device;
  * @mlxreg_hotplug_attr: sysfs attributes array;
@@ -71,6 +73,7 @@
  * @cell: location of top aggregation interrupt register;
  * @mask: top aggregation interrupt common mask;
  * @aggr_cache: last value of aggregation register status;
+ * @after_probe: flag indication probing completion;
  */
 struct mlxreg_hotplug_priv_data {
 	int irq;
@@ -79,7 +82,6 @@ struct mlxreg_hotplug_priv_data {
 	struct mlxreg_hotplug_platform_data *plat;
 	struct regmap *regmap;
 	struct delayed_work dwork_irq;
-	struct delayed_work dwork;
 	spinlock_t lock; /* sync with interrupt */
 	struct device *hwmon;
 	struct attribute *mlxreg_hotplug_attr[MLXREG_HOTPLUG_ATTRS_MAX + 1];
-- 
2.1.4
