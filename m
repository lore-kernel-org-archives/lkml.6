Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2605C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6569D2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6569D2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeHXSm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:42:27 -0400
Received: from foss.arm.com ([217.140.101.70]:60050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeHXSm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:42:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C3415A2;
        Fri, 24 Aug 2018 08:07:24 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.emea.arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF85A3F5BC;
        Fri, 24 Aug 2018 08:07:22 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
Subject: [PATCH v2 2/4] arm64: rockchip: Force CONFIG_PM on Rockchip systems
Date:   Fri, 24 Aug 2018 16:06:35 +0100
Message-Id: <20180824150637.15316-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824150637.15316-1-marc.zyngier@arm.com>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of the Rockchip-specific drivers (IOMMU, display controllers)
are now assuming that CONFIG_PM is set, and may completely misbehave
if that's not the case.

Since there is hardly any reason for this configuration option not
to be selected anyway, let's require it (in the same way Tegra already
does).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac351fc3..21a715ad8222 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -151,6 +151,7 @@ config ARCH_ROCKCHIP
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
+	select PM
 	select ROCKCHIP_TIMER
 	help
 	  This enables support for the ARMv8 based Rockchip chipsets,
-- 
2.18.0

