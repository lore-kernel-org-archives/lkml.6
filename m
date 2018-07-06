Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88131C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673E23E47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4673E23E47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeGFMrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:47:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48998 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:47:02 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mfe8p-1flYUl0Fjv-00P5iG; Fri, 06 Jul 2018 14:46:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hverkuil@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonathan Liu <net147@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
Date:   Fri,  6 Jul 2018 14:45:53 +0200
Message-Id: <20180706124628.3192421-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:c54e9PiOk7Wlim/U846paOiqpg2DfHAPPDpdahMj9m9tN5aT4YK
 cu+p95lUhbuyjabduuZnYLevHn2qMjpsdeuzJ/W2NubsHOeITcwSYid3kayZ7QHtZix7kHq
 4wRB4hdDkk1v+JsOJLVgoe4UiGx+Lws/Z4AFxOkham2vwGr5GrBUHzmOAIT/rpYaPYCs9S/
 Pi7dae3LLPwVx1nKHrR+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p4Z/arbfPhE=:VBLSnoU0vpNyqmFlElX5Cn
 CcJGaXtutVRnMDBW0qOzZ+pNRWW5qLR5/ZJ82iFzm8K2rqz8iwaKbYly8PWzxsQOpdqCibC7w
 VtKV7IKdWc4PhAWY7hk3gxxax7CO7UihJaMXh+l7Kfa+8h1GrT9aeFYXQmmVVmq8QcZjUsKU1
 OQ4ou/sVBbTcgnvAlpnueRMyRIaPDNp5B0q8aVbjpFga3e0nzEx8BsUyZt24P4x9BY3SWPb8G
 Rcwe9W6Ct3wjPXcbmm2B1BEmzI3ENVSoZ4VdHNl8VdAtQVvPe/aRZqmfIp6ChQjX9wICtdXLx
 T9Et8JjZ4iInNm/4HGUJ+xVvhU+MDXJzxWBBIt8qRoVEM/WTTdtwum34tIompFDQDcfS8RfFA
 AJv2yLGQmLn8TwqDJVoIaCTG5rfRs7a1Ftrp6WLyesUjYBIWhhS/p25sSvaEKMFbrtxSRHN06
 8WkVRXcukeIO8RRnIXMTiDnNKlpJ+VIhI21yLbjmXIwTxFsqAJ7WWYgwxGbhpWTd7C0EVUnJf
 1XwklMYEt59mQvsGEoMmXMv9C2aMcPS++Rf79McWJsV4+xE4c6BdD/NKGVt7yzDnSnxtr8l/V
 IJN9Yg928Qb9MbiaV9qcSIpfRS8VzJ+dEhsoU/Y4YmAeLynnLQcd2ePe1SPrIU6jChaCpT3MY
 Fyk9a+4cRPTMpz0FqvXx1Is9Is/6/ti5EEW1wo5COqedOV5s2HTjriYbry8y+RuOgTKM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:

ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!

This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.

Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
and detach it from the mixer module, I could not tell which way is more
appropriate here.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sun4i/Kconfig         | 2 +-
 drivers/gpu/drm/sun4i/Makefile        | 4 +++-
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 156a865c3e6d..709461deb1c0 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -60,7 +60,7 @@ config DRM_SUN8I_DW_HDMI
 	  selected the module will be called sun8i_dw_hdmi.
 
 config DRM_SUN8I_MIXER
-	tristate "Support for Allwinner Display Engine 2.0 Mixer"
+	bool "Support for Allwinner Display Engine 2.0 Mixer"
 	default MACH_SUN8I
 	help
 	  Choose this option if you have an Allwinner SoC with the
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index cd27d02c94e2..11de3cd52dae 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -39,4 +39,6 @@ endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i-dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o sun8i_tcon_top.o
+ifdef CONFIG_DRM_SUN8I_MIXER
+obj-$(CONFIG_DRM_SUN4I)		+= sun8i-mixer.o sun8i_tcon_top.o
+endif
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6ddf4eaccb40..7551dcb34c71 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -216,7 +216,8 @@ static bool sun4i_drv_node_is_tcon_with_ch0(struct device_node *node)
 
 static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_MIXER) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static int compare_of(struct device *dev, void *data)
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 3459b9ec56c9..b18c8f175dba 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -44,7 +44,8 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 
 static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_MIXER) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
-- 
2.9.0

