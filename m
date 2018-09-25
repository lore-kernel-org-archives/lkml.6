Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75607C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A80420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xG3SB/hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A80420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeIYSyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:54:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34788 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbeIYSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:54:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so15314074wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38j/leseIFaYyx4yzFjMEUsIrw9mip1Szaiqm4tzm/A=;
        b=xG3SB/hqI9zicDsqSJWxH2a5w6TT5cAbl+08w875aubOfbKW4wjl7huBAYTMw0npzF
         go8eUZ7yKDwZIk8P4tYDlnN/8NWhxTnJCffhRTJO/vPopUeFr//EnbhVbUijE9n2CEOw
         TqfaAJkTdqgye9qyEXoYgBDRRRpGcS+/lU1VGZENwT4XcPGqUvM3JJEL1nAlAr0m5UlJ
         r6BsHPCbkdzfryYDNmHEfnWYbtT8gucikuarsE3qdm9PvINabI7PSfrgnQgZBf/5UQUt
         VQKymh5IQb+1xWifHxW0T4oqTU1TnswOQeqNJlQMtGEcSYxvtMWP/pCoCATJhXV9PIMa
         6IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38j/leseIFaYyx4yzFjMEUsIrw9mip1Szaiqm4tzm/A=;
        b=XqHyLlVgarbCUNJeV7GILXKI8ThcgN2unaKg2CJVZBdL8rikcVpMIyUjiYMdbB2t5r
         FUjD0QTCjT4UU7fy5asEyh8Fd204I6yKdjF8UrfZfcmNxBog9nadwFTmQP2W9NY3lm5Z
         fD62+7H6+R/EV7hFecbwrhfzoNkFGzo23cFvHa7DEbs/8hZlxtNQLmUFuLvu9EfeROw+
         xL9vbJw3I7qo72pEis47adNKaQf31bZsBD+ttszuGgT+PP/Ye1FBnFovSPyPGfpRn5tF
         VIK+LKwzXcD3VkzWPzUW7+Py5tT9CWHrOkKxcWoLDResm8XQKlKyjipAVFXbRjyBj0dK
         ySVQ==
X-Gm-Message-State: ABuFfojiReu+mWio2Ttebg5k8+b9im2p1Gs66R6UaLRg9vwpPqVUZvos
        L29IxLKzLbLf3fHYngH9apILMg==
X-Google-Smtp-Source: ACcGV62vFyqE/rtZmRXRbZQgPOF7bcisFripMfz3eLQzPU++WzaYPCbLaEjSEWGD+F/+huW5YGEBRw==
X-Received: by 2002:adf:e6c9:: with SMTP id y9-v6mr834729wrm.35.1537879600998;
        Tue, 25 Sep 2018 05:46:40 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z13sm2276160wrw.19.2018.09.25.05.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:46:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 1/4] devres: constify p in devm_kfree()
Date:   Tue, 25 Sep 2018 14:46:26 +0200
Message-Id: <20180925124629.20710-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
References: <20180925124629.20710-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make devm_kfree() signature uniform with that of kfree(). To avoid
compiler warnings: cast p to (void *) when calling devres_destroy().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
2.18.0

