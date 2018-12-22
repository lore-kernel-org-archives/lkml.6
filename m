Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75DC21939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437711;
	bh=pX0IOiFX3UWov71xwCwG+qqO+gekykdR6rF12gbD30I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFez92YDgs+ZVeGk0L5B3sAttfCDvWzyESiLtrbsHpzZ27dzGqF6Jl44bU+a6/I3u
	 ozKn3w/wXOAozRrZ4HnzSFlzhzuKhE7J3Bl0T6h3KqjZTmpWPyPltUqULqZV9+sYH8
	 pec5XYXeDL9ESo6s8QcMSK7pZeoBmJKw3uqRJQFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404727AbeLVAPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392217AbeLVAPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:03 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DA021927;
        Sat, 22 Dec 2018 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437703;
        bh=pX0IOiFX3UWov71xwCwG+qqO+gekykdR6rF12gbD30I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zli7NyNl3szGpKwndYWoX2FzxfwousNIjaT44iXTIsbNaF/6etcPtuLptFzVXSXbT
         tLOJzUq4UvekTzj5mW3rqLNlzlnnQdLZsTR0159bi+VfWN5FKIpFyCIi6iyrl//azJ
         C5FNCiaKo4l9OxGnsNqf+Eu5sckCF7u43jVASfn4=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 04/11] platform/x86: make PCI dependency explicit
Date:   Sat, 22 Dec 2018 00:14:45 +0000
Message-Id: <20181222001452.7474-5-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
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

