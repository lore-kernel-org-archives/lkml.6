Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39197C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D794D22B40
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NB78wHzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D794D22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeGFXdz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:33:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41082 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932774AbeGFXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:33:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so3493702ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 16:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1a3DdWcHIQ8WM+WsAwP+a4HKCOOvenikNVsQk812dwA=;
        b=NB78wHzHkKixz2Ex/GgFMpVuNvhCl6xx7sSrPrh6N0pCmLled7O5LomvVPg4B0FjUb
         saIWjsOka4bJWfERiubhXiDa1wEhr0bEd2YnaiWFrDtSI+nRkjnny8VHGMfdIR5Gg9eH
         y2elz8F4upj8OZSeUexBgUrWMtoilpro8wE80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1a3DdWcHIQ8WM+WsAwP+a4HKCOOvenikNVsQk812dwA=;
        b=bDzyh0uSNlEKu65zKMZl3C+hgedcpsjeYtiZ0N08/2meb5z9a920P5z+y+BlmweSOF
         i2xh8wHqQsF8VMOOQeFxTsYVTViY6ufLWzAYEe8U4tDWZ+zZwmEpSYjtRQ4zkDVnmALz
         A1s/gDB5Pa80hs3xryB1XdkxMzbv5UGf9T4Ir1lUsLTkBPjE6a6Bjw4IHYrQJdy2Sk30
         cy887qEadRsVcoAfoKQA/bgY4NXSchqZAt4v8AJ5hAs6jSBkP1u+Zh76RAdMu90AUPJU
         VaZOkNraYyFxHulySoS362Gin05xAaKkLyppThpAIT6Nws01PHX3zaOw8eE3VJk353GI
         X1/Q==
X-Gm-Message-State: APt69E2UxAdR9C2zGuIFwEuEAQgjbT44FyxaZFuEDS/bUnpMwpOwiBUr
        Oswl1ELZWNImNmsOphBn7lPrRX0QWQo=
X-Google-Smtp-Source: AAOMgpcHyMLGj/VY+7PK+5JnGLiYHKSmqpjjPBldX9CgoM4WgM7UgnB1qNScQpN7wj4hs+86ZYu5og==
X-Received: by 2002:a17:902:a508:: with SMTP id s8-v6mr12060806plq.223.1530920033119;
        Fri, 06 Jul 2018 16:33:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id a11-v6sm13129195pgq.32.2018.07.06.16.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 16:33:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
Date:   Fri,  6 Jul 2018 16:31:42 -0700
Message-Id: <20180706233142.166296-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few patches have landed for the qcom-qmp PHY that affect how you
would write a device tree node.  ...yet the bindings weren't updated.
Let's remedy the situation and make the bindings refelect reality.

Fixes: efb05a50c956 ("phy: qcom-qmp: Add support for QMP V3 USB3 PHY")
Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 266a1bb8bb6e..0c7629e88bf3 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -12,7 +12,14 @@ Required properties:
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
 
- - reg: offset and length of register set for PHY's common serdes block.
+ - reg:
+   - For "qcom,sdm845-qmp-usb3-phy":
+     - index 0: address and length of register set for PHY's common serdes
+       block.
+     - named register "dp_com" (using reg-names): address and length of the
+       DP_COM control block.
+   - For all others:
+     - offset and length of register set for PHY's common serdes block.
 
  - #clock-cells: must be 1
     - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
@@ -60,7 +67,10 @@ Required nodes:
 
 Required properties for child node:
  - reg: list of offset and length pairs of register sets for PHY blocks -
-	tx, rx and pcs.
+	- index 0: tx
+	- index 1: rx
+	- index 2: pcs
+	- index 3: pcs_misc (optional)
 
  - #phy-cells: must be 0
 
-- 
2.18.0.203.gfac676dfb9-goog

