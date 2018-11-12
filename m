Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C557C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6241F22360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GDKe23io";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="evLlIa3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6241F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbeKLQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:31:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeKLQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:30:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2306D607B9; Mon, 12 Nov 2018 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542004748;
        bh=m7SrXHq7Rg/lm5piacVD9MCbGRWBAHGfhjMa++YxWAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDKe23io2WuTW89fI5zA3WUpSixoat0yLt3hMzt70HT5vy8+xlvtGZFwaD4Bxgfiz
         OIU2ZB+G73dbaCVQFU+87eebC1MHUsnHpRT+zmt0nlKxDV7q4Gg6TE+TqqXKleeGso
         XBZder53vXPQAqmeERkhhRbZ93DdLCsMQcbZ7IRA=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE1B260452;
        Mon, 12 Nov 2018 06:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542004747;
        bh=m7SrXHq7Rg/lm5piacVD9MCbGRWBAHGfhjMa++YxWAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evLlIa3ukys1bYZsAty3AMdbh5/y73I4WMDY7df9bzYW9YurRuR655EIiaoe7GqAK
         vfT7T/oOxOawfZchgibYt8uV/npOEC4kAH9WFL0ZhjbKLT3/yv8P4hZXKAa6hGVlpm
         h4aCOF3sYL4HTbC7LY9qfmCZGV9yIo1tpj30AUfc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE1B260452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH V2 1/2] dt-bindings: mmc: sdhci-msm: Add SoC-specific compatible strings
Date:   Mon, 12 Nov 2018 12:08:23 +0530
Message-Id: <1542004704-17066-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542004704-17066-1-git-send-email-vbadigan@codeaurora.org>
References: <1542004704-17066-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC-specific compatible strings for qcom-sdhci controller.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..b72871a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -4,12 +4,25 @@ This file documents differences between the core properties in mmc.txt
 and the properties used by the sdhci-msm driver.
 
 Required properties:
-- compatible: Should contain:
+- compatible: Should contain a SoC-specific string and a IP version string:
+	version strings:
 		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
-		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		"qcom,sdhci-msm-v5" for sdcc version 5.0
 		For SDCC version 5.0.0, MCI registers are removed from SDCC
 		interface and some registers are moved to HC. New compatible
 		string is added to support this change - "qcom,sdhci-msm-v5".
+	full compatible strings with SoC and version:
+		"qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
+		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
+	NOTE that some old device tree files may be floating around that only
+	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
+	but doing that should be considered a deprecated practice.
+
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
 	- SD Core register map (required)
@@ -29,7 +42,7 @@ Required properties:
 Example:
 
 	sdhc_1: sdhci@f9824900 {
-		compatible = "qcom,sdhci-msm-v4";
+		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 		reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 		interrupts = <0 123 0>;
 		bus-width = <8>;
@@ -46,7 +59,7 @@ Example:
 	};
 
 	sdhc_2: sdhci@f98a4900 {
-		compatible = "qcom,sdhci-msm-v4";
+		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 		reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 		interrupts = <0 125 0>;
 		bus-width = <4>;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

