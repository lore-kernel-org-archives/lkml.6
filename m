Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14654C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AE220894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AE220894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeGaA2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:28:12 -0400
Received: from mail-d.ads.isi.edu ([128.9.180.199]:33300 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeGaA2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:28:11 -0400
X-IronPort-AV: E=Sophos;i="5.51,424,1526367600"; 
   d="scan'208";a="2623819"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 15:51:00 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] powerpc: factor out RapidIO Kconfig menu entry
Date:   Mon, 30 Jul 2018 18:50:31 -0400
Message-Id: <20180730225035.28365-4-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The menu entry is now defined in the rapidio subtree.  Also, re-order
the bus menu so tha the platform-specific RapidIO controller appears
after the entry for the RapidIO subsystem.

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/powerpc/Kconfig | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 25d005af0a5b..17ea8a5f90a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -993,16 +993,7 @@ source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
+source "drivers/rapidio/Kconfig"
 
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
@@ -1012,8 +1003,6 @@ config FSL_RIO
 	  Include support for RapidIO controller on Freescale embedded
 	  processors (MPC8548, MPC8641, etc).
 
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config NONSTATIC_KERNEL
-- 
2.18.0

