Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988DE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988DE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeKILUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:20:40 -0500
Received: from mx.socionext.com ([202.248.49.38]:41458 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbeKILUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:20:40 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Nov 2018 10:42:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8BC35180D4F;
        Fri,  9 Nov 2018 10:42:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Nov 2018 10:42:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id DED7C1A1236;
        Fri,  9 Nov 2018 10:42:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset description
Date:   Fri,  9 Nov 2018 10:42:06 +0900
Message-Id: <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for reset control of AHCI core implemented in
UniPhier SoCs. The reset control belongs to AHCI glue layer.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index f63c511..ea00517 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -133,6 +133,9 @@ Required properties:
     "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
     "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
     "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
+    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
+    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
+    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
 - #reset-cells: Should be 1.
 - reg: Specifies offset and length of the register set for the device.
 - clocks: A list of phandles to the clock gate for the glue layer.
-- 
2.7.4

