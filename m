Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30CCC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98CA20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mepDEr49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98CA20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJNXBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:01:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:01:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so18277928wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvCSoX4zTkqM47ueqb3aBlVkKFDRALxCQOZsmN07noQ=;
        b=mepDEr493y9voI57zvP0Mo2K+Jh9EZfcAM3YVVChGpzpjLpigDprqpHeJNvFivKN5F
         f5PtNMeSmuIJe/ddEFWjyhdYXKNoiDSeIPm/8zWGqtuiuXqVA6xl8NGgXNpeVrmxizn9
         aQDmTGglT/6C00vvsimEfzJpiQEYJ8kmA24yrHw1ivMyb1gTixTl7SDn2Y2mReI3Pyd0
         9a1Q8Q+ajvdbeaSLRwcZKiyjGf9fhKIe3WpgB6mHSMsbhZ9ZgkYxH6Qm1OEv5gA6QQ8K
         slg4zBa80Vbr6LODVhujreUxy1EVRlfm4nWru7C8Kfy3ajiGFXTSCRYwZni6jtfCKtq6
         miIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvCSoX4zTkqM47ueqb3aBlVkKFDRALxCQOZsmN07noQ=;
        b=ApxoRi187g/bUlMw6Ke1SfxVs7e6j2uqkSKRk3rFzn/ztXYQnEoC7DePdYc9KfcasK
         KS4x0qPJCzBH5xipHKII5KWvT5yu1CdT2MTb9kcMwYLWMHPnWYK1FC7ZvMJjE9x60gsD
         xe4KFlKgjA9Pqd5oU/KNuSots5JrjzO87qyrLm4kc5yXMWoxca0SN0cCUIT5uMk3X0RH
         z/4TlDQO/whb7R0Oy35Jiihiz6U4LURA16DK2IeuUBDIB1DVcqkqg4iecz5QWYHtUcgS
         NAyKsO4rRf3Gs88USm3YHAOzCJndsNu1IjsbyqR0a6GyNtwE6YYW4GiHpVIvNeCcK6Le
         t6Og==
X-Gm-Message-State: ABuFfoh24zug/KGVI4+NAaQuaXvee7/S5FWUX6G0VhfC3abRfDjuoTJD
        sVXIXWxgdwUnxk20UtW75XBlUg==
X-Google-Smtp-Source: ACcGV60IDlfek7E3rWEpuuWe7TM8d88JnwjLlv0gZcijK5eS/N/4HzofBxsiQuhB56EbgHJtRgB9Ag==
X-Received: by 2002:adf:dfcb:: with SMTP id q11-v6mr5252970wrn.253.1539530420452;
        Sun, 14 Oct 2018 08:20:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b139-v6sm14789830wmd.36.2018.10.14.08.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 08:20:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v6 1/4] devres: constify p in devm_kfree()
Date:   Sun, 14 Oct 2018 17:20:07 +0200
Message-Id: <20181014152010.2021-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014152010.2021-1-brgl@bgdev.pl>
References: <20181014152010.2021-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make devm_kfree() signature uniform with that of kfree(). To avoid
compiler warnings: cast p to (void *) when calling devres_destroy().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/devres.c  | 5 +++--
 include/linux/device.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..438c91a43508 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -885,11 +885,12 @@ EXPORT_SYMBOL_GPL(devm_kasprintf);
  *
  * Free memory allocated with devm_kmalloc().
  */
-void devm_kfree(struct device *dev, void *p)
+void devm_kfree(struct device *dev, const void *p)
 {
 	int rc;
 
-	rc = devres_destroy(dev, devm_kmalloc_release, devm_kmalloc_match, p);
+	rc = devres_destroy(dev, devm_kmalloc_release,
+			    devm_kmalloc_match, (void *)p);
 	WARN_ON(rc);
 }
 EXPORT_SYMBOL_GPL(devm_kfree);
diff --git a/include/linux/device.h b/include/linux/device.h
index 8f882549edee..33f7cb271fbb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -692,7 +692,7 @@ static inline void *devm_kcalloc(struct device *dev,
 {
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
-extern void devm_kfree(struct device *dev, void *p);
+extern void devm_kfree(struct device *dev, const void *p);
 extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
 			  gfp_t gfp);
-- 
2.19.1

