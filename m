Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2415C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tu+xjPU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfBHNX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:23:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfBHNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:23:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so3361507wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIjMZWBApTZOoaJL6tl091AuE0dnp0afLV6yVMOATA4=;
        b=tu+xjPU4S39vb5RpTMx4vlubIIO6GpKivRMOUYjUip9HTdFkpZBVXpTNTWKr3mAQ+W
         Kh1PIR7iwAgkgxDbA4KzAK3h0LrMVCbBcCGBFwOoPyXbYDXGpXo3VA7+sjWWRjcR7sIt
         IMy7xGs9ujZP7/5AIZ6pyPETzQrfyBICFIfS7HgFNs4HLeUE8NZsYpgaRWS6Ri6Ahspd
         7haBaD6C/0UPo3EeKWcrJ2RTsm45cXlIrPh2XbKtmxQF3Oh1milRGyIR4IKVoN+JOAf9
         VDl8NpRpF2496GzrHVm7u4UeMXXRYauhY1pjyNA5sfTqVs/X2XMC1OfRNyiLGUGodJFJ
         G2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIjMZWBApTZOoaJL6tl091AuE0dnp0afLV6yVMOATA4=;
        b=fjAmu4yJzQgIDpDqK5UpqDgGaKK/1BN80ghRa5v/AYkivWl7H5dsunpTpb6nN8iZQz
         c6TOtjdHik9vc1CTQDwHxZ5mZJnr0J6aYxhHblqFhFQhfBWasPtICxq3MFr5hLQUm8TT
         cd15SPqarYss6aQN21MNcHkd9KGT59o/7lJZwv52okCzISSYsI9EMnO07z5H0LCEGQAy
         BrqjzbxuJAIdX9AWcPRII/UEO2RdybvyGoP5ssiitdNdHBUC45yrHH2XYrcy3PO6BbiQ
         aiuWnXIOhYKFLC4T3hV6isjp3vGvEfP5jTIPJ1aOQK8Sc65PKycME/5lD+dlvK7Wo/RF
         JYhQ==
X-Gm-Message-State: AHQUAuZtYDY1AlOfM1sulMhDNwnb524n089L38i2LPNPQ0K8epg0kaS8
        cbq5jMSiftMvAkHS8sqbp3LyjQ==
X-Google-Smtp-Source: AHgI3IaGkYE2MiJFiqeMZsjTziPMPVUiX9811cLFiCd2CB/LB66Dc58Roam518QQMxxgf+GOp539oQ==
X-Received: by 2002:a1c:5dce:: with SMTP id r197mr10870170wmb.130.1549632203403;
        Fri, 08 Feb 2019 05:23:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m21sm3033007wmi.43.2019.02.08.05.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 05:23:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Fri,  8 Feb 2019 13:23:02 +0000
Message-Id: <20190208132306.12571-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FastRPC driver implements an IPC (Inter-Processor Communication)
mechanism that allows for clients to transparently make remote method
invocations across DSP and APPS boundaries. This enables developers
to offload tasks to the DSP and free up the application processor for
other tasks.

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
new file mode 100644
index 000000000000..2a1827ab50d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -0,0 +1,78 @@
+Qualcomm Technologies, Inc. FastRPC Driver
+
+The FastRPC implements an IPC (Inter-Processor Communication)
+mechanism that allows for clients to transparently make remote method
+invocations across DSP and APPS boundaries. This enables developers
+to offload tasks to the DSP and free up the application processor for
+other tasks.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,fastrpc"
+
+- label
+	Usage: required
+	Value type: <string>
+	Definition: should specify the dsp domain name this fastrpc
+	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
+
+- #address-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+- #size-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 0
+
+= COMPUTE BANKS
+Each subnode of the Fastrpc represents compute context banks available
+on the dsp.
+- All Compute context banks MUST contain the following properties:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,fastrpc-compute-cb"
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Context Bank ID.
+
+- qcom,nsessions:
+	Usage: Optional
+	Value type: <u32>
+	Defination: A value indicating how many sessions can share this
+		    context bank. Defaults to 1 when this property
+		    is not specified.
+
+Example:
+
+adsp-pil {
+	compatible = "qcom,msm8996-adsp-pil";
+	...
+	smd-edge {
+		label = "lpass";
+		fastrpc {
+			compatible = "qcom,fastrpc";
+			qcom,smd-channels = "fastrpcsmd-apps-dsp";
+			label = "adsp";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cb@1 {
+				compatible = "qcom,fastrpc-compute-cb";
+				reg = <1>;
+			};
+
+			cb@2 {
+				compatible = "qcom,fastrpc-compute-cb";
+				reg = <2>;
+			};
+			...
+		};
+	};
+};
-- 
2.20.1

