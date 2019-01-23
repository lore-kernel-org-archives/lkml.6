Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C50218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NPRbm7pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAWWMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45531 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfAWWMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so1861120pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mnJ9pOfeoLrRRmLw97XaiwPeSNBQRApiw6Xy7Dc0LLg=;
        b=NPRbm7pISFFHGvIToej044RIAiArthXEdYhkcetMulujC9H3ASl/+on/hj25jV+GsK
         nJcfntPb9r6g57TUWCZCI9uRJDcg9S9ClCTMUYuShZ0NTqI92pDytsYQgkWiMFqDPBwB
         TThXu58/zHO9sveoZZj4mu/aRT3aWHCV+S88E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mnJ9pOfeoLrRRmLw97XaiwPeSNBQRApiw6Xy7Dc0LLg=;
        b=qgcCEY1DapI+Ol4/X7eRGcTu1z/xMNTwoD8CONbQ7E97dbiHCIfd9nfpIob/coKWdE
         t0c0YNiK3lDjkFxnSqYSmZH0qPSFiFB8pISJguqWAVDVRFOgvwcVvFiSWr8GqeMEhcdI
         qOry+hjCudz3qLXu5zmy3BzD0BKrO5pB1VRx4PqINAyoNUIfteq7N6I+pyBhUfTkohF6
         2SCAFVga7m4xuZdBITpMoFRDfhoOowZtdI2hQ7Db7hTLLHWxYGeRmU+bkBLDGHNFeRhP
         SdM/Sh3RWdPxhIRfixQ7W2QvIZfbBYyR9RBFqU/cf3XZRp7CiDJM6NCfH/fWoDOFW8VQ
         FrVA==
X-Gm-Message-State: AJcUukfP3I8GvFApeXeUrAo49y7PvEVnLk3Qy2JiMlIE2ISK/5Vx+kgL
        rqShycivpVuyJmqtuf8KVrQONIoi62I=
X-Google-Smtp-Source: ALg8bN6dq4y1P6J9DWWTH1fls/a2uIL4FiXEP0+jWadWvkIrwOOTX7+8GFOY+r0FTqwUE/a6YNWBVg==
X-Received: by 2002:a63:b649:: with SMTP id v9mr3645160pgt.436.1548281529187;
        Wed, 23 Jan 2019 14:12:09 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:08 -0800 (PST)
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
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] dt-bindings: phy: qcom-ufs: Add resets property
Date:   Wed, 23 Jan 2019 14:11:31 -0800
Message-Id: <20190123221137.41722-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a resets property to the PHY that represents the PHY reset
register in the UFS controller itself. This better describes the
complete specification of the PHY, and allows the PHY to perform
its initialization in a single function, rather than relying on
back-channel sequencing of initialization through the PHY framework.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2:
- Added resets to example (Stephen).

 Documentation/devicetree/bindings/ufs/ufs-qcom.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
index 21d9a93db2e97..fd59f93e95562 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
@@ -29,6 +29,7 @@ Optional properties:
 - vdda-pll-max-microamp : specifies max. load that can be drawn from pll supply
 - vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
 - vddp-ref-clk-max-microamp : specifies max. load that can be drawn from this supply
+- resets : specifies the PHY reset in the UFS controller
 
 Example:
 
@@ -51,9 +52,11 @@ Example:
 			<&clock_gcc clk_ufs_phy_ldo>,
 			<&clock_gcc clk_gcc_ufs_tx_cfg_clk>,
 			<&clock_gcc clk_gcc_ufs_rx_cfg_clk>;
+		resets = <&ufshc 0>;
 	};
 
-	ufshc@fc598000 {
+	ufshc: ufshc@fc598000 {
+		#reset-cells = <1>;
 		...
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
-- 
2.18.1

