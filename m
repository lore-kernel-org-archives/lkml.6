Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF66C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB822206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XT4U7lXC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E2WYwJgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfBVWTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:19:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfBVWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:19:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3538960A24; Fri, 22 Feb 2019 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873952;
        bh=pEzKj9gE30fiOIqtcNB5ji6qMgFK4uvlf5GSJktPuFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT4U7lXCA//0kNsz/zX9K8IQlcuH/yxK0WXxhyOGcYy2GdTsEzkU4v6b0gzbN+ayB
         mrqjzmYUvN6sWOs2d8OLw1GqcwtPrRHb/dvHIPJOZ5AwQDucrCFQ+HfyLZnMB71V60
         aWFLL+AWs36yQCjvhrJmYm7hG9MrpQ6DXagyt6E8=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94AF8609F3;
        Fri, 22 Feb 2019 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873951;
        bh=pEzKj9gE30fiOIqtcNB5ji6qMgFK4uvlf5GSJktPuFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2WYwJgkJuz5u/1ckkPs7wgdh8x5epP7GYeYxuHTFxmwBBbyYSy69Bifjxm8mXOh/
         5MhVkxdvoZlqUCimeqQB2mwlX6WwVme4uvMqmbTU66BLaeqPfKej3tw7f5drXtG01Z
         sYqekzOUO7ZmFvNZciy5bnuuIkVJ7esvGSzF3QDc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94AF8609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 7/9] arm64: dts: qcom: add PDC interrupt controller for SDM845
Date:   Fri, 22 Feb 2019 15:18:48 -0700
Message-Id: <20190222221850.26939-8-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222221850.26939-1-ilina@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v2:
	- Use updated address specification in reg
	- Rename to pdc_intc
	- Sort per address in DT
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..e55100c2705e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1534,6 +1534,15 @@
 			#power-domain-cells = <1>;
 		};
 
+		pdc_intc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0 0x0b220000 0 0x30000>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

