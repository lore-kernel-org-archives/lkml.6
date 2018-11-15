Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E16EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610AF2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="g+rE4K/B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7wjocss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610AF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbeKPI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:14 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50719 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbeKPI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A2A00218B7;
        Thu, 15 Nov 2018 17:17:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=zdDOHVhfX6
        venivR2p2CDNh26XuC0oKqDDvujWeSBsE=; b=g+rE4K/BXgOol9G/uZxW9Qo1HX
        y4hvUA02Zwfrz4sA1My2UZWD8jDEWGGM6mdpZDOpXstt1oLeO1k8jp+F4HX+ymBJ
        QzM0GYMw9mFBstEfGt8ArysRZM0NPKQwRStvtTMSqv9IE0OYQ7u/nsgglzjnaQq3
        0rHudiPvY4RcjRkJI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=zdDOHVhfX6venivR2p2CDNh26XuC0oKqDDvujWeSBsE=; b=I7wjocss
        bAZdnzHiBV+UbJ2Y3O6B3KLLJlMGc8r68+wmEbznrTICMQm93+FB+d4lUl+DVamM
        Yz0POJaDnsgODtCPJ8Rcn17q1l/TQAu2GCFy8k42SdrAU8eTd0XeW3sjuIV2YcnP
        yJBgJsL7TqAo0WIRS2u+oxNiUzc6IMaNaZ3UXApK2Og+lgHxrNsjXbLSgdulorFK
        mz3QZSqqMQ42RRLzhbxdqcyk2ulfVFajMN+0HfXkJ6+qXWbBHlwK9ey3Fkh4bLsW
        Mbp1EUWVeJTOmh29tPrN1zyUzTkrzGksThBQSAicdQFETvyQRseoY4HbiYCFMQoy
        1oYuWopIK9NYkg==
X-ME-Sender: <xms:e_DtW0FVlVen70zsVpZ5KvuGk4oGITaFMAZV653xcWpNOxl4mS2f2Q>
X-ME-Proxy: <xmx:e_DtWxPN3sdd8_QvxVYJRL-EDc-MoSelAuDyORScBuRWavD0WaVyAQ>
    <xmx:e_DtWxpKtNbvHJEwfCU8u-W5IG0ee2bZ9aPKJwHSGyYpYPdWuoe2uQ>
    <xmx:e_DtWyDTwZSOi_dqStlJihlPCdPOz6nzeyWTepjb0iPeZ1IBFKl-Hw>
    <xmx:e_DtW6NdIVfqXsQebFcdtDp6durAOiGjCWYHtjqD-Y07NWa7LWYnag>
    <xmx:e_DtWwDn9H9R8oel0YaDzvqfkfMRVvWs1QXgOTWM_RTGKfDx7B4STg>
    <xmx:e_DtWz-agHwjVkvazOysaRwH06lpC6AzcHWNPuxCTrjb-aVfpfXFEg>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49BC2E4307;
        Thu, 15 Nov 2018 17:17:27 -0500 (EST)
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
Subject: [PATCH 4/9] drm: remove deprecated "drm_dev_unref" function
Date:   Thu, 15 Nov 2018 23:16:24 +0100
Message-Id: <20181115221634.22715-5-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more places where this (deprecated) function is being used
from, thus it can now be removed.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 drivers/gpu/drm/drm_drv.c | 13 -------------
 include/drm/drm_drv.h     |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 36e8e9cbec52..22c8f8252207 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -706,19 +706,6 @@ void drm_dev_put(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_put);
 
-/**
- * drm_dev_unref - Drop reference of a DRM device
- * @dev: device to drop reference of or NULL
- *
- * This is a compatibility alias for drm_dev_put() and should not be used by new
- * code.
- */
-void drm_dev_unref(struct drm_device *dev)
-{
-	drm_dev_put(dev);
-}
-EXPORT_SYMBOL(drm_dev_unref);
-
 static int create_compat_control_link(struct drm_device *dev)
 {
 	struct drm_minor *minor;
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 3199ef70c007..abac47c10f1d 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -621,7 +621,6 @@ void drm_dev_unregister(struct drm_device *dev);
 
 void drm_dev_get(struct drm_device *dev);
 void drm_dev_put(struct drm_device *dev);
-void drm_dev_unref(struct drm_device *dev);
 void drm_put_dev(struct drm_device *dev);
 bool drm_dev_enter(struct drm_device *dev, int *idx);
 void drm_dev_exit(int idx);
-- 
2.19.1

