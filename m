Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F83C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEB82083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnkG9jr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfBEAzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:55:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33506 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfBEAzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:55:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so761975plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 16:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1mW3Oimy67WeVuLn9qA3Fkv++/qDwOTRO5PxYuiZ8BE=;
        b=cnkG9jr2gwci20MgtHykOAfclyhdcaNJL91sLxxpNFsftjKyBTg//mAg0rchD5Y480
         w81lb20+UzXfPDWCcyyQLSdqtzJ+mNPkYoo7GjDPeeqHz5jgEmPxcwyRwP6J+ANcYfvk
         BTsWQ1UcoWuYpt2pWraBqYvXr+REvJHX42N60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1mW3Oimy67WeVuLn9qA3Fkv++/qDwOTRO5PxYuiZ8BE=;
        b=fYYdquxxwlupx4xXLcHvbqrK/q+GxStza5spdcRd5PXTvAzCMbeT3frHWOsI72C847
         cQbc7u6J+B3DIO/LnBmR1Yh4E463yv540Pd/RzKcjqSfbPmOmEztXLkkHsYQc3jLp41C
         7OoNhU4+TUE/4JbPJIavAAp6XH9LVV82QocJneVkOwWjX0NZA45SF5iXH5DmmKtGIo7V
         Hk3wMJ4PjmiBSrFT0gRTKCtbO6ZAiHTjN7NwrePxgBHSvLUW6sLy9+oYPf01SOB1hSL3
         wUrmggPgY5wcykOXZXONLsqhOz6v+uaylHe73FIRhn0MNoTfhLhnq1lDxkUG8sLrodyV
         4AJg==
X-Gm-Message-State: AHQUAuZmmRAkLk+GH8sHy9zBLNfm8FxVmtqG68frdU1IpPtlb98R0SqE
        raCfsjU4+UjeOcAApNEiHbmX3A==
X-Google-Smtp-Source: AHgI3IbPQhO7wIYwv7r9WNcRrlrRNqM7bOnee/zxvOGEnLOi9BPXG465AEQ6nU70uIlK37QATrO/0w==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr2247128pln.324.1549328099776;
        Mon, 04 Feb 2019 16:54:59 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t3sm1770661pfa.50.2019.02.04.16.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 16:54:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Define IOMMU for sdhc 2
Date:   Mon,  4 Feb 2019 16:54:52 -0800
Message-Id: <20190205005452.21438-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With apps_smmu initializing the SMMU we must specify iommus property for
the sdhc controller.

Fixes: 4429e57567bb ("arm64: dts: sdm845: Add node for arm,mmu-500")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 340af13ec0c3..05577f08d18f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1539,6 +1539,7 @@
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>;
 			clock-names = "iface", "core";
+			iommus = <&apps_smmu 0xa0 0xf>;
 
 			status = "disabled";
 		};
-- 
2.18.0

