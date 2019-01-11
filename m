Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944ABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619EB2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/A1RbFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAKXB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:01:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfAKXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:01:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so7615279pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtfQdK+NuZm6RALU79/MbDamjG1NtGBB0yoEpvJy90o=;
        b=j/A1RbFdkcj+d9WxOzq5gflz9qCLRoEqS5nyzdniPNv8XWUyGr72vOS0hSv23Ccbtd
         feHfh/83432gvgbGKnkzyKDhnt6n5J1NsQU9OSzoLgYFA6iNI8N2JlhyzaIxWtOWUegJ
         9BS997UgvUBMSY74WJjZBb8bkcsKu6T1z5M3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtfQdK+NuZm6RALU79/MbDamjG1NtGBB0yoEpvJy90o=;
        b=NwjJwdHz2snU3KOswC3lsYOStGLflDnswK5GtwkiP0dTUq7dr8nEqe7Z3n/gV+0kdK
         DNkoGe0EA3pgK2iZXVi4S5VkXqaTG0kvDsxIA3IQw1wmQGApOo6r3dmBnMZ12IRy1tcH
         bAwH6lzQ36IbTzEnp+1CkLxCqhYVZ3IWogWhEUGy0LArePMz0O57XVDUCB3SWhcmDZvN
         IkiiHtEIFwjNwDAg127z+1fcceltRSNEeBz62JtqPUSs0oIh+v+Re1lBz/4Gy5a9lCXe
         TbZ37noDVM+WVGuzS+ZbqcXD9YcxEqU5pOrkHhzBKcEJlRF6tRF14M1h5L6QqkUMByfQ
         G27A==
X-Gm-Message-State: AJcUukeHeTpil7zluqTDLc75hl2tXJn+WRgzO/gD8II0daHqqfazdHgb
        jlcQVPa8UWr86dQkfRfjrljOwA==
X-Google-Smtp-Source: ALg8bN4uExvKt7jxieGS+1JajeiF2AdV1iUktjWmDqNmldP9yYgfT3JaLZLjMUWQgJxtsIRWlKfu7A==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr14893143pgb.56.1547247714944;
        Fri, 11 Jan 2019 15:01:54 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:01:54 -0800 (PST)
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
Subject: [PATCH v1 1/8] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
Date:   Fri, 11 Jan 2019 15:01:22 -0800
Message-Id: <20190111230129.127037-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
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
---
I realize I'm not supposed to add a required property after the fact,
but given that the UFS DT nodes that would use this binding are not
yet upstream (and this would be the first), I was hoping to squeak by.

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 41a1074228ba7..6b6ca4456dc7c 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -53,7 +53,8 @@ Required properties:
 	   one for each entry in reset-names.
  - reset-names: "phy" for reset of phy block,
 		"common" for phy common block reset,
-		"cfg" for phy's ahb cfg block reset.
+		"cfg" for phy's ahb cfg block reset,
+		"ufsphy" for the PHY reset in the UFS controller.
 
 		For "qcom,ipq8074-qmp-pcie-phy" must contain:
 			"phy", "common".
@@ -65,7 +66,8 @@ Required properties:
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

