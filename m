Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69178C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C8D21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kslQlDMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfAWWMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35653 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfAWWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so1708926pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwEgonuYSGrKbJYDl4G3bbQHZLlfkk1X5XVhYfW28I8=;
        b=kslQlDMzIjeV/wdofyuFSig3T4gbiRun22xL6zxuqH+/BQjKZvrgfjxEn+BLqR9ig8
         WYqmdGl/MPAZzd8WaYhwwaCyR/xpkW/JrqgN+V4HGB965QxnhMrrkVo/DEKuCs7i/kJn
         h7FwTVDIYPl2/dF3aSbp/sHUksrRYcV1VZixM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nwEgonuYSGrKbJYDl4G3bbQHZLlfkk1X5XVhYfW28I8=;
        b=svv17pLStgcKOicv2OaItwQf5rUsSbX9BF54kKR+Aj3qpXwD8xpQL+IrUAVsFoMChN
         KlPbkP8Doub+ImSijyrheWyd7UgqbFH/NsRE7M6MiGBR82ZWg+35gnWnQGOhIQmvYU5w
         3USSEyvaX+4ZcRvRPLgXgbP9os8k8N7dR5LJBQrjJSi1lQG0jq7owo76X6Qk9bCg6eJ8
         AuvZqo8USv1FqWQ75jKP5683OKKIw6LfDeEvAZuj//8j/NB+O5MMZbHGhhu3sHnyj+ER
         7Ba+jrAyMyBQmP52eS7MBXtDt0PygvfbvXa4sWLW0BTl8hlV/RCQwqumuiJB0xrK+2yK
         uEJg==
X-Gm-Message-State: AJcUukfUBKQ/Awu76DoraP3mieneXRYo00En9bXEYIa9P+JHqwXbSFaO
        tw/3m8sO8FmJAN05ifgSpAFlQg==
X-Google-Smtp-Source: ALg8bN5U/FBBt+r8Hj97ySEDpETRZckbgmxnT0QvxqbXfa2sJKmXKP5MrMwojRLrLRJMvAOEghniDg==
X-Received: by 2002:a62:104a:: with SMTP id y71mr3798578pfi.34.1548281526447;
        Wed, 23 Jan 2019 14:12:06 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:05 -0800 (PST)
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
Subject: [PATCH v2 2/9] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
Date:   Wed, 23 Jan 2019 14:11:30 -0800
Message-Id: <20190123221137.41722-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a required reset to the SDM845 UFS phy to express the PHY reset
bit inside the UFS controller register space. Before this change, this
reset was not expressed in the DT, and the driver utilized two different
callbacks (phy_init and phy_poweron) to implement a two-phase
initialization procedure that involved deasserting this reset between
init and poweron. This abused the two callbacks and diluted their
purpose.

That scheme does not work as regulators cannot be turned off in
phy_poweroff because they were turned on in init, rather than poweron.
The net result is that regulators are left on in suspend that shouldn't
be.

This new scheme gives the UFS reset to the PHY, so that it can fully
initialize itself in a single callback. We can then turn regulators on
during poweron and off during poweroff.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
I realize I'm not supposed to add a required property after the fact,
but given that the UFS DT nodes that would use this binding are not
yet upstream (and this would be the first), I was hoping to squeak by.

Changes in v2: None

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 4ff26dbf43106..49b8a5eed3cd1 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -56,7 +56,8 @@ Required properties:
 	   one for each entry in reset-names.
  - reset-names: "phy" for reset of phy block,
 		"common" for phy common block reset,
-		"cfg" for phy's ahb cfg block reset.
+		"cfg" for phy's ahb cfg block reset,
+		"ufsphy" for the PHY reset in the UFS controller.
 
 		For "qcom,ipq8074-qmp-pcie-phy" must contain:
 			"phy", "common".
@@ -70,7 +71,8 @@ Required properties:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
 			"phy", "common".
-		For "qcom,sdm845-qmp-ufs-phy": no resets are listed.
+		For "qcom,sdm845-qmp-ufs-phy": must contain:
+			"ufsphy".
 
  - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
  - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
-- 
2.18.1

