Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB84ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25A2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PP6BI/Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbeGTSwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:52:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42878 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeGTSwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:52:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so7488483pgp.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCp62Z/oWd+D7S5Y1kWvUc7vFKn+4MHRRwBmAV6Pi2E=;
        b=PP6BI/AuZEOStL+fJhPux8ZpoqISAofEGG52pDguhZJAH4zrrPRg12WSB731FFi0Bw
         6EEy9GD5i5tYR8BZTPcOkbGgazbZxe/M6aZ1axh6eUK1E+8ir07LoGbAhaLL7HzqVNsb
         bf+ZI4r/cVY1k6lRogj4NvBgFauflTRa/WuILFM16LTE+/4rIuGUNFhEp7jxsvu3RcVD
         s9Rd2WbR0VzX4aijLR8oJQz9ohDHjG+UGmAxLq+rO6IaqRkTxjIX0IPBupfuQj1YZfcZ
         WBXYTg919mVlQ471eZT6khon3o21r88z85p3n5S6lzh40/QywiQtK8dGdhIvNqzr1M38
         lCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCp62Z/oWd+D7S5Y1kWvUc7vFKn+4MHRRwBmAV6Pi2E=;
        b=VgcVLUEtmpdbICwbKWiIl/S2k+k8tW4Ayp2eG0i8HRX0rRZQ9luAQHKEiciwqPOdXG
         YhQHGSIPb/ar0/hPk1JUHwRAw5VIjtRKcDnSVF33PsYXJ4N/4ASVXVmPQPn7GdUkmvz+
         OYJhTYJxekwi8ZxZ3rMUDTY3rPQWCoGWh+zmHLpYAnY+pp2EDRwbD+PXSt3XQwUXPQCh
         FBKa7KGPDuflfrYqnWCXmeg9PDwwfUiK1GpRtzJSi3EzGBJyurP1rObj9v9JjicaUmhH
         vlVsWKLMBzGaPpYiH2NWDooX9zRfSuwNhirSU8EmJEiDrdCLY+VjWThCFGNHk8dsuz8d
         EpeQ==
X-Gm-Message-State: AOUpUlGwKUpUfyF9PCJMMxolYLPv1cnSxEJZ8zvsfTYQlmUkIuy9GgGj
        XVijmBk7e/lA6PoI7QG5388row==
X-Google-Smtp-Source: AAOMgpcTwoyH046TSC63PI8cHmejT0FX2Rhirxnvk9GglHzIqGjOCoHisjBOIJRRru8ooJvl4wVUcg==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr3194899pfi.2.1532109776092;
        Fri, 20 Jul 2018 11:02:56 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id z10-v6sm3468601pfh.83.2018.07.20.11.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 11:02:54 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] iommu: Add config option to set passthrough as default
Date:   Fri, 20 Jul 2018 11:02:23 -0700
Message-Id: <20180720180223.29573-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711205936.18614-1-olof@lixom.net>
References: <20180711205936.18614-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the default behavior to be controlled by a kernel config
option instead of changing the commandline for the kernel to include
"iommu.passthrough=on" or "iommu=pt" on machines where this is desired.

Likewise, for machines where this config option is enabled, it can be
disabled at boot time with "iommu.passthrough=off" or "iommu=nopt".

Also corrected iommu=pt documentation for IA-64, since it has no code that
parses iommu= at all.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Chances since v1:
 - Added analogous behavior for Intel/AMD
 - Added iommu=nopt for x86 and updated docs

 Documentation/admin-guide/kernel-parameters.txt |  3 ++-
 arch/x86/kernel/pci-dma.c                       |  8 ++++++++
 drivers/iommu/Kconfig                           | 11 +++++++++++
 drivers/iommu/iommu.c                           |  4 ++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c9dbdf1009f1..4c822aa50f13 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1744,7 +1744,8 @@
 		merge
 		nomerge
 		soft
-		pt		[x86, IA-64]
+		pt		[x86]
+		nopt		[x86]
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..0acb135de7fb 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -40,8 +40,14 @@ int iommu_detected __read_mostly = 0;
  * devices and allow every device to access to whole physical memory. This is
  * useful if a user wants to use an IOMMU only for KVM device assignment to
  * guests and not for driver dma translation.
+ * It is also possible to disable by default in kernel config, and enable with
+ * iommu=nopt at boot time.
  */
+#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+int iommu_pass_through __read_mostly = 1;
+#else
 int iommu_pass_through __read_mostly;
+#endif
 
 extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
 
@@ -135,6 +141,8 @@ static __init int iommu_setup(char *p)
 #endif
 		if (!strncmp(p, "pt", 2))
 			iommu_pass_through = 1;
+		if (!strncmp(p, "nopt", 4))
+			iommu_pass_through = 0;
 
 		gart_parse_options(p);
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 568ae81b0e99..1813319c8342 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -70,6 +70,17 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "IOMMU passthrough by default"
+	depends on IOMMU_API
+        help
+	  Enable passthrough by default, removing the need to pass in
+	  iommu.passthrough=on or iommu=pt through command line. If this
+	  is enabled, you can still disable with iommu.passthrough=off
+	  or iommu=nopt depending on the architecture.
+
+	  If unsure, say N here.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d227b864a109..6f8f59684def 100644
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

