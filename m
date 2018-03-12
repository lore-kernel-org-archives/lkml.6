Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCLUPi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:15:38 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:26680 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeCLUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:15:36 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Mar 2018 21:15:35 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: narmstrong@baylibre.com, airlied@linux.ie, carlo@caione.org,
        khilman@baylibre.com
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] drm/meson: Use drm_dev_put() instead of drm_dev_unref()
Date: Mon, 12 Mar 2018 21:15:09 +0100
Message-Id: <d4ce46077d3ada7149c4555acfdda8ade4a6cf50.1520885192.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to 'drivers/gpu/drm/drm_drv.c', 'drm_dev_unref()' is just a
compatibility alias for 'drm_dev_put()'. So use the latter instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 02b0886debc0..6ee3dd7fa450 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -284,7 +284,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	return 0;
 
 free_drm:
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return ret;
 }
@@ -303,7 +303,7 @@ static void meson_drv_unbind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 	drm_fbdev_cma_fini(priv->fbdev);
 	drm_mode_config_cleanup(drm);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 }
 
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
