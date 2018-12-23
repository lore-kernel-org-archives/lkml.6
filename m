Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E6CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FF1218A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607541;
	bh=vXpaqdyP174RWeyppfkKxUr4B+YYB9hBUJMorbc8ThA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7wpaNuIXUQet0he/6lsGgyxgKjb343lszIQOgf7lAS1x2AZiB0BMCDa8oifLEnTV
	 giuw8gsdH+BRF0mLBSN+8TZ/uBR52G4vy7k0/E2te/kBSDRVCanu+V1hrqYdedLYTE
	 yTwassC78ulel/5NczkeOitgBULJIUPimk9HXC3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeLWXZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeLWXZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:33 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F282184D;
        Sun, 23 Dec 2018 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607533;
        bh=vXpaqdyP174RWeyppfkKxUr4B+YYB9hBUJMorbc8ThA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7YsGMYNOYijPFobuswL98ETBwI5F/DeEHyW93a8E8cm0MNkGNFb60AKr2UAgMmc4
         DkUn1kP8i3FioZEmYq6US/tGRd1mnwgvWB+8hdM5it1qiAb438fgrmS+q5yy9zyAXk
         O8Kb1NOLLMiFsN1CxXBsMdK54Ixd2xk8DO5ULZJY=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 06/11] apple-gmux: Make PCI dependency explicit
Date:   Sun, 23 Dec 2018 23:25:15 +0000
Message-Id: <20181223232521.11320-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7afb96cb1cd6..89f4b86244a7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
 config APPLE_GMUX
 	tristate "Apple Gmux Driver"
 	depends on ACPI
+	depends on PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
-- 
2.19.0

