Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2855C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734492085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734492085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbeKGCMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:12:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:51207 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388935AbeKGCMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:12:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 08:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="83756006"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2018 08:46:43 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@intel.com
Subject: [PATCHv10 4/8] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Date:   Tue,  6 Nov 2018 10:52:48 -0600
Message-Id: <1541523172-5171-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Tull <atull@kernel.org>

Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: this patch is added in patch set version 2
v3: change to put fpga_mgr node under firmware/svc node
v4: s/fpga-mgr@0/fpga-mgr/ to remove unit_address
    add Richard's signed-off-by
v5: add Reviewed-by Rob Herring
v6: no change
v7: no change
v8: no change
v9: no change
v10: no change
---
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
new file mode 100644
index 0000000..6e03f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -0,0 +1,17 @@
+Intel Stratix10 SoC FPGA Manager
+
+Required properties:
+The fpga_mgr node has the following mandatory property, must be located under
+firmware/svc node.
+
+- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+
+Example:
+
+	firmware {
+		svc {
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,stratix10-soc-fpga-mgr";
+			};
+		};
+	};
-- 
2.7.4

