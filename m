Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC597C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A8420874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOi5mrP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A8420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeFTMLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:11:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39736 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so6431090wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciWHyLMikqH3wKENiDm/GxmXb1N461xZPfHB5KvcB1o=;
        b=bOi5mrP/4LiYJ4u28w3KB9wzX2SLOuq0WuDuGCV7jdYDtZDXAzNCDCLYRgALYhRcT/
         lo0N2teZp8EtW2P52+nGLNhxjUnsry+K3eRKIU0+wVQzCGleLdCAj4aso139Om+LyQsc
         hkrt1fw7YtkRtFMpxfqrlwM34I2Ph/P0Fobqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciWHyLMikqH3wKENiDm/GxmXb1N461xZPfHB5KvcB1o=;
        b=nmtVIDOhAU4t6a2xYZjX9N8yOVaknscr0PFRWxVnx2TcT2WzRx9Xhib/zZmJxtfZCC
         YONiMKQXOyOawnGf/efd1axT4qmhZ6tQm+njKm+mhrIq7ehTh64ZqXmRGpHGqmcG1oI9
         qikORnKeL17frI/xULZmHCOJCn+lzz5fwmnACzr23Y9fXCFtZQoo45J25wvk6NtGsDeA
         j3z1dJp34f+f90TyBmCMUmW2BBPI2VaepPYyCgItoXWFPTDibCrZ6Tl7FaKFlL3FH70i
         v2KYtNE0z5HKTpfsRSxIlax+j1fbtakvXDILQZOTsP0Rh8Xi/eojW/OjLLdklpO+HBhV
         m34A==
X-Gm-Message-State: APt69E3FuRuu6fJfu49mS6+jAQnUzRPQkBWK4ya6RwgEwjm62UmvP+64
        gP8MQlpE80N1/efZ014Hya88RQ==
X-Google-Smtp-Source: ADUXVKIQGIc9U/RumqSw0uLnVXZDj3tM6tgM5h7Hlrwva7wTiuRUdpUeU1aQgvCDYifZZx/yJ1bzPw==
X-Received: by 2002:a1c:69d7:: with SMTP id z84-v6mr1441571wmh.147.1529496707592;
        Wed, 20 Jun 2018 05:11:47 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:46 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v5 2/8] dt-bindings: Introduce interconnect provider bindings
Date:   Wed, 20 Jun 2018 15:11:35 +0300
Message-Id: <20180620121141.15403-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is intended to represent the interconnect hardware present
in some of the modern SoCs. Currently it consists only of a binding for
the interconnect hardware devices (provider).

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..6e2b2971b094
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,33 @@
+Interconnect Provider Device Tree Bindings
+=========================================
+
+The purpose of this document is to define a common set of generic interconnect
+providers/consumers properties.
+
+
+= interconnect providers =
+
+The interconnect provider binding is intended to represent the interconnect
+controllers in the system. Each provider registers a set of interconnect
+nodes, which expose the interconnect related capabilities of the interconnect
+to consumer drivers. These capabilities can be throughput, latency, priority
+etc. The consumer drivers set constraints on interconnect path (or endpoints)
+depending on the use case. Interconnect providers can also be interconnect
+consumers, such as in the case where two network-on-chip fabrics interface
+directly
+
+Required properties:
+- compatible : contains the interconnect provider compatible string
+- #interconnect-cells : number of cells in a interconnect specifier needed to
+			encode the interconnect node id
+
+Example:
+
+		snoc: snoc@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
