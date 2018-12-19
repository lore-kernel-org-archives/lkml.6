Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783E920811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeLSXz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:55:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbeLSXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so10582670pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmkWC6pBuGeFAGP7edBr1/hwoo6BncU6XUndeY7AGW0=;
        b=C+0rIKtwgt1CfJm4JOYghxF0a9JHLnvDb3LlkQ7ZQ9KFKXTd9AkdeO35fa8AV1Av5D
         vbzNUKuapsknatO4KDoYqqZxuWyTV7lGG5NKHebEN6fim+y4Wxo8RKNr5C+4um0uOC9P
         3tSJ258zlZs8GyUwCOlvYgHSPJYSrOzkBk66U6mur5D1pUOzrO5Wu396py61VNJayqzC
         Y7rhOD+EsfANE/0Qn5fjgIcL6gi8Y2guS/qOve0a0Vas+zRayo5dDU7WTb1YRWJb1G/y
         83rxN5YoP6Zdeh4kh1pbXRqbl5+PxXi7cN+J+w9yjBL8X2rp3GUHhGvlOyQ3vPxJFQm6
         R3Zw==
X-Gm-Message-State: AA+aEWacQiocbWkrpwXWSQv7XoNc7iuoPo8Y2c24FnH9B2fy7x5tpuuR
        CjqiUOdj1qG51hufyxwYGQNw2A==
X-Google-Smtp-Source: AFSGD/UwNZnNALaB0EnINJrOwORGNCGCyV84uT7oAOvrOp8K3G/ECkwXkcYJ9x1RI8dfexc2NfzpVA==
X-Received: by 2002:a63:f844:: with SMTP id v4mr17806064pgj.82.1545263752744;
        Wed, 19 Dec 2018 15:55:52 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:51 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 6/8] arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
Date:   Wed, 19 Dec 2018 15:55:26 -0800
Message-Id: <20181219235528.114830-7-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181219235528.114830-1-mka@chromium.org>
References: <20181219235528.114830-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'xo_board' as ref clock for the DSI PHYs, it was previously
hardcoded in the PLL 'driver' for the 28nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Stephen Boyd <swboyd@chromium.org>' tag

Changes in v3:
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- patch added to the series
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a12..89f30f34ff896 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -959,8 +959,9 @@
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&gcc GCC_MDSS_AHB_CLK>;
-				clock-names = "iface";
+				clocks = <&gcc GCC_MDSS_AHB_CLK>,
+					 <&xo_board>;
+				clock-names = "iface", "ref";
 			};
 		};
 
-- 
2.20.1.415.g653613c723-goog

