Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84AC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1241220892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPyicPac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1241220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeKITia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKITi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:38:29 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C723B20883;
        Fri,  9 Nov 2018 09:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541757519;
        bh=6twvW47HJnNmQ3p9fShCfSZFiKbUVIxdff5p2s09lxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPyicPacCDqASKkdZKLpvnhtvAvLt+O1wHkioh+72tkRXECsSmyk/xbpjgp8lZcWp
         mxQP6sc+k0Lw7pZ61+cr+1MVXjRpt78U3Q1NR1SMkaCPpQgm13vLr0PQhG0wgOMUsj
         CCgu9MNvC8c7C71sOHMal5cuNmdoX2iTm5TWXNlY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/2] arm64: defconfig: Enable some qcom remoteproc configs
Date:   Fri,  9 Nov 2018 15:28:03 +0530
Message-Id: <20181109095803.16036-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181109095803.16036-1-vkoul@kernel.org>
References: <20181109095803.16036-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Enable remoteproc configs to boot the remoteprocs on QC chipsets. These
are common configs and not specific to a specific SoC so should be enabled
across the board.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
v2: fixed the change of config names

 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b02da2e7a39a..09732a9b46bb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -614,9 +614,15 @@ CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_REMOTEPROC=m
+CONFIG_QCOM_Q6V5_MSS=m
+CONFIG_QCOM_Q6V5_PAS=m
+CONFIG_QCOM_SYSMON=m
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
+CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_QCOM_GLINK_SSR=m
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
-- 
2.14.4

