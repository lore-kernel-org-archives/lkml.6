Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEC420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bz6AnpAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405209AbfAPQLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:11:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51407 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfAPQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:11:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2594684wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zq2oMbbyivDSUeOMLU6UgVaZMPHzfeEtdH+iJhaQzFI=;
        b=Bz6AnpAOC1LWp7HIBwDPW+c8rI8rUIahEAzNe0cf4f9UbL5QjWiz+9EPB6M8Nomzlh
         oaHmJRLfPCL9PHQSBM4L1e4f9TLFbjrjJ5tOTWBpDhIWOBhONvm1Y4f1pdYJZBm1cCCg
         KNQiq/we5MfhtJ2paVJvkrEDQx1ztjjFkjxHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zq2oMbbyivDSUeOMLU6UgVaZMPHzfeEtdH+iJhaQzFI=;
        b=VpPEGIPMIPews+WkQslil10/mhMwLj/MQLmKbu5p/8PMLWqYWydW90pmerakJQpaaK
         /YQyZFDotSIsJtKQ7pnfyn8s2l9XNJzb0105CjlDVGDGxmm6/f194Pl8hsNhtflwroTf
         TpoH41rONPlZYBpiz3E7k213VALuHQhtWOOCMCCnMP9m1OlMrANvRHi5SrvNcXSH9S+E
         RVpqFipUIkwZZ+hSFIfNBsWTdSN7wFVtFLD8SPvhYFjM7OcSRK0AbGcjTXGnE+J4MFzR
         Ht3MXlwGwORJcqRG6An+LSQsXYhosQEfjk577pl1+llrHQVuBkNswRWmhWa/TNRHsdoV
         I7lw==
X-Gm-Message-State: AJcUukdlYqBIodtmA3pOKwt3rRMUBKyh+Xw8u0APexnBn6SO2FQDWkh0
        6WRdCODsFMZZIrlt8/fbmJecEw==
X-Google-Smtp-Source: ALg8bN4Cf46ZL1gy7/zlADr5kz6Lry7MyVxWtkfDt83Hljxxs3bH3mOcohe+U1Tkugq4psB8bi4ACw==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr7978630wmg.107.1547655071506;
        Wed, 16 Jan 2019 08:11:11 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 08:11:10 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, georgi.djakov@linaro.org
Subject: [PATCH v13 2/8] dt-bindings: Introduce interconnect binding
Date:   Wed, 16 Jan 2019 18:10:57 +0200
Message-Id: <20190116161103.6937-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is intended to represent the relations between interconnect
controllers (providers) and consumer device nodes. It will allow creating
links between consumers and interconnect paths (exposed by interconnect
providers).

Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..5a3c575b387a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,60 @@
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
+directly.
+
+Required properties:
+- compatible : contains the interconnect provider compatible string
+- #interconnect-cells : number of cells in a interconnect specifier needed to
+			encode the interconnect node id
+
+Example:
+
+		snoc: interconnect@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
+
+= interconnect consumers =
+
+The interconnect consumers are device nodes which dynamically express their
+bandwidth requirements along interconnect paths they are connected to. There
+can be multiple interconnect providers on a SoC and the consumer may consume
+multiple paths from different providers depending on use case and the
+components it has to interact with.
+
+Required properties:
+interconnects : Pairs of phandles and interconnect provider specifier to denote
+	        the edge source and destination ports of the interconnect path.
+
+Optional properties:
+interconnect-names : List of interconnect path name strings sorted in the same
+		     order as the interconnects property. Consumers drivers will use
+		     interconnect-names to match interconnect paths with interconnect
+		     specifier pairs.
+
+Example:
+
+	sdhci@7864000 {
+		...
+		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
+		interconnect-names = "sdhc-mem";
+	};
