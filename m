Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966916AbeEYMWV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:22:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966601AbeEYMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:22:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B462860618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 04/16] dt-bindings: qcom_nandc: remove nand-ecc-step-size
Date: Fri, 25 May 2018 17:51:32 +0530
Message-Id: <1527250904-21988-5-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM NAND controller supports only one step size (512) but
nand-ecc-step-size is required property in DT. This DT property
can be removed and ecc step size can be assigned in driver with
512 value.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---

Currently there is no user in mainline linux kernel for
QPIC. Following patches for this node is in review

https://patchwork.kernel.org/patch/10426405/
https://patchwork.kernel.org/patch/10426385/

If these changes got merged then I will submit another change
to remove the nand-ecc-step-size from actual DTS.

* Changes from v2:

 NEW CHANGE

 Documentation/devicetree/bindings/mtd/qcom_nandc.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
index f246aa0..1123cc6 100644
--- a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
+++ b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
@@ -45,7 +45,6 @@ Required properties:
 			number (e.g., 0, 1, 2, etc.)
 - #address-cells:	see partition.txt
 - #size-cells:		see partition.txt
-- nand-ecc-step-size:	must be 512. see nand.txt for more details.
 
 Optional properties:
 - nand-bus-width:	see nand.txt
@@ -79,7 +78,6 @@ nand-controller@1ac00000 {
 		reg = <0>;
 
 		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
 		nand-bus-width = <8>;
 
 		partitions {
@@ -119,7 +117,6 @@ nand-controller@79b0000 {
 	nand@0 {
 		reg = <0>;
 		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
 		nand-bus-width = <8>;
 
 		partitions {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
