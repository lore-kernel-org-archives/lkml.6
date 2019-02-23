Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A312EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6856720855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956354;
	bh=AA62J+TuPdkYekuVMLVaG/m5V3YDAF21EHUmxlT6wds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L8D9+XugdM1POsSeDDuk5dqCXRy1GNSzHe5zQ1hhXrNHbZ7nhf14nAM5L+FxsO3kE
	 o06ghM9lIGNp1RSeqqmvbGnL0N5uK5llgO9x7qyerkug9WiWJNmfE8FiAXMv2o5eYG
	 sBwDCkQFbkjs1YLr2IzAW4wOP4vKx0mWKjdwm/zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfBWVL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730074AbfBWVL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CF520861;
        Sat, 23 Feb 2019 21:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956316;
        bh=AA62J+TuPdkYekuVMLVaG/m5V3YDAF21EHUmxlT6wds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7RrLxM35G41N8lt+aoZMNZdvF493Ycpd6NlG3vRzzIBswAw6w+RGOrbp49y2gHj+
         AiKBXF4bNJHHDR1Af7lkMHI68aoXFr2FmnWhWzirapLK66hFbywnB2bJlakMZyvzj/
         7EcCx/P/h3wvn6s59TOSiHQhoAolUqZEjMnd6fJw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 13/18] platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
Date:   Sat, 23 Feb 2019 16:11:30 -0500
Message-Id: <20190223211135.203082-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211135.203082-1-sashal@kernel.org>
References: <20190223211135.203082-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@kernel.org>

[ Upstream commit 0ee4b5f801b73b83a9fb3921d725f2162fd4a2e5 ]

Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

SAMSUNG_Q10 selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.

Copy BACKLIGHT_LCD_SUPPORT dependency into SAMSUNG_Q10 to fix:

WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
  Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
  Selected by [y]:
  - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index a2eabe6ff9ada..99913af2338c1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -806,6 +806,7 @@ config INTEL_OAKTRAIL
 config SAMSUNG_Q10
 	tristate "Samsung Q10 Extras"
 	depends on ACPI
+	depends on BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver provides support for backlight control on Samsung Q10
-- 
2.19.1

