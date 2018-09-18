Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCABECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F078214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q46d73yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F078214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeIRGRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33308 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeIRGRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so121541pfn.0;
        Mon, 17 Sep 2018 17:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6MQQBXg5BnNlq8nEfytR1l6OiNQOXKjftVMweLbkvc=;
        b=Q46d73yBGTh78wTOuVGKyhfR94gX/gcwpSRfDfvKmaS0qreYgTgdDlArsiszaNZ0bE
         3cJBiwrtoWtR1ZR/5b0ub2CZ/GrQ5+RbbKq2yVXW7zpeBFqoK5Zd5g7Vg6NnOtxyMYFv
         sDtZk/WC6ds114c3nIgnxPWOb5mZgk5EmZ4/M2YAWpCUmYGBzMpyg9xpRLcwqm/n7jVQ
         Qmaf0fAv2CJsVPIOrBfU51fRL1l52+71NMLYMjMqzshnBNISSoA8RBx7rHteRDt0ieie
         CqMOJGdZpQBCa3Bk2vvKpeWn9/x8yBk/k3GWxb2wfYPGgIbypXpRza2ebzvAeW6vSIxj
         ubkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6MQQBXg5BnNlq8nEfytR1l6OiNQOXKjftVMweLbkvc=;
        b=bCAuZuPPHVg4djUJKrBtOxGhdWH1LZKlJDrUuF+t+/kQfwxOHzy2DxoMz2aNPp/CCV
         fnN7mapd90/DgMHHPuCeFzWsXVOvI7DN+pR5ocbW2WbNHWssS/WpXy1WZqI84A+TYtnO
         Qm7Lp1k1sgIZKBePXGQ+7idKLEKwhiU4w3ust0jEj42oKQfdJFwDwWCXlavbLuwEz0iH
         RsGPKheHWSz+Vvjx86yxvBBIlPok8Xzqn9E46sz84KAYo4+gE7EHVRBJLOWaGhrd+q+6
         84Np8RkyFM0RoAtKU7EiG4h+s9Wg4PnXaOHmuv9qrujC8DhoYzt1qOEzlRbh4/02icIv
         tvFQ==
X-Gm-Message-State: APzg51Cv+d6hz2a3vRekUfz3SvLEa4DFmY5NR9X2SVyvxvjAXOttwjKH
        rLiHcC9tBfr9Xrq+zf/PbJhihvsw
X-Google-Smtp-Source: ANB0VdZk2Y12NF7FM/VAX2wnHmvki/0cfmr/wd4RmKbnbEYC30Y4wOHSNDHanHn2Vj3UtxHps9SA5A==
X-Received: by 2002:a63:df04:: with SMTP id u4-v6mr26033110pgg.434.1537231670246;
        Mon, 17 Sep 2018 17:47:50 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] Input: iforce - update formatting of switch statements
Date:   Mon, 17 Sep 2018 17:47:22 -0700
Message-Id: <20180918004732.9875-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to our coding style case labels in switch statements should
be aligned with the switch keyword.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-ff.c     |  18 +--
 drivers/input/joystick/iforce/iforce-main.c   |  70 +++++------
 .../input/joystick/iforce/iforce-packets.c    | 112 +++++++++---------
 3 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-ff.c b/drivers/input/joystick/iforce/iforce-ff.c
