Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD260C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9FC24781
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9FC24781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGCU7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:59:47 -0400
Received: from gateway20.websitewelcome.com ([192.185.61.9]:28324 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753311AbeGCU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:59:44 -0400
X-Greylist: delayed 1426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 16:59:44 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 07522400CF19D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 15:35:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aS1afG1xSSjJAaS1gfkyqU; Tue, 03 Jul 2018 15:35:57 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=49912 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faS1Z-0038y8-Hz; Tue, 03 Jul 2018 15:35:45 -0500
Date:   Tue, 3 Jul 2018 15:35:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: mark expected switch fall-throughs
Message-ID: <20180703203544.GA1015@embeddedor.com>
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
X-Exim-ID: 1faS1Z-0038y8-Hz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:49912
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/joystick/db9.c          | 5 +++++
 drivers/input/keyboard/adp5589-keys.c | 1 +
 drivers/input/mouse/appletouch.c      | 1 +
 drivers/input/mouse/cyapa_gen5.c      | 1 +
 drivers/input/mouse/cyapa_gen6.c      | 1 +
 drivers/input/mouse/elantech.c        | 2 +-
 drivers/input/mouse/sermouse.c        | 4 +++-
 drivers/input/touchscreen/elo.c       | 1 +
 8 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index de0dd47..0006da5 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -263,6 +263,7 @@ static unsigned char db9_saturn_read_packet(struct parport *port, unsigned char
 			db9_saturn_write_sub(port, type, 3, powered, 0);
 			return data[0] = 0xe3;
 		}
+		/* else: fall through */
 	default:
 		return data[0];
 	}
@@ -282,11 +283,14 @@ static int db9_saturn_report(unsigned char id, unsigned char data[60], struct in
 		switch (data[j]) {
 		case 0x16: /* multi controller (analog 4 axis) */
 			input_report_abs(dev, db9_abs[5], data[j + 6]);
+			/* fall through */
 		case 0x15: /* mission stick (analog 3 axis) */
 			input_report_abs(dev, db9_abs[3], data[j + 4]);
 			input_report_abs(dev, db9_abs[4], data[j + 5]);
+			/* fall through */
 		case 0x13: /* racing controller (analog 1 axis) */
 			input_report_abs(dev, db9_abs[2], data[j + 3]);
+			/* fall through */
 		case 0x34: /* saturn keyboard (udlr ZXC ASD QE Esc) */
 		case 0x02: /* digital pad (digital 2 axis + buttons) */
 			input_report_abs(dev, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
@@ -380,6 +384,7 @@ static void db9_timer(struct timer_list *t)
 			input_report_abs(dev2, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9_LEFT ? 0 : 1));
 			input_report_abs(dev2, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9_UP   ? 0 : 1));
 			input_report_key(dev2, BTN_TRIGGER, ~data & DB9_FIRE1);
+			/* fall through */
 
 		case DB9_MULTI_0802:
 
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 32d94c6..2835fba 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -885,6 +885,7 @@ static int adp5589_probe(struct i2c_client *client,
 	switch (id->driver_data) {
 	case ADP5585_02:
 		kpad->support_row5 = true;
+		/* fall through */
 	case ADP5585_01:
 		kpad->is_adp5585 = true;
 		kpad->var = &const_adp5585;
diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 032d279..0aeed28e8 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -472,6 +472,7 @@ static int atp_status_check(struct urb *urb)
 				dev->info->datalen, dev->urb->actual_length);
 			dev->overflow_warned = true;
 		}
+		/* fall through */
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 5775d40..14239fb 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2554,6 +2554,7 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
 		}
 
 		cyapa->state = CYAPA_STATE_GEN5_APP;
+		/* fall through */
 
 	case CYAPA_STATE_GEN5_APP:
 		/*
diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 0163978..c1b524a 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -680,6 +680,7 @@ static int cyapa_gen6_operational_check(struct cyapa *cyapa)
 		}
 
 		cyapa->state = CYAPA_STATE_GEN6_APP;
+		/* fall through */
 
 	case CYAPA_STATE_GEN6_APP:
 		/*
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index dd85b16..44f57cf 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -340,7 +340,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 		 */
 		if (packet[3] & 0x80)
 			fingers = 4;
-		/* pass through... */
+		/* fall through */
 	case 1:
 		/*
 		 * byte 1:  .   .   .   .  x11 x10 x9  x8
diff --git a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
index 8df5266..4431057 100644
--- a/drivers/input/mouse/sermouse.c
+++ b/drivers/input/mouse/sermouse.c
@@ -143,7 +143,8 @@ static void sermouse_process_ms(struct sermouse *sermouse, signed char data)
 			switch (sermouse->type) {
 
 				case SERIO_MS:
-					 sermouse->type = SERIO_MP;
+					sermouse->type = SERIO_MP;
+					/* fall through */
 
 				case SERIO_MP:
 					if ((data >> 2) & 3) break;	/* M++ Wireless Extension packet. */
@@ -154,6 +155,7 @@ static void sermouse_process_ms(struct sermouse *sermouse, signed char data)
 				case SERIO_MZP:
 				case SERIO_MZPP:
 					input_report_key(dev, BTN_SIDE,   (data >> 5) & 1);
+					/* fall through */
 
 				case SERIO_MZ:
 					input_report_key(dev, BTN_MIDDLE, (data >> 4) & 1);
diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index 83433e8..7f2942f 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -352,6 +352,7 @@ static int elo_connect(struct serio *serio, struct serio_driver *drv)
 
 	case 1: /* 6-byte protocol */
 		input_set_abs_params(input_dev, ABS_PRESSURE, 0, 15, 0, 0);
+		/* fall through */
 
 	case 2: /* 4-byte protocol */
 		input_set_abs_params(input_dev, ABS_X, 96, 4000, 0, 0);
-- 
2.7.4

