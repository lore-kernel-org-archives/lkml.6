Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C5922BC4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5922BC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030632AbeGBLls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:41:48 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12724 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030605AbeGBLll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:41:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3a0f720000>; Mon, 02 Jul 2018 04:41:38 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 04:41:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 02 Jul 2018 04:41:40 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 11:41:40 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 11:41:39 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Mon, 2 Jul 2018 11:41:39 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b3a0f710000>; Mon, 02 Jul 2018 04:41:39 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date:   Mon, 2 Jul 2018 14:40:26 +0300
Message-ID: <20180702114033.15654-2-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
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
tree bindings.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2:
    - Edited commit message to not say that doorbell interrupts cannot be
      routed to shared interrupts.
    - Added tegra194 compatibility string.
    
    v3:
    - Added Jon's A-b and Rob's R-b

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

