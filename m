Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1490ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5407921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCu6u161"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407921547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeIUFyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:54:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42580 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeIUFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:54:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so5076357plq.9;
        Thu, 20 Sep 2018 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vNQHJ1PVklIpmA6lmuHU4tL2czx3/Ieaf/l/Pf47rLc=;
        b=sCu6u161XK8hQ2Is0EDdrVLyhc0ADJEBnpy7CmJesMIgkfTQ4eKvkJ6BLUsjrkeQ6Z
         w9s9VGS/EdLknda3FKLz2wXctyqhSwHriE6d3XLkx9LRXMsk2vmJ1wPuQOTGcEvboMTr
         hcmH5hNLp5bqLkAkHu5rR8I3PgSJ4l45ZTTYqVnW0GclnOtAR9/6uOGxs8uACalSopne
         ekT6YU35Bf6rKWY1h/N+7jS4L0cvxbhnpPCyI1/PwIlFrtOCyaDHexgc3dVQ4qprLPpd
         360kpQBL/Uw1bJ0u/nM1ZbV2vdtnchYqzeY7Jb8KmQq672mIfHuTd/irJuloSLDEC+py
         BnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vNQHJ1PVklIpmA6lmuHU4tL2czx3/Ieaf/l/Pf47rLc=;
        b=f6uxqOU1fJTpDaN0MhtUdMu6OeXi9YYuCe+VZK25NcvHnNxPEVdaohoG3ueKN1YnYb
         qZGNrlfSUIGOpn5CGcfPxGFxrA4wsZqdz3Rqt6IfWOuxm5Pc+Oop8GU0Il7NAOZeo6Mv
         p/Sr1LZwMRnDQbPHDLlfZ1T3m29yScjqqAXcz94S6BO9wb8kOzP0bL9HG7pBhQBAgYyk
         83bTnXdI8EKb9j9FV76LXUCAqqIwNOAFLV/VaxY9b/jTo+AQuZLnBjc0Hjx5NouAqy+f
         an5PsLgVDWyeXttaT5bgz12ToCx3zeiZjvtnqdlCcW1ttyDEo+i/P4TN+wWdDBvxNv03
         RoGw==
X-Gm-Message-State: APzg51AopCYZ5jaz3su66Ol7qN/9H6D0m3wWNVvnTyF85sGwGJvcnDLW
        v6nIzQI+cfcG7JnhauQ0Ii4=
X-Google-Smtp-Source: ANB0VdaFZ1nqcwrTBoZMkOOJfa2sZhJxD3Q9gg6B0xZmj3N5uEd4Q0N6LaO7wxvAPYXqOrPArcaE4A==
X-Received: by 2002:a17:902:7c8c:: with SMTP id y12-v6mr42009346pll.283.1537488494807;
        Thu, 20 Sep 2018 17:08:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q26-v6sm43355083pfj.127.2018.09.20.17.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:08:14 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Thu, 20 Sep 2018 17:07:52 -0700
Message-Id: <20180921000753.21846-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921000753.21846-1-nicoleotsuka@gmail.com>
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../devicetree/bindings/hwmon/ina3221.txt     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..266c9586c9b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,23 @@
+ina3221 properties
+
+Required properties:
+- compatible: Must be "ti,ina3221"
+- reg: I2C address
+
+Optional properties:
+
+- ti,channel1-name:
+- ti,channel2-name:
+- ti,channel3-name:
+	The names of the input sources (described in the schematics)
+	Set the names with "NC" to indicate not-connected channels
+
+Example:
+
+ina3221@40 {
+	compatible = "ti,ina3221";
+	reg = <0x40>;
+	ti,channel1-name = "NC";
+	ti,channel2-name = "VDD_5V0_EXT";
+	ti,channel3-name = "VDD_19V";
+};
-- 
2.17.1

