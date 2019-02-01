Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1854BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93D121907
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiHcgq1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfBANLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:11:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfBANLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:11:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so7016363wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIjMZWBApTZOoaJL6tl091AuE0dnp0afLV6yVMOATA4=;
        b=XiHcgq1aAFJuWzvkuXssoWFFSvUcQIfrZgJK2K07DZgY1KWgvVd4+CsGUyjeS6aysD
         2iavZyZYneQKqLpKtUYY/2jKuR/9TU8fyPpjldyd0Z3zgys6KCvJtJ+axz3BBCzHdjNk
         tBSTQ45hpSUE5IeZc0Uh/FHKD71nfP+PnQkFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIjMZWBApTZOoaJL6tl091AuE0dnp0afLV6yVMOATA4=;
        b=ZU5kLSCz875PqRWxkEkqiGr5D58+e56YFm/5G6YNHkBEQtZlBnD9EEnwyTc2IFVbKs
         G76T1yu95Pt1mxY8Y9oCS4xlCIciDRs3xS48aDLrIZz80prwK2/7j3M7jRDtwCNDQB16
         eT+0OPnu6WWMfKFoPAOEkRvm/K4vdjukKxm4Vg6ri9qZnlIJwD9EQlJeNUkNn/E3bpQT
         k42Qv6UEtci5D/IjPYwApbnd8yxkam35Fz2mo5WlB+F3dccZZcqnw54ehRTQ/HeeT53E
         mSDtjWZs1RHo0CJ6SgQMG8nbi6uJWjNkhhIwqwmEbPg0W8pishHutiw+EUtLab45GvtH
         fAAg==
X-Gm-Message-State: AJcUukeqzLOYVBOXHlcLCRPg7fRbo9jwFGDIMF5qpQniJbdTXSQ86iwM
        E3omyPH0Rn2+DnAniBtjLrHcxw==
X-Google-Smtp-Source: ALg8bN50fnQGSXQ36djP8WoZyD1G5BPUFA2eD0COTv3ejyozmqWfSRlPrYvCIhq85VeHTdntaUO8Ng==
X-Received: by 2002:adf:f308:: with SMTP id i8mr36942302wro.219.1549026664301;
        Fri, 01 Feb 2019 05:11:04 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a12sm12563461wro.18.2019.02.01.05.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 05:11:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Fri,  1 Feb 2019 13:09:21 +0000
Message-Id: <20190201130925.27066-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
References: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
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

