Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10615C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3987218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kgPJc1oB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W5RcAh4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfAXUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:22:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfAXUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:22:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 343CE60D3A; Thu, 24 Jan 2019 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361358;
        bh=ABF6vgsWKN9GZIGL/rqqe/8FztsVkObvmZPcf2pDx7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgPJc1oB11duIOWCWwQvIE/dmfB09j1MID6hSroVtD4WdRMzSZi1QEnY/YHDBfLFP
         5hOotnzxFRJodgINbgE0XPXmF/1IBDTb/4kaL3TCYfikNJjK9DhV8X1Dh4gltQPrSa
         5v+hhLWfO7HlCv4gqjhm6gFVHrIEXiwm9Yn0h3lw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 072216165F;
        Thu, 24 Jan 2019 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361344;
        bh=ABF6vgsWKN9GZIGL/rqqe/8FztsVkObvmZPcf2pDx7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5RcAh4ib71h16T+Vr4wCaSfBTzAqsafE5LWuuN8KMipxIN3TRtGu1LRm2d85MjLA
         cVSN0Rq+ASED1R57XA6MDLnIy9KpGjY9UN5Rok5pxoI3IllNF/LPlZb7XzP9dJJ5aa
         5rmNr3qIDx8H1k8I3F+As9FXtTtXu3XtYLmO8YA4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 072216165F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 8/8] arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845
Date:   Thu, 24 Jan 2019 13:22:05 -0700
Message-Id: <20190124202205.7940-9-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124202205.7940-1-ilina@codeaurora.org>
References: <20190124202205.7940-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PDC interrupt controller for SDM845 devices. The interrupt
controller can detect wakeup capable interrupts when the SoC is in a low
power state.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2649b7102565..9e7c58803cd5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -658,6 +658,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
+CONFIG_QCOM_PDC=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

