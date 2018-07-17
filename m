Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A152ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D429F206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429F206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGQWDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:03:42 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.182]:37387 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729738AbeGQWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:03:42 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 6D4096C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:29:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fXWZfKMGNbXuJfXWmfSCYU; Tue, 17 Jul 2018 16:29:09 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58594 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffXWZ-001K4K-CX; Tue, 17 Jul 2018 16:28:47 -0500
Date:   Tue, 17 Jul 2018 16:28:46 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: mark expected switch fall-throughs
Message-ID: <20180717212846.GA13179@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1ffXWZ-001K4K-CX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:58594
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1394724 ("Missing break in switch")
Addresses-Coverity-ID: 114958 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/axp20x_usb_power.c   | 1 +
 drivers/power/supply/cros_usbpd-charger.c | 1 +
 drivers/power/supply/wm8350_power.c       | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 44f70dc..42001df 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -222,6 +222,7 @@ static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 	case 100000:
 		if (power->axp20x_id == AXP221_ID)
 			return -EINVAL;
+		/* fall through */
 	case 500000:
 	case 900000:
 		val = (900000 - intval) / 400000;
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 3a0c96f..688a16b 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -325,6 +325,7 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 		 */
 		if (ec_device->mkbp_event_supported || port->psy_online)
 			break;
+		/* fall through */
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index a2740cf..15c0ca1 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -230,7 +230,8 @@ static irqreturn_t wm8350_charger_handler(int irq, void *data)
 	case WM8350_IRQ_EXT_USB_FB:
 	case WM8350_IRQ_EXT_WALL_FB:
 		wm8350_charger_config(wm8350, policy);
-	case WM8350_IRQ_EXT_BAT_FB:   /* Fall through */
+		/* Fall through */
+	case WM8350_IRQ_EXT_BAT_FB:
 		power_supply_changed(power->battery);
 		power_supply_changed(power->usb);
 		power_supply_changed(power->ac);
-- 
2.7.4

