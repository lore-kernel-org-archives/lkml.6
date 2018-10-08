Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C60C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2176F2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TgrDb2ap";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k606hbre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2176F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJHUKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:10:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:10:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B7E560C81; Mon,  8 Oct 2018 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003554;
        bh=rtZFfpeeP3sYJt+dblteHR45TRoa/BXNVupV6RRD5j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgrDb2apHu7y2o04gEw3cudxaCXWtUT0JU/IXQ/4ROLll9+1HQ+o0suVbEfgZ9VWE
         Kj4oQOnJHXP97G4XhT5SHtidFQ3Jf0Ov+8ymGnDBIFNU7EgLgWNcKQIRCD88aavLmv
         KYH4NuXUogD1Rxr2om8m37+s1nolU4BALmAevhqc=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53B5360881;
        Mon,  8 Oct 2018 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003552;
        bh=rtZFfpeeP3sYJt+dblteHR45TRoa/BXNVupV6RRD5j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k606hbrehkjmS2IDrHRp6ZGiMF3TSSCAA+X98/X+TW16dLcYGNvA7ecThkNk0hy/1
         qVzUCub9PsbsuK7BmnXdceQTUnZo6YeJprc1TvhEjb/9Gu3Fc/4t16vdaALmGiTXHa
         j+22EvgaXdsMlq0igwV/B9wYbuLFZj0p1qIC5DD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53B5360881
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: [PATCH V1 5/7] mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
Date:   Mon,  8 Oct 2018 18:28:04 +0530
Message-Id: <1539003486-24087-6-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
References: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
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

