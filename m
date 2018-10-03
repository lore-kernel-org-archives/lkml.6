Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B29C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A02098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qtUBcRFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1A02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJCX4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:56:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58506 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJCX4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:56:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93H6Uw8086551;
        Wed, 3 Oct 2018 12:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538586390;
        bh=McduHk/KM6AL1WzEFuq5qTh/x8QBREeZd+6QMbWqmlw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qtUBcRFZcqJAlu8BN7DZ+RvIlePA4EylnbfCvFcW/khARNRpoYW65+MDq1hRF1eE3
         +dODeD6zRTv3bfDath4h2v79f1uUMAvqZCLLzPDVJIGS9cSTCDq3oaVNrlCtPfvcwA
         ej4jUh1EW55bIWnurT+4+1qOYvW6N3DhzHOENTVs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93H6T02023372;
        Wed, 3 Oct 2018 12:06:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 12:06:29 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 12:06:30 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93H6L3G010144;
        Wed, 3 Oct 2018 12:06:27 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
Date:   Wed, 3 Oct 2018 22:36:58 +0530
Message-ID: <20181003170658.3835-3-vigneshr@ti.com>
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

K3 devices have the same ECAP IP as OMAP SoC. Enable driver to be built
for K3 devices.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d252716f2..0c7bc6f554cf 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -447,7 +447,7 @@ config PWM_TEGRA
 
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
 	help
 	  PWM driver support for the ECAP APWM controller found on AM33XX
 	  TI SOC
-- 
2.19.0

