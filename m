Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C38721906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="axBbMvRS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B1r9sqlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeLUG3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:29:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbeLUG3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:29:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51D8A6071C; Fri, 21 Dec 2018 06:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545373760;
        bh=iF5Tb1v9tMIT+cLJKIYWHklKGV5KpBvrxitTym4H0XI=;
        h=From:To:Cc:Subject:Date:From;
        b=axBbMvRSCp/KzzWB1IY0PRM4yN4yntMlPWcmg7W4qMME4cOnQNBfX6tDXqUM56B1r
         HiLRzlcATs77Cj4eK16Q/+gekMfuVEsMaB4kCcQK25juQl9c8QPCnFUNTHTULOtV1a
         4BxFCmjSV59Aq4dCV1XRcdOUil7lXMgQqvO3VNd4=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8130760208;
        Fri, 21 Dec 2018 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545373759;
        bh=iF5Tb1v9tMIT+cLJKIYWHklKGV5KpBvrxitTym4H0XI=;
        h=From:To:Cc:Subject:Date:From;
        b=B1r9sqlPpoEt9zL2cEfmdXoKWN1MWM8HAkT+1cqOvhWVcgY3GgS9vuJ3rcmueitqG
         iXQF+5jatpVVFkuKp4N/6DZ0h3a3ccIRGduSJGTZ9YTFuWFROdt83E0E9Knlcs4wXJ
         PCewpg7dDpzSHn2RTxxRgZzF08exGcneXK2U2RX8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8130760208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: [v1] arm64: dts: sdm845: add interconnect DT entries for MDSS on SDM845
Date:   Fri, 21 Dec 2018 11:59:08 +0530
Message-Id: <1545373748-1416-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect properties such as the source and the destination
ports for MDSS on SDM845.

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0ded68c..ba97547 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2120,6 +2120,11 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
+			interconnects = <&rsc_hlos MASTER_MDP0 &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_MDP1 &rsc_hlos SLAVE_EBI1>;
+
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+
 			iommus = <&apps_smmu 0x880 0x8>,
 			         <&apps_smmu 0xc80 0x8>;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

