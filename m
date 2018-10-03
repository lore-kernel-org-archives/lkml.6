Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EBCC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642952148D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YOs2c2ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642952148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJCX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:56:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44286 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJCX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:56:00 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93H6RId121566;
        Wed, 3 Oct 2018 12:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538586387;
        bh=6LsUnc+fsTqX4SM6dAFhhMPHj3LI8jizpIAUaaMHhno=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YOs2c2exXtIc0RYHJhJfcKXx0uYpxBvzZY/HiWPJ81hnjixJDvwVQiWbuhFnORciO
         I8A0AsL6jQHLJDc7GO5CtVUECRKicpZ0lnxXjFa6KBO9DuB164mrsie5SfTR694F9J
         6OdTPNGr3dpVvQj6Qgd1peSm5L07qYPVOPnFScek=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93H6RbC023319;
        Wed, 3 Oct 2018 12:06:27 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 12:06:27 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 12:06:27 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93H6L3F010144;
        Wed, 3 Oct 2018 12:06:25 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
Date:   Wed, 3 Oct 2018 22:36:57 +0530
Message-ID: <20181003170658.3835-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003170658.3835-1-vigneshr@ti.com>
References: <20181003170658.3835-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string "ti,am654-ecap" to support PWM ECAP IP of
TI AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 06a363d9ccef..b9a1d7402128 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -7,6 +7,7 @@ Required properties:
   for da850  - compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
   for dra746 - compatible = "ti,dra746-ecap", "ti,am3352-ecap";
   for 66ak2g - compatible = "ti,k2g-ecap", "ti,am3352-ecap";
+  for am654  - compatible = "ti,am654-ecap", "ti,am3352-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
-- 
2.19.0

