Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D88EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C5B20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C5B20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933380AbeGIQHJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:07:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeGIQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:52 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mboqj-1fLqbm1pMj-00Iyub; Mon, 09 Jul 2018 18:06:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Liu <net147@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
Date:   Mon,  9 Jul 2018 18:05:55 +0200
Message-Id: <20180709160615.2686055-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:yfMQHlSrnKBRQ1W1oWue4dMcRmiJaOain4IMJcV3MVRbduh5nGg
 dE/45cd9ACGkChuav2BqcLp/AYu1ny4M6l8k/ibLV+8YTKBzHTwk1SET3A2j1mhmR0Xny7q
 eOg+xJoDGeOAhSyfIGYYhYd0/1sQWoa2gsJnqNj8ZxaJuyEGjYac/3/rmKML0lNZ/Xb7v1h
 asfeyo5aGUAJCx6Y5gHPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G2oTdP56VaM=:NO43VNKIEuhaxY6mZxdQ+2
 X9LU7SWrVRKPk9GRk0vfgSsApGFDw3yElsETthZxRPJF2Bxep/RAEiuE4DWwRu7UE5FEYGem5
 x4uSmN/2gcVfnH2uoBryE+mIHw8WZ7r6pSMhBA6F+A1N04N+pewbuwDGoM8qkn5sHg40Geico
 xjuOeTyRUTYjd0ImrM1EeupC8bC+a+31bRGNLYAUs7wk7P3VuLNYrNiaYqpUVxtILgrwlIu2a
 E6mF0phipqXst9qqsFV2O5IOA+LBHh1UsS/OIEWGfNT829LMJAaEm3Qpj99Eo4gJOYmOV/nu3
 pHhSh1dHKBetYb+9HviuwuGlr4CvKV8JbDc7tDRbgtfTrp0FQ194Lg2u66TD/5XSTkbRjc1HC
 rM/mlDTGM0naKa0ecYcY+tiojH0LZtYmi5zgjbtYMwLjUdbRByxJUzha1JuEOG2Z6CLpQnypR
 cdH8SAjNeh+Cdt9qkcwOYNTBefueydM6ov63Jvsuc2F8/QFuBi2GX/K9hDCWa415aGoo9ql/v
 8XQScTd/nwM1o2CuCCKQEKMOd5U+Epq85j7yZaYXBWiw/S22n4oACEPd4z05a6N77Z/EgYqVs
 395IdJPQpy+IMwp1pY10Po/1mA6YKsVEOtd/Qq9UF1vgxkZI+mq8+ACWFP9ist1XYwbVx4TKE
 icNaXUkwvRPIrtT2LlrfiSOWIpZld9B4RuFnsQ+JG29rMcL3YH3vN9JZnpta0MnSxdMs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:

ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!

This solves the problem by adding a silent symbol for the tcon_top module,
building it as a separate module in exactly the cases that we need it,
but in a way that it is reachable by the other modules.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: link the tcon top module separately instead of into the mixer
---
 drivers/gpu/drm/sun4i/Kconfig         | 7 +++++++
 drivers/gpu/drm/sun4i/Makefile        | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 3 ++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 156a865c3e6d..c2c042287c19 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -68,4 +68,11 @@ config DRM_SUN8I_MIXER
 	  graphics mixture and feed graphics to TCON, If M is
 	  selected the module will be called sun8i-mixer.
 
+config DRM_SUN8I_TCON_TOP
+	tristate
+	default DRM_SUN4I if DRM_SUN8I_MIXER!=n
+	help
+	  TCON TOP is responsible for configuring display pipeline for
+	  HTMI, TVE and LCD.
+
 endif
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index cd27d02c94e2..0eb38ac8e86e 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -39,4 +39,5 @@ endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i-dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o sun8i_tcon_top.o
+obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
+obj-$(CONFIG_DRM_SUN8I_TCON_TOP) += sun8i_tcon_top.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6ddf4eaccb40..495d0fc41297 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -216,7 +216,8 @@ static bool sun4i_drv_node_is_tcon_with_ch0(struct device_node *node)
 
 static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static int compare_of(struct device *dev, void *data)
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 3459b9ec56c9..3704d95874c2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -44,7 +44,8 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 
 static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
-- 
2.9.0

