Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A7C282C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614A821907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="LCd2VTUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfBHCRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:10 -0500
Received: from onstation.org ([52.200.56.107]:34986 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfBHCQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:55 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 02099DAF;
        Fri,  8 Feb 2019 02:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592214;
        bh=stKr+GY6XFcpQcLJHWrdcT4C2N+QkidVMsox3qJtSmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCd2VTUVFc06Xgxfksc9sWeqcnMDhFzdoCl3paa7jOqV+1PkJfke3EHt0RVhU+luu
         xBaaSsHRSnC11IgxHAG0IDNFIclY9HrCoWvBjDBtn1YA9Qisw3seawhwPLGk4ZdYGo
         UMbmOrSo5FZCJACX+itiw1GkjBex4XavE0vFGcc4=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 09/11] arm: dts: qcom: mdm9615: add interrupt controller properties
Date:   Thu,  7 Feb 2019 21:16:29 -0500
Message-Id: <20190208021631.30252-10-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller properties now that ssbi-gpio is a proper
hierarchical IRQ chip. The interrupts property is no longer needed so
remove it.

Note that the IRQs started at 24 instead of 192 like all of the other
PMICs. This is the same IRQs as the MPP for this board. qcom-pm8xxx.c
doesn't set the shared IRQs so this is highly likely to be a copy and
paste error.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- None

 arch/arm/boot/dts/qcom-mdm9615.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index e49f67ad5dbc..02afc6a42005 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -323,13 +323,8 @@
 
 				pmicgpio: gpio@150 {
 					compatible = "qcom,pm8018-gpio", "qcom,ssbi-gpio";
-					interrupt-parent = <&pmicintc>;
-					interrupts = <24 IRQ_TYPE_NONE>,
-						     <25 IRQ_TYPE_NONE>,
-						     <26 IRQ_TYPE_NONE>,
-						     <27 IRQ_TYPE_NONE>,
-						     <28 IRQ_TYPE_NONE>,
-						     <29 IRQ_TYPE_NONE>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
-- 
2.17.2

