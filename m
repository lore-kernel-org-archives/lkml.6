Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C3C04ABB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6520873
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JtGi0E8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D6520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeIGOsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38074 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbeIGOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so14025182wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=874CbkmyKCyBfTs9WgjHeXXK4p9vYZrCF79UGreNijg=;
        b=JtGi0E8EtyYudsIFL9qZFkG0FIwpMOaj9jFQI1/hi3wcuWuUVInGn/oVbgZUnC7r+/
         ESIx8/2m8bMPfnhf3wfWY4zmhcIytQZMz5Btk9LDDq+fi+OSPsUad73nwbz49USeA0LS
         b4W85gi6o39gPDZGyXE4lmPycrCUtA/umJTTCXGTUJHcgCmByZ5EcEkPG7j25eIDAwie
         glIN3eQtm369yj3+FrAucFWz2OF4dFF0q7AoTbnklQD9gT0NsR2cQihAaV9WjAAppBnw
         c3I7nUdHo/dkCeBh/5Bl8R/Iv/3NoMV+/QtvU/fQ4xWQdfyHmf7xvkMHknvLHgJTpywG
         dZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=874CbkmyKCyBfTs9WgjHeXXK4p9vYZrCF79UGreNijg=;
        b=K62sx3T0s/wtrJ6+gtjpmU0I0tz9FmUZm7cwfOQ3T6UgCMyEnDtMV0vo4+KXV1HGkS
         MTYX7MRGf9JcXkeOp+eXQsH1RDoYKWdG3yWL+gbdorKyIkaHVUf2ODVbNaOMfjjpDHqV
         7sg2IkO0Ziz5O9CbCeIyfH9CK8OKjTm0WL5a6Xg5tqhjLJ7OtyJfnJLHP7zIdzN/KdJL
         FyrXkPyDBoo8wA6Xw+6gnTKU0Si3QDs0k+pGAJmW4eMNi7wYXBLBG50y55MYAhCCCL8P
         0+eu26O56QFibLDrLsfDeK0P1Gkv7unrvh3NtAEo9ZEd+6zgmcvIKTnxbQQP9tc7xbqc
         eujg==
X-Gm-Message-State: APzg51BBtSH9d86qOFUeUkzt6vUy1eCIiW/KfRAQmKSkOibfowMP9W+a
        kS4sxwq10V/L3TVy+5Gw3YC0Wg==
X-Google-Smtp-Source: ANB0Vda6VBe5FobB98uJtZPvt++yeqLqlDh6ifRlvqAGdkP0nvvIpNhCJwPav5nsLR05kFpP5HoT8A==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr4519638wmh.108.1536314905081;
        Fri, 07 Sep 2018 03:08:25 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:24 -0700 (PDT)
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
Subject: [PATCH v2 05/16] nvmem: sunxi_sid: use devm_nvmem_register()
Date:   Fri,  7 Sep 2018 12:07:39 +0200
Message-Id: <20180907100750.14564-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/sunxi_sid.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index d020f89248fd..0296c23db322 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -181,15 +181,13 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	else
 		econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
-	nvmem = nvmem_register(&econfig);
+	nvmem = devm_nvmem_register(dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
 	randomness = kzalloc(size, GFP_KERNEL);
-	if (!randomness) {
-		ret = -EINVAL;
-		goto err_unreg_nvmem;
-	}
+	if (!randomness)
+		return PTR_ERR(-EINVAL);
 
 	for (i = 0; i < size; i++)
 		econfig.reg_read(sid, i, &randomness[i], 1);
@@ -200,17 +198,6 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nvmem);
 
 	return 0;
-
-err_unreg_nvmem:
-	nvmem_unregister(nvmem);
-	return ret;
-}
-
-static int sunxi_sid_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
 }
 
 static const struct sunxi_sid_cfg sun4i_a10_cfg = {
@@ -243,7 +230,6 @@ MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
 
 static struct platform_driver sunxi_sid_driver = {
 	.probe = sunxi_sid_probe,
-	.remove = sunxi_sid_remove,
 	.driver = {
 		.name = "eeprom-sunxi-sid",
 		.of_match_table = sunxi_sid_of_match,
-- 
2.18.0

