Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C72084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWiigB3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeLPQ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:57:47 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40645 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeLPQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:57:47 -0500
Received: by mail-yw1-f65.google.com with SMTP id r130so4284365ywg.7;
        Sun, 16 Dec 2018 08:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GDRWZSpcVm6yGnkxfwtc7lStS4p2K6CpZdIssAu5KoQ=;
        b=oWiigB3f9rk/eQWFbFcB/Lt3l8WyyPtdZC5UpnAmdskoSlzNmpWZhw5QodeRe2MiHH
         2u63LKMRDzFoeDGmVdEGDwCeEVTYVbDMAx81D5KuNulbJ5WWuy3+DQL8eKtbvxQh/CbO
         qifRw7gmas39Wp4D13kk3tza0udlOhRbNtj6DbyS7CRpU17i6eEOr29YEH0Dzb8/Y21q
         fqu/0xJQzF0rClvu+dJ39bjWFGBbbfIhkmR8yR2umJ8RBjEgdqSNqG+orCNsQcYTrW6g
         G20KXmvgx4e44DaAWO8IuHpfJTAkHD5kYixVJNSZ64hNQDzhIAyCk1qLWAxdu/gLPYRV
         Lu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GDRWZSpcVm6yGnkxfwtc7lStS4p2K6CpZdIssAu5KoQ=;
        b=A25tMiR97Bg6awtSib4m2y4oiHZg/0sG9bUimdRqM72chhCzhGZZvP+9uhCr9cU2f0
         cdrBT+nXW2Pk58stbW3/hH6f0vka41URHTZuaqlVKPmLVg5EXMAqrME1s6zJ9BkAy0kn
         d9TX/n+YBXr7eCFs/E/AsQcPhxjuGXCDR8z84NIYq8qXTvNoFvzDnHtDkUFqmLWeGBJe
         kRPej+en/vBXBEZaVifpReBuC9UyqE4ni3lqhIrCvyse513wBnL7ugneHC7HPGvvoqM4
         P9EKKwZETQ15h31cYhIXUw8MWGo1hOOIPl4Y/n3MDOEenAiilFya0PZ05P3DL31PTEhY
         YAig==
X-Gm-Message-State: AA+aEWZX+ltc1KOUU3+lWlMPwcPVWxFu0wXMfM5qbNpBbdE7qAvLVQ4W
        eY0hxcVt23pyJTDjjNdKqgs1ZYZq
X-Google-Smtp-Source: AFSGD/VAADoAQ4+CjfF0H/pZ0UftBAvE3OpLn5dfS5PmtvwHo0dGU0e8FRDVheoQrGP8YcpmF+OowQ==
X-Received: by 2002:a81:3944:: with SMTP id g65mr6990615ywa.337.1544979464816;
        Sun, 16 Dec 2018 08:57:44 -0800 (PST)
Received: from ubuntu ([67.191.186.148])
        by smtp.gmail.com with ESMTPSA id 141sm3460398yws.47.2018.12.16.08.57.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 08:57:44 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     marvin24@gmx.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] Staging: nvec: nvec: fixed check style issues
Date:   Sun, 16 Dec 2018 08:57:43 -0800
Message-Id: <1544979463-10126-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed an endline open parenthesis issue and replaced udelay() by the
preferred usleep_range() function.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/nvec/nvec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 08027a3..69eef7d 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -382,8 +382,10 @@ static void nvec_request_master(struct work_struct *work)
 		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
 		spin_unlock_irqrestore(&nvec->tx_lock, flags);
 		nvec_gpio_set_value(nvec, 0);
-		err = wait_for_completion_interruptible_timeout(
-				&nvec->ec_transfer, msecs_to_jiffies(5000));
+		done = &nvec->ec_transfer;
+		timeout = msecs_to_jiffies(5000);
+		err = wait_for_completion_interruptible_timeout(done,
+								timeout);
 
 		if (err == 0) {
 			dev_warn(nvec->dev, "timeout waiting for ec transfer\n");
@@ -626,7 +628,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 		break;
 	case 2:		/* first byte after command */
 		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-			udelay(33);
+			usleep_range(0, 33);
 			if (nvec->rx->data[0] != 0x01) {
 				dev_err(nvec->dev,
 					"Read without prior read command\n");
@@ -713,7 +715,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 	 * We experience less incomplete messages with this delay than without
 	 * it, but we don't know why. Help is appreciated.
 	 */
-	udelay(100);
+	usleep_range(0, 100);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

