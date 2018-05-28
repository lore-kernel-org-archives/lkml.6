Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164892AbeE1LCJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164868AbeE1LCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Bourdon <delroth@google.com>,
        Andre Heider <a.heider@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 424/496] max17042: propagate of_node to power supply device
Date: Mon, 28 May 2018 12:03:29 +0200
Message-Id: <20180528100337.614849378@linuxfoundation.org>
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

From: Pierre Bourdon <delroth@google.com>

[ Upstream commit 66ec32fc7cd116dab5c02603ea8ec28ff92da3b5 ]

max17042_get_status uses the core power_supply_am_i_supplied. That
function relies on DT properties to figure out the power supply
topology, and will error out without DT.

Fixes max17042 battery status being reported as "unknown".

Signed-off-by: Pierre Bourdon <delroth@google.com>
Signed-off-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/max17042_battery.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1021,6 +1021,7 @@ static int max17042_probe(struct i2c_cli
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
+	psy_cfg.of_node = dev->of_node;
 
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
