Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD08ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B754F21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2+0dM0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B754F21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbeIVEXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:23:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35368 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeIVEXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:23:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so6542293plo.2;
        Fri, 21 Sep 2018 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cB+2D/GSI/kMki3Q36tKZbfbcvl/nIbd9au7x+bETgs=;
        b=T2+0dM0ppHqsYpAJl3qwtjGtY8QpZLtDKtyQ9mosM7cnCvuRJBb5DwFyn2H1Q0n1Gq
         GuYPpIBDJEIW26bNkXvGpz4kq160phFbcvVfmeY+/0UBYajrdWxtDd7s8/Mxp0StxKjz
         KrctLZTnZRCx964obNvPnZFzIUeW3fedhgqSYiUXMdkUvuE4o+GruOwpHfeu7yl8U9us
         7W84LHmrFeb37ZcT5cgA1d+0FhcLn6lNJ7tzJXf3VIHGi4/LuHaJJlNO1Agm1k5myHUJ
         K515HlJIrnsSqqBLtNDK7cUqY8zeV11Y8hAfQgloOzwVb1gq0PTlj3ileS/k8fS6v9LZ
         MUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cB+2D/GSI/kMki3Q36tKZbfbcvl/nIbd9au7x+bETgs=;
        b=q0WGzRTQOmOpAxXxGdJaHjBds6dzndmOJZxWXKcFOwK48ssT4QWMEXvHY6/8wuq10v
         kaggJ9pYMB2SdH9mG+4phEjJ1gtTZRkHRhvHF1WmtT10tXzncaAqzh9ksa8C5efuw0qs
         Hu887F+0aQ3dX0vcfoTYUikOfpV+kZY7n3XFWfPo3XadydD4mikPMZpLgguvV2DW0m0C
         Lwf3lr5/fIs5XJUhQjn0Ubkck2/0QRHfLBiRI4QsqXCVSd+HrJNIY2Rj7h8z5LAVR7kP
         eXnifadwo0JMhnNzURvO4rgDCBNF05p+ConOkjs3GzVmgJN8kbJDtCW45b74Y3w2ReOq
         AWGQ==
X-Gm-Message-State: APzg51DDVp1F+WGG4iqlAMntitz3zShBULDVdalNfPha+PJh5X+DdVvN
        A9LjZLp2D/1H1IUEd7GcvQQ=
X-Google-Smtp-Source: ANB0VdafsAGUr95ZDnX1fwP/EMEw4vzYUvo7w55oWuEfYNgDaE6pt5dxeVENkDMbfARDgiUmBdn50g==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr45926125plb.322.1537569149562;
        Fri, 21 Sep 2018 15:32:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 203-v6sm31683227pgb.14.2018.09.21.15.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:32:29 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Fri, 21 Sep 2018 15:32:15 -0700
Message-Id: <20180921223216.634-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921223216.634-1-nicoleotsuka@gmail.com>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v2->v3:
 * Added a simple subject in the line 1
 * Fixed the shunt resistor value in the example
v1->v2:
 * Dropped channel name properties
 * Added child node definitions.
 * * Added shunt resistor property in the child node
 * * Added status property to indicate connection status
 * * Changed to use child node name as the label of input source

 .../devicetree/bindings/hwmon/ina3221.txt     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..bcfd5b9c697b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,38 @@
+Texas Instruments INA3221 Device Tree Bindings
+
+1) ina3221 node
+  Required properties:
+  - compatible: Must be "ti,ina3221"
+  - reg: I2C address
+
+  = The node contains optional child nodes for three channels =
+  = Each child node describes the information of input source =
+
+  Example:
+
+  ina3221@40 {
+          compatible = "ti,ina3221";
+          reg = <0x40>;
+          [ child node definitions... ]
+  };
+
+2) child nodes
+  The names of child nodes should indicate input source names
+
+  Required properties:
+  - input-id: Must be 1, 2 or 3
+
+  Optional properties:
+  - shunt-resistor: Shunt resistor value in micro-Ohm
+  - status: Should be "disabled" if no input source
+
+  Example:
+
+  input1 {
+          input-id = <0x1>;
+          status = "disabled";
+  };
+  VDD_GPU {
+          input-id = <0x2>;
+          shunt-resistor = <5000>;
+  };
-- 
2.17.1

