Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA7220659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y6mNrnjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA7220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeIEBtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeIEBtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:49:42 -0400
Received: from localhost.localdomain (unknown [136.62.81.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0796020869;
        Tue,  4 Sep 2018 21:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536096166;
        bh=rPSFHXYRUOlgkKyDVCSn4RXFEm+10nWrwZJ950h0Mus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6mNrnjjqdF17XAf/ftIzywf+Xg6SoHPctkB5PgFLkruagRtbfe41yec3Zdg04AkF
         Qkj0S/+V0nNbsK5nZM6LhSa3XWi1Mfr3l1SeZSmUfTwe+PN1Bu89CoLwYkMuvRs5Vk
         PDT5ZiSN7ZCLSCsLV2PjiZldJ7ube3SJHD/2EqVQ=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 5/8] dt-bindings: fpga: fix freeze controller compatible in region doc
Date:   Tue,  4 Sep 2018 16:22:34 -0500
Message-Id: <20180904212237.3078-6-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180904212237.3078-1-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org>
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
v2: no change in v2 of patchset
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

