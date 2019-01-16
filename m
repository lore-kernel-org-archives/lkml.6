Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A38720859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404080AbfAPJ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:58:15 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49657 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404057AbfAPJ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:58:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="25551589"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 02:58:09 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 16 Jan 2019 02:58:08 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 7/8] USB: host: ohci-at91: add sam9x60-sfr definition for ohci
Date:   Wed, 16 Jan 2019 10:57:43 +0100
Message-ID: <e7ea12330d4ba8f612110a185a2aa77d91522694.1547629763.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this SFR compatible definition for the sam9x60 SoC and manage
its use in ohci-at91.c driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/usb/host/ohci-at91.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index ec6739ef3129..fc35a7993b7b 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -141,8 +141,11 @@ static struct regmap *at91_dt_syscon_sfr(void)
 	struct regmap *regmap;
 
 	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
-	if (IS_ERR(regmap))
-		regmap = NULL;
+	if (IS_ERR(regmap)) {
+		regmap = syscon_regmap_lookup_by_compatible("microchip,sam9x60-sfr");
+		if (IS_ERR(regmap))
+			regmap = NULL;
+	}
 
 	return regmap;
 }
-- 
2.17.1

