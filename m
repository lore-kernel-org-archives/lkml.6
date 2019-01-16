Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A74C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C81206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqdSNsfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbfAPLhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:37:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39024 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbfAPLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:37:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so5152549ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G4uWfUBdfRWJ7ooa2ukqyMzWYVfm+tWSAZRULgvNQ08=;
        b=DqdSNsfGTw5APfw140m3LimoqimPBt+dTkOxqu/2bQyXk7S9f23O7PxiN3oFynlZKr
         SASxPUZ8sG4xbfOK9h8FHLlWWFpRIZSahu+mE0EseqtvBLV4sdCnBwOS8M3gko6ngb7C
         i176BhDXn0+wm8tZGD3yN7Qp96KnQZ3Sv/tjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4uWfUBdfRWJ7ooa2ukqyMzWYVfm+tWSAZRULgvNQ08=;
        b=LG8ibGRXVwX8DpqX2a4U6n/bYirOLNT9CSDN8Jda0XhZjg2iT8A2LG/DFnhtKrUMr9
         EKLGpD09wXIFwd9JRCxwDU88xP/0adLP7pHsCuTMGhrTPM43aiJKEnUmAAdO3/kroYn3
         /CQtK7sTuRXoaLgOnY3tkoIZmZrbVbnYBwpnfFyR8ZDc1ZhVMjiePGmB0Y+HV6U0AUIk
         3TMkjpZ2CPLlooWbyubU4yP1/S7fFxUw0G0iT8FEpZNMpXgY56uD2jbPkoYanGFe13rR
         Wu176vndiqFeWkKYWQwPagx3eCBTN5Z4IA3xKVEHKArB1k4AYGrtjT9W1aOk+bULK+p+
         D2rw==
X-Gm-Message-State: AJcUukcHiKSu/vqzBwa6MSrlJE1C9IixBGogiAc+YQsnkQbJl2cqKDNA
        toacCbmJgA0whU9P/WD0C2AYMA==
X-Google-Smtp-Source: ALg8bN4GExvNSUhrn1ThdHo4TWGq9deM7EiNDhwBHUXk+6BhziaXs9EaV54O4+YG3vKLHV5hZLkJyg==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr6194730ljb.153.1547638653812;
        Wed, 16 Jan 2019 03:37:33 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f11sm1144237lfi.12.2019.01.16.03.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 03:37:33 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>,
        linux-wireless@vger.kernel.org
Cc:     Ricardo Salveti <rsalveti@rsalveti.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jan Kiszka <jan.kiszka@web.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date:   Wed, 16 Jan 2019 12:37:23 +0100
Message-Id: <20190116113723.15668-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During "wlan-up", we are programming the FW into the WiFi-chip. However,
re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
is made in-between the programmings.

To conform to this requirement and to fix the regression in a simple way,
let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
(runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
current code is to treat this scenario as an error, but unfortunate this
doesn't work as expected, so let's fix this.

The other part is to guarantee that a power cycle of the SDIO card has been
completed when wl12xx_sdio_power_on() returns, as to allow the FW
programming to succeed. However, relying solely on runtime PM to deal with
this isn't sufficient. For example, userspace may prevent runtime suspend
via sysfs for the device that represents the SDIO card, leading to that the
mmc core also keeps it powered on. For this reason, let's instead do a
brute force power cycle in wl12xx_sdio_power_on().

Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Keep the SDIO host claimed when calling mmc_hw_reset().
	- Add a fixes tag.
---
 drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index bd10165d7eec..4d4b07701149 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -164,6 +164,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 	}
 
 	sdio_claim_host(func);
+	/*
+	 * To guarantee that the SDIO card is power cycled, as required to make
+	 * the FW programming to succeed, let's do a brute force HW reset.
+	 */
+	mmc_hw_reset(card->host);
+
 	sdio_enable_func(func);
 	sdio_release_host(func);
 
@@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 {
 	struct sdio_func *func = dev_to_sdio_func(glue->dev);
 	struct mmc_card *card = func->card;
-	int error;
 
 	sdio_claim_host(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
 
 	/* Let runtime PM know the card is powered off */
-	error = pm_runtime_put(&card->dev);
-	if (error < 0 && error != -EBUSY) {
-		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
-
-		return error;
-	}
-
+	pm_runtime_put(&card->dev);
 	return 0;
 }
 
-- 
2.17.1

