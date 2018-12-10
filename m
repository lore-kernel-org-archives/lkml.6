Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179BDC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29C120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xJIdGNeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29C120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeLJJ3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:29:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34711 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLJJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:29:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so6140641wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLy0SwLSlaGwBkl+R1noWL7/C+Z5I/Uca6dIaJcbB2c=;
        b=xJIdGNeKegPSOtQ+PEIf8lJnRNSP/2by2POqN0ozS4xMRjCrs94QlI6MkjbzxGo7/D
         6e5CdfuwmScOkQF6kKxVmeSJ4vz1n3rWiWiq9CYIZ0vUsuxp4PKEwfEOuK6AyQBlFYab
         0ccIrshx8NSYw7fgS0ncO1jXA7LZWkzHgbIpt9UqHvRPll+ObfbJB26dZB5nvstK2QRs
         xH0wPQLL9QWMirhhn0UoiMDBGRzmjxdZ54ab+H9zsvG9Dj1MoM/mFIpe6JgViqCctD6S
         YhDFtzARuwDxlTlOovCqYR40J/qyd+xWOCaPM61nwYAoIInyOq/2oGpz9623gTzcL2ry
         4QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLy0SwLSlaGwBkl+R1noWL7/C+Z5I/Uca6dIaJcbB2c=;
        b=mJ09K05PLq63T9Fcm/DyOyg72yKaJ+2Yte1goahygXcuBwxoTw6R12jkK9MOCLKSX1
         UEIHAkPZAL+voZr7D8InoNuT5sJB+MKfZqdXUWcj4frKhF4CWUFcqnD9yW+fKafhY+MI
         IpcrUjidobGBk5E2yP2jq2KIUopjz1OjzHa3uMsOjLoKOaTmhMqLb5rwSDDUJmEU5liF
         pRhedlGui10D8g+nz2EwHGn9IGWgzxGDsafQWto5+olHXE8uHXU45D81EomL5m7pXqWf
         4I7noW5Y43v80ECLn4f2cL/KaobBvcWEa9g2qqwtR+YsJ5WudoEpOaLMHbdCvULZsO/O
         euWA==
X-Gm-Message-State: AA+aEWbnaaDOEU2oegBr5yfVE+JrrD3G/7q1swC1a1WSMEFwpk1xgGuZ
        LWxLEoIdN38X6hrsvS8s566vKA==
X-Google-Smtp-Source: AFSGD/W8siubOMUy4gGFt2YEE32b0gn4hrwCzt6L4ZRUZsajc4Ozf6EFG5giz6Qhitltb66SY/EepA==
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr9737373wmd.111.1544434145308;
        Mon, 10 Dec 2018 01:29:05 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id k128sm16348976wmd.37.2018.12.10.01.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:29:04 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND] drm/meson: remove firmware framebuffers
Date:   Mon, 10 Dec 2018 10:28:53 +0100
Message-Id: <20181210092853.13050-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we are using simplefb or another conflicting framebuffer, make
the call to drm_fb_helper_remove_conflicting_framebuffers()

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index d3443125e661..afbb3d707d15 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
 	writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
 }
 
+static void meson_remove_framebuffers(void)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	/* The framebuffer can be located anywhere in RAM */
+	ap->ranges[0].base = 0;
+	ap->ranges[0].size = ~0;
+
+	drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
+						      false);
+	kfree(ap);
+}
+
 static int meson_drv_bind_master(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -242,6 +259,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto free_drm;
 
+	/* Remove early framebuffers (ie. simplefb) */
+	meson_remove_framebuffers();
+
 	drm_mode_config_init(drm);
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
-- 
2.19.2

