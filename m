Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeBWVBQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:01:16 -0500
Received: from muru.com ([72.249.23.125]:58020 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbeBWVBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:01:11 -0500
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] bus: ti-sysc: Remove unnecessary debugging statements
Date: Fri, 23 Feb 2018 13:00:53 -0800
Message-Id: <20180223210100.86732-6-tony@atomide.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already show the status for the interconnect target module
when debugging is enabled, there's no need to be more verbose
about that. So let's just cut down the noise and remove the
extra debug statements.

Signed-off-by: Tony Lindgren <tony@atomide.coM>
---
 drivers/bus/ti-sysc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -201,9 +201,6 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	ddata->module_pa = of_translate_address(np, ranges++);
 	ddata->module_size = be32_to_cpup(ranges);
 
-	dev_dbg(ddata->dev, "interconnect target 0x%llx size 0x%x for %pOF\n",
-		ddata->module_pa, ddata->module_size, np);
-
 	return 0;
 }
 
@@ -296,11 +293,8 @@ static int sysc_check_children(struct sysc *ddata)
  */
 static void sysc_check_quirk_16bit(struct sysc *ddata, struct resource *res)
 {
-	if (resource_size(res) == 8) {
-		dev_dbg(ddata->dev,
-			"enabling 16-bit and clockactivity quirks\n");
+	if (resource_size(res) == 8)
 		ddata->cfg.quirks |= SYSC_QUIRK_16BIT | SYSC_QUIRK_USE_CLOCKACT;
-	}
 }
 
 /**
@@ -326,7 +320,6 @@ static int sysc_parse_one(struct sysc *ddata, enum sysc_registers reg)
 	res = platform_get_resource_byname(to_platform_device(ddata->dev),
 					   IORESOURCE_MEM, name);
 	if (!res) {
-		dev_dbg(ddata->dev, "has no %s register\n", name);
 		ddata->offsets[reg] = -ENODEV;
 
 		return 0;
-- 
2.16.2
