Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B760C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FAF20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FAF20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeINMT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:19:57 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54286 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbeINMT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:19:57 -0400
Received: from sf.home (host86-186-94-77.range86-186.btcentralplus.com [86.186.94.77])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 03B70335CEB;
        Fri, 14 Sep 2018 07:06:51 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
        id 11609212B1F0A; Fri, 14 Sep 2018 08:06:48 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: enable GENERIC_HWEIGHT
Date:   Fri, 14 Sep 2018 08:06:46 +0100
Message-Id: <20180914070646.29273-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed on a single driver failure:
  ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!

CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: linux-ia64@vger.kernel.org
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8b4a0c1748c0..1a71f92f0b8e 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -576,3 +576,7 @@ config MSPEC
 	  If you have an ia64 and you want to enable memory special
 	  operations support (formerly known as fetchop), say Y here,
 	  otherwise say N.
+
+config GENERIC_HWEIGHT
+	bool
+	default y
-- 
2.19.0

