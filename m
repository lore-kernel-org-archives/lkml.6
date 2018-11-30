Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28BBC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8647220867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iU0kIELw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8647220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeLAABU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:01:20 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37718 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLAABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:01:20 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4AFB010C164E;
        Fri, 30 Nov 2018 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543582327; bh=FuhQb2lqpSXXlmjXkfczrDAH9W1VHN54RKKoDxU6IOI=;
        h=From:To:Cc:Subject:Date:From;
        b=iU0kIELwMxOKBmEJXCUMfzfvkXvuIMzegiZVdKG76rf0lw6XYIuTk7GEbXkVNaTHy
         aiXHlQz5dewiW/foWTrhRZf2Q6ALv+qHJY8ZXcSQUFh4DUQhG7eSvYrqlgwoZwdkZp
         5DG519sDITiag47VdDO0rBhijQJXwIvI+QI5abjS7aJgiA6WMiQjcjYowBve2q5L2O
         NsWdRejPndFGLe8bD7ooqMjwnknz/6nMJleuuLWqIoFauOG4Z+DX7IEdNMypN7Bc5X
         RSnrYipepgYj3mYnE/VZupGhFylRiHxrAbo4McCcsSQCkY7XU5jr0goVl9m5KbhvCI
         XDF0g2DYM1b1Q==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id B8E7032F7;
        Fri, 30 Nov 2018 04:52:05 -0800 (PST)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] ARC: change defconfig defaults to ARCv2
Date:   Fri, 30 Nov 2018 15:51:56 +0300
Message-Id: <20181130125156.34460-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

Change the default defconfig (used with 'make defconfig') to the ARCv2
nsim_hs_defconfig, and also switch the default Kconfig ISA selection to
ARCv2.

This allows several default defconfigs (e.g. make defconfig, make
allnoconfig, make tinyconfig) to all work with ARCv2 by default.

Note since we change default architecture from ARCompact to ARCv2
it's required to explicitly mention architecture type in ARCompact
defconfigs otherwise ARCv2 will be implied and binaries will be
generated for ARCv2.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: <stable@vger.kernel.org> # 4.4.x
---

Changes v1 -> v2:
 * Added CONFIG_ISA_ARCOMPACT to ARCompact defconfigs

 arch/arc/Kconfig                    | 2 +-
 arch/arc/Makefile                   | 2 +-
 arch/arc/configs/axs101_defconfig   | 1 +
 arch/arc/configs/nps_defconfig      | 1 +
 arch/arc/configs/nsim_700_defconfig | 1 +
 arch/arc/configs/nsimosci_defconfig | 1 +
 arch/arc/configs/tb10x_defconfig    | 1 +
 7 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5fcbda6b37cc..6dd783557330 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -109,7 +109,7 @@ endmenu
 
 choice
 	prompt "ARC Instruction Set"
-	default ISA_ARCOMPACT
+	default ISA_ARCV2
 
 config ISA_ARCOMPACT
 	bool "ARCompact ISA"
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index c64c505d966c..df00578c279d 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 # published by the Free Software Foundation.
 #
 
-KBUILD_DEFCONFIG := nsim_700_defconfig
+KBUILD_DEFCONFIG := nsim_hs_defconfig
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 8c23bd086cd0..020d4493edfd 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -14,6 +14,7 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
index ae7a0d8be98d..6e84060e7c90 100644
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 8e0b8b134cd9..219c2a65294b 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -15,6 +15,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_LBDAF is not set
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index ad77f20e5aa6..35dfc6491a09 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -15,6 +15,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_LBDAF is not set
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index a7f65313f84a..e71ade3cf9c8 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -19,6 +19,7 @@ CONFIG_KALLSYMS_ALL=y
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
-- 
2.16.2

