Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EBCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A862084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RwKY65J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfAKXCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfAKXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:02:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so7626818pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFa9dZDnTlLUNw3LxfKJLjg60R1d6M30gGhExTiakGk=;
        b=RwKY65J/VJ93YHg/tGNlaLOUUGvs3zeg2oNpSJOx8yi9NAxvfK5Q5BtrSEWM+3RoDT
         2+0ns8S6rOJnAvZbmKj8H9DeuCv9qoLTTOYpDHWUHwgBTSoKIpq1xTnlhH0/wpONmQZe
         mke3Ft52VAce87ouK2LL9ZIOOSlQS7uLbM93g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFa9dZDnTlLUNw3LxfKJLjg60R1d6M30gGhExTiakGk=;
        b=DOmA0wKv/S38vhg5Zgm7VB+s7JQFNgaUios6gdcLld7qDEI5RsleDEhkFBY/jegLbU
         7WyDmvxuhFNYKg2B3meTklAokBxR/+sSs8Rl++7PBzGaFCv3wozk4M3siABf9G5dtPTp
         6y9khv7u+iW63MNpvUy9F6i7PKcEmxx0rrj1JPApnyYPtyYHS0gpmkonF0KYfdSFkv6S
         WUCj907wg3guJv4aBO5egHpN4YRQPLeAz1PZHVoQXoVeZB8XeTkCpiU0fRtA7f/elBVL
         scoM8mPwitZNVFpodUg7947ZiUsFm7AbvIeKOVuezGb6BJB7VBqbZeEA4uVkEpN+3F6W
         kRrA==
X-Gm-Message-State: AJcUukfopl9h0U9DBX1F3ZxROr1Gmsat/+b6pHU6n8N4o96vZqgLuvNr
        vBi0SYeRR+ZkdQhfeBiV7+R1zQ==
X-Google-Smtp-Source: ALg8bN7xCso6B959PPpGN8vAw5jbMldMZ7tJnqf0ulNZSNPAQFoD8mv6PHiszu2yOOFQbRGwIh5x7w==
X-Received: by 2002:a63:a553:: with SMTP id r19mr14971240pgu.53.1547247721044;
        Fri, 11 Jan 2019 15:02:01 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:02:00 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 3/8] arm64: dts: sdm845: Add UFS PHY reset
Date:   Fri, 11 Jan 2019 15:01:24 -0800
Message-Id: <20190111230129.127037-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the reset controller in the Qcom UFS controller for the PHY.
This will be used to toggle PHY reset during initialization of the PHY.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
This commit is based atop the series at [1]. Patches 1 and 2 of that
series have landed, but 3, 4, and 5 are still outstanding.

[1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b29332b265d9e..029ab66405cf4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -990,6 +990,7 @@
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			power-domains = <&gcc UFS_PHY_GDSC>;
+			#reset-cells = <1>;
 
 			clock-names =
 				"core_clk",
@@ -1033,6 +1034,8 @@
 			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
 			status = "disabled";
 
 			ufs_mem_phy_lanes: lanes@1d87400 {
-- 
2.18.1

