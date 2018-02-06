Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeBFVXf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:23:35 -0500
Received: from mout.web.de ([212.227.15.4]:50297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753503AbeBFVXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:23:33 -0500
Subject: [PATCH 1/2] drm/tilcdc: Delete an error message for a failed memory
 allocation in seven functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
Message-ID: <8391221b-45f4-7ad2-ad21-3681a945f034@users.sourceforge.net>
Date: Tue, 6 Feb 2018 22:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WO36D14GALTA23tM/DiDwOPWpCrTrJs0lifX9035pLxAfVOv9r6
 yeCAVjvqz1F57dkSzlFkUE5uSBt15zCCiKvzOq4//klHP6HNgYbX2oEhcEiV/oB/DgiOXbN
 AFrkE8paBg12uHdamTD2FDwfVuBjDxPXdFANVk2iF7XWPTdQ6h1XrFUwn5fggA8PVjPD7Ld
 J12oUQgs76Pvvp0ec7nrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FlUOGp4/JQ0=:hZjWEhFmKAOGTyhMrhmfjq
 0LLj6DeXpQ65M+Z2UilxDVlQ656Yo1aJ21I9yAmJL2gYxIgswkXhPG3kjO8eXxm/jz/JD96f7
 GoOASWYa8/jVGlPMkggPcMKMgzhN9HG6At+FKWmm8SjrCRXecIp/swiWfOoGvEAfkCKl07FKl
 Eha1qAB3yEFpmCma0fSbxF8OBL/YcNvnDrEINv8XzQOcHClCXumre7eR5WrCmc9Bq+nwMrRSD
 bdMjXiQv7lsPgYYe4ezkZHIGUjL1clyC2jSDcmjdjWMflZAwLhWMG7h06+QfqavyKWIn9mhnY
 nH6QFilAm8+b8bq/cPLjqZVUIv6UosrmAek4p2K2g/IGKSj6wtHyKoVdr1xG1G0aNknH1GZO1
 JOwJoVUMUsOqlrJGJnGKEwhd/676whj1vELVPq5GMxZ2rNiJ6JPnqFy11d1JZwHyVvOw9rJ8Y
 Pl0TH6CEL2YQCt7p79QswI4wZmN/92VWQbqJHOctAzAT/1pZrtdHhOGD4OOHWHwoloXLfWo7N
 E2zmdaFCmkj/mUxI/WUX0CQ8LOhGkFH0r6fIsNbBtcQJUuI38X7e2TH1RoD8xuJZBCNYYAUrq
 bATn/55zMjpP+GgMQMknY6mxM4awb9UpibZwxivcwVevh957Lq5d8YXLP34rDEAPe3URljC7n
 3vW7tnIZ9tTamcqEQfBEzpgwer34C1RO9VZpvJmsfaJ3Ma12/p4MSnGqucuOk5Rhu084OY6E4
 7mG6nJoaN8/3ekQzLhYhqBD5fxE7kjQGzr6H1XTcQQa8fL/ZQ9fHAzpFis3ZmcKCfOOIe9YUq
 AvH7I3HzY/R35pF/H4o0kXrVy9aI+V0t7v6reE50pad+MuJYIs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 21:51:15 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 4 +---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 4 +---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 9 ++-------
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 8 ++------
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 8bf6bb93dc79..1b278a22c8b7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -994,10 +994,8 @@ int tilcdc_crtc_create(struct drm_device *dev)
 	int ret;
 
 	tilcdc_crtc = devm_kzalloc(dev->dev, sizeof(*tilcdc_crtc), GFP_KERNEL);
-	if (!tilcdc_crtc) {
-		dev_err(dev->dev, "allocation failed\n");
+	if (!tilcdc_crtc)
 		return -ENOMEM;
-	}
 
 	init_completion(&tilcdc_crtc->palette_loaded);
 	tilcdc_crtc->palette_base = dmam_alloc_coherent(dev->dev,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1afde61f1247..b8a5e4ed22e6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -233,10 +233,8 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "failed to allocate private data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	ddev = drm_dev_alloc(ddrv, dev);
 	if (IS_ERR(ddev))
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 8eebb5f826a6..0b6aa95aec89 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -101,10 +101,8 @@ static struct drm_encoder *panel_encoder_create(struct drm_device *dev,
 
 	panel_encoder = devm_kzalloc(dev->dev, sizeof(*panel_encoder),
 				     GFP_KERNEL);
-	if (!panel_encoder) {
-		dev_err(dev->dev, "allocation failed\n");
+	if (!panel_encoder)
 		return NULL;
-	}
 
 	panel_encoder->mod = mod;
 
@@ -210,10 +208,8 @@ static struct drm_connector *panel_connector_create(struct drm_device *dev,
 
 	panel_connector = devm_kzalloc(dev->dev, sizeof(*panel_connector),
 				       GFP_KERNEL);
-	if (!panel_connector) {
-		dev_err(dev->dev, "allocation failed\n");
+	if (!panel_connector)
 		return NULL;
-	}
 
 	panel_connector->encoder = encoder;
 	panel_connector->mod = mod;
@@ -294,7 +290,6 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
-		pr_err("%s: allocation failed\n", __func__);
 		of_node_put(info_np);
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index 7e3643462a08..c45cabb38db0 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -111,10 +111,8 @@ static struct drm_encoder *tfp410_encoder_create(struct drm_device *dev,
 
 	tfp410_encoder = devm_kzalloc(dev->dev, sizeof(*tfp410_encoder),
 				      GFP_KERNEL);
-	if (!tfp410_encoder) {
-		dev_err(dev->dev, "allocation failed\n");
+	if (!tfp410_encoder)
 		return NULL;
-	}
 
 	tfp410_encoder->dpms = DRM_MODE_DPMS_OFF;
 	tfp410_encoder->mod = mod;
@@ -224,10 +222,8 @@ static struct drm_connector *tfp410_connector_create(struct drm_device *dev,
 
 	tfp410_connector = devm_kzalloc(dev->dev, sizeof(*tfp410_connector),
 					GFP_KERNEL);
-	if (!tfp410_connector) {
-		dev_err(dev->dev, "allocation failed\n");
+	if (!tfp410_connector)
 		return NULL;
-	}
 
 	tfp410_connector->encoder = encoder;
 	tfp410_connector->mod = mod;
-- 
2.16.1
