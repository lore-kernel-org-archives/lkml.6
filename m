Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EDDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928E121477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WiQNf4qh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MTuoaHJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928E121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeHXWrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:47:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeHXWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:47:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 790EA6055D; Fri, 24 Aug 2018 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535137886;
        bh=k4YiXU8deiWgOlPWxRa44phoJdzLM2aV+pWxCDgK83U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiQNf4qhGqlhenGz0C/huPVa7im3Xe3wxCj+WXh3GO/LCxY/NcvZXxB7pDba3RmE6
         WsZq+4MUpW6c4/fVHdp0kmg9fKTbVVG4Sg88npMNd/gapuToAPrrg/bxeRRn6B0vV4
         ZhR2rYpIwUC83MlDPbln9nN+0nmYp0lcDCEjWjhU=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4C376022B;
        Fri, 24 Aug 2018 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535137885;
        bh=k4YiXU8deiWgOlPWxRa44phoJdzLM2aV+pWxCDgK83U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTuoaHJa30gKTERGLm/bZrpVxf2dRoYp4DJATOMbUUlh9yVs8x8eHWjdjctANzgTl
         JLiDYgODvwhpw5yDpx5EFBQMw1pxwcLj9umxZUrk64JS8GK9tCaHqS3LcfzG8/iE8V
         DVO4+E3scKMp9S2fHua2fSRt5HMeHzuF7dqKi3RY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4C376022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 2/2] dt-bindings/interrupt-controller: pdc: fix example to match actual bindings
Date:   Fri, 24 Aug 2018 13:11:11 -0600
Message-Id: <20180824191111.14571-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824191111.14571-1-ilina@codeaurora.org>
References: <20180824191111.14571-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDC map should use the GIC SPI port and not the vector. GIC
internally adds 32 to SPI hwirq numbers.

Fixes: 1ae8862e27e ("dt-bindings/interrupt-controller: pdc: Describe PDC device binding")
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 0b2c97ddb520..30f2f10d75e9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -61,13 +61,13 @@ Example:
 	pdc: interrupt-controller@b220000 {
 		compatible = "qcom,sdm845-pdc";
 		reg = <0xb220000 0x30000>;
-		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+		qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
 		#interrupt-cells = <2>;
 		interrupt-parent = <&intc>;
 		interrupt-controller;
 	};
 
-DT binding of a device that wants to use the GIC SPI 514 as a wakeup
+DT binding of a device that wants to use the GIC SPI 482 as a wakeup
 interrupt, must do -
 
 	wake-device {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

