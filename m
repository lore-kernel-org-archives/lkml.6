Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7186CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E9220877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E9220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJDTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:15:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35763 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeJDTP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:15:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B034C208B5; Thu,  4 Oct 2018 14:22:51 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 38E6120CFE;
        Thu,  4 Oct 2018 14:22:32 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v4 04/11] net: mscc: ocelot: move the HSIO header to include/soc
Date:   Thu,  4 Oct 2018 14:22:01 +0200
Message-Id: <20181004122208.32272-5-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since HSIO address space can be used by different drivers (PLL, SerDes
muxing, temperature sensor), let's move it somewhere it can be included
by all drivers.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.h                       | 2 +-
 {drivers/net/ethernet => include/soc}/mscc/ocelot_hsio.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {drivers/net/ethernet => include/soc}/mscc/ocelot_hsio.h (100%)

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 616bec30dfa3..d3980158c4a3 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -13,10 +13,10 @@
 #include <linux/if_vlan.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <soc/mscc/ocelot_hsio.h>
 
 #include "ocelot_ana.h"
 #include "ocelot_dev.h"
-#include "ocelot_hsio.h"
 #include "ocelot_qsys.h"
 #include "ocelot_rew.h"
 #include "ocelot_sys.h"
diff --git a/drivers/net/ethernet/mscc/ocelot_hsio.h b/include/soc/mscc/ocelot_hsio.h
similarity index 100%
rename from drivers/net/ethernet/mscc/ocelot_hsio.h
rename to include/soc/mscc/ocelot_hsio.h
-- 
2.17.1

