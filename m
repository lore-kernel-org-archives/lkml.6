Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1CFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5FE20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTFcgsUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfAaUVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:21:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39110 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfAaUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:21:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1985709pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oli7Ra9jhK+5aytYDg7Z1vmHr+drx/8e8TMUhHBKi6M=;
        b=KTFcgsUSVE3O9Ek44a1fdasIIhvwdU5J2kdwz5CQKPtUnyquKzMb1reEgMuj9zL9Zz
         bLIFOgjewQ6C/KPmAJDLvbiuIDcvYzK5khV9D3dpsCNEZj7pE7kQZFPtSl98undqCprP
         mlq8PFH01Im7CsIl1txBvb0KX6XnYOGPidAl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oli7Ra9jhK+5aytYDg7Z1vmHr+drx/8e8TMUhHBKi6M=;
        b=E5qvzc5f9z8TvmlFoia7GLnlZ5bbvi2zTgCrtoWypzlwYhOXDwpopttqiCCLHUlwTm
         3LHXs4uMn9/5tqSkC8KTjCqocQyhr0LHvCq+WKVs+667J+EvkVHiPor45PfyfjVxuOYE
         Iv//R6wT7/6yLYM1iEothesW0iLD8AYEv2M5JbIzEYVKgcvA7dnHQTH6LV6iv1lTvYsh
         9KRF7wfqE+/n3eY4mXY2jCJfExl6Fc9qCPuF0af+4yp2MWoDQa78EdbFM7mWD2hL9Yzn
         uhKMczzqX305y/KxNxCE/ARX/uqSov3bPFoGk6Jl3CwkjI7ItiFkZkng88xGzubDaybC
         mHlA==
X-Gm-Message-State: AJcUukdueNq4GwtOyt1jikHv75/DhI0BTGWthnxx8D/LoTOATOeoV1Z7
        Kgi3Uk9BZ6Ft3mJBBsyr140YBg==
X-Google-Smtp-Source: ALg8bN61gMnz8q9UtV+GLzy5Ha4FaAZ8Q0n43FxX6fFTWYAqz1BGi3agNhzBZd+gXivwZbslhVTsxQ==
X-Received: by 2002:a17:902:1005:: with SMTP id b5mr36399550pla.310.1548966070779;
        Thu, 31 Jan 2019 12:21:10 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c13sm6952205pfo.121.2019.01.31.12.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 12:21:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: Disabled VFE SMMU
Date:   Thu, 31 Jan 2019 12:20:55 -0800
Message-Id: <20190131202055.13301-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing the SMMU trips a security violation, so disable the VFE
SMMU for now.

Fixes: f3442ab97257 ("arm64: dts: qcom: msm8996: Add VFE SMMU node")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6ba96916c66d..c761269caf80 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1000,7 +1000,7 @@
 			clock-names = "iface",
 				      "bus";
 			#iommu-cells = <1>;
-			status = "ok";
+			status = "disabled";
 		};
 
 		camss: camss@a00000 {
-- 
2.18.0

