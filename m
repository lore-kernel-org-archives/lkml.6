Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFAA21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="apNyTeTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfAVFvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:51:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34850 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfAVFvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:51:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so10534852pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 21:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rOTwnk6dtXq1KXQGBQ526dvyAfi3nAsjQPbpfKkz9uA=;
        b=apNyTeTIOu5lY+Mf7f6LashjOOCLN83vhKtDE5/65csBnytr0rEiyYbPKRr0h7JBUG
         DjI1dFfdl984zFGLjqNLvGV63gZVPlZyPbQ3Kjyk8Oj7FeSVk1JXS5ot0VJ/6MKiQsWz
         vcsBuMn5eO+yUlSHJx68vpudzXyq/5yUNARNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rOTwnk6dtXq1KXQGBQ526dvyAfi3nAsjQPbpfKkz9uA=;
        b=tKFBFLHpaabYaapkMrMM6N6r8pKXxnZPW6owfAERcEFbuK2cHDQ7a4t+VQPk9ySlq8
         P8TOa0g+UcjVu9y3eQCcge+9J/pYwisElEJnKf430y0zIyEoyFpjSmQSxi0uEtLEedMv
         ZlL72mvO3sROdi5V9tTMz/KY11+DGlEKhC1dBXzVjmlYcp/ckxBe3Tq1ihRPL7QRpiqo
         DCnnS10MxumlunnGlUJEYp2GcvtJf3p3pWcsf+g/lwZsyKCEXDiCZTYDiGDawVk5ucvQ
         FwStz2oJ72Sn1UjrbgkXx6XVemk2Fr6dVZGQbsqC+MxzHu3C+JZ43AWb+J0xNu6uQgLH
         x7pg==
X-Gm-Message-State: AJcUukehFSMRJyHs7WT2aPkqszL8TJD4Znf5BQXxAjofVFpIhkOlD/ew
        FtvZeZB8AYnvPOrrQ1RN07CuKg==
X-Google-Smtp-Source: ALg8bN4os5nJ/hXm3XXYGY1Xewvk5noRcizPMqWcGzuO/uqrNOclqe6PFLB4a2N7Qb6/TBaIPgfbEQ==
X-Received: by 2002:a62:520b:: with SMTP id g11mr32794050pfb.53.1548136307766;
        Mon, 21 Jan 2019 21:51:47 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm23771572pfl.33.2019.01.21.21.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:51:46 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
Date:   Mon, 21 Jan 2019 21:51:04 -0800
Message-Id: <20190122055112.30943-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122055112.30943-1-bjorn.andersson@linaro.org>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the rmtfs memory node, as described in version 10 of the memory
map.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdcac3704c13..64f57cc5c61a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -72,6 +72,15 @@
 		#size-cells = <2>;
 		ranges;
 
+		rmtfs@85d00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0x85d00000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
 		memory@85fc0000 {
 			reg = <0 0x85fc0000 0 0x20000>;
 			no-map;
-- 
2.18.0

