Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D837C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FAC20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XN7s/G0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfAQEa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:30:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35712 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfAQEaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:30:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so4118659plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZo7ET0lBcl98JX6n/hCp1L5/IwM2yp7Eu4Ugyh+OIo=;
        b=XN7s/G0wGq4Q8Pt4pGw4MjLsp5mCP3s07xqBBVc5Nfh0AvDP2DL81flh6lPc4EQT/A
         VNPmUxdTUqczhWZxpUmkimKa7I10yHYQDmcnUl07S8J0MxyIOmr3OaP5jsQtVBJ6D+0J
         iI0p9/nH+G9myREnQ+Km+t8qUi1xW47t6co70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZo7ET0lBcl98JX6n/hCp1L5/IwM2yp7Eu4Ugyh+OIo=;
        b=d5ToEe7nvQ2YVE4ub39wEpv0pDoW3w8AcgGuTzqk2twBXouEpHeqnUj1CDCXs4yPoL
         atf//ZFHt7fHgH61mlroXcx4akv/3Ta8IunmRFfR/PMjzp3oQmRMUr2vIIxCBMaUzdhJ
         uEK7FndGzJ6VUBmGWltyHAqomVLvKu8o9HjVzJqoAowCXdoa+Jy1M9EYTKSjM19lfDqH
         QVars3sW5mANzP9uGS/YhAHJd9KdklWOwatNkOiY3heoSke/pEu71Q6I24qu5+IcGDEI
         53R6Yg0te0dagBJ8XzNbERtRmNRf8e6t6hlwahAR4cQSykFRlXs1E4XTGtoc105A4XIr
         hVkQ==
X-Gm-Message-State: AJcUukc8+0RrFh8OgKIDZB/RjkqN3czX1NfkjLSvetkdDOYgUg2creP1
        YvX108r9ExjSppTBrs6dxcy9Nw==
X-Google-Smtp-Source: ALg8bN6AQqW3kkTSM1Spd6aZnzp61mfoJLH241AG/3wJT8w7WHIARW/7uW1xacDtPocHYhToTS8RcQ==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr13188760plb.223.1547699424480;
        Wed, 16 Jan 2019 20:30:24 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm361574pgc.89.2019.01.16.20.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:30:23 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] arm64: dts: qcom: sdm845: Extend ranges and describe DMA space
Date:   Wed, 16 Jan 2019 20:29:40 -0800
Message-Id: <20190117042940.25487-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190117042940.25487-1-bjorn.andersson@linaro.org>
References: <20190117042940.25487-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices attached to an IOMMU, translation between IOVA and physical
addresses is no longer 1:1 and dma-ranges should be specified to
describe the available IOVA address space.

On SDM845 the busses are implemented with 36 address bits, so dma-ranges
must be defined to reduce the size of the IOVA address space from the 48
bits supported by the SMMU. Without this DMA allocations may end up with
IOVAs outside the valid range, that gets truncated by the bus between
the device and its translation unit.

Also extend ranges to describe the available address space.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Split this out from patch 1.
- Rewrote commit message from scratch

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9867d42dc836..143c5af32e7b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -353,7 +353,8 @@
 	soc: soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges = <0 0 0 0 0 0xffffffff>;
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
 		compatible = "simple-bus";
 
 		gcc: clock-controller@100000 {
-- 
2.18.0

