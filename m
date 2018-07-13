Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D18ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8C20858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MbrKWRNy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VDJi5mQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A8C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeGMKID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:08:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:08:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94D9960B7F; Fri, 13 Jul 2018 09:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475647;
        bh=rtZFfpeeP3sYJt+dblteHR45TRoa/BXNVupV6RRD5j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbrKWRNy8MojyzUf3c3c/f2lhUnMy+++t+/Wj8dXAosD7dQQbMCE6b+tUYOIEPOL4
         1M3iD2xGoFCdC4gXTYgflCal1/qHOT3ZztwcD1pW17F1zxL2HhdCTa2k6PMC0OkowH
         WDyib7QRoYZnFjq91ygnHpZCNtoN67DMgWnvbDa4=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F2EC60791;
        Fri, 13 Jul 2018 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475646;
        bh=rtZFfpeeP3sYJt+dblteHR45TRoa/BXNVupV6RRD5j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDJi5mQ8nG7dYK9cLiE3WAdZ/WAQfdcAFw8sPayRt9xlZOZIS1MWCjFIxCdInvIWD
         GN8q3RM+Hqs5ed9dbq16QR4CbKHqX4HpZRiD9GUkwlkBuj+fcZZxNVf04jxjKW2Prz
         gxJK1XCeAdfUqcEqtU8c0Eu1I3F1aOf7SDzkI7sk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F2EC60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org
Subject: [PATCH RFC 5/7] mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
Date:   Fri, 13 Jul 2018 15:23:01 +0530
Message-Id: <1531475583-7050-6-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI-MSM platform is using devfreq ondemand governor.
Select devfreq governor for SDHCI-MSM platform.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/host/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c19..2ba2c62 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -442,6 +442,8 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select PM_DEVFREQ
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

