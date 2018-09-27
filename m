Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51B92170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VGvPnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51B92170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeI1DOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:14:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44679 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:14:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so2706098pff.11;
        Thu, 27 Sep 2018 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEPqo8UshyGJEBSPc3pM5gqUJLhqwWP5Igyt9SkMH6A=;
        b=J7VGvPnNsmWFyn9jNknc2VbrvVRXOnPnkPgkDpaRg2xnZ3+bmBtnf59GEGWKS5hnpY
         iZHZ6z2VzZsohkX050yI515r9TI9myIwEEuoHUayUuSKESwgYzSBC2KP1oJ+HzBu4d+W
         F73hbP6vlKNENQR6DpQspvvPXRODssLaxofKpZgH0TslTThqMjMs5BMYnfvlET258VjI
         LQaxXI6nNZxT7EJcLfruRLDznUHVp1Ytcy+p/ZQ9o5ClbIcrdOKyy4Y80q7n9oVHPl1r
         4VoWJ/DH+2KxyigA/pj6aJ8OOQ9PM9Lux3Z51gyMJEGV4VGSv9RWxxsR+qvTp3QxtSBX
         6DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nEPqo8UshyGJEBSPc3pM5gqUJLhqwWP5Igyt9SkMH6A=;
        b=SbCa2d3kbuShvYXb6whYJLCRCuCFUXjgKAuOCCdRsDxtVZwKcDWzqrUM8UJJ2Wql27
         9d+yu5LhYM1yqeppDn/4c9zjVRu5prsmi+m7ZhcPbp9+nimON0V7T7uaYpmTXZJXFaNH
         AWZy8BkPAmHcW+amQV1UlsqyC427ovDS1s5Inl5Eadwa93dZd3Z9dl9CoHES0+qEdLvj
         U78qgBWBbf/3tzu1PJn2I4sP7mu+iZN6hoxzVVSediUZ7PsY/2HsWHSf6yreYnfWI8rl
         xq+hwh8ZX7MmBHEe6+RgDzpc4wCcBxqk3sdRRWkkYjhoD62GS8n9rCyG+x4EelAaVyHL
         sVcg==
X-Gm-Message-State: ABuFfohNIKR80/Flg/p74rppeCWoH16K8ab0oBjMa4TGHNDK4/iPAaXf
        ku/6GysYRQfdE1RFZdSjmLAs9Yek
X-Google-Smtp-Source: ACcGV60Jbs8fqROqCYdPp2QOhRnblTCoqb7nj6EGRGljIW89TmPxc3xkuj3Kkdtu0lLfukxxqg0toA==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13-v6mr12890550plm.114.1538081654340;
        Thu, 27 Sep 2018 13:54:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v26-v6sm4354101pfe.57.2018.09.27.13.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:54:13 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Thu, 27 Sep 2018 13:54:05 -0700
Message-Id: <20180927205406.21932-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927205406.21932-1-nicoleotsuka@gmail.com>
References: <20180927205406.21932-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v6->v7:
 * Restored three channel examples and merged them with the parent one
v5->v6:
 * Removed status property as no need to explicitly list it.
 * Combined all examples into a complete one.
v4->v5:
 * Replaced "input-id" with "reg" and added address-cells and size-cells
 * Replaced "input-label" with "label"
 * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
v3->v4:
 * Removed the attempt of putting labels in the node names
 * Added a new optional label property in the child node
 * Updated examples accordingly
v2->v3:
 * Added a simple subject in the line 1
 * Fixed the shunt resistor value in the example
v1->v2:
 * Dropped channel name properties
 * Added child node definitions.
 * * Added shunt resistor property in the child node
 * * Added status property to indicate connection status
 * * Changed to use child node name as the label of input source

 .../devicetree/bindings/hwmon/ina3221.txt     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..a7b25caa2b8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,44 @@
+Texas Instruments INA3221 Device Tree Bindings
+
+1) ina3221 node
+  Required properties:
+  - compatible: Must be "ti,ina3221"
+  - reg: I2C address
+
+  Optional properties:
+  = The node contains optional child nodes for three channels =
+  = Each child node describes the information of input source =
+
+  - #address-cells: Required only if a child node is present. Must be 1.
+  - #size-cells: Required only if a child node is present. Must be 0.
+
+2) child nodes
+  Required properties:
+  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
+
+  Optional properties:
+  - label: Name of the input source
+  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
+
+Example:
+
+ina3221@40 {
+	compatible = "ti,ina3221";
+	reg = <0x40>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	input@0 {
+		reg = <0x0>;
+		status = "disabled";
+	};
+	input@1 {
+		reg = <0x1>;
+		shunt-resistor-micro-ohms = <5000>;
+	};
+	input@2 {
+		reg = <0x2>;
+		label = "VDD_5V";
+		shunt-resistor-micro-ohms = <5000>;
+	};
+};
-- 
2.17.1

