Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E284ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DDC2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DDC2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeIWCGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:06:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:33705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeIWCGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:06:17 -0400
Received: from eddi-vb.fritz.box ([87.123.147.0]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lu3J4-1fbfCu2kkQ-011UNM; Sat, 22
 Sep 2018 22:11:22 +0200
From:   Tobias Herzog <t-herzog@gmx.de>
To:     oneukum@suse.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cdc-acm: correct counting of UART states in serial state notification
Date:   Sat, 22 Sep 2018 22:11:11 +0200
Message-Id: <1537647071-2691-2-git-send-email-t-herzog@gmx.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
References: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
X-Provags-ID: V03:K1:gc6QyhSN4lrE2w2RWYzmeku1QWXlsgnwM2F57BhUxmEAw6Z2H/U
 y5u76mHGq+HfHdWAnSEaur/sT3gNsByc6SCbnTpicHgN/bUfQIu9RevqT4zv5HRkOVtZ9G/
 mkoULQKsrO9RZB8ZfnYpw101yMfdWXNnk5g7KiNiilVO64YQKur9LQWGQrEnpcqsChjD67y
 ML7yHd4IGejzQhHuOhW1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Dn1hDfOdGY=:S+OAmYK7zq6snhfY9boi1l
 FDWuO7zFzMhI7jN0g5nELj9REJa+G0TwHGdXUf0IVXw7kF8ZTxga0wW9sr9AEurVuiUcrIt6r
 8Rb9YcfyYXoltkrCOqF3nwfstUo99TWck+WkIAJSqe4xol2O6n4xSJI+kw+v/oi1Mcqs5K5R5
 a7O8bQDw6OUYeHjttsF5uo0CP7CE8gfIDYsiLkXjrx+P64SDLly/WLSkEC2NyqoWDCih6d72H
 fTvunYilb8q9Rc4VRtzCQJRFh4ZsZRR+oM42AaN5oirau7Ofop1vXmaQ4qDPforKoeAHiFJcZ
 MpAK3cyybNEsAwitB2lLg6Yw5G6kfEgW28sy0wFB6mxe9coaTsTAFQmUbFFjFGZQthGIryWIb
 589H/iRsPrCKCBYXaijdvM5OYzPKi2hWVs4o5o14efSIkXBE6AYPZqA2JUfoZ1pRixhuyuiLk
 EUhbOcZtW7qTsegeb8Y1S/HOSwOfWubE44UuQi5/QQVok6AsvRD8P/rxnvBiX9WaeXrvQtsEV
 rss2PvguE5u3wRMxy/i8j0CyZyiWxv0qn7ZWtsGfbs7GLJrdHJhgD/I6ufGZ4Utn1CWGscQAg
 tbf+9YVdd1lMowsbEk8NQMpx1NsmhbrMLkXFLDgNMhlE0cguy2GTpAaSkGA1jiWalirt/K8n2
 mZsyFIzes7fjVd+PhkXT8wkPIhjW5DnGt5GhEDBM1I7dtEhlE8WSH8alCOfioQE0aftYziU//
 o9x9QgRsub7Fpj+4zDHYR8YM76j1lCWih0uR6ASiB/CxrjRHKbXXpb+lazpQyBNrblTxwYUjm
 WRDh5mZQghU+ZW+AJR6X7+Q88hc9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb standard ("Universal Serial Bus Class Definitions for Communication
Devices") distiguishes between "consistent signals" (DSR, DCD), and
"irregular signals" (break, ring, parity error, framing error, overrun).
The bits of "irregular signals" are set, if this error/event occurred on
the device side and are immeadeatly unset, if the serial state notification
was sent.
Like other drivers of real serial ports do, just the occurence of those
events should be counted in serial_icounter_struct (but no 1->0
transitions).

Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
---
 drivers/usb/class/cdc-acm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 50339ca..187f386 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -310,17 +310,17 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 
 		if (difference & ACM_CTRL_DSR)
 			acm->iocount.dsr++;
-		if (difference & ACM_CTRL_BRK)
-			acm->iocount.brk++;
-		if (difference & ACM_CTRL_RI)
-			acm->iocount.rng++;
 		if (difference & ACM_CTRL_DCD)
 			acm->iocount.dcd++;
-		if (difference & ACM_CTRL_FRAMING)
+		if (newctrl & ACM_CTRL_BRK)
+			acm->iocount.brk++;
+		if (newctrl & ACM_CTRL_RI)
+			acm->iocount.rng++;
+		if (newctrl & ACM_CTRL_FRAMING)
 			acm->iocount.frame++;
-		if (difference & ACM_CTRL_PARITY)
+		if (newctrl & ACM_CTRL_PARITY)
 			acm->iocount.parity++;
-		if (difference & ACM_CTRL_OVERRUN)
+		if (newctrl & ACM_CTRL_OVERRUN)
 			acm->iocount.overrun++;
 		spin_unlock_irqrestore(&acm->read_lock, flags);
 
-- 
2.1.4

