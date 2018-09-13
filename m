Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A0DC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA4C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA4C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbeIMSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:47:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeIMSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:47:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75694CF3;
        Thu, 13 Sep 2018 13:38:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 56/78] arm64: rockchip: Force CONFIG_PM on Rockchip systems
Date:   Thu, 13 Sep 2018 15:31:43 +0200
Message-Id: <20180913131811.374353349@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 7db7a8f5638a2ffe0c0c0d55b5186b6191fd6af7 ]

A number of the Rockchip-specific drivers (IOMMU, display controllers)
are now assuming that CONFIG_PM is set, and may completely misbehave
if that's not the case.

Since there is hardly any reason for this configuration option not
to be selected anyway, let's require it (in the same way Tegra already
does).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig.platforms |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -125,6 +125,7 @@ config ARCH_ROCKCHIP
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
+	select PM
 	select ROCKCHIP_TIMER
 	help
 	  This enables support for the ARMv8 based Rockchip chipsets,


