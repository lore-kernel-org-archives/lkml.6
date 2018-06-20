Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC895C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B7A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B7A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeFTMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:21:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12647 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754069AbeFTMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2a469d0000>; Wed, 20 Jun 2018 05:20:45 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 05:21:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Jun 2018 05:21:11 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 20 Jun 2018 12:21:07 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b2a46b00003>; Wed, 20 Jun 2018 05:21:07 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date:   Wed, 20 Jun 2018 15:20:35 +0300
Message-ID: <20180620122042.10950-2-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSP interrupts can be routed through exposed "shared interrupts". These
interrupts can be mapped to various internal interrupt lines. Add
interrupt properties for shared interrupts to the tegra186-hsp device
tree bindings. At the same time, add the compatibility string for
tegra194-hsp, which is backwards compatible with tegra186.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---

Notes:
    v2:
    - Edited commit message to not say that doorbell interrupts cannot be
      routed to shared interrupts.
    - Added tegra194 compatibility string.

 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..620c249363ca 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -15,12 +15,15 @@ Required properties:
     Array of strings.
     one of:
     - "nvidia,tegra186-hsp"
+    - "nvidia,tegra194-hsp", "nvidia,tegra186-hsp"
 - reg : Offset and length of the register set for the device.
 - interrupt-names
     Array of strings.
     Contains a list of names for the interrupts described by the interrupt
     property. May contain the following entries, in any order:
     - "doorbell"
+    - "sharedN", where 'N' is a number from zero up to the number of
+      external interrupts supported by the HSP instance minus one.
     Users of this binding MUST look up entries in the interrupt property
     by name, using this interrupt-names property to do so.
 - interrupts
-- 
2.16.1

