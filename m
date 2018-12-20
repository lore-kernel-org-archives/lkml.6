Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E888C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0642084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QthjFVbM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bv552o4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbeLTNj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:39:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:39:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5436260734; Thu, 20 Dec 2018 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545313196;
        bh=wnQUw7jwo96D69aHNCTBik+TrUJRrc0PKK58qGQRFtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QthjFVbMDwwnRncUoM1NjAYur3lHB66M3pNO9Qw8sz/SX27p9wHUtyM223AVEO/2s
         9ddTuJ7niED85QcAmSNTeIE5kLzmzZma+e5CAjmrjpW/AAmL64Do8MNzHuLKbbU4Lw
         EIsbBlOYTMpZTIIl2Pw7+N+AMMUValYxv65+M7o4=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 986D0606FC;
        Thu, 20 Dec 2018 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545313195;
        bh=wnQUw7jwo96D69aHNCTBik+TrUJRrc0PKK58qGQRFtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bv552o4Z4RCry827KciDZnKLkaWfxWidA5hMy2uRJ2HkwaKM54H+//PZbYLOudHxi
         EfP4Z1YvtYHPNghJGkmw2qm9FZg3g90+be6dp9YURWwXENo2JRWLcNMLEFoRdnjrud
         xMLIBJP/PSGsXWn2cW+n6UJ7LAxGYSi7lQGmzgVs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 986D0606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845: Add ADSP reserve-memory nodes
Date:   Thu, 20 Dec 2018 19:09:33 +0530
Message-Id: <1545313174-13481-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
References: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory nodes required for remoteproc q6v5_adsp pil.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 23a253b..c0a012f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -88,6 +88,11 @@
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
+
+		pil_adsp_mem: memory@8b100000 {
+			reg = <0 0x8b100000 0 0x1a00000>;
+			no-map;
+		};
 	};
 
 	cpus {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

