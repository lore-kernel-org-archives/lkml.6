Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21BBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A3620823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUQv4oTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfBHRNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:13:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38750 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfBHRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:13:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so4148026wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIjMZWBApTZOoaJL6tl091AuE0dnp0afLV6yVMOATA4=;
        b=jUQv4oTcJp+WfiWAnh4utQ406+UUmL1iwAJM7bwXkcK+9jADsoctShsdBVRWXvNsuv
         EHIwvMR0ES7RkV4+E7LmmYOAUyz1zPq1kOA5PWpTWhDaK9tb92veZZ1FBLjAHNe4MsX6
         2lbyw7WLBqfc3viVnulEM1mUWjSAp+OHoGJbQqd89ULgWuZeJvLrMyulvO1Py/R1bGjC
         jsP7r8CUECZYyQvI6kQzgyuKqzsf6hrGr1ocgnbf5DkFt0pByXWjte4mQqoafbk0qRRX
         MZUJux/8iZw/9w+usOK7u02YmyfocFKTYe/VZ+ojaP/v6JQMpKW3INukrOpxFVYwbMjK
         5ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIjMZWBApTZOoaJL6tl091AuE0dnp0afLV6yVMOATA4=;
        b=R0/e9IQTTjsWpATe0EVsiEL/nNrh8clCWEvap9LgXy8FHKHnl2G6zsH/cdMd85viFF
         1y6os0FKLYhFVJZ42O2Jt6YiiNhNBhNZMRUBrKVeZlNO3dV9++XC4i17FFHJZbjvcoJs
         izRo+a/H8lU7YmVIvy7pq9mygzFf7TJ2IeiMmYrzCD53E390IpR7n99mS6MLpWOwMM7D
         uo+g+LJwhsL0+qaCA6gpZKOGYf6+PxQmb7yvuuOyuYJFPxa+cMyOcbdsjWZeMGlI9Ydm
         hB7NstKemEMcDZBkQEO6ZygANZ4f6LPWa35y1wuaXI/8hstQ9HzOSZizWQxxsvuC0kD6
         JMCw==
X-Gm-Message-State: AHQUAuaS40sdO2xm34EPqs6Sr8bPSBfq2OLhwcf28RcFTT5wqoJkH5Tg
        bPhmxsbN/6UNVLdzGY06n6SK4g==
X-Google-Smtp-Source: AHgI3Ibnpp6U9aAms4ZLkCxm/BL6VhML23jO6FJL2tltqsvH/HSItrFoN8B5GYR9tRTVy6PNUFd86w==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr16971086wrq.204.1549646008130;
        Fri, 08 Feb 2019 09:13:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f139sm4521634wmd.19.2019.02.08.09.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 09:13:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Fri,  8 Feb 2019 17:11:23 +0000
Message-Id: <20190208171127.24168-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208171127.24168-1-srinivas.kandagatla@linaro.org>
References: <20190208171127.24168-1-srinivas.kandagatla@linaro.org>
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

