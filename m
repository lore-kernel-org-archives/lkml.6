Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E728020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0x3W17S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfANTmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:42:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34380 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfANTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:42:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so292927wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMVWf8S5qQu4nvxHW3aF7B34QEW9X1fPwQ6VU5Gu+DY=;
        b=k0x3W17SuiYSteG11Gc0m9OKo1MyAuFmDtUW5axGlr2XXH19XnSz+MHtLGApPmof7p
         ckHUuBtJMBSZr16+qUqJMmW2eLDob84ttVM1MvdqkKJ9A+TcLWtv+lRf6kgyV4fPgl0r
         tI/QMFEfZPi+AcrI13Ugfo8IfTFtIgg/fAPY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMVWf8S5qQu4nvxHW3aF7B34QEW9X1fPwQ6VU5Gu+DY=;
        b=JAJWfItKpslePkhjZ6LnCh5l+PN2WxUP91Avo72QQXl85FGF+mrGt+bM9tsB1RaFxy
         DBc1Ez//4xN3AOaDP5TCAe8XxrwAD45bwso7fxMt+pafOKXWz7k2cPUolhYNcO1n4buz
         74it6MLz8XlkG+mjVYXkuNk+CWV83Jmyai62G1PigzB1ZpTWnUvxLJVtHo7UiP7WZLTU
         YOkFEshSc+jmTyj/eXV0hG++PFBzSpGooPVhs0flXK77rnSIOFyPyulCV7Z5NHR9qmnN
         HTBnVEodQ6XtOdezFGiVUBk7JyOl6fu1wsCFliwFvrqxaircFBY6PZ5aQ5ZrEbBiP4Jj
         sz4w==
X-Gm-Message-State: AJcUukcMHMHXXwRLTzJXr00IZAM81ANDHZPA8Kl6D6Ls830SvYEaTpB3
        6rfB8v7ygj0gEAwW4JaZyasuhw==
X-Google-Smtp-Source: ALg8bN6RgcUWbEbh9a4SFZ1h5WfPIFdO+ItUs6i5KQ7sEtGfnKecj7bcJ8NiyVmjvY76FaE34QqQDQ==
X-Received: by 2002:adf:d112:: with SMTP id a18mr66534wri.17.1547494933858;
        Mon, 14 Jan 2019 11:42:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm66779996wrs.47.2019.01.14.11.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 11:42:13 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Mon, 14 Jan 2019 19:41:08 +0000
Message-Id: <20190114194112.32567-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
References: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
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
 .../devicetree/bindings/misc/qcom,fastrpc.txt | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
new file mode 100644
index 000000000000..004e636b4133
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -0,0 +1,84 @@
+Qualcomm Technologies, Inc. FastRPC Driver
+
+The FastRPC driver implements an IPC (Inter-Processor Communication)
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
+Each subnode of the Fastrpc node represents compute context banks available
+on the dsp. The name of the nodes are not important. The properties of these
+nodes are defined by the individual bindings for the specific service
+- All Compute context banks MUST contain the following property:
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
+- secured:
+	Usage: Optional
+	Value type: <boolean>
+	Defination: Indicating context bank is secured
+
+- nsessions:
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
+			lable = "adsp";
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

