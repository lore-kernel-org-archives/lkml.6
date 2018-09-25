Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402EAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E5320867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLI795JV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E5320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeIZFJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:09:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45119 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIZFJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:09:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so4547787pfi.12;
        Tue, 25 Sep 2018 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hL162RkExEcLg9Z+BbmT3Ey+Hhsqgktqno5vtgKw68E=;
        b=TLI795JVq6orQTiHJTZSUk1WDFFrt55+3qvytTcTeuoo7h5bY8UvvSfk7OHIHa4HGd
         JTgenpLrDJxNXLS3orP374tWwUC5pvKQSq4H5WbDNtecIXRW9Dc7O5Xzl6GOxptCWBs0
         /1BbciHi1jEaE5iagE59f8+9kRnHYvwJ7yNrWuky5izMYNl9xNwwehrss9KZAT4W6dX9
         3IF38WifMK4Kdkz5B0ygLCHYotOdwcV2BIkMw/JBdUuUCmht0tLeiNm4pgGi5A3edWEh
         hQLyUiVd34Sb/GFsI51xnMmMG419L2Vyed+Ox9Lg4RqkR9tW8XEBcsGP7UFyUKvFNQC+
         NlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hL162RkExEcLg9Z+BbmT3Ey+Hhsqgktqno5vtgKw68E=;
        b=YzURbUxaTxghMhAYM6BpcC3GGQfAMJoVLdgOivL9Gyv/OOa6c91TomRB7YGjgsEYxk
         2kZ3mqSfTbHZrHYLEWHynTMnbIFfS38C9lpNXrM2qHHYEEA/3K29oDJpJHXRovt30R9y
         KbtuPFcfhGqpebcERtWHl1j8rLjxmvB7BJ5IZtkKsG3jFBGIyot8O/rsxJro3TvXf+99
         +kNpkNizpjBlk7WW4i74d/yccxDrdgt1jvmhoHyohj4OB/CcpfaJXPWN3F3FEwq2eC5l
         2JLvzplpo+2eLNC2hrWAQaUnvpBsjNri4IUyw+DfTBOWwMIjOJROThA6qw3C/8u6yyDb
         wQgw==
X-Gm-Message-State: ABuFfojIGAdwFYfLUphw/wxMmngF7s/2pZUa22AcYofI+VF3ByZ3znD6
        8GXs/WnChf1dH+4H8tIEpxo=
X-Google-Smtp-Source: ACcGV61zyBLcZHf//kNvVQZCexlS4Dtt2f2+rQyPEgSxvXwXDmOvX/x6XgvPOk4x24VG/2op7rM9Ig==
X-Received: by 2002:a63:c4f:: with SMTP id 15-v6mr2983098pgm.155.1537916391915;
        Tue, 25 Sep 2018 15:59:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n22-v6sm4652579pfi.185.2018.09.25.15.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:59:51 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Tue, 25 Sep 2018 15:59:29 -0700
Message-Id: <20180925225930.31886-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925225930.31886-1-nicoleotsuka@gmail.com>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
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

 .../devicetree/bindings/hwmon/ina3221.txt     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..e17a897f4803
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,49 @@
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
+  Example:
+
+  ina3221@40 {
+          compatible = "ti,ina3221";
+          reg = <0x40>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          [ child node definitions... ]
+  };
+
+2) child nodes
+  Required properties:
+  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
+
+  Optional properties:
+  - label: Name of the input source
+  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
+  - status: Should be "disabled" if no input source
+
+  Example:
+
+  input@0 {
+          reg = <0x0>;
+          status = "disabled";
+  };
+  input@1 {
+          reg = <0x1>;
+          shunt-resistor-micro-ohms = <5000>;
+  };
+  input@2 {
+          reg = <0x2>;
+          label = "VDD_5V";
+          shunt-resistor-micro-ohms = <5000>;
+  };
-- 
2.17.1

