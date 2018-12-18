Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10F621873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FalqUbGe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ktRkLgVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeLRSEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:04:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:04:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 135846021A; Tue, 18 Dec 2018 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545156293;
        bh=2jhh6tgZMpXhQ2EjT98PY55Rv6OzcMm+VOpyOCA8iu4=;
        h=From:To:Cc:Subject:Date:From;
        b=FalqUbGeFbWRftnAXrZ9mEw4z3ArmlY7EYOtyNwPWWIPAK6wi782KCp2+KsKkwg7u
         g7CZHR40bbQAFJkIj0/vClP7ir7x54dYw7/qZbjz9LzymXVBM92/Jkbu44RKo45WgS
         osrtNL3HTVFnEDINgyziSTUdSvJeqoxFtPRdnQew=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B80BF60591;
        Tue, 18 Dec 2018 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545156292;
        bh=2jhh6tgZMpXhQ2EjT98PY55Rv6OzcMm+VOpyOCA8iu4=;
        h=From:To:Cc:Subject:Date:From;
        b=ktRkLgVxHgkb19PSuyFk8pjzqu1gRd1R95gOPD5jBmK0ZamL2ewTnqizpS0NXOXQK
         rWvG53yzf3VpbD0dVLVO60BKpkNuZHXCFtL/nBSZGnjY1GeJ1fI1mSszUX7kR7Smiv
         vSKQpLZSsRPc2JX/PVv4TwdRCClanteWPlMSnHDM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B80BF60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: msm8998-mtp: Increase load on l21 for sdcard
Date:   Tue, 18 Dec 2018 11:04:43 -0700
Message-Id: <1545156283-5461-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l21 is used as sdcard vmmc, and needs the load increased to prevent
voltage drop issues with some sdcards.  This addresses -84 errors seen
during sdcard init with SDR104 cards.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 50e9033..288adbf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -192,6 +192,8 @@
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+			regulator-system-load = <800000>;
 		};
 		vreg_l22a_2p85: l22 {
 			regulator-min-microvolt = <2864000>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

