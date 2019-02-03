Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C527C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090C62084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfBCO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:28:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55478 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730034AbfBCOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:37 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdP-0006Kl-RI; Sun, 03 Feb 2019 14:20:35 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-0006zm-5I; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Eduardo Valentin" <edubezval@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.115131534@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 115/305] thermal: rcar: Make error and remove paths
 symmetrical with init
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ac71c7025ebc1ed25114b1be77dc60b7f8cb8544 upstream.

Swap interrupt disable and thermal zone unregistration in the error and
remove paths, to make them more symmetrical with the initialization
path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -462,9 +462,9 @@ static int rcar_thermal_probe(struct pla
 
 error_unregister:
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
@@ -480,9 +480,9 @@ static int rcar_thermal_remove(struct pl
 	struct rcar_thermal_priv *priv;
 
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);

