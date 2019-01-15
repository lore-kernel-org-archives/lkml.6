Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C0CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEE020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2YFQgeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfAOKdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:33:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38519 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfAOKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:33:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1076311pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+/pZ0dv7/TrWKuI+u0mzefBEqQY+i72QxuOgn/qV09M=;
        b=V2YFQgeO9AiPLYV38d75wisXsQIpYGe3qcgzWdbSM1k2YkPw4Otq0pEkHmGWqWUdfi
         doKRbzXKTsW5UzDJSaddrSaBuc7fIsr0Qh+McMqpZ6ZPhv3S7Zm0v2/w0RBJmJ/ng530
         mTyTuXCwLcan9QL1pUhizD3ECoRGpPO/1vH7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+/pZ0dv7/TrWKuI+u0mzefBEqQY+i72QxuOgn/qV09M=;
        b=bUVqNbexgDDAJoK2KA87xcxEE61kvE6m9CR4N27J7aO/5WkfS3zq4gavLGzJMqJEvW
         Q4Yb9KPKcuy71WyVBYYnlfErUS/LWKcYYPtQhJBm3wA3ziZWCUcsoAiJM240NzLWV8T/
         BNnVYX47WxolN1Hrfdh1Adj9c7o5G0jlQNAYJ2qK090bDo5S5Udo+1C9x6yuZn0Ad4dr
         xbmInhwQh++dtfU8Yquun7zyQuJf7VBwyuHif1eq5WrwbNt40axiiB3WNHUlw2NYL2MC
         cWZM4zWFjHUpMDUB2D4qyKILQ81gkMtIapdlA1+eqA5MLvX6+ZaC7wSvyt0Mia1XHVhu
         yNiw==
X-Gm-Message-State: AJcUukdqC8m93JWu1kQzkgzlgz+SAzHZd54iXSJUmlJJQ1qpwv9GVHru
        tcSB1W8Ch6jCoDFvAnpTTLylRA==
X-Google-Smtp-Source: ALg8bN5b9xnbSVkceqQdiHXO7eQhHuqmqXejKbxaNDs4F6q8XIhKODGGcIAZsFyXRlUkadb7MNuYpw==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr3123202pgk.213.1547548398856;
        Tue, 15 Jan 2019 02:33:18 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d13sm5073957pfd.58.2019.01.15.02.33.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 02:33:18 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com
Subject: [PATCH 1/4] dt-bindings: power: sc27xx: Add one IIO channel to read charge voltage
Date:   Tue, 15 Jan 2019 18:32:34 +0800
Message-Id: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one IIO channel named "charge_vol" to read the charge voltage for
the SC27XX fuel gauge controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index fc35ac5..0a5705b 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -9,8 +9,8 @@ Required properties:
   "sprd,sc2731-fgu".
 - reg: The address offset of fuel gauge unit.
 - battery-detect-gpios: GPIO for battery detection.
-- io-channels: Specify the IIO ADC channel to get temperature.
-- io-channel-names: Should be "bat-temp".
+- io-channels: Specify the IIO ADC channels to get temperature and charge voltage.
+- io-channel-names: Should be "bat-temp" or "charge-vol".
 - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
 - nvmem-cell-names: Should be "fgu_calib".
 - monitored-battery: Phandle of battery characteristics devicetree node.
@@ -47,8 +47,8 @@ Example:
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
 			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
-			io-channels = <&pmic_adc 5>;
-			io-channel-names = "bat-temp";
+			io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
+			io-channel-names = "bat-temp", "charge-vol";
 			nvmem-cells = <&fgu_calib>;
 			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
-- 
1.7.9.5

