Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA8C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D37208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nGGCBUhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D37208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeJADAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:00:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbeJADAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:00:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so6387825wmw.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q/fF90NrepbyDB35CQnzwzM4iX3gSJNp5nR350IMu2k=;
        b=nGGCBUhxAo54lfQfvsb74d3PLMuqV2YBe29QG4VwwG0Y9/8FPrSAKc08QujiIV77p3
         c4/eFVI5cueAq6Fbz2y9axeGe7MACPgapBfERbVlIbeqiJ8gBM7MHQcBprrtzJs6ooIL
         tKvfmk1rQv2toOY9kW07ramvt2ryQGR5fDCQEj4iR8r2tXNulrKK0RudqhwF9lVKC0VE
         7sanU0upOFackTKjRmZcBNV0LhN/wJjVdUOytJfJhcGsjhVpkQWivtL+qDR1zaNdYeuh
         Q3NreFOMDnM9XKaTUpo0yeXWAiplVhpQvCAOW7FsmCrQiiSbH/Z43+h15FJqX1uO8R2R
         NbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q/fF90NrepbyDB35CQnzwzM4iX3gSJNp5nR350IMu2k=;
        b=AhpfRyjYirx53RTmSiqgPOVFrrqbuxPR8gVZDpo7jXGo8B6kuSaxUFEL2Q/ri9Yftz
         IQTo3pZ2wZ3X9nuqbO70LzS8TtsG96X809rph3jrtYGOtuDRBny2ND/2gG7unBb/Po3Z
         DIYwgjE365Al/3bffRUbSKVzt5OngNGPm0ECxsLaXkPvY+g9J1uQ8vWnWTl56aw49ig0
         yqiVBRtATE0W7jH1ph4diygCyLEx2ME3uzwH9y15mWqhjIalFakCJwfDmyorocwNrJdV
         2u25h4JOAs9qxRt0Pd99H3rAtjxqCvg0DWBzcdWOeDzFcsAfiNS0vwIrT0pmqz8Ig5ym
         d3FA==
X-Gm-Message-State: ABuFfohrk6aRk1EmJtsncf7kDpQZOcc/8MyOCJDq7xT4knPj1K8LJ9lS
        Ak+g9gmqLYo5GRieBGDtg6s0vA==
X-Google-Smtp-Source: ACcGV61YR78MUWSIaTMjdb0Fjz2ZkIQGg0cUgeKGe7/UMgCN654b/Ck7tH6FLmP0XBBAWbn3u3vAIg==
X-Received: by 2002:a1c:ae84:: with SMTP id x126-v6mr6848149wme.73.1538339181794;
        Sun, 30 Sep 2018 13:26:21 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v16-v6sm18566465wrw.12.2018.09.30.13.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:26:21 -0700 (PDT)
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
Subject: [PATCH v6 1/4] devres: constify p in devm_kfree()
Date:   Sun, 30 Sep 2018 22:26:12 +0200
Message-Id: <20180930202615.12951-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180930202615.12951-1-brgl@bgdev.pl>
References: <20180930202615.12951-1-brgl@bgdev.pl>
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

