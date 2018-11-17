Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3AAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830AE2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EoSpFaPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830AE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeKQVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:35:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeKQVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:35:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so5488716wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=471EVX66eKG2C8zwmFonz8VdTtC8qyHHt4XcSn+E5/U=;
        b=EoSpFaPfwNgWyE3tDScDRlQ9yDR5+bvaMiltIpaIhKCrZr5sjIpgUNbqADR63/pgVJ
         Yu12MqaRI7yP7ioP63vkfeIu471L1mdxxw0fG83ubDhb6tfNlRXQq2imxXmTPTlhXsF+
         5vLoOOb+6vQ+6n/7s7m0riYJrN6DF8+BYIt7xKI5Op/LMf4Salv5rD3FCDAGMINgtnkA
         1AF3LPlLe/63kQKMEiw++wr2as+W7hZxCo5AgUwH5I8VT9EdGzcD6GkQ+AXDiLiFvt+Y
         ogWuKiVzdbIl3mzNapoE0jQsMmmo49ZrSZxA5N2iTObTUEtg169H3TyMV5jxiurXAggW
         SHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=471EVX66eKG2C8zwmFonz8VdTtC8qyHHt4XcSn+E5/U=;
        b=YCq6pBcSyxIQ214f6PxaCnsnUeFUm1/xw1+8vAC3KkrTrlbY7Q525NAubC5aC7+uWm
         hZrNou+DB+5mGJstZDF9z4OuYsV//digv62XfYQSo1XBv19oTv/xSFmInQ+WO2fmzR6l
         a1PNjuExNet4aTkcPSMitoh1UR75hQWwmDO/AvULwmm+29ibI3+JOyNNNV7tUIaFgCY0
         bpVmwGLQwRrwJkF3PhAYhXmdGHLF0J4AkExhIhmXcXultQf2t3PaPNeApXMV4F9O9Bx5
         vecjlUHDxlLkDMFmKANtqffmT5QKKD39QjGCjw/qqx0wFGvAFfzWCgrfELIMXJJAFcml
         Nnuw==
X-Gm-Message-State: AGRZ1gL5crhfAzX/9NPi3iVLtpL+G0c2wO8p5eXsGbjSt7c9TMS1H9vq
        4ymp/L8qnNOvX0mnRsLqRvNPVQ==
X-Google-Smtp-Source: AJdET5fvtUFE1brHyC0KbAinvEWA69RIvxQA5ReVGKvAcm5ZkvhQBmFOivl3W+ZWBwPXqe1PMlSvkQ==
X-Received: by 2002:adf:9cc2:: with SMTP id h2-v6mr12916541wre.322.1542453517211;
        Sat, 17 Nov 2018 03:18:37 -0800 (PST)
Received: from localhost.localdomain (176-137-58-115.abo.bbox.fr. [176.137.58.115])
        by smtp.gmail.com with ESMTPSA id k5-v6sm50797646wre.82.2018.11.17.03.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 03:18:36 -0800 (PST)
From:   abailon@baylibre.com
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 2/2] dt-bindings: interconnect: Document imx7ulp interconnect bindings
Date:   Sat, 17 Nov 2018 12:19:05 +0100
Message-Id: <20181117111905.29091-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181117111905.29091-1-abailon@baylibre.com>
References: <20181117111905.29091-1-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This documents the device tree bindings for the interconnects
present in the imx7ulp SoC.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/interconnect/imx7ulp.txt           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx7ulp.txt

diff --git a/Documentation/devicetree/bindings/interconnect/imx7ulp.txt b/Documentation/devicetree/bindings/interconnect/imx7ulp.txt
new file mode 100644
index 000000000000..c32b7becdca7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/imx7ulp.txt
@@ -0,0 +1,17 @@
+iMX7ULP interconnect driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : should be "fsl,imx7ulp-icc";
+- #interconnect-cells : should contain 1
+- clocks : list of phandles and specifiers to all interconnect bus clocks
+- clock-names : clock names should include both "nic0_div" and "nic1_div"
+
+Examples:
+	icc0: icc {
+		compatible = "fsl,imx7ulp-icc";
+		clocks = <&clks IMX7ULP_CLK_NIC0_DIV>,
+			 <&clks IMX7ULP_CLK_NIC1_DIV>;
+		clock-names = "nic0_div", "nic1_div";
+		#interconnect-cells = <1>;
+	};
-- 
2.18.1

