Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF79C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1C120890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1C120890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeGaA2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:28:16 -0400
Received: from mail-d.ads.isi.edu ([128.9.180.199]:33300 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbeGaA2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:28:15 -0400
X-IronPort-AV: E=Sophos;i="5.51,424,1526367600"; 
   d="scan'208";a="2623822"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 15:51:04 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
Date:   Mon, 30 Jul 2018 18:50:33 -0400
Message-Id: <20180730225035.28365-6-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Tested that kernel builds for ARM with the RapidIO subsystem and switch
drivers enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index afe350e5e3d9..602a61324890 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
 
 source "drivers/pci/Kconfig"
 
+source "drivers/rapidio/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
-- 
2.18.0

