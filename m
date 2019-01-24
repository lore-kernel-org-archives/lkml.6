Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01355C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5307218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3Ir0IQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfAXPZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:25:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46997 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfAXPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:25:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so6864743wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zctOFcXs6+EqsNvLDCpHPO7stwx5YTajBT2XWhNMNok=;
        b=W3Ir0IQgtO2Ghitoqi6wH/pihXTN7mFPyj9cXssgScb2EyhvgVSSElNFUEGA9vUGBd
         T/JhB2JKUNZFxAjaz6ExCBwIludxrX0eIDGEwC/BCBerFhzEqJVvHyOJkL3YXDvdXok5
         h1rnsR8fIPzJVdeKDP9PubPVa9ShJOlEHcB0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zctOFcXs6+EqsNvLDCpHPO7stwx5YTajBT2XWhNMNok=;
        b=IaEdEeTFkacsGDgDjjaTgavVMmiB0wUtTQUu+gcOPgOfWlku5AVUKkLMd/Y79YsJzd
         mQYfw/XC+UWs8DzNusCaIToX96JNirbPovErkrX4c5SfiSEmrjN5lRza+YuRkLE89Hzw
         gpnISDYFpggIiXHHob7W+AyadhHm23J+jAFfZZb1hpXifwxe270mfbfPPYPqUxTmFebo
         ll/EQdmloxVO02JHSPjjlcJtiTJjWjY/2btCC4TdNg+NTTXJHi9qeAtjotUAQbcxYVGj
         DU9UX5bx4bJjNE1GyDP3GM/7UzH9uUs+xPGYKCl+ru3OR2ufkzIAwnDZ84kc+A6xEcZq
         FTgw==
X-Gm-Message-State: AJcUukeQn15CNJ+Rey1OlobH5biI2jvXdL5Y1PkmPGlWNtV0TVGUPb7i
        YpNrPGTWIBc9BwWgepvzPKdkYg==
X-Google-Smtp-Source: ALg8bN5YhVPgUcgrIUpTUepLK4e0aFtEowaE99KzCfrYbnRJ7jYmQ4NfVmOZZhI7NnTuyoRfZTFFOw==
X-Received: by 2002:adf:f390:: with SMTP id m16mr7377267wro.71.1548343548315;
        Thu, 24 Jan 2019 07:25:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z12sm80371157wrh.35.2019.01.24.07.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 07:25:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Thu, 24 Jan 2019 15:24:08 +0000
Message-Id: <20190124152412.10503-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124152412.10503-1-srinivas.kandagatla@linaro.org>
References: <20190124152412.10503-1-srinivas.kandagatla@linaro.org>
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

