Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84228C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CDA2173F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc2u/rJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CDA2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbeHGM5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:57:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43260 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeHGM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:57:40 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so6947804plv.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ni9lYCCJ1DN/2Vf0QZIqF72U+f3npylLIvSbMNmcQyA=;
        b=Jc2u/rJxX49nKk3ledHSW0qa+3DjKge/MKOOHVVXFU7Z4a3Qw6n6akwx1y2VTGF++i
         Rtk8U5XRUwHukoR+Tsu6qXf4j3XqrUH1bDtTsCPoxyqx2e3g3yfUqNs9XK7DbKXoFr1H
         FiNWcyhNI5+QnocMmmz9VbIIfK+yesSKgG6og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ni9lYCCJ1DN/2Vf0QZIqF72U+f3npylLIvSbMNmcQyA=;
        b=PN0na+g5da5AuL0IU28PN3avsF8gjC6+chj+dk3QxVbad1hiBO/UWufyAufrBZyOtC
         ln1ijS4c7ecM7+GTznsPEzhPjo/7EcpIxJDsrEYIawCJ7f7rUSpwJbQjsy95Qt0jso5T
         7k6DqT399GYwJLo6yoKYPaGK7W9GEuzlNqJdpsq97hI+aIyAhrjlRtAJkHMECcvS2aHi
         xAghcsF8A+Yd4rJ7IMI1aYFfy7m/LwENSA4ioUfu6SJ2EMY7QVteMJSpn2NFy0GzA6EW
         6LKONc8LCClNNnWSQro7XlfxAYx2uks1Dyb+9R2mfkwoPjee/0k3LglO2inHtOoZ8PwR
         WS8g==
X-Gm-Message-State: AOUpUlHdvCLc9IEvX38gTwT7fs+kBLBNGKttwkeh/HBskC/I7bFuEmiP
        P2rLTo6Vb64IHk9+q8nvXrLwrw==
X-Google-Smtp-Source: AAOMgpcapeW5UKOHkjUUwjQpH9++0a8wr4LafmyZGZ6zjyk+CAJMEJdsSpKTiWj5XaVWzfdvtb9Cbw==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr17486946plb.38.1533638636738;
        Tue, 07 Aug 2018 03:43:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l127-v6sm2305547pfc.55.2018.08.07.03.43.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 03:43:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        lanqing.liu@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date:   Tue,  7 Aug 2018 18:43:37 +0800
Message-Id: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

This patch adds the binding documentation for Spreadtrum SPI
controller device.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
new file mode 100644
index 0000000..06ff746
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -0,0 +1,31 @@
+Spreadtrum SPI Controller
+
+Required properties:
+- compatible: Should be "sprd,sc9860-spi".
+- reg: Offset and length of SPI controller register space.
+- interrupts: Should contain SPI interrupt.
+- clock-names: Should contain following entries:
+	"spi" for SPI clock,
+	"source" for SPI source (parent) clock,
+	"enable" for SPI module enable clock.
+- clocks: List of clock input name strings sorted in the same order
+	as the clock-names property.
+- #address-cells: The number of cells required to define a chip select
+	address on the SPI bus. Should be set to 1.
+- #size-cells: Should be set to 0.
+
+Optional properties:
+- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
+	converted to the delay clock cycles = interval number * 4 + 10.
+
+Example:
+spi0: spi@70a00000{
+	compatible = "sprd,sc9860-spi";
+	reg = <0 0x70a00000 0 0x1000>;
+	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "spi", "source","enable";
+	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	sprd,spi-interval = <9>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
1.7.9.5

