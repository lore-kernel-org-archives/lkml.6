Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5457BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E780121476
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QkdclCl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E780121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeHBKbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:31:18 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:58527 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:31:18 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1C80E10C0CBC;
        Thu,  2 Aug 2018 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533199271; bh=4vk8GAZcFVoNepn7v002nW+pIhEgcYf+o2Vslit3gFA=;
        h=From:To:Cc:Subject:Date:From;
        b=QkdclCl3Kagv9UJk11x7U9OdPq8mnY9/rU1C7KTU9xhOhnV2HI0p0icussQiTUzTn
         HnTz9Cj2dCxWmmw/tZr1p3Fo3N5LrVgERs7WB4Gnej6MtZFrwf0WdvGmXUWYQMVV3z
         fN9XogyvPkNtYoikyQ0iIKN/x1H+ctepUDb13Ngtu2qicBfmT25Lgk8P/OCZ9qnfzD
         7FFeLJRSnmnXDsg3M2flx32OW5nMvrRp26prcc5/VvnrQOww7cLyyRmSjxZo4zRvoQ
         D9/tOgSk+M42rQ8VSEU/qjRvt56g2HolBvYGKzBRxer5sRa71TwLeNADXmOYPcT/lN
         9/65BqXCXQIBw==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id DAE2A36CE;
        Thu,  2 Aug 2018 01:41:09 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: Remove CONFIG_DEFAULT_HOSTNAME from defconfigs
Date:   Thu,  2 Aug 2018 11:41:07 +0300
Message-Id: <20180802084107.14616-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to set the same hostname to all ARC boards
by default. It usually gets overwritten by init scripts anyways.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/configs/axs101_defconfig          | 1 -
 arch/arc/configs/axs103_defconfig          | 1 -
 arch/arc/configs/axs103_smp_defconfig      | 1 -
 arch/arc/configs/haps_hs_defconfig         | 1 -
 arch/arc/configs/haps_hs_smp_defconfig     | 1 -
 arch/arc/configs/hsdk_defconfig            | 1 -
 arch/arc/configs/nsim_700_defconfig        | 1 -
 arch/arc/configs/nsim_hs_defconfig         | 1 -
 arch/arc/configs/nsim_hs_smp_defconfig     | 1 -
 arch/arc/configs/nsimosci_defconfig        | 1 -
 arch/arc/configs/nsimosci_hs_defconfig     | 1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig | 1 -
 arch/arc/configs/vdk_hs38_defconfig        | 1 -
 arch/arc/configs/vdk_hs38_smp_defconfig    | 1 -
 14 files changed, 14 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 55686cc4bb19..3dbb2b3f60af 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 20fb8e4e7337..4d7b85d4b2dc 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 51d1e866ce94..92417e2e39f3 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index ab231c040efe..4984d9ed1573 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index cf449cbf440d..1e93690b4a4f 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index ba101d12515f..200d4ee436bc 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_NO_HZ_IDLE=y
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 31c2c70b34a1..0b59778604e4 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
index a578c721d50f..e829b683887d 100644
--- a/arch/arc/configs/nsim_hs_defconfig
+++ b/arch/arc/configs/nsim_hs_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
index 37d7395f3272..bef937c551f8 100644
--- a/arch/arc/configs/nsim_hs_smp_defconfig
+++ b/arch/arc/configs/nsim_hs_smp_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index 1e1470e2a7f0..ac601e33bb47 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 084a6e42685b..fef290c65e4c 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index f36d47990415..c0d19623aa82 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index f629493929ea..4a459de56679 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index 21f0ca26a05d..a8ac5e917d9a 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -1,5 +1,4 @@
 # CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_DEFAULT_HOSTNAME="ARCLinux"
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
-- 
2.17.1

