Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17528C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B820811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeLSX4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:56:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45150 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbeLSXz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so10189204plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7vCU+zUqasVs+ZArX0LOx1TRnOv+Rq87gAUH37MLqs=;
        b=cWrRiDvP3RIX4+ybyWg6+TDQ8ceDVuOX+BzwxHKT3j9BuyZbTHS4txguAbsHWTiU2P
         ZwL0D9sVigZDZS2z3hVriWfEEBJGDXyCHMBIvi1SwQ7UBXGyX5ByOZzZXRwHF3y+bdi4
         KrVxn4n//eMQIETggzu/3KlAzF12yE9WD64V6udC1EgpzgwDKaMFVF9KuyrYTMb1FwZg
         4YezFUMJUASMa188uuL4mobS0yjbhl7v1E/FDRHyRr9UNXTPLCutDYmP9i7FK7qTn+eC
         AEjFhkGGg7boU61r81d8WYqUlDu4avq+M+uOw9xgY3X9JII7NuaZHEN+rHWNGfH8qfmT
         P3uA==
X-Gm-Message-State: AA+aEWZYyPOlZasmA9J1GTwKSOn5K0jRzLnJM1miN9VLTicHTgUoGaxH
        DkhEDrb5kSdC9zOaIFWG4GP+uA==
X-Google-Smtp-Source: AFSGD/XDhAj5bxlkXXlg2aX/Zr/lEyh5q/JMl0SvtPm6Itz2UBrH3r8Y9O268Ud/p/LWv+4esEpFRw==
X-Received: by 2002:a17:902:b494:: with SMTP id y20mr22616113plr.178.1545263756073;
        Wed, 19 Dec 2018 15:55:56 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:55 -0800 (PST)
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
Subject: [PATCH v5 8/8] ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY
Date:   Wed, 19 Dec 2018 15:55:28 -0800
Message-Id: <20181219235528.114830-9-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181219235528.114830-1-mka@chromium.org>
References: <20181219235528.114830-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'xo_board' as ref clock for the DSI PHY, it was previously
hardcoded in the PLL 'driver' for the 28nm 8960 PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Stephen Boyd <swboyd@chromium.org>' tag

Changes in v3:
- patch added to the series
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 48c3cf4276101..d337ae9326cd8 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1338,8 +1338,9 @@
 				<0x04700300 0x200>,
 				<0x04700500 0x5c>;
 			reg-names = "dsi_pll", "dsi_phy", "dsi_phy_regulator";
-			clock-names = "iface_clk";
-			clocks = <&mmcc DSI_M_AHB_CLK>;
+			clock-names = "iface_clk", "ref";
+			clocks = <&mmcc DSI_M_AHB_CLK>,
+				 <&xo_board>;
 		};
 
 
-- 
2.20.1.415.g653613c723-goog

