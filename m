Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAA52148D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtNLuEC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAA52148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIXGpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:45:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45246 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:45:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so8330518pll.12;
        Sun, 23 Sep 2018 17:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImtNeDFgwkeNNxKU07DnlmMuPLQIHVyVVmQEszJwKBI=;
        b=KtNLuEC8GJgiz9sgV7j1aawXwBosKjjRjJSfr4+rHvqjzE9nqrgzpO5BPrsz1CpdB3
         K0NsEk8o1/7IDIU0FbQe6v/vW0cKmi2pis+ND7GBce34rScELVDye7Fc9vDC3XTrFe6V
         avW0doSyXI+7BgU+3u01FKrnZ34LvEjraxMF/VyUoTTXPCpmS7I4WrelJRDd/wSTiKQk
         WZCBKQV5eHomm1e2JEOKxE5TQIN/zVpsD8DIO2T65YOhgOmoTxs8XYqjszuy2QRwUWdC
         KQnwW34tSPaBK2lATlIUlfOZtn0mu18fmtSLfiZWenX/wwt9ycrMwOnwNO7pMcK7UGt3
         GEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImtNeDFgwkeNNxKU07DnlmMuPLQIHVyVVmQEszJwKBI=;
        b=WsqFYsfi6Cexn2otSfInP7vcmvEeIkjjKHtaHvufcONC32yV+4hCYBVfk9pF0GmlJB
         /dSahldEhYj/1NFTtBUQ+XnzlIEwB3o/PeKLkujbU1m72X71rnTNZXVUbTNEZqoVJ+ch
         M0Qc9Gymgf4u0BcS1m05j++vl4NxXjrz05RzegZXXMUTVUYFDejWamXBjj7c3CPXcmQI
         XopaHITZw9tz3IENKrFhYw4SrbqxSTOypl10rty1Lzl+tUFqZgvL7sJpfDTFT2ggn0Ok
         5otXgnYxtogXH1Nyo4aaa6W/HaLJGV4Wn6mkW3B8Zgzo3cs2DHDdP6FXbWjp8amv6WV7
         ctXQ==
X-Gm-Message-State: ABuFfojCyv3k2OF6VoxFZEJP5Y6aJwYLxpxOGTR2mgoFuyn1mp/fX2fd
        2tSmIJw9Kgv68TDTMLJQBU8=
X-Google-Smtp-Source: ACcGV63Yr3cNdbSY5DTB5GSFKrpdIXCFJ0hEvk1Lo0w06Bgmop3PYJnUzzluery9TKP4Mtfrz/f1/Q==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr8133569plb.176.1537749963644;
        Sun, 23 Sep 2018 17:46:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/20] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date:   Mon, 24 Sep 2018 03:41:34 +0300
Message-Id: <20180924004153.8232-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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

