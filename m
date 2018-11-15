Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF47C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906E82146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="bJWffdQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="om4rvsF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906E82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbeKPI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:26:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47457 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388764AbeKPI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:26:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B9C4A23171;
        Thu, 15 Nov 2018 17:17:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=cbw2ej/70a
        OG1LVZTK+2DCtHgjbMbIZvjp0BkY7gXwQ=; b=bJWffdQ+dB1gPFFuJUBGebYHhG
        yWHM2x4SLialJB80TqcWKdjSF3aPjAILsvxmK3N4U1CCnjcKAEkArw2hiT1hLaPW
        lZ6P0ZRPnoa4Pj+TYV2sEmZaePKrF9DEBmyPJxU4zpO1gAn+Ha1iJDLCCuRfBS2N
        GbcjPrCWMOHxziDos=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cbw2ej/70aOG1LVZTK+2DCtHgjbMbIZvjp0BkY7gXwQ=; b=om4rvsF5
        yFEgLB+GcwOwfzG9cnTLDuxYcVQ1tiwfwan/gKFyU9os2xWLRUv1We53hX/HuCiq
        JGWIPO+lV4rZHxp5TD4J6d4WPO+51IjKfWYguzYpyeHfxmJizLv2FlJ3guUs2oPv
        vIV8KXpETOPyaMF/AFhrCLzrNS8yriAf7HDXWFudT0Zn96xwN6sTXkIN5WAmxBgT
        dDnOsArIhxOaMBv29pSpMMoWrEDjM0RB4N9MSe0fJHjxPsrY5Df1SeXQYfv5QqRG
        k23shmcMeFz9pV/MAwZW7hXXrR/wwkjhML7ztxvOO8VT0d8n6YDhKDKu52riMHVW
        cr+s2xwHSUGBzA==
X-ME-Sender: <xms:avDtW8dK9xfKoSK29j_h-sLxCZNazxMJx6hnpS0cltN5Rohl3Y-DaA>
X-ME-Proxy: <xmx:avDtW_FEa0CxjMoZiSM8jmHP9Y9kgs4eyAX8LnAi7dyQvjtHr2aeHg>
    <xmx:avDtW-B7Je1JrtG2yLAxchJSJiQ08b8Gdm2EYptCmqctnf-Qyw9c6A>
    <xmx:avDtW0mvvxVQuvn33dWGYlJH4G4afnHcSLnDfzRcsgs0mltOCYZHww>
    <xmx:avDtW84t1LgLL_JfBEWAp1K1foi5QoncgUVaT2UITq_A-m8L2WslLQ>
    <xmx:avDtW7vx0jWeUwVHyF62U6dc4JkzutbVwT4aNjX7CAVv8dpFLBSlRg>
    <xmx:avDtW97opqpxC6FPUvYtQD8m6VLUjXOuijXqeGYwCX6pC8U2lg1CCw>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44961E49AD;
        Thu, 15 Nov 2018 17:17:10 -0500 (EST)
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
Subject: [PATCH 2/9] drm: remove deprecated "[__]drm_gem_object_[un]reference[_locked]" functions
Date:   Thu, 15 Nov 2018 23:16:22 +0100
Message-Id: <20181115221634.22715-3-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more places where these (deprecated) functions are being
used from, thus they can now be removed.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 include/drm/drm_gem.h | 50 -------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 3583b98a1718..daa34328b5be 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -222,56 +222,6 @@ __drm_gem_object_put(struct drm_gem_object *obj)
 void drm_gem_object_put_unlocked(struct drm_gem_object *obj);
 void drm_gem_object_put(struct drm_gem_object *obj);
 
-/**
- * drm_gem_object_reference - acquire a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for drm_gem_object_get() and should not be
- * used by new code.
- */
-static inline void drm_gem_object_reference(struct drm_gem_object *obj)
-{
-	drm_gem_object_get(obj);
-}
-
-/**
- * __drm_gem_object_unreference - raw function to release a GEM buffer object
- *                                reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for __drm_gem_object_put() and should not be
- * used by new code.
- */
-static inline void __drm_gem_object_unreference(struct drm_gem_object *obj)
-{
-	__drm_gem_object_put(obj);
-}
-
-/**
- * drm_gem_object_unreference_unlocked - release a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for drm_gem_object_put_unlocked() and should
- * not be used by new code.
- */
-static inline void
-drm_gem_object_unreference_unlocked(struct drm_gem_object *obj)
-{
-	drm_gem_object_put_unlocked(obj);
-}
-
-/**
- * drm_gem_object_unreference - release a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for drm_gem_object_put() and should not be
- * used by new code.
- */
-static inline void drm_gem_object_unreference(struct drm_gem_object *obj)
-{
-	drm_gem_object_put(obj);
-}
-
 int drm_gem_handle_create(struct drm_file *file_priv,
 			  struct drm_gem_object *obj,
 			  u32 *handlep);
-- 
2.19.1

