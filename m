Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90763C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F0120876
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dO4KNvUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F0120876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeIGOsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44428 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbeIGOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so14343058wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KfLprIfJuLGiikb3NQ4jaXuB3vUOmbbQ5NtX8GENxrY=;
        b=dO4KNvUqz2aIxCjLfjhvE77hHxkUffpT/Vay5uCjP+ZFbvi/dvLUPdKTf9UWESwTfZ
         4/jbKTykpco+qBPXvr/0uGIwk4404XTFWhM5Y//VXplxG2QGA661QC8spnd/EhEFXu8E
         m7PbrqktMofdmCw7G2N7HSRpWoI9w37HUimtR5Cvxcml6TNmhL2H9rsSG6qhcA6Om+ra
         +lnHuhqohMvYegZS4UuZMFSF9BhxFwr0o3qWgNVZ+rS9jO4CktTxULJ03Wgb8NytupTI
         Xz8V/IrDju3TRKZ11YYikItkH/JnwGMcQ494vA7zeL5GrHOVno/HSuS1mUV6/hTsPG3d
         cw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KfLprIfJuLGiikb3NQ4jaXuB3vUOmbbQ5NtX8GENxrY=;
        b=CLIrThb+2WNtJR/UratUBBMTb3G5x8plfrj1150AuaR1CfKfCBi/8z3O9tqClY7A6g
         FBFUm3dcQkXHu0KYUH6uQnBOgN6Ji101iPWlAiRkfOgGZwE0+nax+i5Z60I5+eHVG87k
         EYUCiU5uxFQyn52FpXcbv7/3TCD0+oyPoTC59iW0Hwcgo60v7PVaQuc2UYdenz4ASqiV
         yeB5sh9BADNVq+kQpRZKZjyYnrcf4eN8ZvktvOx0q70zL3NffS6dPo4jXhk9Oh44X54u
         lNYBpO3tYt2pyEjvAFBaPisR5Y269lB2Ec1bPajJlX8XcqlRUBPN9P6/MyO41Iyzhr3Q
         NcwA==
X-Gm-Message-State: APzg51Dx38Y6wVA7d+b6/iNHb0QCDD+nQp3WVfDuFzhSL5Vx1wBC5jJy
        lfrax7AdOQnt1llZjap2ISXjjg==
X-Google-Smtp-Source: ANB0VdafhIuGK3oNDNnpMZYcVQAMSylAY/tTUn7PGNQnolzR5ctIKa4tIqeUtaLOTPHujjcOX8+qbw==
X-Received: by 2002:adf:c751:: with SMTP id b17-v6mr5739892wrh.134.1536314907593;
        Fri, 07 Sep 2018 03:08:27 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:27 -0700 (PDT)
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
Subject: [PATCH v2 07/16] nvmem: change the signature of nvmem_unregister()
Date:   Fri,  7 Sep 2018 12:07:41 +0200
Message-Id: <20180907100750.14564-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function can no longer fail and there are no more users that check
it return value. Change it to return void.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 8 ++------
 include/linux/nvmem-provider.h | 9 +++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2335b72d4b3e..89b91f73d08a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -450,20 +450,16 @@ static void nvmem_device_release(struct kref *kref)
  * nvmem_unregister() - Unregister previously registered nvmem device
  *
  * @nvmem: Pointer to previously registered nvmem device.
- *
- * Return: Will be an negative on error or a zero on success.
  */
-int nvmem_unregister(struct nvmem_device *nvmem)
+void nvmem_unregister(struct nvmem_device *nvmem)
 {
 	kref_put(&nvmem->refcnt, nvmem_device_release);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
 static void devm_nvmem_release(struct device *dev, void *res)
 {
-	WARN_ON(nvmem_unregister(*(struct nvmem_device **)res));
+	nvmem_unregister(*(struct nvmem_device **)res);
 }
 
 /**
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index cc8556e3c825..d14a577a002d 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -67,7 +67,7 @@ struct nvmem_config {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
-int nvmem_unregister(struct nvmem_device *nvmem);
+void nvmem_unregister(struct nvmem_device *nvmem);
 
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
@@ -81,10 +81,7 @@ static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int nvmem_unregister(struct nvmem_device *nvmem)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
 
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
@@ -95,7 +92,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return nvmem_unregister(nvmem);
+	return ERR_PTR(-ENOSYS);
 
 }
 
-- 
2.18.0

