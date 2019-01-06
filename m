Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC9C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB045217F4
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejOuZlKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfAFIKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46266 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfAFIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so19378624ply.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 00:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hsxzuIWHrUK2k0II5ccVYx3OoYr1DLVIOe8aiHXCb3w=;
        b=ejOuZlKWrkEn5N9R5qdhP0m5aI6EuFK6smZPfsOuZBpojX4gPq1bkBiICRzAw8wKdg
         +26VQF7m9/5HPSdKihwTzsBef3kjC48/DbkiOMNThABaT8nuZFROI3Uw20lEe5z6bekv
         MiXLEky3T8iQkKxHVoVpD6wT/vB4qDZKGdzWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hsxzuIWHrUK2k0II5ccVYx3OoYr1DLVIOe8aiHXCb3w=;
        b=ZTyy8TUWG2H3xNKbRASuzNtu/ibOiymzPS4VuU20OygxhdGDx4AXfrmgkSoKBq8zUG
         avQHDeMTyuyqo3fDs8GINHJhhivweOtY5MPdlA3VJbIlwbB/6kbGkctID+BpeuUyGPMH
         kSQLlbsBxuHa2NYi/QTtCIBWen+KFY8CdHa+oOlyPQ34m2DA7suVi9b9kssQ6FwpQphV
         feJKbPrDB8kkZ53tM1okHLdHmxbS3STFrKAxW6mA8QKyd/AVO1EPk1Iamz4X2yVn+A1d
         04R21tuQNG+jsGPIZ6Fmw4H5xs5C5cdPqLXm51ZN18KVQx28wSAqfA9GK/bkLsX+nMTZ
         b6ZA==
X-Gm-Message-State: AJcUukfC88EbG9YOBVRQWA5G/mzNcBbgkqUSzDumXLIVn37eaPGE5hlb
        a7BJ7RF3lxO5wQ7mhYYzWXy+kQ==
X-Google-Smtp-Source: ALg8bN6FpZNormokjsz7ivB1cLTeR3w5EPla6/tFRKs/dLcWpWxolJVuv/u63xCqoAFfluk4Z+K/hg==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr55926240plg.222.1546762225117;
        Sun, 06 Jan 2019 00:10:25 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm90763364pfv.26.2019.01.06.00.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 00:10:24 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [(RFC) PATCH v2 7/7] soc: qcom: aoss-qmp: Add cooling device support
Date:   Sun,  6 Jan 2019 00:09:15 -0800
Message-Id: <20190106080915.4493-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190106080915.4493-1-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS provides three cooling devices "cx", "mx" and "ebi" that must
be enabled when temperature goes below a certain level to counter low
temperature issues. Probe these devices, when described in DeviceTree.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

We do not yet have the necessary support in the thermal framework to implement
the cooling device associated with the QMP, so I've just included this patch as
an RFC in this series.

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 18 ++++++++++
 drivers/soc/qcom/aoss-qmp.c                   | 36 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
index 9b0d9785efe0..aae300f32421 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -42,6 +42,16 @@ power-domains.
 		    modem state (3), SLPI state (4), SPSS state (5) and Venus
 		    state (6).
 
+= SUBNODES
+The AOSS side channel also provides the controls for three cooling devices,
+these are expressed as subnodes of the QMP node. The name of the node is used
+to identify the resource and must therefor be "cx", "mx" or "ebi".
+
+- #cooling-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 2
+
 = EXAMPLE
 
 The following example represents the AOSS side-channel message RAM and the
@@ -54,4 +64,12 @@ mechanism exposing the power-domains, as found in SDM845.
           mboxes = <&apss_shared 0>;
 
 	  #power-domain-cells = <1>;
+
+	  cx_cdev: cx {
+		#cooling-cells = <2>;
+	  };
+
+	  mx_cdev: mx {
+		#cooling-cells = <2>;
+	  };
   };
diff --git a/drivers/soc/qcom/aoss-qmp.c b/drivers/soc/qcom/aoss-qmp.c
index de52703b96b6..6e9299e3b2bd 100644
--- a/drivers/soc/qcom/aoss-qmp.c
+++ b/drivers/soc/qcom/aoss-qmp.c
@@ -33,6 +33,8 @@
 #define QMP_MAGIC	0x4d41494c
 #define QMP_VERSION	1
 
+#define QMP_MAX_COOLING_DEVICES		3
+
 /**
  * struct qmp - driver state for QMP implementation
  * @msgram: iomem referencing the message RAM used for communication
@@ -44,6 +46,8 @@
  * @event: wait_queue for synchronization with the IRQ
  * @tx_lock: provides syncrhonization between multiple callers of qmp_send()
  * @pd_pdev: platform device for the power-domain child device
+ * @cdev_pdevs: platform device for the cooling devices
+ * @cdev_count: number of valid @cdev_pdevs
  */
 struct qmp {
 	void __iomem *msgram;
@@ -60,6 +64,9 @@ struct qmp {
 	struct mutex tx_lock;
 
 	struct platform_device *pd_pdev;
+
+	struct platform_device *cdev_pdevs[QMP_MAX_COOLING_DEVICES];
+	size_t cdev_count;
 };
 
 static void qmp_kick(struct qmp *qmp)
@@ -230,6 +237,8 @@ EXPORT_SYMBOL(qmp_send);
 
 static int qmp_probe(struct platform_device *pdev)
 {
+	struct platform_device *cdev;
+	struct device_node *cdev_node;
 	struct resource *res;
 	struct qmp *qmp;
 	int irq;
@@ -279,13 +288,40 @@ static int qmp_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to register AOSS PD\n");
 	}
 
+	for_each_available_child_of_node(pdev->dev.of_node, cdev_node) {
+		if (!of_property_read_bool(cdev_node, "#cooling-cells"))
+			continue;
+
+		/* Register cooling device, with its device_node as platform_data */
+		cdev = platform_device_register_data(&pdev->dev,
+						     "aoss_qmp_cdev",
+						     PLATFORM_DEVID_AUTO,
+						     of_node_get(cdev_node),
+						     sizeof(cdev_node));
+		if (IS_ERR(cdev)) {
+			dev_err(&pdev->dev,
+				"failed to register cooling device: %pOFn\n",
+				cdev_node);
+			continue;
+		}
+
+		qmp->cdev_pdevs[qmp->cdev_count++] = cdev;
+	}
+
 	return 0;
 }
 
 static int qmp_remove(struct platform_device *pdev)
 {
 	struct qmp *qmp = platform_get_drvdata(pdev);
+	struct device_node *np;
+	int i;
 
+	for (i = 0; i < qmp->cdev_count; i++) {
+		np = dev_get_platdata(&qmp->cdev_pdevs[i]->dev);
+		platform_device_unregister(qmp->cdev_pdevs[i]);
+		of_node_put(np);
+	}
 	platform_device_unregister(qmp->pd_pdev);
 
 	qmp_close(qmp);
-- 
2.18.0

