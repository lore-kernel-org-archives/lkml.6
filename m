Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEEAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23A121721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WMVt93yC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ouw7TaHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfAVNjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:39:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfAVNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:39:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA77360860; Tue, 22 Jan 2019 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548164362;
        bh=9Fu5Jdr53QglcM4lIrZSiw3D+X1QCqYiAmr8c70t4P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMVt93yCO99aQLLnOe28jZUkmlLE18/pDB5k7GjISaO1iXz3K8QX3A2uxjfX2EBcJ
         Mqnnst+l6ULRTfbbxh54JUimqgqjOBgCPAj5ozVWHwri4r3tVbzKVnUb2INbV4k1Rm
         sluZakpKyzy0riqMemFYCTVS86XUfw8LqAqJMeI4=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D88E60B11;
        Tue, 22 Jan 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548164347;
        bh=9Fu5Jdr53QglcM4lIrZSiw3D+X1QCqYiAmr8c70t4P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouw7TaHAR9s54D9b+zg24DzIFucDYY4UgtTx07gV07g7DUCTu+bTpwLN7mnhT/Q2i
         mds/MBJwxmMFnFsgod3qeCUGNYQXm+k4T/qwhCfYXlpz3zCMh58v8Ohx3HVKc2uWNh
         anIk27JachJkHqOsR/ullRU6QbGOvWd4x95HVuPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D88E60B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv4 4/4] arm64: dts: qcom: sdm845: Remove the duplicate header inclusion
Date:   Tue, 22 Jan 2019 19:07:57 +0530
Message-Id: <75e897bed99f5e1901d357d40ff576d21dbce5ee.1548133311.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplicate inclusion of qcom,gcc-sdm845.h
mistakenly introduced by commit 6e17f8140521 ("arm64:
dts: sdm845: add prng-ee node").

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2c589f7f13a8..fc124aeb57e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -12,7 +12,6 @@
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
-#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

