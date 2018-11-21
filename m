Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BA3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F28520672
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cVYd3LrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F28520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbeKVHjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:39:04 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:36168 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbeKVHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:39:04 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1A51424E039E;
        Wed, 21 Nov 2018 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542834186; bh=aLg11JFpGtVAbOU1QFpIpeM1H5L/LipawYumQraMjSE=;
        h=From:To:Cc:Subject:Date:From;
        b=cVYd3LrMAfGDom3GYUndfq71QzL1J/QYoZ7/+ZLR5qxovyvfeYDXefAe6KI/6Wp08
         U9QfDn7Jk4u4d2b6umPESPuPd9xaeWla0vXA0HKHKY8s+x0Cqyng8efrfATEaj3/ux
         5nEOONE6DJ3ZW6xzciX8CvUMmLh/QLqt11X5nAUGsf052B2w0j2qLQeLOPyOdtBrxJ
         3pNpLL8JBrPqCUtQCm1Fikg62KfGuanbDVKMQvSxwZt04rtC25xNq3z6ZZLBZYWKD1
         C6sBQM1zcV7VnBT0dW4v8zejilZrbZagNQ8bxhWca9MWySsq3WRaFtkhHP1YDFyFmq
         BlOMahdVARk5g==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id E5B6C45A4;
        Wed, 21 Nov 2018 13:03:04 -0800 (PST)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Subject: [PATCH] arc: [nsim] Disable NFS
Date:   Thu, 22 Nov 2018 00:03:01 +0300
Message-Id: <20181121210301.7010-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pure nSIM models only CPU core and serial port thus
no point in having NFS enabled.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/configs/nsim_700_defconfig    | 1 -
 arch/arc/configs/nsim_hs_defconfig     | 1 -
 arch/arc/configs/nsim_hs_smp_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 8e0b8b134cd9..4754145f6e1b 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -54,7 +54,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
index 739b90e5e893..38525155773b 100644
--- a/arch/arc/configs/nsim_hs_defconfig
+++ b/arch/arc/configs/nsim_hs_defconfig
@@ -55,7 +55,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
index b5895bdf3a93..c5d35069a35c 100644
--- a/arch/arc/configs/nsim_hs_smp_defconfig
+++ b/arch/arc/configs/nsim_hs_smp_defconfig
@@ -54,6 +54,5 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-- 
2.16.2

