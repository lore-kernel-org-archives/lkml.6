Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B8DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08191208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TjY7XD59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08191208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeH1Ncw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:32:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55807 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1Ncw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:32:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so1208747wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SVWcFbk/dVzlsS+UwHvhPxvTnIJPJG8C6MWyhlzaJP4=;
        b=TjY7XD59PXtSvVirztIUG/IzfuDVWIiYSDoXxS4NQ4F2s7v5QZzehTI9rlcKQKQmHC
         S7Wfo/sISESMCfGCmTz8pBDEpoKRlEvMSySpNcKszz/mSeCD6r3ZYQqh7NS42cCUrTUl
         ohCflbE1aFg6Cg8i4w7T4tUE1hRO4ML0HDDYDXlYX3s/sM/60rqYtpraEcXbn7VFpFsI
         Rf13u+/Ix6L/8VCcE26REBhIMzh4gODasHflNG5XY4jsGkCfFaneUEaxxPeL1JAmVr33
         4agPt2IlxFibmgO36O4hLogKoEqwoSfDEogM+joTQ4uEDhYEWBHeY58XBOHgpQLO+h8I
         Ngjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SVWcFbk/dVzlsS+UwHvhPxvTnIJPJG8C6MWyhlzaJP4=;
        b=NJUN14JYre1Taoka91KuboS5qxC5mXDnIJ+ZX/J+uFYLo0pg52p6johrlF3azxFOaG
         6Ltk7Eukv+cXLEF+AArcqKiQZRm67ap8injxpSv6Uzka4Mn8+iSuqLDP+RiUKbsS4lDz
         1hETLZjzaKPp852YCeC+KPs82g4of0t+xVvh1a4o7XsU7jmTCok6Qj5wsmeaLaYegd7n
         DhRA+zXa7aFaBtvNnWanbPc4nIIojMz0s5o1LaFF1xZiBNPrTMDojlwLdqhMLTv7siG4
         0xN9bavpoQ/Zb3G51A5jcX5D/2/VIh74oOD+XCcViY1dFC1g5jU2j+Do3iZVOBfJ/7Xs
         EGzQ==
X-Gm-Message-State: APzg51BIscVfXsMcvKST9XI1rujf0BfjLdYi8Xf6BnbX6FlgillrIdAv
        K4oTPk6E8s+KjIpjTjmmS0me8w==
X-Google-Smtp-Source: ANB0VdaV9Pzpww2Wl5G6NP9NsWTUDI9DTePHGQQs1BV4TSeNoZ3PsHOAKQ3DK7ioV0EeP/SgV6txyQ==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr759080wmf.141.1535448846439;
        Tue, 28 Aug 2018 02:34:06 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l18-v6sm952276wru.75.2018.08.28.02.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:34:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/4] devres: constify p in devm_kfree()
Date:   Tue, 28 Aug 2018 11:33:29 +0200
Message-Id: <20180828093332.20674-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828093332.20674-1-brgl@bgdev.pl>
References: <20180828093332.20674-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make devm_kfree() signature uniform with that of kfree(). To avoid
compiler warnings: cast p to (void *) when calling devres_destroy().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
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

