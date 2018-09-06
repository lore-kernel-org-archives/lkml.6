Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491AC2086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+IbhZJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491AC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeIFWie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeIFWie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:38:34 -0400
Received: from localhost.localdomain (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F472075B;
        Thu,  6 Sep 2018 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536256917;
        bh=dBCuIXE4xs1mW3JZhGhjdSMHk/0FeWMRlB7hXsyshyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=e+IbhZJUjVcBl5xQLlng2AELDtxwnkj72zojSuw3Zvm1FU2tIP5a1VWqLiAxIRJW4
         dIguD4nGVNVvrL00qTNBEypIp8nHLeAcT5tIMPDscUw5FgiOPfkQPi5/BrU/G3IaXf
         JiMug5/k6pMWI+bBMM0RdKEHVwZxBvrzOmRYun84=
From:   Alan Tull <atull@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Moritz Fischer <mdf@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: [PATCH] dt-bindings: fpga: fix freeze controller compatible in region doc
Date:   Thu,  6 Sep 2018 13:01:52 -0500
Message-Id: <20180906180152.3620-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
regarding the freeze controller bridge, secifically:

 compatible = "altr,freeze-bridge";

The compatibility string should be "altr,freeze-bridge-controller"
as set forth in altera-freeze-bridge.txt.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 6db8aed..90c4469 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -415,7 +415,7 @@ DT Overlay contains:
 			firmware-name = "base.rbf";
 
 			fpga-bridge@4400 {
-				compatible = "altr,freeze-bridge";
+				compatible = "altr,freeze-bridge-controller";
 				reg = <0x4400 0x10>;
 
 				fpga_region1: fpga-region1 {
@@ -427,7 +427,7 @@ DT Overlay contains:
 			};
 
 			fpga-bridge@4420 {
-				compatible = "altr,freeze-bridge";
+				compatible = "altr,freeze-bridge-controller";
 				reg = <0x4420 0x10>;
 
 				fpga_region2: fpga-region2 {
-- 
2.7.4

