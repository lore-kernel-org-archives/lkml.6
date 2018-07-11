Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0460C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5794620C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="l5XZrAij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5794620C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeGKVGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:06:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39531 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbeGKVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:06:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so9677717plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kH1OAZbg4SwsSjoTfYNN6AUhqR4P0nNvaqNShxI+kSc=;
        b=l5XZrAijAYHSDSxhC7/+OCJkFZ6DmlzDg70Opshn9JVDFjmSp/MhUT4BPv1veFlS69
         DcIJmVeTMycWF1sjS8cvMBCrUvnMIRrtlr8JnDV5GfCmVwzHJM7PnHN/igKoUYU0BCBV
         5hqT5yDnT5K69YOvVU1DBk4vmQI+vJhQMLzZfOXjmVDdlBliYaVdm62zaDKsjLj8aJoR
         KLpgC8IAI/e0voESQdze/LGGxwfFsBXp33F5Ba5V7SRAT2+GNxuAbTdAAGmRHjFWDMlK
         s1rEZ4FHwuwZDKnAmj2Y19Xy2CmePlpc6ly+sLqlOASvHrpU4+GKo1h24/SBstI9tFsm
         Qbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kH1OAZbg4SwsSjoTfYNN6AUhqR4P0nNvaqNShxI+kSc=;
        b=IpFFkwRm66q99mqLqhCrd0YDuUwcVbmu8y0B74bbs7Fbii8DzzCp7AE7Mka/lT8MaQ
         /vB8T4x9Cht406DhwAVyfcxyrb1FSMT90Xwu0RAsHiS7bTJiizNarHZzghn11A9icwys
         LBFkYOcL7RZLO87QdZFPvj3o56WQGF0en8JLMntUU97MgEB2eoyFQETXIhnkTe4GCT4C
         pU/2IKfgZaZbpkWgposD/CR1hjAT3Y34JlRDpo1jfFUZubL0W1rAWHbL+Y7v0sB4sFS5
         Njmopox+Z8g3cp/br33/GDcNzi8ArhhySa/lAaIKJHghzHZTc6f9oAbLFHDq9kgBacKt
         KxRA==
X-Gm-Message-State: AOUpUlGPDI+lAl5pmrkGUAeMct2kwNS8bUpF9tnctAjtu/U+LcwHwcIO
        FIlI/aBL5MGePdjKlTeXX6zNwg==
X-Google-Smtp-Source: AAOMgpdA27c5kQ3jVfWzB+O13TJuJdctDPGZppzGah4kmmj1q6sbjyf8EJbKqQ8hOJlMkklicSL2hA==
X-Received: by 2002:a17:902:2927:: with SMTP id g36-v6mr160180plb.303.1531342795922;
        Wed, 11 Jul 2018 13:59:55 -0700 (PDT)
Received: from localhost.localdomain (173-13-129-225-sfba.hfc.comcastbusiness.net. [173.13.129.225])
        by smtp.gmail.com with ESMTPSA id j2-v6sm22867564pff.35.2018.07.11.13.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 13:59:54 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/2] iommu: Add config option to set passthrough as default
Date:   Wed, 11 Jul 2018 13:59:35 -0700
Message-Id: <20180711205936.18614-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the default behavior to be controlled by a kernel config
option instead of changing the commandline for the kernel to include
"iommu.passthrough=on" on machines where this is desired.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/iommu/Kconfig | 10 ++++++++++
 drivers/iommu/iommu.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 689ffe538370..a9bb1a5b5e43 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "IOMMU passthrough by default"
+	depends on IOMMU_API
+        help
+	  Enable passthrough by default (removing the need to pass in
+	  iommu.passthrough=on through command line). If this is enabled,
+	  you can still disable with iommu.passthrough=off
+
+	  If unsure, say N here.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b37563db7e..ab8fc54467e0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -36,7 +36,11 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+#else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+#endif
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
-- 
2.11.0

