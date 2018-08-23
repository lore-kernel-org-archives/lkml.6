Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09F520A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FMzNa9Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09F520A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbeHWQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:47:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54614 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHWQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:47:40 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/4] dt-bindings: clock: ingenic: Explicitly list compatible strings
Date:   Thu, 23 Aug 2018 15:17:42 +0200
Message-Id: <20180823131744.744-2-paul@crapouillou.net>
In-Reply-To: <20180823131744.744-1-paul@crapouillou.net>
References: <20180823131744.744-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535030278; bh=RlnaZvZLuNJsgspRV2/krhESAn4qTCR3qRHVcOy25Ko=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FMzNa9Y/4lQw3o8MOl3WG4bP4VmI34Vd1D54GQ5jzKPPZ/FJY8NedlATpU+eAOUtzsFen0TGFFWev4Oy5cOlL6xkuMlJnZZJ1klcJIslRVi9eZx+2xZh55AycNeqWDTWdkaMRjCN+utR2oMzWm9OXaCK4KyJ/ov5ThhAwH8E3Xs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is better than letting the other developers wondering what are the
supported strings.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    New patch

 Documentation/devicetree/bindings/clock/ingenic,cgu.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.txt b/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
index f8d4134ae409..ba5a442026b7 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.txt
@@ -6,8 +6,11 @@ to provide many different clock signals derived from only 2 external source
 clocks.
 
 Required properties:
-- compatible : Should be "ingenic,<soctype>-cgu".
-  For example "ingenic,jz4740-cgu" or "ingenic,jz4780-cgu".
+- compatible : Should be one of:
+  * ingenic,jz4740-cgu
+  * ingenic,jz4725b-cgu
+  * ingenic,jz4770-cgu
+  * ingenic,jz4780-cgu
 - reg : The address & length of the CGU registers.
 - clocks : List of phandle & clock specifiers for clocks external to the CGU.
   Two such external clocks should be specified - first the external crystal
-- 
2.11.0

