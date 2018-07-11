Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F1C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474FA20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G0aCK6V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474FA20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbeGKRIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:08:21 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39105 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:08:21 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4442124E022E;
        Wed, 11 Jul 2018 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531328587; bh=GwwtFcHroGyHpuG0I0BLw9EgBPE606DZVAZg0W+tIxo=;
        h=From:To:Cc:Subject:Date:From;
        b=G0aCK6V/SyY4hjJLK5dsnsLqKVXlWfyGNFdxdXWRABi4oDmdTxAuaxYqFgoxXUfaF
         Bf0XWZvuD26rdq20r0J9qrcId0IpLYU49vuGXAtzJUgzg/Vuo8hNOGq8V2egCS31jz
         IIseEkz3zRHNDvhHR5q5z9E31ZufcG5KlhEVxd7GHXO2huv7pt+8uW7WmUeoUbpDrS
         zl5sP2jBnv3gM0P/LU3QEsfSCAbjzeoB/yqqeo+aiJ4UQQsuEq4OQvRPm2QpFTyrYu
         Kouj+GZpZ1MJV5i34lcpf8Vor4itiaTd9FgTa6LNCX7q110ISYmH/fViIPemdWFRZa
         faGFUvB9S0y/w==
Received: from abrodkin-7480l.internal.synopsys.com (abrodkin-7480l.internal.synopsys.com [10.121.3.42])
        by mailhost.synopsys.com (Postfix) with ESMTP id E56913B73;
        Wed, 11 Jul 2018 10:03:05 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: Enable FUSE_FS on devboards
Date:   Wed, 11 Jul 2018 20:02:58 +0300
Message-Id: <20180711170258.30165-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to use FUSE file-systems such as SSHFS.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/configs/axs101_defconfig     | 1 +
 arch/arc/configs/axs103_defconfig     | 1 +
 arch/arc/configs/axs103_smp_defconfig | 1 +
 arch/arc/configs/hsdk_defconfig       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 09f85154c5a4..13500399ea86 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -94,6 +94,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
+CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 09fed3ef22b6..a0576308cccd 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -93,6 +93,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
+CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index ea2f6d817d1a..9bd590c22620 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -96,6 +96,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
+CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 1b54c72f4296..ba101d12515f 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -64,6 +64,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
+CONFIG_FUSE_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-- 
2.17.1

