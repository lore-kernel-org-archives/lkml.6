Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCFAC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25462080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCM4sHVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25462080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeLLUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38064 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so9156143plb.5;
        Wed, 12 Dec 2018 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4Qv/57YSOuii7c1Tuz+KC/jZPl9gkkiFtIGT0hxDTM=;
        b=RCM4sHVDxxwA1NCrJP56E2CynuY78JvUNZO8MeiZkQt9qx+HBEC2XDOwP8QoTOdk2F
         jsOjFFuvJJuLeHnnkgrCEBvmymkl98FfFg1+wFRh8dlT1COwCZeQezVsSRMs9NWSg4KT
         QzNFWGMxw5oAzow2Yas69/N0EvzF27iLaFruWPVaEu9DJs+4bXCG67NyIrM5GG+EenYz
         lwDNMvvZiXReDBnJZfDNGJ11h377gyOZIaXZodzFE6quJpoBmEsAagrfoKZrqfGynkwu
         l4z8GU5qeRrarlyRxOYk/fnSg1HpzHcOPHzJoBEnJT3FYkVR7yHT5CEToNlmenuJ+aVn
         bYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Qv/57YSOuii7c1Tuz+KC/jZPl9gkkiFtIGT0hxDTM=;
        b=PA8tP9nVpX70IN/49C8b22uKZEzhO/C5sM77RKrPvgbnXYbVuSYERcpTjwU1zSB8Sz
         oB6UwxsIH5pucVwUUtVuT3Z7Z14+EnjOiWPVYPN4O5gaWTWOSNCMRxnnEjdQt9unw96P
         x0nrTaE8vJcVqXEPNqHlQBSAAzPCdhso0WcG0xVwBuuZk+aDbuJYBFkY/WqmZ2xx8WYP
         +gf6smQZOhks6TLb8kD6BMFAO58lRI9EiJ+bHza//8Xo9qsbYXZSFL+AoLrbVfdjSZX7
         kUF1SeTIMmXaAPbn9mFnVZGNucckRBZGlsRtZ9kPCIJFM20zG0O47wPOCNMb2XFRRPLh
         +Qjw==
X-Gm-Message-State: AA+aEWb+WTUMhVMfzSplUUt1mO6dtI/JuQKCKPSE5CZ5sG7HLPMIu01l
        9HWGCaOytlVnFJISamxO8ss=
X-Google-Smtp-Source: AFSGD/UK79UJzdtSvpz00LmCrGtLELv75uTlKdO+AXwRWWEdRNTbv/Is7TJ12yK+WRdicL/qCT9YvQ==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr20947759plt.35.1544647925047;
        Wed, 12 Dec 2018 12:52:05 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/24] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date:   Wed, 12 Dec 2018 23:38:44 +0300
Message-Id: <20181212203907.23461-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
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
index da6a4e357b2b..ff75cf60117b 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,22 +19,15 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
 #include <linux/moduleparam.h>
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
2.20.0

