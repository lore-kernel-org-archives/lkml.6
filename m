Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20536ECDFC3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBA120898
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="af5vzXGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBA120898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeILMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34937 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeILMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so1254124wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k5yxIXhSHg7bpz4pLJ1Q0FLt3HidWjwucjgci+GeA8c=;
        b=af5vzXGaR5Frlti+DQ3wvprPAl5RfialBE83+2/EZFV3YsyuSiGI5sqA38YmPcsD1/
         svi1+uuGsL3QIFWX8Ske6Ws/GikTz9MKvCN0ucOZhnyPLU+zxpFGcRPgrw2tqiJq/ihM
         jqe7cXPOgbdQEQPdj34wqtB7HAAa2ooc24nPACICJZzt1jjU0alpLcZL+6pSVZ4joAKU
         Wj7ruNOIMGrFFoqasLZG/Q1oD8OJpCEaoRqcRxAij5D8zbHVRVtzY+nYHLmD9L+TF4gr
         d1Y5GBr9Lux6lYZTM98nWDI403W1PwgDBs5Oi0d9WQoIbUUu4PMMzQGWN9gPF2cD6pmD
         XMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k5yxIXhSHg7bpz4pLJ1Q0FLt3HidWjwucjgci+GeA8c=;
        b=sTdPGz2hfc2R6zlzEkqlJcmireDPOo4I/qPXnqNLzqLKB25IWhLXys81aX+w+ELh+D
         02BSsqMRdEoFxseYSF1c+xdPI+RB4d2Rq1TXUUKaqYF+nSfXuYv3HU4TVGo7iO3EIY26
         Ko+Tsge9Wna2rcfXeECiifnz58036DtKl5SQPLhTw70jVvLjy3Jcr3Hn680NDMNCsYTF
         rgh0Kea/Qm2eBpaOqcvvBMdyYTkYTyAgHz5bntFr/Vg7bwA1RQZ1tetFjpzAUXPaLPaI
         TJj/HZ9R4kcHO9O2YlFPUhtQoNXiwY3VKVgZkjoBjqQ36FRxTCEpVR1Xj/wl/DmqkZL7
         HJoQ==
X-Gm-Message-State: APzg51B6X2uz4/pWCIipacAKNjEvzTfbKIOwlm5ud0kWtiy3O8rEHhRB
        A/AYU3HHod23sbRRp0sXfvxIyw==
X-Google-Smtp-Source: ANB0VdYzD1Oqnd50HfQsossSncXp9AfGsuZx8m8Dn8JshEwtPYZovwPTJW5nRMo6u1rOru28lt2+hw==
X-Received: by 2002:a1c:9215:: with SMTP id u21-v6mr703832wmd.106.1536738719900;
        Wed, 12 Sep 2018 00:51:59 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:59 -0700 (PDT)
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
Subject: [PATCH v3 10/21] nvmem: change the signature of nvmem_unregister()
Date:   Wed, 12 Sep 2018 09:51:18 +0200
Message-Id: <20180912075129.25185-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We switched the nvmem framework to using kref instead of manually
checking the current number of users in nvmem_unregister() so this
function can no longer fail. We also converted all remaining users
that still checked the return value of nvmem_unregister() to using
devm_nvmem_register(). Make the routine return void.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 8 ++------
 include/linux/nvmem-provider.h | 9 +++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 552ffedce38e..c950d54bb69d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -553,20 +553,16 @@ static void nvmem_device_release(struct kref *kref)
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
index 24def6ad09bb..033c9c3c80a6 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -70,7 +70,7 @@ struct nvmem_config {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
-int nvmem_unregister(struct nvmem_device *nvmem);
+void nvmem_unregister(struct nvmem_device *nvmem);
 
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
@@ -87,10 +87,7 @@ static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int nvmem_unregister(struct nvmem_device *nvmem)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
 
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
@@ -101,7 +98,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return nvmem_unregister(nvmem);
+	return ERR_PTR(-ENOSYS);
 
 }
 
-- 
2.18.0

