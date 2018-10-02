Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60097C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2505F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG32msl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2505F20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJBHqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:46:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35347 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJBHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:46:07 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so299425iob.2;
        Mon, 01 Oct 2018 18:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wIq9IFwVJHrQLumNYDLwrD02H3CSb5KOfmjnOjo7lE=;
        b=PG32msl2xsabBXOWKmt+d7NODHvYjTiCwFDhqhjqt1ep6hzpqjCHBjwt+DlrlxDaz7
         NQm3e/rFgl1GdikY2+tJXSKKCZDNMIXxtF+GAudlyXbRzo4Nb31ypmuTX8jF67gLP4VP
         umHy301m4yjbO21yr1ysyJDZ44AMflwFryYEkPOteyyvbCzufRHSYhG53vP9LKiN1pq3
         TuuB4aYepEqyeOtQkM1+OlObA5e4jHtbAw+3/sSJIR8N9YgkYoeOASKfXHweCG7XQW14
         TeiXVrmU9ES/cxxZ9WhYutayUDPVORt1hD+r+62SToHw58uaVI/TpNKr0V8C8NPTsoR4
         wGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wIq9IFwVJHrQLumNYDLwrD02H3CSb5KOfmjnOjo7lE=;
        b=UyKaqMWQVk4GVggFU7oGj9SOcX0A9lUw33MiTVzWI0lqWzi8I3cq7rAgxJ7E6yxplT
         b42I2CLspjITc9hwTcfOxwq69YTEC9EaOdcubREz6qPfPsANd2jQRLu7PoVZpYuNmIYu
         XBXMK824xVdsjEujUNb0xSKGuOiKV0zt+qu+UQpTDUwd20FtFNrrv9Ulte6uKcKDJhYG
         G22d0mPCcUQq4V+OuUUmINTCzXo/ejuLWNitNqHQENqgZl9EN1WiY1uRkOLE61lqDJJw
         Q5YDJG14NKX5Cgn62lF0DHVM/rB3KYOlZJdMnN3NLKcjRSrOLVDeZKbp1Zv8iFR9Ozj0
         8Agw==
X-Gm-Message-State: ABuFfojqImq6P1D5gkCc+Oa7XSloclbCinOztgF7utfz6dTwau5JWVpF
        0bmXkxDcq8g4iyDDRCE/M8M=
X-Google-Smtp-Source: ACcGV61WvI4jO78o8phv7VgMq6bGCFsdbLVQcAOmkAHJf3tpiVQL7aFCfLv48x0FdD/xAh9bfgPm9Q==
X-Received: by 2002:a62:4ec9:: with SMTP id c192-v6mr13907012pfb.221.1538442335411;
        Mon, 01 Oct 2018 18:05:35 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x20-v6sm26084959pfe.131.2018.10.01.18.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:05:34 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v9 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Mon,  1 Oct 2018 18:05:22 -0700
Message-Id: <20181002010523.2019-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002010523.2019-1-nicoleotsuka@gmail.com>
References: <20181002010523.2019-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v7->v9:
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

