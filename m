Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8995C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D599206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="Ob43s0UP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emwCZkJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D599206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbeKPI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:32 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44359 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeKPI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 61CE72218B;
        Thu, 15 Nov 2018 17:17:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=2/uzg/+g2E
        Rl1jwIMfVlU9Oj+/gZ2XmjxYZKfBKhe1o=; b=Ob43s0UPCDjDz9NAH3GAcQocG+
        5ACEMwhig1K+UsL7+c9KZvuRDJgWNCr5Y1sKWOT4Mi7zPF49y/R/uFwRxJ+mJg0w
        3Vj+aW9HDUQpEh7jigpk5Sk5GLILfAwYpH1D7tUsrCby/ynVGXJS/ZsqatGjrFHk
        0GSM1LOfcwqBxXfRU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2/uzg/+g2ERl1jwIMfVlU9Oj+/gZ2XmjxYZKfBKhe1o=; b=emwCZkJe
        kqTrD4aNPEr93s/qe5REHBuJborXcVEDETZVo8UMtR5axOcFw8E7WusH5AFDxkf/
        mUNPHu/PM8LAPoOMSNPX8py1LI3kNRf1+psopBID+2ZNb/yGGAOqyJaRLwpE4Q2u
        wcAzAOqMMiLz8Tykd3zsZnc04rGK9wlSTY4SDI7//4ckxEB5aSJN2UXoAhFfvq+r
        JqTpBHVUavodIiXZcaQEGCGDj+kxsKpqGvww/hRN5tniBS1+iTGTktsZBuAjZUdP
        74PoIDhaylWc5cYCLJBBQUz2P8EhhJpms/IMnNmfiO9WiY9cqlwwOx6LB4v5LVfU
        27Aujl987v08CA==
X-ME-Sender: <xms:jvDtW3z8i3Ix1ESbo0PhhC_DleZKZxZg3dnU7cxachOL-n2abGbVFg>
X-ME-Proxy: <xmx:jvDtW1ftTG4RDE_Xwi0767AaVU7DwTyD9DGdfzqsZr3ZdWLGa-m7sg>
    <xmx:jvDtW4vOu5hs_xq6C78ma0qrdXQpoUsFaxfS_7R7zeNkz9m5lc9g6A>
    <xmx:jvDtW9mkquAnjmvN06PIXL3N-e8VtUC8IZOkFoAn8lxF7DJlbwHydA>
    <xmx:jvDtWzQ0aOhHDoGaZH0ui7tv16Rl253QjZtGEkeTY4EFvib9wBIOxQ>
    <xmx:jvDtW7Jwnx08WbzgH6GdR4dmruuOgp3hGOdS8oGVR0e5eRZTIiH9FQ>
    <xmx:jvDtW1gvSVYcVTYVI5jVrA6cLxm0vKYE843JCNnkGRACuilbeFt56Q>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1A0AE46B7;
        Thu, 15 Nov 2018 17:17:45 -0500 (EST)
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
Subject: [PATCH 6/9] drm: remove deprecated "drm_connector_[un]reference" functions
Date:   Thu, 15 Nov 2018 23:16:26 +0100
Message-Id: <20181115221634.22715-7-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more places where this (deprecated) function is being
used from, thus it can now be removed.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 include/drm/drm_connector.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 9ccad6b062f2..b91b206f1665 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1191,30 +1191,6 @@ static inline void drm_connector_put(struct drm_connector *connector)
 	drm_mode_object_put(&connector->base);
 }
 
-/**
- * drm_connector_reference - acquire a connector reference
- * @connector: DRM connector
- *
- * This is a compatibility alias for drm_connector_get() and should not be
- * used by new code.
- */
-static inline void drm_connector_reference(struct drm_connector *connector)
-{
-	drm_connector_get(connector);
-}
-
-/**
- * drm_connector_unreference - release a connector reference
- * @connector: DRM connector
- *
- * This is a compatibility alias for drm_connector_put() and should not be
- * used by new code.
- */
-static inline void drm_connector_unreference(struct drm_connector *connector)
-{
-	drm_connector_put(connector);
-}
-
 /**
  * drm_connector_is_unregistered - has the connector been unregistered from
  * userspace?
-- 
2.19.1

