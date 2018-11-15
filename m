Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36FB206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="VvU1lSVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="de1dbJyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36FB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbeKPI1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:41 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49331 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbeKPI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F946222AF;
        Thu, 15 Nov 2018 17:17:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=O7SXFI/SrJ
        2csaFotIRya4mQd9lIpwVcLKNVpq45uic=; b=VvU1lSVHvJmGU1bWvmGJ0wEe7V
        anF5qf1wWfrI9lG7oevEd7qUkaJ757T/iIp1ZcuiXGKiCxG9gUpPjJPM5JfD+zi9
        ReT8BCglomXnzlhvuW0eFiZPY9GJ4rx0BUKEQb5S1RoleQYTz46ankxqQkvKC7R2
        L4SiQ+qhu1k6wkicg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=O7SXFI/SrJ2csaFotIRya4mQd9lIpwVcLKNVpq45uic=; b=de1dbJyw
        nrXu93soawWbLZXSdCkJaPgK9VbzfcRwLUac/nlI41aUG7mpH3ceiejqAu7gTqDm
        oiizPnMdqKS7rSdmalcTHj5qsZcV5zhkX8PcRajfOQPMfFs6agB/M1NlWSQscngi
        gziK+3McYDGOO+dnMa8+My9EjADmXlABax37XfUrg5zIhIEtEqhf3Q7SgEmQKzWu
        N/+THSk20v5wsWYELLCnBXDMwRwlb4v67tEZ6ffuonD6Ll5tOZXX2YEFyQcNeVZv
        /mrxtlrnLwgwH8U2gV4xSIsFLRbqjg5OJzxWmSmd2+vCy4fdpyxiArvkby4G9g1X
        iVr1fKegdkA0MQ==
X-ME-Sender: <xms:l_DtWwdFMg9ywO2msMtdBsyYvLLVDsin2dfpPDg1GmU1lAOO1Xi1bg>
X-ME-Proxy: <xmx:l_DtWxF3xxuQn0XoSmRU78DZoI07nKtKyT3bfxIiKL3JdCAa-3GelA>
    <xmx:l_DtW4qcjCc0DGjRmI_mDnOjUCuX9GRN-e-3SJsz70NxCRkYPjP3iQ>
    <xmx:l_DtWx0AjkMUsJkHTwdGebfF_dendwZsQ4SexDoXnnwxJbLSbHG2qQ>
    <xmx:l_DtW0AweRH3j-KdLAK1c1CiBqk9bhoX91jeVkUbuFvPQh2W-LCnXA>
    <xmx:l_DtW08ohOr1Kpb8Kzzt2FUWYnrB_x0EmRMc5Dn1qRX0NyQWaglISQ>
    <xmx:l_DtW0pRzxtAh7efXuXkdBcj11lG81Q3gFXZl7hSAwFQE0pIwwYzrw>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91A05E469E;
        Thu, 15 Nov 2018 17:17:54 -0500 (EST)
From:   Fernando Ramos <greenfoo@gluegarage.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH 7/9] drm: remove deprecated "drm_framebuffer_[un]reference" functions
Date:   Thu, 15 Nov 2018 23:16:27 +0100
Message-Id: <20181115221634.22715-8-greenfoo@gluegarage.com>
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
 include/drm/drm_framebuffer.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index c50502c656e5..c94acedfb08e 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -240,30 +240,6 @@ static inline void drm_framebuffer_put(struct drm_framebuffer *fb)
 	drm_mode_object_put(&fb->base);
 }
 
-/**
- * drm_framebuffer_reference - acquire a framebuffer reference
- * @fb: DRM framebuffer
- *
- * This is a compatibility alias for drm_framebuffer_get() and should not be
- * used by new code.
- */
-static inline void drm_framebuffer_reference(struct drm_framebuffer *fb)
-{
-	drm_framebuffer_get(fb);
-}
-
-/**
- * drm_framebuffer_unreference - release a framebuffer reference
- * @fb: DRM framebuffer
- *
- * This is a compatibility alias for drm_framebuffer_put() and should not be
- * used by new code.
- */
-static inline void drm_framebuffer_unreference(struct drm_framebuffer *fb)
-{
-	drm_framebuffer_put(fb);
-}
-
 /**
  * drm_framebuffer_read_refcount - read the framebuffer reference count.
  * @fb: framebuffer
-- 
2.19.1

