Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CFFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDD620652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RjwCbAju";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dWjqUx7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfARMYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:24:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfARMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:24:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1ABA460C05; Fri, 18 Jan 2019 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547814246;
        bh=9Fu5Jdr53QglcM4lIrZSiw3D+X1QCqYiAmr8c70t4P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjwCbAju15SbS/SsJZo8RzLpP7l9xGgioiv/2fiI41Ok3KZ+nwrcc+Q10q7kwpYFT
         qOaq1LU6siOx1uxyaoRy8wnH/HBSgObow7K3bInVnsqSpMV4wzn/qulIVYs/DrVfgP
         5hhXlTgfg4H/MyXfy8TWoQgxCX6UU3pWgfpy4EoM=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6854360AD8;
        Fri, 18 Jan 2019 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547814219;
        bh=9Fu5Jdr53QglcM4lIrZSiw3D+X1QCqYiAmr8c70t4P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWjqUx7MySkre8jaYhY8Je9d76t/Ujn4AZpbxNnHwQKaAL6kkZRuu5ElywmZIAZZO
         ys8YnVf5WarG2adhHKKiuU2MratsYgMNiikh8O/Qfsa3x1rgX100enqf9xsfAshXQg
         vWepyZXXoGEvn0kOvrd8mcXv7ZnrlQ3663bixXNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6854360AD8
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
Subject: [PATCHv3 4/4] arm64: dts: qcom: sdm845: Remove the duplicate header inclusion
Date:   Fri, 18 Jan 2019 17:52:56 +0530
Message-Id: <8a6a300068c0ecf6e4e3d3de5aa55144b4a50762.1547813804.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
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

