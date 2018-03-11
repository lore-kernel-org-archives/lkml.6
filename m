Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeCKWcP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:32:15 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:33184 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbeCKWcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:32:13 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Mar 2018 23:32:11 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: shawnguo@kernel.org, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm: zte: Fix an error handling path in 'zx_crtc_bind()'
Date: Sun, 11 Mar 2018 23:32:03 +0100
Message-Id: <20180311223203.3669-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' is known to be 0 at this point. It must be updated by the value
returned by 'clk_prepare_enable()'.

Fixes: 0a886f59528a ("drm: zte: add initial vou drm driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/zte/zx_vou.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
index 7491813131f3..3351b258ed7a 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -838,7 +838,7 @@ static int zx_crtc_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	clk_prepare_enable(vou->ppu_clk);
+	ret = clk_prepare_enable(vou->ppu_clk);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable ppu_clk: %d\n", ret);
 		goto disable_axi_clk;
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
