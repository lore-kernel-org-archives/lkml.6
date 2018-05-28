Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938746AbeE1MUM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164828AbeE1LC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 466/496] power: supply: ltc2941-battery-gauge: Fix temperature units
Date: Mon, 28 May 2018 12:04:11 +0200
Message-Id: <20180528100339.551165957@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ladislav Michl <ladis@linux-mips.org>

[ Upstream commit dde5953f05a89eb63a0d666ffe51d447b2ac3e05 ]

Temperature is measured in tenths of degree Celsius.

Fixes: 085bc24d1553 ("Add LTC2941/LTC2943 Battery Gauge Driver")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -316,15 +316,15 @@ static int ltc294x_get_temperature(const
 
 	if (info->id == LTC2942_ID) {
 		reg = LTC2942_REG_TEMPERATURE_MSB;
-		value = 60000;	/* Full-scale is 600 Kelvin */
+		value = 6000;	/* Full-scale is 600 Kelvin */
 	} else {
 		reg = LTC2943_REG_TEMPERATURE_MSB;
-		value = 51000;	/* Full-scale is 510 Kelvin */
+		value = 5100;	/* Full-scale is 510 Kelvin */
 	}
 	ret = ltc294x_read_regs(info->client, reg, &datar[0], 2);
 	value *= (datar[0] << 8) | datar[1];
-	/* Convert to centidegrees  */
-	*val = value / 0xFFFF - 27215;
+	/* Convert to tenths of degree Celsius */
+	*val = value / 0xFFFF - 2722;
 	return ret;
 }
 
