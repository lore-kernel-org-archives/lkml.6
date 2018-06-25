Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019032605C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar4HYTpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019032605C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755649AbeFYTKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:10:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43734 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753182AbeFYTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:10:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so7242088plj.10;
        Mon, 25 Jun 2018 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O1a0cy/xcGn31lKvYuILhBPYLowbWAOtvCNptJ/VlJI=;
        b=ar4HYTpmZQ2vvOUJ7WP8a4Ll72wXwjy4upD32cgWn58AZKWdWQUNf19qb/1XBRiuCd
         0ljrgMo2X5L6LZpEGpdg9kwJLziSQckrtcUbM1Jm1Yr47zylTf6thnsJOKAYpkqKcgg4
         yJYM4oypDOhveUG+YQaSALP7QTSp2l+uNRVdA2E0qhgPBJ8P09ySaPQ+GAAQIp4UfX9k
         indcRz1zrNrKhQfIvKJCuEXk6FVfpX6LB5duiLBjV7DW0Z8odDe27VxyvSoAc0DG7veW
         XPzTz8r6n+H84sw40ajwshYI5Ui57HCViX4w2u7PGva6RpW9INrvFL7dcT+JQnR173jX
         UtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O1a0cy/xcGn31lKvYuILhBPYLowbWAOtvCNptJ/VlJI=;
        b=d2sIxm/REQHh7QOJjl4tF8TRO26gh/622Doh+X6Ib2uwtlXtJ8r+BrpDr1OmHQ3pMy
         /znY2Fvl0Nn4vr5vla9oVsmfyYxVSB4yx/xSty/oNH9rCbLnuU1sptVqlmZs2vSWLzwL
         rzSrkzgawB7SycmbTg9c+pvJGxZ9XDsU90Sim0ZdCkFHu1Ec3x7R/Tf1d3ldLrhBDsi3
         v4cxBaLnAC8Fxn0kx1OxwozcGI+tSbHNe5UEX7DZhZd8NDDkXcVIcAa48igk4wpIa3KZ
         fc+8suaJsz5jQWpykEB2sNZddschrj3Oajlik8JwAdb/IB6k4Bb6TeV1SmC6SoopkAXc
         +VPA==
X-Gm-Message-State: APt69E1fUlOQM5KutQQYNNgCvPToZFGGxgd1zycpM2A9FzkVrDTbpHWT
        uUx3YMQ9v2OtrgC9vxnvqgaU+zRv
X-Google-Smtp-Source: ADUXVKLIV25gWR14DYWcdTz2ZxaDOxJOT3jixWKyEvXBkUpK+Ld8b0DRGpzH5j0e8ctlqGBArqkIoA==
X-Received: by 2002:a17:902:8d96:: with SMTP id v22-v6mr13525022plo.176.1529953800662;
        Mon, 25 Jun 2018 12:10:00 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b62-v6sm8078178pfj.123.2018.06.25.12.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:09:59 -0700 (PDT)
Date:   Mon, 25 Jun 2018 12:09:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: psmouse - fix button reporting for basic protocols
Message-ID: <20180625190957.GA187975@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit ba667650c568 ("Input: psmouse - clean up code") was pretty
brain-dead and broke extra buttons reporting for variety of PS/2 mice:
Genius, Thinkmouse and Intellimouse Explorer. We need to actually inspect
the data coming from the device when reporting events.

Fixes: ba667650c568 ("Input: psmouse - clean up code")
Reported-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 5ff5b1952be0c..d3ff1fc09af71 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -192,8 +192,8 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 			else
 				input_report_rel(dev, REL_WHEEL, -wheel);
 
-			input_report_key(dev, BTN_SIDE,  BIT(4));
-			input_report_key(dev, BTN_EXTRA, BIT(5));
+			input_report_key(dev, BTN_SIDE,  packet[3] & BIT(4));
+			input_report_key(dev, BTN_EXTRA, packet[3] & BIT(5));
 			break;
 		}
 		break;
@@ -203,13 +203,13 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
 
 		/* Extra buttons on Genius NewNet 3D */
-		input_report_key(dev, BTN_SIDE,  BIT(6));
-		input_report_key(dev, BTN_EXTRA, BIT(7));
+		input_report_key(dev, BTN_SIDE,  packet[0] & BIT(6));
+		input_report_key(dev, BTN_EXTRA, packet[0] & BIT(7));
 		break;
 
 	case PSMOUSE_THINKPS:
 		/* Extra button on ThinkingMouse */
-		input_report_key(dev, BTN_EXTRA, BIT(3));
+		input_report_key(dev, BTN_EXTRA, packet[0] & BIT(3));
 
 		/*
 		 * Without this bit of weirdness moving up gives wildly
@@ -223,7 +223,7 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 		 * Cortron PS2 Trackball reports SIDE button in the
 		 * 4th bit of the first byte.
 		 */
-		input_report_key(dev, BTN_SIDE, BIT(3));
+		input_report_key(dev, BTN_SIDE, packet[0] & BIT(3));
 		packet[0] |= BIT(3);
 		break;
 
-- 
2.18.0.rc2.346.g013aa6912e-goog


-- 
Dmitry
