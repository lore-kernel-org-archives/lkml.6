Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06AFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93915208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvjh8Av1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93915208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbeGaRyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:54:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeGaRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:54:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so17260700wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciWHyLMikqH3wKENiDm/GxmXb1N461xZPfHB5KvcB1o=;
        b=kvjh8Av19tm70Bw3cjax1UQRlc7MGcaA63442wYqH1VGa+gvL3/PSTOBVWXnywvC7i
         VlsttPrTQzX3FRZ4NsMrRewQ3DOY2BREc8ge/Vc3WnqklgaTZwjA0REK5GTB7XSup2uV
         IVf90e7ERmMlW1a28dvJfHxkLMyUvFra8sVrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciWHyLMikqH3wKENiDm/GxmXb1N461xZPfHB5KvcB1o=;
        b=fZxlqEnOE3DrNcqqvdgJdkKUCVffg3c7WJos76cp4lJSanctGLWVOzccZf/bMHwrUx
         4yxTVl7j6y+xkan6KpSmPkJGhzeaZ1xRJx/e7EioXUkJoOHN3xOLlDxrEQaqzF2ied4V
         nCNakomGeFD8jUDPh6IuI6+WKgR1c7tTAxLTeAHwrQmFIaqc5MOxWUSSnwtwn3qHuLC9
         IQJzEjHpsbXKs9RZ03zO1P+lj8FV+ELG03+pPjTSylsp+NMd/46ZrYalvWdQ3/Nx+yOx
         3uxzSOtKC4XvHQs7LgbT8rzaYWuzSHWwp3tKNhoiJ63VEuEX9cct2uABWhgA7qa56+n6
         Ya0Q==
X-Gm-Message-State: AOUpUlEF2JL9ZsSBWcOcUwVU8Iwcy7V5lybMzEfajzmnMWs6rgYUALE+
        Zz7ZEr+MSwx1wPuIie0YR876YQ==
X-Google-Smtp-Source: AAOMgpc98l8EnnCeCnfTBKh3JY9aMNMIylRGDIRMHl4Jh1b49Qvh/MsqbNrhlnV8VnwZggm7uujS0g==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr20839574wro.279.1533053626316;
        Tue, 31 Jul 2018 09:13:46 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t186-v6sm3643457wmf.14.2018.07.31.09.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 09:13:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider bindings
Date:   Tue, 31 Jul 2018 19:13:34 +0300
Message-Id: <20180731161340.13000-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731161340.13000-1-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
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
