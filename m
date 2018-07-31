Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8985920870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8985920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeGaU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:27:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46452 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeGaU1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:27:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so6525996pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pregnSMfkOaGBP4vqZw3v3Rj/ItF+UeK9Knvf5WfDP4=;
        b=VkXT3UslsFTaxVbYYw1rXyovyjHIgfOq0J4qbilaa7l4TzzfRjq/63kPevQFAM4WEb
         +O5MuWKAukWkNq6QhwzXVpo6eTa8rgLPCwIYVmwib981GI8UnIYHT9ZpRMuPH16ljr7o
         YNnBSG7U2GtB1iF6Hl8m8OqKAUtGCx3IZKDS247XouGVWCZpwkoD+DrnZs7q1qVrH8+r
         4MbdP1k7siC3yiqjBvrxVvgsSpUxRqFTsxj36TVQXN3nhOitVgYP8cj234OJE9H0bezC
         9rCXeZb0RXJfh6PDbQf41pnTOO405jLnetmKsFPFaPSwrSMvvP69HtZY4/p0vtYAs+CC
         Ko6A==
X-Gm-Message-State: AOUpUlFIkgq0ULdHpDgT4ZTx4KVfMS1sv8SDiA96sLTGm1NUXFnumCzc
        w4ur5uOIAT24pD4FwcNNO950xA==
X-Google-Smtp-Source: AAOMgpfds2lT/E/rBjuOnkKDZlGAt8EfyHQXPu0vTVnZmPbs69tz1vuDZNyN4GNLZWnQzb6aGW/ZVw==
X-Received: by 2002:a63:41c6:: with SMTP id o189-v6mr21971048pga.323.1533062774698;
        Tue, 31 Jul 2018 11:46:14 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b21-v6sm4981683pgw.79.2018.07.31.11.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:46:13 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 1/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
Date:   Tue, 31 Jul 2018 11:45:52 -0700
Message-Id: <20180731184556.169290-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- patch added to the series
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
2.18.0.345.g5c9ce644c3-goog

