Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED3FC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0092020890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0092020890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeGaA2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:28:17 -0400
Received: from mail-d.ads.isi.edu ([128.9.180.199]:33300 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbeGaA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:28:16 -0400
X-IronPort-AV: E=Sophos;i="5.51,424,1526367600"; 
   d="scan'208";a="2623823"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 15:51:05 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Date:   Mon, 30 Jul 2018 18:50:34 -0400
Message-Id: <20180730225035.28365-7-acolin@isi.edu>
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

Tested that kernel builds for arm64 with RapidIO subsystem and
switch drivers enabled, also that the modules load successfully
on a custom Aarch64 Qemu model.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a8f0c74e6f7f..5e8cf90505ec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -308,6 +308,8 @@ config PCI_SYSCALL
 
 source "drivers/pci/Kconfig"
 
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 menu "Kernel Features"
-- 
2.18.0

