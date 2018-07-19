Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDABECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E007120854
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="apQW0Swu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rrrt2TAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E007120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGSDSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:18:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbeGSDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:18:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C1A46071B; Thu, 19 Jul 2018 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531967838;
        bh=lMup+nRBbsAfz0p6b5jnf9zH1hX7SwbDYVzNvDN1ZpI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=apQW0SwukTxKGQHIHA72m88R+wHuCE4+PufNZmSxoqq/ZWEdT5e2A4rge7JNvg6+I
         SF6Apj7X8cIiBj3oIzPmzKwtVrI6A9PwusrR4D36R7cgj4pWVZPX3CBJOxRG5v78S8
         M/45CpKYVGSPUt9/kjbfPPiG9C5teYp1C3VsiIuQ=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44F956071B;
        Thu, 19 Jul 2018 02:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531967837;
        bh=lMup+nRBbsAfz0p6b5jnf9zH1hX7SwbDYVzNvDN1ZpI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Rrrt2TAMl8Jwl5wMYVR8w3wOH0E5EIAhsLbucovBTRu6EXsV6TQMaYjkLCMWXPma7
         6PwL0T556YCgOpkS0vi20WFhurvQP9YnMhhHjk1Oh/9EuXGhk2hBUwMH9o95Jkwc5P
         WyIYj4IiDR3XgDBNPAkfDKI0iCnnVGheIiVCurJQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44F956071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        amit.kucheria@linaro.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
Subject: [RFC PATCH v2 2/2] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Wed, 18 Jul 2018 19:37:00 -0700
Message-Id: <1531967820-27483-3-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531967820-27483-1-git-send-email-daidavid1@codeaurora.org>
References: <1531967820-27483-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RSC(Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 228d502..caffa67 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1091,6 +1091,11 @@
 
 				pmi8998_bob: bob {};
 			};
+
+			qnoc: qnoc{
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

