Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41074C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W+BVKe0L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kkqKlr+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfANQg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:36:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:36:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 080AB6086B; Mon, 14 Jan 2019 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483784;
        bh=+2bcDl0Zo8wZ9KYE2I79+vgoN7vzuMRAQs/hwSAvQpA=;
        h=From:To:Cc:Subject:Date:From;
        b=W+BVKe0LjzGQzQk5NnFoW6nXSo+MrkRCouQIlGLSbcpO5LRmkkPtKaJF5xXBveka6
         oxybA15nAmAc9q/RqQz56DelVuxTQiaYlPaoPvlAZ7nzI9RYY02jJZh4utJ/nm+13Y
         P+buYZ+z2XXLtf1C0p4gscziF9hSCTZmsHDIoHf4=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6ACE6086B;
        Mon, 14 Jan 2019 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483782;
        bh=+2bcDl0Zo8wZ9KYE2I79+vgoN7vzuMRAQs/hwSAvQpA=;
        h=From:To:Cc:Subject:Date:From;
        b=kkqKlr+rD2aFnbD49Ttl2sXvZKus1MrVVMdkmltGUI0JEXG5ZJ38/arlrfArXX5a3
         SbgLe4771IQo92C7CEwakQXVZqe6xaOkS883blZiUnw+Ez4PCK9RhS5CYHUtYOV1al
         9q0txeg6FJFLelPQJaIGrBuR4ksQ8XiuMvP+22Q8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6ACE6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 1/6] dt-bindings: phy-qcom: Add support for msm8998 usb
Date:   Mon, 14 Jan 2019 09:36:11 -0700
Message-Id: <1547483771-5334-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB on msm8998 utilizes the QUSB2 and QMP phys, similar to sdm845.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   | 5 +++++
 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 41a1074..6061b6f 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -9,6 +9,7 @@ Required properties:
 	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
 	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
+	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
 	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
@@ -42,6 +43,8 @@ Required properties:
 			"aux", "cfg_ahb", "ref".
 		For "qcom,msm8996-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref".
+		For "qcom,msm8998-qmp-usb3-phy" must contain:
+			"aux", "cfg_ahb", "ref".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
@@ -60,6 +63,8 @@ Required properties:
 		For "qcom,msm8996-qmp-pcie-phy" must contain:
 			"phy", "common", "cfg".
 		For "qcom,msm8996-qmp-usb3-phy" must contain
+		 "phy", "common".
+		For "qcom,msm8998-qmp-usb3-phy" must contain
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"phy", "common".
diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
index 03025d9..fe29f9e 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
@@ -6,6 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
 Required properties:
  - compatible: compatible list, contains
 	       "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
+	       "qcom,msm8998-qusb2-phy" for 10nm PHY on msm8998,
 	       "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
 
  - reg: offset and length of the PHY register set.
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

