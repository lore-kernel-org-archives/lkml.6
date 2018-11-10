Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0315DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD8A208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD8A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeKKHy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:54:57 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:32770 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeKKHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:54:57 -0500
Received: from localhost.localdomain (85-76-84-189-nat.elisa-mobile.fi [85.76.84.189])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id E0F1430017;
        Sun, 11 Nov 2018 00:08:25 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver
Date:   Sun, 11 Nov 2018 00:06:12 +0200
Message-Id: <20181110220612.21653-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable OCTEON USB driver which is needed on older hardware
(e.g. EdgeRouter Lite) for mass storage etc. This got accidentally
deleted when config options were changed for OCTEON2/3 USB.

Fixes: f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more drivers")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/configs/cavium_octeon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 490b12af103c..c52d0efacd14 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -140,6 +140,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
+CONFIG_OCTEON_USB=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y
-- 
2.17.0