index 3536d5f5ad18..56973dd97fd6 100644
--- a/drivers/input/joystick/iforce/iforce-ff.c
+++ b/drivers/input/joystick/iforce/iforce-ff.c
@@ -384,12 +384,12 @@ int iforce_upload_periodic(struct iforce *iforce, struct ff_effect *effect, stru
 	}
 
 	switch (effect->u.periodic.waveform) {
-		case FF_SQUARE:		wave_code = 0x20; break;
-		case FF_TRIANGLE:	wave_code = 0x21; break;
-		case FF_SINE:		wave_code = 0x22; break;
-		case FF_SAW_UP:		wave_code = 0x23; break;
-		case FF_SAW_DOWN:	wave_code = 0x24; break;
-		default:		wave_code = 0x20; break;
+	case FF_SQUARE:		wave_code = 0x20; break;
+	case FF_TRIANGLE:	wave_code = 0x21; break;
+	case FF_SINE:		wave_code = 0x22; break;
+	case FF_SAW_UP:		wave_code = 0x23; break;
+	case FF_SAW_DOWN:	wave_code = 0x24; break;
+	default:		wave_code = 0x20; break;
 	}
 
 	if (!old || need_core(old, effect)) {
@@ -488,9 +488,9 @@ int iforce_upload_condition(struct iforce *iforce, struct ff_effect *effect, str
 	int core_err = 0;
 
 	switch (effect->type) {
-		case FF_SPRING:	type = 0x40; break;
-		case FF_DAMPER:	type = 0x41; break;
-		default: return -1;
+	case FF_SPRING:	type = 0x40; break;
+	case FF_DAMPER:	type = 0x41; break;
+	default: return -1;
 	}
 
 	if (!old || need_condition_modifier(iforce, old, effect)) {
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 3a0698327c42..9964aa8b3cdc 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -132,22 +132,21 @@ static int iforce_upload_effect(struct input_dev *dev, struct ff_effect *effect,
  * Upload the effect
  */
 	switch (effect->type) {
+	case FF_PERIODIC:
+		ret = iforce_upload_periodic(iforce, effect, old);
+		break;
 
-		case FF_PERIODIC:
-			ret = iforce_upload_periodic(iforce, effect, old);
-			break;
+	case FF_CONSTANT:
+		ret = iforce_upload_constant(iforce, effect, old);
+		break;
 
-		case FF_CONSTANT:
-			ret = iforce_upload_constant(iforce, effect, old);
-			break;
+	case FF_SPRING:
+	case FF_DAMPER:
+		ret = iforce_upload_condition(iforce, effect, old);
+		break;
 
-		case FF_SPRING:
-		case FF_DAMPER:
-			ret = iforce_upload_condition(iforce, effect, old);
-			break;
-
-		default:
-			return -EINVAL;
+	default:
+		return -EINVAL;
 	}
 
 	if (ret == 0) {
@@ -351,34 +350,29 @@ int iforce_init_device(struct device *parent, u16 bustype,
 		signed short t = iforce->type->abs[i];
 
 		switch (t) {
+		case ABS_X:
+		case ABS_Y:
+		case ABS_WHEEL:
+			input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
+			set_bit(t, input_dev->ffbit);
+			break;
 
-			case ABS_X:
-			case ABS_Y:
-			case ABS_WHEEL:
-
-				input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
-				set_bit(t, input_dev->ffbit);
-				break;
-
-			case ABS_THROTTLE:
-			case ABS_GAS:
-			case ABS_BRAKE:
-
-				input_set_abs_params(input_dev, t, 0, 255, 0, 0);
-				break;
-
-			case ABS_RUDDER:
-
-				input_set_abs_params(input_dev, t, -128, 127, 0, 0);
-				break;
+		case ABS_THROTTLE:
+		case ABS_GAS:
+		case ABS_BRAKE:
+			input_set_abs_params(input_dev, t, 0, 255, 0, 0);
+			break;
 
-			case ABS_HAT0X:
-			case ABS_HAT0Y:
-		        case ABS_HAT1X:
-		        case ABS_HAT1Y:
+		case ABS_RUDDER:
+			input_set_abs_params(input_dev, t, -128, 127, 0, 0);
+			break;
 
-				input_set_abs_params(input_dev, t, -1, 1, 0, 0);
-				break;
+		case ABS_HAT0X:
+		case ABS_HAT0Y:
+		case ABS_HAT1X:
+		case ABS_HAT1Y:
+			input_set_abs_params(input_dev, t, -1, 1, 0, 0);
+			break;
 		}
 	}
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 70db273e5045..7aba2966454a 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -142,66 +142,72 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 
 	switch (HI(cmd)) {
 
-		case 0x01:	/* joystick position data */
-		case 0x03:	/* wheel position data */
-			if (HI(cmd) == 1) {
-				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-				input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-				if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-					input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-			} else {
-				input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_GAS,   255 - data[2]);
-				input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
-			}
+	case 0x01:	/* joystick position data */
+	case 0x03:	/* wheel position data */
+		if (HI(cmd) == 1) {
+			input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+			input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+			input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
+			if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+				input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+		} else {
+			input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
+			input_report_abs(dev, ABS_GAS,   255 - data[2]);
+			input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+		}
 
-			input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
-			input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
-
-			for (i = 0; iforce->type->btn[i] >= 0; i++)
-				input_report_key(dev, iforce->type->btn[i], data[(i >> 3) + 5] & (1 << (i & 7)));
-
-			/* If there are untouched bits left, interpret them as the second hat */
-			if (i <= 8) {
-				int btns = data[6];
-				if (test_bit(ABS_HAT1X, dev->absbit)) {
-					if (btns & 8) input_report_abs(dev, ABS_HAT1X, -1);
-					else if (btns & 2) input_report_abs(dev, ABS_HAT1X, 1);
-					else input_report_abs(dev, ABS_HAT1X, 0);
-				}
-				if (test_bit(ABS_HAT1Y, dev->absbit)) {
-					if (btns & 1) input_report_abs(dev, ABS_HAT1Y, -1);
-					else if (btns & 4) input_report_abs(dev, ABS_HAT1Y, 1);
-					else input_report_abs(dev, ABS_HAT1Y, 0);
-				}
+		input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
+		input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
+
+		for (i = 0; iforce->type->btn[i] >= 0; i++)
+			input_report_key(dev, iforce->type->btn[i], data[(i >> 3) + 5] & (1 << (i & 7)));
+
+		/* If there are untouched bits left, interpret them as the second hat */
+		if (i <= 8) {
+			int btns = data[6];
+			if (test_bit(ABS_HAT1X, dev->absbit)) {
+				if (btns & 8)
+					input_report_abs(dev, ABS_HAT1X, -1);
+				else if (btns & 2)
+					input_report_abs(dev, ABS_HAT1X, 1);
+				else
+					input_report_abs(dev, ABS_HAT1X, 0);
 			}
+			if (test_bit(ABS_HAT1Y, dev->absbit)) {
+				if (btns & 1)
+					input_report_abs(dev, ABS_HAT1Y, -1);
+				else if (btns & 4)
+					input_report_abs(dev, ABS_HAT1Y, 1);
+				else
+					input_report_abs(dev, ABS_HAT1Y, 0);
+			}
+		}
 
-			input_sync(dev);
+		input_sync(dev);
 
-			break;
+		break;
 
-		case 0x02:	/* status report */
-			input_report_key(dev, BTN_DEAD, data[0] & 0x02);
-			input_sync(dev);
+	case 0x02:	/* status report */
+		input_report_key(dev, BTN_DEAD, data[0] & 0x02);
+		input_sync(dev);
 
-			/* Check if an effect was just started or stopped */
-			i = data[1] & 0x7f;
-			if (data[1] & 0x80) {
-				if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-					/* Report play event */
-					input_report_ff_status(dev, i, FF_STATUS_PLAYING);
-				}
-			} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-				/* Report stop event */
-				input_report_ff_status(dev, i, FF_STATUS_STOPPED);
+		/* Check if an effect was just started or stopped */
+		i = data[1] & 0x7f;
+		if (data[1] & 0x80) {
+			if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
+				/* Report play event */
+				input_report_ff_status(dev, i, FF_STATUS_PLAYING);
 			}
-			if (LO(cmd) > 3) {
-				int j;
-				for (j = 3; j < LO(cmd); j += 2)
-					mark_core_as_ready(iforce, data[j] | (data[j+1]<<8));
-			}
-			break;
+		} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
+			/* Report stop event */
+			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
+		}
+		if (LO(cmd) > 3) {
+			int j;
+			for (j = 3; j < LO(cmd); j += 2)
+				mark_core_as_ready(iforce, data[j] | (data[j+1]<<8));
+		}
+		break;
 	}
 }
 EXPORT_SYMBOL(iforce_process_packet);
-- 
2.19.0.397.gdd90340f6a-goog

