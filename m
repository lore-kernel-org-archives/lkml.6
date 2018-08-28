Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855FCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0C72089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvLZ/yf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0C72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeH1MyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:54:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45221 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeH1MyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:54:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so441310pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nAwmOnrb0wdKODUtZHJ2nYT/GWx0JLB/qBAyXK4vPaE=;
        b=XvLZ/yf/S1NpIdIvg7DyWMqWVkzTjZR7LNwqCJbvW2mgtFrjzKZSVOdS1ZO/Q/M3da
         /oEJbx4gqYsKV/vzogons50By4TEjqogZ+4wT+mcTC7UeK8NZDCcBWQpPq+VdbCPseJL
         Co1wOYY7EPPKOTLe9O1TdVPnEecikUZH34UFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAwmOnrb0wdKODUtZHJ2nYT/GWx0JLB/qBAyXK4vPaE=;
        b=QRu6fwEM/axrvy6N3vtL14SGJNB8vd898fW2f/xt8K52nmqxwmQt0vb6mhC1iwgp0s
         KWQamo1y4yKJw7CxKZPUQn0qt8iXomz4ml+dtR7j9y8B9c7D0NoXluuErHq5mZAXGEep
         NzFAGBJSSHhnvcSUPDALkP1r401wW5z4go/ACyjExkSdar5UF9eVSWAj7HV1IIMCgrIn
         WRRn10AJPRBC/96pZthxYWOL1xn/J+CwhsEUewb2GTjich7nGnWI0GFXmALYGrwvOsMq
         mxJLrr5zLREvheG9C0zEk9FkowJRolOtanpS+qIOQM49RtPzhWV+azrYCY4wWfjoFaUc
         MGzw==
X-Gm-Message-State: APzg51DqxALxiDOf4YT7EcI+vf/ufRfDaiiKGnShAvr+8DZqJj/nL4M8
        0NC8C7YBzHjSnP66wrGAgtCh0w==
X-Google-Smtp-Source: ANB0Vda37dO5PJ853cBMLizm4OiFSWhqN9emGQCevT1ZtsfG0ObgYAGfbkOdk6i2MqdWDL/nNbQtyQ==
X-Received: by 2002:a17:902:26:: with SMTP id 35-v6mr626409pla.276.1535447006041;
        Tue, 28 Aug 2018 02:03:26 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v140-v6sm1979292pgb.45.2018.08.28.02.03.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 02:03:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date:   Tue, 28 Aug 2018 17:02:22 +0800
Message-Id: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC2731 charger
device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../bindings/power/supply/sc2731_charger.txt       |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
new file mode 100644
index 0000000..02b616c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
@@ -0,0 +1,14 @@
+Spreadtrum SC2731 PMIC battery charger binding
+
+Required properties:
+ - compatible: Should be "sprd,sc2731-charger".
+ - reg: Address offset of charger register.
+ - phys: Contains a phandle to the USB phy.
+
+Example:
+
+	charger@0 {
+		compatible = "sprd,sc2731-charger";
+		reg = <0x0>;
+		phys = <&ssphy>;
+	};
-- 
1.7.9.5

