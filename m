Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758386AbeD0NZI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:25:08 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:54646 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758349AbeD0NZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:25:05 -0400
From: <jan.tuerk@emtrion.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "GitAuthor: Jan Tuerk" <jan.tuerk@emtrion.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 3/7] drm/panel: Add support for the EDT ETM0700G0EDH6
Date: Fri, 27 Apr 2018 15:24:38 +0200
Message-ID: <20180427132445.3458-4-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23808.007
X-TM-AS-Result: No--4.946200-8.000000-31
X-TM-AS-MatchedID: 700378-702796-702311-712124-704425-701499-705574-704421-1
        05040-705211-704410-701236-862004-188019-706290-708712-148004-148036-42000-
        42003
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

The Emerging Display Technology ETM0700G0EDH6 is the
uses the same panel as the ETM0700G0BDH6. It differs
in the hardware design for the backlight and the
touchscreen i2c interface. As the new display type has
different requirements for drive-strengths on the i2c-bus,
add an additional compatible to allow the handling of it or warn
about incompatible cpu and display combinations.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
Changes for v4:
  - re-arrange the Patch-series to match the DT-submitting-patches
  - Additional patch for the Documentation of the new DT-bindings
  - no change (re-arranged 2/6 => 3/7)

 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8b7feb2888f2..2eed60134fa3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2149,6 +2149,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "edt,etm0700g0bdh6",
 		.data = &edt_etm0700g0bdh6,
 	}, {
+		.compatible = "edt,etm0700g0edh6",
+		.data = &edt_etm0700g0bdh6,
+	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
 	}, {
-- 
2.11.0
