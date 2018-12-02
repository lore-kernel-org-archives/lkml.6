Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F40AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE407206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE407206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeLBJTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:19:10 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:49403 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbeLBJTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:19:10 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3057B44004B;
        Sun,  2 Dec 2018 11:19:06 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] psi: fix reference to kernel commandline enable
Date:   Sun,  2 Dec 2018 11:18:50 +0200
Message-Id: <99058450a8c792cde07c7ced343bf1711c75b8f3.1543742330.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel commandline parameter named in CONFIG_PSI_DEFAULT_DISABLED
help text contradicts the documentation in kernel-parameters.txt, and
the code. Fix that.

Fixes: e0c274472d ("psi: make disabling/enabling easier for vendor kernels")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index cf5b5a0dcbc2..ed9352513c32 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -515,8 +515,8 @@ config PSI_DEFAULT_DISABLED
 	depends on PSI
 	help
 	  If set, pressure stall information tracking will be disabled
-	  per default but can be enabled through passing psi_enable=1
-	  on the kernel commandline during boot.
+	  per default but can be enabled through passing psi=1 on the
+	  kernel commandline during boot.
 
 endmenu # "CPU/Task time and stats accounting"
 
-- 
2.19.2

