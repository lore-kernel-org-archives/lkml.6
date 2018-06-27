Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C117C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4693B2607D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vXWK2sEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4693B2607D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965351AbeF0O7S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:59:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43516 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeF0O7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:59:15 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RCSnDs056223;
        Wed, 27 Jun 2018 07:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530102529;
        bh=r4QmPBPfwvBfvwSOY7PvLeKWRHtXCotnnhf+u63NpB8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vXWK2sEs5Qtp3U8XBnOVYD6sJNythNn6TFUqkMlABl0Ze/cvN9nnamjKhZ7u3tl0x
         Onvv7WOXRAYsDfbJLXY4vjZywsHJNhj2wPXDISe8cFUQSD+uEx05oJUM9hrA3OnwyA
         Qt3R2N3PLU6sBHTJPzW0LMTtnsWtsIvsuY4XHYgw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RCSnlr000698;
        Wed, 27 Jun 2018 07:28:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 07:28:49 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 07:28:49 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RCSgMs027559;
        Wed, 27 Jun 2018 07:28:46 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 1/4] dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host mode
Date:   Wed, 27 Jun 2018 17:59:16 +0530
Message-ID: <20180627122919.23926-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627122919.23926-1-vigneshr@ti.com>
References: <20180627122919.23926-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device tree binding documentation of TI's dra7xx PCI controller
for enabling unaligned mem access as applicable not just in EP mode but
in host mode as well.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 7f7af3044016..452fe48c4fdd 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -26,6 +26,11 @@ HOST MODE
    ranges,
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
+ - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
+			       should contain the register offset within syscon
+			       and the 2nd argument should contain the bit field
+			       for setting the bit to enable unaligned
+			       access.
 
 DEVICE MODE
 ===========
-- 
2.18.0

