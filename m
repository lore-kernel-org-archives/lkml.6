Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB93216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xZHB+j/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB93216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeI1Ngs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:36:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52931 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeI1Ngq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:36:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so803544wmw.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38j/leseIFaYyx4yzFjMEUsIrw9mip1Szaiqm4tzm/A=;
        b=xZHB+j/bjUkWuFfewEWNphV9YJEvenWMiyVbvCSju9sIKOcbGRR3UWIdjouNJQdea9
         0HRG8gdIgaZcZ33syKrHxhkweUi85XYkucxPaGupl++jNMcnX0Hb1WfurRj3idIUSj6H
         kP6n8Mc5KLmPliGjvB5ZyU29/7gKL0K7oJD1vgFehOZNQvDiN2FQqHhzkEBR862tbryP
         w+owBeCV5sDcDbXI64lVYmgfKbCHUcStLUy9Jv1MBm7DO/jRVjiKII/OEGME9eeO2PAF
         ipjqovvgpp0UpL1Y/TTAW2F4/QDaVzSFCA3ZJD44oM8/ONaEmzKqwOcabwv2QEnK/1fp
         ebAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38j/leseIFaYyx4yzFjMEUsIrw9mip1Szaiqm4tzm/A=;
        b=PMcsv2aJ+ycTu4v3vgkVbVSeCes/JG718aw15oXfisHOwjAV0p2gJSOc6B4pzomVDr
         AdifCq+BTTr+wliXypS4xwnK2qI3vVNE9c9snvX9ozeaLIAy5J7nT45h4zchDa7u0m1r
         DfY5R8kddi+kVPFb2czH2V4r+F89frs8npD+SDBQQtcVzp5BPRIWm4ZCvQHRU9h8dSu5
         hytdE86c0B844njBZvTIQQq2xoOXj1LUgWkLDi7aSy6RVSifoTkV8oFbIM8rwmJz0NOH
         zkMK56eS/iuPv5Par+FSECzNzUN3IzcD0nhKAL4oe3SeBx8ol2Fih3igFR5Afh6qlrZl
         2IXw==
X-Gm-Message-State: ABuFfohRV9oq2KUniUBnu5EGD4/6qX56R03wWlmlj869jWsTxKicZi43
        NOGlgaPDBGkOnXQ90djK/a8KNQ==
X-Google-Smtp-Source: ACcGV62Ip6U1Gi1brHiX2B58GmseLhqeGNqwLC5svpHUnTYyV+a0H0N1hk95pywnAS5bhjqUL/eNkg==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr721419wmy.81.1538118863900;
        Fri, 28 Sep 2018 00:14:23 -0700 (PDT)
Received: from brgl-bgdev.sitez.s.ibrowse.com (93-158-26-51.subs.ibrowse.com. [93.158.26.51])
        by smtp.gmail.com with ESMTPSA id w3-v6sm2699580wru.93.2018.09.28.00.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:14:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 1/4] devres: constify p in devm_kfree()
Date:   Fri, 28 Sep 2018 09:14:11 +0200
Message-Id: <20180928071414.30703-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928071414.30703-1-brgl@bgdev.pl>
References: <20180928071414.30703-1-brgl@bgdev.pl>
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

