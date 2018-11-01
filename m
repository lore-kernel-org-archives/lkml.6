Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648EC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06120657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kunKR+QD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nsy9TE5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E06120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeKAVKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:10:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbeKAVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:10:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EA2460A34; Thu,  1 Nov 2018 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541074041;
        bh=j6k2jueKREAlqukUd/Hbhcqzh5EU7vsRwqSvkR+mUBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kunKR+QDVkqV3LMdjaZu0rbAAVahjMB4fM3zsAmpYYdh2rnerr0iLVWb6lUP3tE/L
         C1MCMHZhNl1Mq0F6qgqCdypyREU1a/ExswAqSZ/AyXAWDxgQXkAkv78qugKn7XUMvf
         mztdMutnWSkAnGnPmPNJIZBlm+44kGvMDGv70bmo=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9021F6021C;
        Thu,  1 Nov 2018 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541074040;
        bh=j6k2jueKREAlqukUd/Hbhcqzh5EU7vsRwqSvkR+mUBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsy9TE5TqGBLh4XKLxqtwqlmgQTrhx+Jq/aCNg5QCpOiEorcwYhcnPs4Xco4n9hmp
         Bygr/ujNYPSwhjF1sJAiPw+As34qq2qAIEfMRSdACo8wYZaI9xx84WZVCuB9O0AawD
         9SolhKa6EFnu3tWQWiuVbZA09qRBN+Ipsx2uQFyM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9021F6021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible string for SDM845 SOC
Date:   Thu,  1 Nov 2018 17:36:38 +0530
Message-Id: <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..f2ffbeb 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: Should contain:
 		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
 		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		"qcom,sdm845-sdhci" for sdm845 SOC
 		For SDCC version 5.0.0, MCI registers are removed from SDCC
 		interface and some registers are moved to HC. New compatible
 		string is added to support this change - "qcom,sdhci-msm-v5".
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

