Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02441C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B977B21907
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMMKRR86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfAFIKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37463 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfAFIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so20317615pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 00:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rh2Ck7LIQpEkBwHFh55ynypbWnh0z21Uufq2+c/DSpk=;
        b=cMMKRR86xvlO/bimhaW4sFTbsUyo1Dvu5bGm1I1yAXrqhKPXT5lb5yW69OagxYWoay
         usXvR9vn8Yxn2UPZB1s42euFIrprWvAGySzeA2bS+/nh7vqCkRgqlqVjUf4c6VVp+Fir
         r5Qf4Ey2wQMgUvigBhC7vbFSS3k2UovfIVdrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rh2Ck7LIQpEkBwHFh55ynypbWnh0z21Uufq2+c/DSpk=;
        b=V9K4fyBer9lIufIaUxhRW77DlW/7F/xJlh/5Tp6ScnoVbxzemRuzNCDe5AyESkp+T1
         UgWrdSlvoo9hwB52Q51xqku1OUczREA11jieCNZnoEfm/gcE6/R+7ga2/8ImQOqKk9HL
         Po91jDDo3TpLrS5PxPnpbWgJIVXwPUlXk2Mq8EUuOV9P0eiriPi9kCR9R5E25gLkd6WF
         lUGFcR28bL1YzaSkmlqhE2M/PkvympQayfUC/M6B/IDI2+sQVkzlvYhNeX2edtACgJgd
         zs4n4Ubv/YyDpjFH/mn5UdDWzGT8AemOMLTGi2yk1jmCNZE2e2HNqxSbrNBENLsfKN+M
         ZaDw==
X-Gm-Message-State: AA+aEWaHn5e9PhzLvjEo4RRzzscA+Ye9UcYMOEpxoUG6PKGoqcRH9ATO
        +PD3d47/ynKyhM+HIc/ponH0gQ==
X-Google-Smtp-Source: AFSGD/WaJ3iaYBf5UBfalizUVd3c0TIRpPsNS9qE3Gkgj0H++ctugVln6aIlILLWkRtVlhVhMoOsKg==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr61431520pfh.228.1546762218054;
        Sun, 06 Jan 2019 00:10:18 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm90763364pfv.26.2019.01.06.00.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 00:10:17 -0800 (PST)
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
Subject: [PATCH v2 1/7] dt-bindings: soc: qcom: Add AOSS QMP binding
Date:   Sun,  6 Jan 2019 00:09:09 -0800
Message-Id: <20190106080915.4493-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190106080915.4493-1-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the QMP based side-channel communication mechanism to
the AOSS, which is used to control resources not exposed through the
RPMh interface.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Don't describe power-domain as a separate child node

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 57 +++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     | 15 +++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
new file mode 100644
index 000000000000..9b0d9785efe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -0,0 +1,57 @@
+Qualcomm Always-On Subsystem side channel binding
+
+This binding describes the hardware component responsible for side channel
+requests to the always-on subsystem (AOSS), used for certain power management
+requests that is not handled by the standard RPMh interface. Each client in the
+SoC has it's own block of message RAM and IRQ for communication with the AOSS.
+The protocol used to communicate in the message RAM is known as QMP.
+
+The AOSS side channel exposes control over a set of resources, used to control
+a set of debug related clocks and to affect the low power state of resources
+related to the secondary subsystems. These resources are exposed as a set of
+power-domains.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm845-aoss-qmp"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the base address and size of the message RAM for this
+		    client's communication with the AOSS
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the AOSS message IRQ for this client
+
+- mboxes:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the mailbox representing the outgoing doorbell
+		    in APCS for this client, as described in mailbox/mailbox.txt
+
+- #power-domain-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 1
+		    The provided power-domains are:
+		    QDSS clock-domain (0), CDSP state (1), LPASS state (2),
+		    modem state (3), SLPI state (4), SPSS state (5) and Venus
+		    state (6).
+
+= EXAMPLE
+
+The following example represents the AOSS side-channel message RAM and the
+mechanism exposing the power-domains, as found in SDM845.
+
+  aoss_qmp: qmp@c300000 {
+          compatible = "qcom,sdm845-aoss-qmp";
+          reg = <0x0c300000 0x100000>;
+          interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+          mboxes = <&apss_shared 0>;
+
+	  #power-domain-cells = <1>;
+  };
diff --git a/include/dt-bindings/power/qcom-aoss-qmp.h b/include/dt-bindings/power/qcom-aoss-qmp.h
new file mode 100644
index 000000000000..7d8ac1a4f90c
--- /dev/null
+++ b/include/dt-bindings/power/qcom-aoss-qmp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Linaro Ltd. */
+
+#ifndef __DT_BINDINGS_POWER_QCOM_AOSS_QMP_H
+#define __DT_BINDINGS_POWER_QCOM_AOSS_QMP_H
+
+#define AOSS_QMP_QDSS_CLK	0
+#define AOSS_QMP_LS_CDSP		1
+#define AOSS_QMP_LS_LPASS	2
+#define AOSS_QMP_LS_MODEM	3
+#define AOSS_QMP_LS_SLPI		4
+#define AOSS_QMP_LS_SPSS		5
+#define AOSS_QMP_LS_VENUS	6
+
+#endif
-- 
2.18.0

