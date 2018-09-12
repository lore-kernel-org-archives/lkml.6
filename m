Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D725ECDFC2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3520E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wdLW1Tcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeILMzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34935 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeILMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so1254058wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=wdLW1Tcw2CPABQPZEQhA4DxeaA1J71Qx4oJERKBJ5zwSWV8zhJXcXI/ra1B4w7/h8k
         FAxhpXCRzpKAnlqIWtg95+eUsuPXntQ4DOdbhpF1f6CHHEdlqUNO8+28MOxleaCKjXL9
         40rijCgtPdmtHKODn4w+o6qar5Re33d0y0E1babeWA6yJOJiGPpZMbqCDibonOru95Hh
         W3ES6A9+wFr/GDHr8IFOeBHix5qlP0dgglHXzlruxJI5PxgJMwFFDxCQ14byniEWUSV1
         R6v01dlVHyr9jL5YCbF6pffXXv5HDqc5UKOP9uO0md/DNcDP0Q6vNI26e7623tjgbNtK
         +luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=XqMQERr09DTaRgwIzjE+BrCMvYGxXVZ6tgVOOC8uzAAAe/w5HPCvU/P3Xqv05M/pup
         xiILlPcJvf59Duid31+4zsFo60tf/SxGq0aGhda5bX/dIXRuvbNBhgmO9TcHnVyBtOZ3
         vxTENkD/5wUDe/ZprW63HbPgqx3d416zndVavdgNyYGDTlBi9tkdvl/s7iAQ+ar0OODt
         BowRorjL8Kbmn8duGN7ag9Br+ID1A2kKjutoIJ9JtAsDSthuWxrAO3GqW21aLMhxso0L
         uFsX77/MgDP4qQ0aRO308Qi9ilzLJ3WKMmkiyc4jPVGr4e9Ed8jQD5wzuFv6+3J29xlr
         tnxw==
X-Gm-Message-State: APzg51A308oLxjgyJwT6HMOm+YS6UnShkE/l4Q9cZGev4WvP8nDL04ma
        bAHa9DXOFF1tAHuZJd28ICCZew==
X-Google-Smtp-Source: ANB0VdZFFqyJaKSGzkYb3Y+wcOqFkd7zRny8K2kXHtqDE1Pz7BCT56tB2AAc2ku9D6MNPnpYKWD4KQ==
X-Received: by 2002:a1c:3d07:: with SMTP id k7-v6mr749591wma.146.1536738718471;
        Wed, 12 Sep 2018 00:51:58 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 09/21] nvmem: mxs-ocotp: use devm_nvmem_register()
Date:   Wed, 12 Sep 2018 09:51:17 +0200
Message-Id: <20180912075129.25185-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register();

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/mxs-ocotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 7018e2ef5714..53122f59c4b2 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -177,7 +177,7 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
-	otp->nvmem = nvmem_register(&ocotp_config);
+	otp->nvmem = devm_nvmem_register(dev, &ocotp_config);
 	if (IS_ERR(otp->nvmem)) {
 		ret = PTR_ERR(otp->nvmem);
 		goto err_clk;
@@ -199,7 +199,7 @@ static int mxs_ocotp_remove(struct platform_device *pdev)
 
 	clk_unprepare(otp->clk);
 
-	return nvmem_unregister(otp->nvmem);
+	return 0;
 }
 
 static struct platform_driver mxs_ocotp_driver = {
-- 
2.18.0

