Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeECMZO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:25:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeECMVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:21:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B20E607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 03/14] dt-bindings: qcom_nandc: make nand-ecc-strength optional
Date: Thu,  3 May 2018 17:50:30 +0530
Message-Id: <1525350041-22995-4-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, nand-ecc-strength is optional. If specified in DT, then
controller will use this ECC strength otherwise ECC strength will
be calculated according to chip requirement and available OOB size.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

  NEW PATCH

 Documentation/devicetree/bindings/mtd/qcom_nandc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
index 73d336be..f246aa0 100644
--- a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
+++ b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
@@ -45,11 +45,13 @@ Required properties:
 			number (e.g., 0, 1, 2, etc.)
 - #address-cells:	see partition.txt
 - #size-cells:		see partition.txt
-- nand-ecc-strength:	see nand.txt
 - nand-ecc-step-size:	must be 512. see nand.txt for more details.
 
 Optional properties:
 - nand-bus-width:	see nand.txt
+- nand-ecc-strength:	see nand.txt. If not specified, then ECC strength will
+			be used according to chip requirement and available
+			OOB size.
 
 Each nandcs device node may optionally contain a 'partitions' sub-node, which
 further contains sub-nodes describing the flash partition mapping. See
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
