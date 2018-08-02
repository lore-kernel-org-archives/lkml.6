Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2C8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F34B214F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RlL0RSF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F34B214F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeHBKuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:50:01 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:33622 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeHBKuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:50:01 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D7E4824E0796;
        Thu,  2 Aug 2018 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533200388; bh=2juGTyWYE2h9zLrDxnx2HGGuijRcjUzlFb+O7J3rk3M=;
        h=From:To:Cc:Subject:Date:From;
        b=RlL0RSF54leLuobTVnz4QKWlgCgJ9RiBut9ec3csH4gJxbfhj2J/06jYrKIQjy6Z/
         suAhssQAXGmY08TdaJLkwqj3qfEZVDE+PMgWyZEUqJdN0Uu25leBTJjhp7NnMVD35a
         ja4ktzoEjvJdxC6refW7WjPOI5fwca5o61Kt1YLbZj6EtvDS11FKLWn/bcvMEP3qCO
         LMqwR9ydWXQVDt4TELrySQyenuxmKzYZryHi4zZMhNhJS9rfAdaaqvwegTdSGzWJhj
         6N29FuB+sSLOchkIFZ2IwqNmfdVeewmxirpdXnLcrdXe7I4/NH95t8+8lsqFf2MM7E
         d82Xxt3A+HmwQ==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7ECD759F6;
        Thu,  2 Aug 2018 01:59:47 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: [PATCH] ARC: Remove disabled CONFIG_DEVKMEM from defconfigs
Date:   Thu,  2 Aug 2018 11:59:45 +0300
Message-Id: <20180802085945.18651-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEVKMEM by default is disabled so clean-up
our defconfigs.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
---
 arch/arc/configs/axs101_defconfig          | 1 -
 arch/arc/configs/axs103_defconfig          | 1 -
 arch/arc/configs/axs103_smp_defconfig      | 1 -
 arch/arc/configs/haps_hs_defconfig         | 1 -
 arch/arc/configs/haps_hs_smp_defconfig     | 1 -
 arch/arc/configs/nps_defconfig             | 1 -
 arch/arc/configs/nsim_700_defconfig        | 1 -
 arch/arc/configs/nsim_hs_defconfig         | 1 -
 arch/arc/configs/nsim_hs_smp_defconfig     | 1 -
 arch/arc/configs/nsimosci_defconfig        | 1 -
 arch/arc/configs/nsimosci_hs_defconfig     | 1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig | 1 -
 arch/arc/configs/tb10x_defconfig           | 1 -
 arch/arc/configs/vdk_hs38_defconfig        | 1 -
 14 files changed, 14 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 96b7258a76be..67cfb46675a2 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -61,7 +61,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 CONFIG_MOUSE_SERIAL=y
 CONFIG_MOUSE_SYNAPTICS_USB=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 72fc21ef1334..42a743c54520 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -62,7 +62,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 CONFIG_MOUSE_SERIAL=y
 CONFIG_MOUSE_SYNAPTICS_USB=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 2ac89bd00e28..5886fdcacb34 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -63,7 +63,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 CONFIG_MOUSE_SERIAL=y
 CONFIG_MOUSE_SYNAPTICS_USB=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index 4984d9ed1573..765ec516135c 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -57,7 +57,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_ARC_PS2=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index 1e93690b4a4f..1f97b63c77f3 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -60,7 +60,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_ARC_PS2=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
index 7c9c706ae7f6..31ba224bbfb4 100644
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -59,7 +59,6 @@ CONFIG_NETCONSOLE=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 0b59778604e4..b3c3c5763a3e 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -44,7 +44,6 @@ CONFIG_LXT_PHY=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_ARC=y
 CONFIG_SERIAL_ARC_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
index e829b683887d..cd7aed46e6bf 100644
--- a/arch/arc/configs/nsim_hs_defconfig
+++ b/arch/arc/configs/nsim_hs_defconfig
@@ -45,7 +45,6 @@ CONFIG_DEVTMPFS=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_ARC=y
 CONFIG_SERIAL_ARC_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
index bef937c551f8..84a2a31fd0d4 100644
--- a/arch/arc/configs/nsim_hs_smp_defconfig
+++ b/arch/arc/configs/nsim_hs_smp_defconfig
@@ -44,7 +44,6 @@ CONFIG_DEVTMPFS=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_ARC=y
 CONFIG_SERIAL_ARC_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index ac601e33bb47..f3750934f7b3 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -48,7 +48,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_ARC_PS2=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index fef290c65e4c..0069a254215a 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -47,7 +47,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_ARC_PS2=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index c0d19623aa82..dd5a7e22944e 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -58,7 +58,6 @@ CONFIG_MOUSE_PS2_TOUCHKIT=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_ARC_PS2=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 1aca2e8fd1ba..8129ca7b5ff0 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -58,7 +58,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_VT is not set
 CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 4a459de56679..db47c3541f15 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -52,7 +52,6 @@ CONFIG_NATIONAL_PHY=y
 CONFIG_MOUSE_PS2_TOUCHKIT=y
 CONFIG_SERIO_ARC_PS2=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
-- 
2.17.1

