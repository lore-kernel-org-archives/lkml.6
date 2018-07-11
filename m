Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDE2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405AE20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c/z05n45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405AE20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbeGKRSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:18:54 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:39436 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeGKRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:18:54 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5D18324E01B3;
        Wed, 11 Jul 2018 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531329218; bh=OvG5BawBhb8rDB6nzWF8pfFIQpOLVFRbnSXg1P1glao=;
        h=From:To:Cc:Subject:Date:From;
        b=c/z05n45B1s7iDUhPflOyVcK8rPvQ1BiKyQmF7B2UcJAVoK618iLN3Py5PEKarigF
         1cM8fcqOv655MqjA97x9b+wjulqekz9ceMSAD0dXYeXXVT2Y+ElpC7DzsdF9l1Rmu4
         ayOMpB5E8K+qGLV77b8q982/WC9g1hfwOodtb8hCLQVjp1CgiZyLuPK6eh5jmb7wJh
         mqGYC7JAs05R/sbdV9qlCIMfBIdbsAP/2S7YhlWlD8ML/cZMMZJ/LAG0uxAOSNLohS
         hPcmstvZsot5CT08VImEEx77cchKue7G3U6uRR118tDrgGYfaS08/9b/intimHPzoD
         /64xzAOnREozg==
Received: from abrodkin-7480l.internal.synopsys.com (abrodkin-7480l.internal.synopsys.com [10.121.3.42])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0772A3927;
        Wed, 11 Jul 2018 10:13:36 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: [plat-axs10x] Get rid of auto-selected CONFIG_AX10x options
Date:   Wed, 11 Jul 2018 20:13:33 +0300
Message-Id: <20180711171333.1745-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4fbaf649ebbc ("ARC: [plat-axs10x] auto-select AXS101 or AXS103 given the  ISA config")
made selection of CONFIG_AXS10x option automatic so there's no point
in keeping them in defconfigs.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/configs/axs101_defconfig     | 1 -
 arch/arc/configs/axs103_defconfig     | 1 -
 arch/arc/configs/axs103_smp_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 13500399ea86..55686cc4bb19 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
-CONFIG_AXS101=y
 CONFIG_ARC_CACHE_LINE_SHIFT=5
 CONFIG_ARC_BUILTIN_DTB_NAME="axs101"
 CONFIG_PREEMPT=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index a0576308cccd..20fb8e4e7337 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
-CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
 CONFIG_ARC_BUILTIN_DTB_NAME="axs103"
 CONFIG_PREEMPT=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 9bd590c22620..51d1e866ce94 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
-CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
 CONFIG_ARC_BUILTIN_DTB_NAME="axs103_idu"
-- 
2.17.1

