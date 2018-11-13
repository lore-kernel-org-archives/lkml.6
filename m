Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CAEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1F2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YLkeC/tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC1F2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeKMP51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:57:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35610 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbeKMP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:57:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAD60PTI079103;
        Tue, 13 Nov 2018 00:00:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542088825;
        bh=btyIrrrnMU7HQuds2fVhIXB19qa0WUEuo+QcKLP4YeA=;
        h=From:To:CC:Subject:Date;
        b=YLkeC/tmOOtpGxpd6CrsjmBt0zoE3qOVUYvbG+R2Hy0u3PwwRIRvDBW6GA4rWGYnT
         h+S6PCPXdSvkebKrqmjkWQL0wbdWdVJhb+7uSpyCubxYHVFC4qsBcxKJoqhNklYfSS
         7uDiQ+5bcVB+KXwmOhAgymPZ5sTiEql1PRrNGpe8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAD60PEv007889
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 00:00:25 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 13
 Nov 2018 00:00:25 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 13 Nov 2018 00:00:24 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAD60Lu7017811;
        Tue, 13 Nov 2018 00:00:22 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 0/4] AM654: Add pinmux support
Date:   Tue, 13 Nov 2018 11:31:07 +0530
Message-ID: <20181113060111.16374-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux definitions and pinctrl regions for AM654 SoCs
and enable uart and i2c.

v2:
Add only minimum needed macros in dt-bindings include file
New patches to illustrate pinmux using uart and i2c


Tero Kristo (1):
  arm64: dts: ti: k3-am65: Add pinctrl regions

Vignesh R (3):
  dt-bindings: pinctrl: k3: Introduce pinmux definitions
  arm64: dts: ti: am654-base-board: Add pinmux for main uart0
  arm64: dts: ti: k3-am654-base-board: Add I2C nodes

 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 60 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 11 +++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    | 19 ++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |  7 ++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 86 +++++++++++++++++++
 include/dt-bindings/pinctrl/k3.h              | 35 ++++++++
 7 files changed, 219 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/k3.h

-- 
2.19.1

