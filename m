Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D62BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FB92156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BV4K5hwU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oixdu+gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FB92156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHXF3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:29:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeHXF3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:29:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF29D6028E; Fri, 24 Aug 2018 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535075834;
        bh=rLsxJ1a8x2mBZ6wLP2jpy1ou4PLj5peeDT4dr+vtY/Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BV4K5hwUR1yvYc05WaZH/T5P6f19iAWaaDSI2PxNiuSNBaDBv1if/k4g3z/7PhLJd
         VXvNOCq9cFkdTMTcwqGQ/c+IOKgvo9lQin0/7Kh+SbV+K5LANdmB4QiZ1E1+Pt/MsG
         aoTnHNWwVuI3poBjawe6pG93OvIvOgfhgcuZCvIE=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F0196053C;
        Fri, 24 Aug 2018 01:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535075833;
        bh=rLsxJ1a8x2mBZ6wLP2jpy1ou4PLj5peeDT4dr+vtY/Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Oixdu+gHItinI1IxC53G0lEP4NZEGxoBiHX9KlrDwT82qQSypixpAyR4LYswOMlhj
         NhYVmSZBc8z+gXWVi3pYTIfHk4H+w0Bpx0aFBRSvCWXgWqLV65z10vGjbrALfqENjv
         8Vou3wqlEaqxYoZcN1AdLKxTVWGEgOrPD6n7Vff4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F0196053C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        amit.kucheria@linaro.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com,
        evgreen@google.com
Subject: [PATCH v3 2/2] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Thu, 23 Aug 2018 18:56:54 -0700
Message-Id: <1535075814-17343-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org>
References: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RSC(Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Change-Id: I58f0bfc3ed484d7b45064dceb94dcfda507e9333
Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1097c7e..4d15784 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1651,6 +1651,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			qnoc: qnoc{
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		ufsphy: phy@1d87000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

