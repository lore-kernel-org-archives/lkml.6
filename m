Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D509CC64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE12082C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Noeuy81u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CE12082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeI2IGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:06:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43631 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeI2IGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:06:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so5400275pfi.10;
        Fri, 28 Sep 2018 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wY2uvfhDy/86uUBxBQekBXNYMfsp+PaS8p52+lVw/S8=;
        b=Noeuy81uDxOtVMSLGG/ifxNoBnRosHMfbZ++fkqj1ZJyFdw1XVXIQEXhvgCn/LFmSf
         ErxoaN4hwv33qqyQHjSPHDVZ6xe5+xpt706uhB2hb7A0bEZv+igPgILTcRLjjcz3Mcrw
         Hce+E9XU7AbMNWRER54wYcW26Zg+/Rw4RPlQzu3rcrZP5iUhqxrX+HF7gOk57gt2t5Nh
         d9+7ZYw6ThoYC0OUvrVsM/q8AwkK0GuGEQOLeQSV3QmNXxXobUR7Tk4NXiru/l3nRtey
         YtFjONR/abnXVNram3gyf8qgSsDBA6vqVaUeCzuoQa8rWuwyTNjpdZsKqTwlk0fdwhwQ
         rfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wY2uvfhDy/86uUBxBQekBXNYMfsp+PaS8p52+lVw/S8=;
        b=NASX7vqJn7NLPIxk8ErrsJK+dbvnjgSXrK+2fHlLPN6cDT33iAB2/SuQs12uv+Hknb
         2qMud+RpnZcpSr/AKOC+eKQD4M1uobZVNxqibgdfxxhcECxgIOr44HiUYVoOC4731l3W
         rs3gLBssfMVhOwApQ0/QQB4okR1XcmM4bhAMzZ8sq/1PiWG1cu6BhheWxl2aLsQTmNA1
         IEvFZCbzXEmUyzIemnQW6ZYqGteqkpQlNW2yCROTM3jqDsLXsNxr7yq5kWPNeUaAzVf4
         9W/Dx27vvr6Hq2r08ZnbmlkjsDeoxAgm9QqR7pFxS7stJ6L7mqn+Tk/Ms05GJgeZNc0p
         h2lQ==
X-Gm-Message-State: ABuFfoiji21YRDZwPij9Cf1pzsTsYfPg/qdYHwMnhEkwl8j94EHhNX9b
        YTm5UZFoQ7I7TfxecEk4kF4=
X-Google-Smtp-Source: ACcGV60nRIgUT+iIcUF1JMHETjJXDEdpQ9iUfPS7SM5T/rLCHvjRR3nUib/m3iNtkNwoIjDJwDjQBg==
X-Received: by 2002:a62:1b45:: with SMTP id b66-v6mr1161142pfb.94.1538185189213;
        Fri, 28 Sep 2018 18:39:49 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8732813pfm.137.2018.09.28.18.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:39:48 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v8 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Fri, 28 Sep 2018 18:39:36 -0700
Message-Id: <20180929013937.29289-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929013937.29289-1-nicoleotsuka@gmail.com>
References: <20180929013937.29289-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v7->v8:
 * N/A
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

