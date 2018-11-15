Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD782087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="f3asoA3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AYSrVVLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD782087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeKPI0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:26:49 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37101 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbeKPI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:26:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 347BC23173;
        Thu, 15 Nov 2018 17:17:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=/Ga6ixswCA
        Mh39m8SVk3xvW/K1WEt/PTY2+rnjOprys=; b=f3asoA3B5YQ/dNBRiJ9esmRJRE
        0AdSLu3Uc4pJN6C2Qav3INIYUVex5BAeMswrQeUO+7SAq6rrhhppXgAiTNigidoa
        u/aBDJyEPKyCFIpMLY+ef5qCwhjPPSH7ru+CLMpXMqiAk3LD/2ukbd5PeN3lVI5m
        RwzjQ0/+4ihoHWNKs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=/Ga6ixswCAMh39m8SVk3xvW/K1WEt/PTY2+rnjOprys=; b=AYSrVVLK
        khaofqeCU+FmvYc53ZSQ7Vk7NAWIxRbOoMlpC8PusYYLKK0pmTCbn0hWBM9iIiEB
        4dHJOSFLEabmjQ7bD14HjBFVgGFCA23OBrQPzKsjG4jQ022ROhaIz+e8vcbEIIU3
        lZ8Z3k7WeGJ0ZBwD3w5JtaaT62CS7UiQTAnzsTG3Z/DpjS4i6d0breY1nnufE1Ek
        Jn2ryAZuSGXrgYlxRdo9sTCDlj3iIHe1ESYOAmI82cYfJJLJfM4zB/4qkmNq4L1l
        YkJdZQoGs6EM16CQh15NmxkdOUyIg0HE2Ol6WUcOaziuw1dUpuu8LmVRwwUZohZB
        COJloxAAcfVZNA==
X-ME-Sender: <xms:YfDtWySyJS0ilJ3fyhq9fNl84WHyRoP8NjHKEHsMsKl2FVfP2a51Ew>
X-ME-Proxy: <xmx:YfDtW-T2nkXHI8HD8uwLPVaRb-tCijCjfmiOThJmHTfSMMXHXjx3CA>
    <xmx:YfDtWxtAivAP3cffjG28Wjqa4N7XXyeS7E6f1DWjyy9vHBqWeXA-1g>
    <xmx:YfDtWzYLIA3ya1WswhMdcRHsjGTaP3CHdMfGtNkKzpq9AnghPPIYOQ>
    <xmx:YfDtW2s1Fygq9oHX-JTH7zJhkg_DcZN80WTMKGWHHuuWMC-UvDsx5Q>
    <xmx:YfDtW1GTGNBE_i6hL6WN8GWvL1nmoc7jChRaPOD6-cTTAJMVVUmtIQ>
    <xmx:YvDtW4CQjXV9Cdb-kiw0ECOHZeVSZLMe7mdlEQLNPZxmUSBd2mm7jA>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3CECE47A1;
        Thu, 15 Nov 2018 17:17:01 -0500 (EST)
From:   Fernando Ramos <greenfoo@gluegarage.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH 1/9] drm: replace "drm_gem_object_unreference_unlocked" function with "*put_unlocked"
Date:   Thu, 15 Nov 2018 23:16:21 +0100
Message-Id: <20181115221634.22715-2-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch unifies the naming of DRM functions for reference counting as
requested on Documentation/gpu/todo.rst

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index a61c1ecb2bdc..e6ccf7fa92d4 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -414,7 +414,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 		return ret;
 
 	ret = drm_gem_handle_create(file, gobj, &handle);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (ret)
 		return ret;
 
@@ -454,6 +454,6 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 	bo = gem_to_bochs_bo(obj);
 	*offset = bochs_bo_mmap_offset(bo);
 
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 	return 0;
 }
-- 
2.19.1

