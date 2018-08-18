Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA0FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8C215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo9kCFOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B8C215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeHRTDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40666 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRTDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so6112920edq.7;
        Sat, 18 Aug 2018 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EkLQys/9bz4lne9ViArBTfdU/WxgXgESOlEwrVsKz20=;
        b=lo9kCFOouS+KRpp3R/amkYJCBTUm3Qbpsw/2Gck+cEogdxJ1z4bYF46jeybbiVt7d3
         EHMBGCcnDvMwHzAyLdf1ZjqLSff5IXxIOXfH4dC+RScFv7S/k6qyzbJbY9Ok0Co3y483
         ERC/qlw8JnSpsUzVQ3LUn7k47vF5QnkwDxvmh77nMyBiBv/Mk5oOGTmiEbosqHT32ym2
         lzHttTRUEPJLespgRUyFgPrOVQ6q6ZNSLqdXgsQpQe99jzh/YN3vG22J0rNWh3uYjTd9
         vhZ6vRaT8D8eJpJTUW7vj6dsgSglVwivrdzZc/DLURcFEGtj0NYevrMDTjbTXDQpeH8J
         PIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EkLQys/9bz4lne9ViArBTfdU/WxgXgESOlEwrVsKz20=;
        b=ltYTnMmA3xyYJ+ey1FMQrjkwfVUHPlyi02OHt30MNrwnS1HvSlfcELgI8UNkDBbvSJ
         /uzCEeRNUq05PxaIluM5tvcc/ws5JZshmSPZ+/49lzt4FvuU/myWEeiiN9AuIyY9TZhl
         Yq3p1cxiI0451ONkA6K1dvewLvgXBTYLPyykYZYGdkia7ZDp4uLlO66q1jSXlNIOeSsg
         8+AJPz3SlK9PNGhP6tTZbFEP/PSY2MOwCthHUEGeWkmLQ++iBThBptCSfk0VM6NEKK4o
         PiDDyx83aovSx3Hyvu2DKFsrLeKvLj/FjpMdxYrc+L0LBQX8Dlqnzv42OeOHlXjHOJKx
         wBGA==
X-Gm-Message-State: AOUpUlGHwO9EAhKC1mFH2oI9Q2sGGwa/mDDnjUK04oxkua4s04icCUmm
        KZVShDpTprtS1gn4yywSKW0=
X-Google-Smtp-Source: AA+uWPwUVplqf+jyAsM1kXb35JQOfIekC3UexK0g9jkZsloEfNlEh1gU+d9YottxxMj4ZrWdyTMIPg==
X-Received: by 2002:a50:f5e1:: with SMTP id x30-v6mr2766653edm.132.1534607737861;
        Sat, 18 Aug 2018 08:55:37 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/19] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date:   Sat, 18 Aug 2018 18:54:12 +0300
Message-Id: <20180818155430.5586-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded headers inclusion and sort the headers in alphabet order.
Remove pr_fmt macro since there is no pr_*() in the code and it doesn't
affect dev_*() functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 7b1361d57a17..6dda7ee1d36c 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -17,21 +17,14 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/vmalloc.h>
-#include <linux/mm.h>
-#include <linux/list.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/iommu.h>
-#include <linux/of.h>
-
-#include <asm/cacheflush.h>
 
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
-- 
2.18.0

