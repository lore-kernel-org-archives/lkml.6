Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BAC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337A1206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/RTeAHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337A1206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJAFZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:25:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47080 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeJAFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so10311251ljj.13;
        Sun, 30 Sep 2018 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHWs6Au1FsWp2FoWJ3Uy9p5Gr5yjrkh0kTfv7OJxXhM=;
        b=b/RTeAHHD429uQlGP250Ec8JNRzApDuwm1c8BGQ7nYVqtsUy2DPhP8f36gbgrt3p5C
         cV7iTXjhtBd/tL2SPkoGdoJe9oEY5pBuy5OOtjm5dTbmhNLjH3KmzRhJwQIwHN6MfXL6
         cb5BbFPID2YtSyGcQnfOB7+APUbB7/X4EuCuS95DybBLU84N+UF9k66qfy4pz1fur5/Z
         aqWMh9/6186rpa4CHB4BU4vPSjOtvJiBh1KdiyG5OvnnzDBCwaZYb/s3i4cpn80lD50t
         THvUSQwxUa9aR2Nbido7N+jfZqLZ4amevwdzyZV5TN2Ou3XPVaVXyYNTbR6sxg9AOMf+
         L+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHWs6Au1FsWp2FoWJ3Uy9p5Gr5yjrkh0kTfv7OJxXhM=;
        b=TWhUKp/aayxyJ87HJ4qPZi3NG/CxuM2oPThb7Z4oYQ5L7QR7aVPuWztHbtAyu+xQ56
         CDcVwr18fy8iJN48bojXsedCjm5to1dpq0wQ8J8KTXdsHUxxNtOXjAFtgquSswWTcQMY
         Ghe7hCa5FP718vwl+v/vcL5xoSNBdFYKMRJLyFDEWun/CTp7VmfbW15XaZNcHcJawpIo
         rQBVg1u88qb2rD12TCLsrrKQikI5fCilHks5GFYdq0xJ7y7rRPckOjALrflXaKKkZOsQ
         7dxa3CP82Z86AW4KGkZwU33JX+rHj2oVXNWMLzYHhIm1T2CmN+jAOxqip314ZI1wWaXU
         c63Q==
X-Gm-Message-State: ABuFfoib/8UStdYUQtCJxg338VT/BkN4taIR964ElsEF8oB1KG/DTLvX
        hYTc+okQtm2Ku/hRq1QZX78=
X-Google-Smtp-Source: ACcGV623g8MyYExUVu+CC5qPv1POyAa1Ovz2Ke6D8dhoeN79nCIJ+SAl+6p3hudykOPhGjK1QGooqQ==
X-Received: by 2002:a2e:4702:: with SMTP id u2-v6mr4977891lja.147.1538347734925;
        Sun, 30 Sep 2018 15:48:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/21] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date:   Mon,  1 Oct 2018 01:48:13 +0300
Message-Id: <20180930224833.28809-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded headers inclusion and sort the headers in alphabet order.
Remove pr_fmt macro since there is no pr_*() in the code and it doesn't
affect dev_*() functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
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
2.19.0

