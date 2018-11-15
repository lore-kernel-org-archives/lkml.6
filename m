Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78891206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="bFuISejH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJaz7x2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78891206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbeKPI1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34609 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeKPI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:25 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B22822326;
        Thu, 15 Nov 2018 17:17:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=QuTM9RYjL9
        w5CMKskoMwsV3+b5RvhIJ1DEvyj9LlsaM=; b=bFuISejH5sQewz+4SNKNVROBzI
        wCgcs4uqr+F8uj2ix+d2hKe8+ae2VTbPkJbiDUqXyTYPA6/26B6iXU5y66GPpruZ
        aAY7jQISzXfXNy57N6pSBTTGo91GhBX30O8xec/Vd6tYh18vN4mFzwXOZAuwm+vF
        NfXmZ3OAevc0qCXbo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=QuTM9RYjL9w5CMKskoMwsV3+b5RvhIJ1DEvyj9LlsaM=; b=UJaz7x2t
        jtUuuDvrkIjhzQsX/6Z4Hm/wEBqYpiJGUgDQjB9mAo82QwmGPcHAvOvJ4IQTf0Cp
        T/pFSs2tUcjUSjTA+5duauSulPNJSmRz4pfRgtOAXLyxHiB2l5rSlFZSbp3CPn/Y
        Nr6fEaJE3gS4uMDqeKdXD1iWp21KVw4RC9L7FGSBQe1eycwLrL2VrUEnwbxp0JMX
        HV8wdf0u2mhThBjhKJMfGrZHc/pAkSxe4f8im62fnFJp5sqapcaKUsxfd8PJsPdN
        VOC1IllJY3f7+hbeU429zG04tlMKEyMHF0HIMi8Jlg3ac0awuh/lcSBa1zOdn4rb
        zoCep4FXjpa8qw==
X-ME-Sender: <xms:hfDtW0awH6Tf-ydTJocpnTDAbxCGPTFpfv4EA2W_GHjFrgyEcUVwag>
X-ME-Proxy: <xmx:hfDtW4tkCUm9c6sdJZiMo7W4LtKH9xDCLRlC3s9KRw4Ft35nOfH_ZQ>
    <xmx:hfDtW1qnwffXdNr_3jnvl1oY3w1CxJYjhp6FcIZsf5060mkcMVwOhw>
    <xmx:hfDtW1lmofS4ql24vchTgDgojxLxmhg58oV-MbCMTTZTjXbwO-9ZBQ>
    <xmx:hfDtW5wHf5waMrwko4Y-qRYDl0Wdjoy1eF8Wr4exoqQ1dTUjPPTFww>
    <xmx:hfDtW9lQVKy7J9FQpsgZuyZC6HNqpCg6Ea6uRMV8SwJ9vrdEn6urpQ>
    <xmx:hfDtW3CCPnb5eLyPlNF5zzdY6vVwqpuaNpT-7c9j5AOKruTIX7cjCQ>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 097B6E46B7;
        Thu, 15 Nov 2018 17:17:35 -0500 (EST)
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
Subject: [PATCH 5/9] drm: replace "drm_connector_unreference" with "drm_connector_put"
Date:   Thu, 15 Nov 2018 23:16:25 +0100
Message-Id: <20181115221634.22715-6-greenfoo@gluegarage.com>
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
 drivers/gpu/drm/bridge/tc358764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index ee6b98efa9c2..afd491018bfc 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -379,7 +379,7 @@ static void tc358764_detach(struct drm_bridge *bridge)
 	drm_fb_helper_remove_one_connector(drm->fb_helper, &ctx->connector);
 	drm_panel_detach(ctx->panel);
 	ctx->panel = NULL;
-	drm_connector_unreference(&ctx->connector);
+	drm_connector_put(&ctx->connector);
 }
 
 static const struct drm_bridge_funcs tc358764_bridge_funcs = {
-- 
2.19.1

