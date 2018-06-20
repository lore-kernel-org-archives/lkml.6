Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9A720652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mg3N/U29";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cZvbJevC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9A720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933148AbeFTI5i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:57:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932748AbeFTIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1BBA360B23; Wed, 20 Jun 2018 07:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479686;
        bh=YtQ0W2EsxcF0VoS5Cw3s5QEdqrgfZpLdj9N0gU3onic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mg3N/U29qYqRZ3LujoFLuTgsQkULsGpWjouOJiCqnlQXFc0U3UjtlYAWKEjinOZI0
         bywYkxt9eDIEQANgPJivLHxPOHsuQ1tkaYb0oHmnPzAOs1jHBt93UcX2woom7X/NPP
         Gc3uKq2lJmKY6qsK4eU7eDqb0bwaLyeM2L+wqDTU=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CFD360B11;
        Wed, 20 Jun 2018 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479685;
        bh=YtQ0W2EsxcF0VoS5Cw3s5QEdqrgfZpLdj9N0gU3onic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZvbJevC1f6iwq62yafUg0ODMTiVQlf+2jeWIlr/WZQYFEavwsGKcMBnwKyll11nP
         cQhg6uTzNG2+LW2zuS1t2tTXijDV2ORMiBQOreplN6MwxVVMDY4X7dDWQrWKS/fmp1
         /JNOOHB1SF+cVu+6UOWIDBv/lFt+if3VRvz/2Ad0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CFD360B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 03/15] dt-bindings: qcom_nandc: update for ECC strength and step size
Date:   Wed, 20 Jun 2018 12:57:30 +0530
Message-Id: <1529479662-4026-4-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. If nand-ecc-strength specified in DT, then controller will use
   this ECC strength otherwise ECC strength will be calculated
   according to chip requirement and available OOB size.

2. QCOM NAND controller supports only one step size (512 bytes) but
   nand-ecc-step-size is required property in DT. This DT property
   can be removed and ecc step size can be assigned in driver with
   512 bytes value.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---

* Changes from v3:

1. Clubbed following 2 patches into one
   https://patchwork.ozlabs.org/patch/920465/
   https://patchwork.ozlabs.org/patch/920467/

* Changes from v2:
  NONE

* Changes from v1:
  NEW PATCH

 Documentation/devicetree/bindings/mtd/qcom_nandc.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
index 73d336be..1123cc6 100644
--- a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
+++ b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
@@ -45,11 +45,12 @@ Required properties:
 			number (e.g., 0, 1, 2, etc.)
 - #address-cells:	see partition.txt
 - #size-cells:		see partition.txt
-- nand-ecc-strength:	see nand.txt
-- nand-ecc-step-size:	must be 512. see nand.txt for more details.
 
 Optional properties:
 - nand-bus-width:	see nand.txt
+- nand-ecc-strength:	see nand.txt. If not specified, then ECC strength will
+			be used according to chip requirement and available
+			OOB size.
 
 Each nandcs device node may optionally contain a 'partitions' sub-node, which
 further contains sub-nodes describing the flash partition mapping. See
@@ -77,7 +78,6 @@ nand-controller@1ac00000 {
 		reg = <0>;
 
 		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
 		nand-bus-width = <8>;
 
 		partitions {
@@ -117,7 +117,6 @@ nand-controller@79b0000 {
 	nand@0 {
 		reg = <0>;
 		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
 		nand-bus-width = <8>;
 
 		partitions {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

