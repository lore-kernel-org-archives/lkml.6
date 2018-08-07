Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D415C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB72208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB72208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbeHGLHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:07:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51154 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387547AbeHGLHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:07:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDEBB80D;
        Tue,  7 Aug 2018 01:54:17 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.Emea.Arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85ACF3F5D4;
        Tue,  7 Aug 2018 01:54:16 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 0/2] iommu/rockchip: Runtime PM fixes
Date:   Tue,  7 Aug 2018 09:54:04 +0100
Message-Id: <20180807085406.3863-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series addresses a couple of runtime PM issues I've spotted
while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
specifically doing kexec.

Note that even with these two patches, kexec is still fairly broken on
rk3399, as the VOP is never turned off (see [1] for a fix).

[1] https://www.spinics.net/lists/arm-kernel/msg670229.html

Marc Zyngier (2):
  iommu/rockchip: Handle errors returned from PM framework
  iommu/rockchip: Move irq request past pm_runtime_enable

 drivers/iommu/rockchip-iommu.c | 45 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 17 deletions(-)

-- 
2.18.0

