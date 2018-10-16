Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDCFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08020881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cBQvIdpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F08020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJPNwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:52:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:52:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9G63HFH045372;
        Tue, 16 Oct 2018 01:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539669797;
        bh=H8KzI9Vac6elHy27XoGbgGpU3pE391Bg1aw6iDfkwrE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cBQvIdpSxt8aEURlSb76CYVomTzXXcNnbCjY02r59wHKgDHFtTn7G02IZptlwfI60
         CdbjSFj3RvQAamtFgAuvJ4dC/sNcY1OTDRU4TObZhKccMjryazA1JVBg6kIp0nq70b
         Tb3ek9XZ8f/0CBp7XczTygoBe12SiL3JVbztxKuQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9G63HUD017208;
        Tue, 16 Oct 2018 01:03:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 16
 Oct 2018 01:03:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 16 Oct 2018 01:03:16 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9G63Bok027391;
        Tue, 16 Oct 2018 01:03:14 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
Date:   Tue, 16 Oct 2018 11:34:01 +0530
Message-ID: <20181016060402.18756-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016060402.18756-1-vigneshr@ti.com>
References: <20181016060402.18756-1-vigneshr@ti.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

v2: Add Reviewed-by

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
2.19.1

