Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C3C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F5320839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fNBGhOL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F5320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeILJMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:12:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59438 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeILJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:12:40 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8C49kRM072583;
        Tue, 11 Sep 2018 23:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536725386;
        bh=jFevDdF1nZ5Rzh5sKTMcs3+L65qk9w3tYNIBWwVsgPo=;
        h=From:To:CC:Subject:Date;
        b=fNBGhOL7wE11BVEs7sEBWkt1wk/iGTvmwdqrlRxSN0WZDaVzEIfpKJ+STlFRaPcVf
         oRK6fMlAK7GhtiiKXNwRqscdtEZH0yfXAtt8UZA4SUaX/XRXN72HxQgVvyTiK8Mjbb
         vd3RumFyQMRE5AMuFEXMjw2oQ5xqBknlwcGeqSC0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8C49kBM002231;
        Tue, 11 Sep 2018 23:09:46 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 23:09:45 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 23:09:45 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8C49hf8007037;
        Tue, 11 Sep 2018 23:09:43 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <mark.rutland@arm.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <j-keerthy@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH] dt-bindings: power: Introduce suspend states supported properties
Date:   Wed, 12 Sep 2018 09:39:32 +0530
Message-ID: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introuduce linux generic suspend states supported properties.
It is convenient for the generic suspend path to have
the knowledge of the suspend states supported based on the
device tree properties based on which it can either be suspended
or safely bailed out of suspend if none of the suspend states
are supported.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../devicetree/bindings/power/power-states.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/power-states.txt

diff --git a/Documentation/devicetree/bindings/power/power-states.txt b/Documentation/devicetree/bindings/power/power-states.txt
new file mode 100644
index 0000000..bb80b36
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/power-states.txt
@@ -0,0 +1,22 @@
+* Generic system suspend states support
+
+Most platforms support multiple suspend states. Define system
+suspend states so that one can target appropriate low power
+states based on the SoC capabilities.
+
+linux,suspend-to-memory-supported
+
+Upon suspend to memory the system context is saved to primary memory.
+All the clocks for all the peripherals including CPU are gated.
+
+linux,suspend-power-off-supported
+
+In this case in additon to the clocks all the voltage resources are
+turned off except the ones needed to keep the primary memory
+and a wake up source that can trigger a wakeup event.
+
+linux,suspend-to-disk-supported
+
+Upon suspend to disk that system context is saved to secondary memory.
+All the clocks for all the peripherals including CPU are gated. Even
+the primary memory is turned off.
-- 
1.9.1

