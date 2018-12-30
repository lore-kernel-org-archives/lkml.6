Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB960C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9784B2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199788;
	bh=vD7pM55vLterchdIgXTgLSh+RedpgqA34yD+rNTIEp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iW8x7m3u1f304uFGkbpEUBy6bVBM/S0UUdz+lUWYQqZ+ll0Dq++DtJZJ0A5Wd2yxi
	 zEDiuThlPm/I9ONar+3tb1MOW7HVq/j+VHyIXCtW5z41rOB78j3b/hRQ51jKZk7h72
	 ul/TC4eGZzTQwnswFIEst+sP+Xt9s67GXPNZPRMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeL3T41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbeL3T4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:25 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595D620836;
        Sun, 30 Dec 2018 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199785;
        bh=vD7pM55vLterchdIgXTgLSh+RedpgqA34yD+rNTIEp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTSKBQw+sP8yrtiHyyNkYJSjicti/ZUCKnyu14krpyKBPkKtV2Thokpt1ZkvjAihD
         XytOezVJcI3wixRkBGS0PKpziFhTp6EbrYDcTKSjEilkdolvDXNd8a1sL2fT0ylAm0
         XQ3b5Ed47B48yENLJ3XDwirpy5RT7wmE9Rqolsmw=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/11] drivers: thermal: int3406_thermal: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:08 +0000
Message-Id: <20181230195612.6657-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need CONFIG_PCI to be set in order to be able to use this driver.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 0582bd12a239..fba1976d5f8d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -31,7 +31,7 @@ if INT340X_THERMAL
 
 config INT3406_THERMAL
 	tristate "ACPI INT3406 display thermal driver"
-	depends on ACPI_VIDEO
+	depends on ACPI_VIDEO && PCI
 	help
 	  The display thermal device represents the LED/LCD display panel
 	  that may or may not include touch support. The main function of
-- 
2.19.0

