Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31395C04E86
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1442098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1442098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeHWEtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:49:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbeHWEtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:49:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDE037A7E9;
        Thu, 23 Aug 2018 01:22:08 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-163.rdu2.redhat.com [10.10.124.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 863442026D74;
        Thu, 23 Aug 2018 01:22:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Jeffery Miller <jmiller@neverware.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/nouveau: Cleanup indenting in nouveau_backlight.c
Date:   Wed, 22 Aug 2018 21:21:49 -0400
Message-Id: <20180823012151.20099-5-lyude@redhat.com>
In-Reply-To: <20180823012151.20099-1-lyude@redhat.com>
References: <20180823012151.20099-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 01:22:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 01:22:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still no functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jeffery Miller <jmiller@neverware.com>
Cc: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 017d5b7924bb..7ad90e7610a1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -68,7 +68,7 @@ nv40_get_intensity(struct backlight_device *bd)
 	struct nouveau_drm *drm = bl_get_data(bd);
 	struct nvif_object *device = &drm->client.device.object;
 	int val = (nvif_rd32(device, NV40_PMC_BACKLIGHT) &
-				   NV40_PMC_BACKLIGHT_MASK) >> 16;
+		   NV40_PMC_BACKLIGHT_MASK) >> 16;
 
 	return val;
 }
@@ -82,7 +82,7 @@ nv40_set_intensity(struct backlight_device *bd)
 	int reg = nvif_rd32(device, NV40_PMC_BACKLIGHT);
 
 	nvif_wr32(device, NV40_PMC_BACKLIGHT,
-		 (val << 16) | (reg & ~NV40_PMC_BACKLIGHT_MASK));
+		  (val << 16) | (reg & ~NV40_PMC_BACKLIGHT_MASK));
 
 	return 0;
 }
@@ -164,7 +164,7 @@ nv50_set_intensity(struct backlight_device *bd)
 	u32 val = (bd->props.brightness * div) / 100;
 
 	nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
-			NV50_PDISP_SOR_PWM_CTL_NEW | val);
+		  NV50_PDISP_SOR_PWM_CTL_NEW | val);
 	return 0;
 }
 
@@ -204,9 +204,10 @@ nva3_set_intensity(struct backlight_device *bd)
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
 	val = (bd->props.brightness * div) / 100;
 	if (div) {
-		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or), val |
-				NV50_PDISP_SOR_PWM_CTL_NEW |
-				NVA3_PDISP_SOR_PWM_CTL_UNK);
+		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
+			  val |
+			  NV50_PDISP_SOR_PWM_CTL_NEW |
+			  NVA3_PDISP_SOR_PWM_CTL_UNK);
 		return 0;
 	}
 
-- 
2.17.1

