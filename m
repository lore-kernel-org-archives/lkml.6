Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2556C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C362082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404093AbfAPJ61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:58:27 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46525 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388613AbfAPJ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:58:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="25386573"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 02:58:12 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 16 Jan 2019 02:58:11 -0700
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
Subject: [PATCH 8/8] net: macb: add sam9x60-macb compatibility string
Date:   Wed, 16 Jan 2019 10:57:44 +0100
Message-ID: <dfc7db7606e0898fbedc1f45ed9637379595f9cb.1547629763.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatibility string for this product. It's using
at91sam9260-macb layout but has a newer hardware revision: it's safer
to use its own string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 66cc7927061a..a0889ef107a1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3941,6 +3941,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,np4-macb", .data = &np4_config },
 	{ .compatible = "cdns,pc302-gem", .data = &pc302gem_config },
 	{ .compatible = "cdns,gem", .data = &pc302gem_config },
+	{ .compatible = "cdns,sam9x60-macb", .data = &at91sam9260_config },
 	{ .compatible = "atmel,sama5d2-gem", .data = &sama5d2_config },
 	{ .compatible = "atmel,sama5d3-gem", .data = &sama5d3_config },
 	{ .compatible = "atmel,sama5d3-macb", .data = &sama5d3macb_config },
-- 
2.17.1

