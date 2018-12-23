Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA14C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC96621971
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607537;
	bh=pX0IOiFX3UWov71xwCwG+qqO+gekykdR6rF12gbD30I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+y294/lGjkLKmxkR4C6Cz26tS6zoaf7YEtP/ujcazUikwUpnzOTSXb2nBPVFqPoH
	 q8+1cNGxp/YDvG9jVt4cRi/wMhMAGJ5XHQI+RVuz7Oy19KpTsVHkw9vDjOOy7nPSNO
	 36bjL/h6IiLGgSXrcn0p0eCsUe3IjbXAE3O/FTv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLWXZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeLWXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:31 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60EB621783;
        Sun, 23 Dec 2018 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607531;
        bh=pX0IOiFX3UWov71xwCwG+qqO+gekykdR6rF12gbD30I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4Jn3r+Y0iMWg3y0fEIjBPVOVJaaip+rU5jzwaEEuLfi5VVfPm3JzF66pNCLADgoq
         LuGTnpyfszwzCfL+XKUA8yC6SRY/+UwLWuNlCbnPEYQOSoi1oZLWCGx04KK5Xp+mbL
         xM+TC+sKHMshfRH2vUGMXNFsEsDWTNRwWYhAlT0Q=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/11] platform/x86: intel_ips: make PCI dependency explicit
Date:   Sun, 23 Dec 2018 23:25:13 +0000
Message-Id: <20181223232521.11320-5-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipss driver is a PCI device driver but this has not been mentioned
anywhere in Kconfig.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e3b62c2ee8d1..b36ea14b41ad 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1009,7 +1009,7 @@ config INTEL_MFLD_THERMAL
 
 config INTEL_IPS
 	tristate "Intel Intelligent Power Sharing"
-	depends on ACPI
+	depends on ACPI && PCI
 	---help---
 	  Intel Calpella platforms support dynamic power sharing between the
 	  CPU and GPU, maximizing performance in a given TDP.  This driver,
-- 
2.19.0

