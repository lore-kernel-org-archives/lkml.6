Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABADC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D4320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D4320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbeGYBAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:00:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbeGYBAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:00:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so1226712pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5GhO5K5kAs1DwsY5LZGmonhIBQTmf1fZLT4KuDJt3E4=;
        b=eOnEZqVo+GQRG0UFj3LNWhB1GV4z9n7J0sW29YgBEC5RwKrchkLrs93OKTpN7f41eV
         wQ4whPmHtrMt1DRtAIYiBrjvEJQtF5TBfTD4DHwIjZTu0gGlqaY/g0j2DUskNNgtTgQ8
         IXjMeGBulPiF62wvKg3JaUOX3guunXTuMspBSy6nKdo9+1ONi/ytG4D1db7ZjX18L8nH
         s6V3TQd0iuhk/hy6d1TqSKi7RZUi5OHR56CJv0sAkvi2LpejenhFvqPWY1JdwXsDvw7D
         innO6c/1RZf8QwBHoH4WPBOTL4YBunb0zspIbnJazI3TtkDrroJTgjQKyS7LQhcxDgwj
         91rw==
X-Gm-Message-State: AOUpUlEUPSxBx5zby2rxvW/0QLNAHJDc/kWQoCFWbAlz0jJ9uXUA56bu
        dX9ANwufH6pGbkdwnvT1b1zqWg==
X-Google-Smtp-Source: AAOMgpfVoeyWd9Yw89rBCfbW+p9JAJccSWPlXTdnZNJHU4waZJtnWouqB6hOJ3tXW77Phjhmk6/86g==
X-Received: by 2002:a63:5f50:: with SMTP id t77-v6mr17237149pgb.300.1532476297060;
        Tue, 24 Jul 2018 16:51:37 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p5-v6sm16628549pfn.57.2018.07.24.16.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 16:51:36 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
Date:   Tue, 24 Jul 2018 16:51:30 -0700
Message-Id: <20180724235130.58592-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation claims that the 'reg' property consists of two values,
the SPMI address and the length of the controller's registers. However
the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
the controller register length from the documentation of the field and the
example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 290ec06fa33a..86fb41fe772f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -6,8 +6,7 @@ interrupt signal and status register to identify high PMIC die temperature.
 
 Required properties:
 - compatible:      Should contain "qcom,spmi-temp-alarm".
-- reg:             Specifies the SPMI address and length of the controller's
-                   registers.
+- reg:             Specifies the SPMI address.
 - interrupts:      PMIC temperature alarm interrupt.
 - #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
 
@@ -20,7 +19,7 @@ Example:
 
 	pm8941_temp: thermal-alarm@2400 {
 		compatible = "qcom,spmi-temp-alarm";
-		reg = <0x2400 0x100>;
+		reg = <0x2400>;
 		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 		#thermal-sensor-cells = <0>;
 
-- 
2.18.0.233.g985f88cf7e-goog

