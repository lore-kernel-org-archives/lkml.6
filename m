Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-778319-1524663736-2-17781200953488298848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524663736; b=k5sNI8BAUNTZnOs1LD7aCDAL9NrvB+ImDDklmLAiRfKMMVkNhi
    mIX2qA9W26g3sAIZaogL2kFyhEgsV2Da1e74jv5aw9sGeTk5Zf3uRbrFA0aHhZyq
    2rexM0BKvew8syUMVmPBv685Aag/XLFFLqzr4tL0v/WZ9O+tsT9gfk3b1KyO+FfO
    RjFAY9RTLKRi6BmK++L8O4qO6fQYjIiV0sbVsTGEFeU9FYfD7i+mam8xp6ZQkjqV
    wi63JNg35kLPSlsStWuVFqxLuxGrieV6hxiaY+FGOgo7tK3MqVEynrv6fCUcy55b
    O7KA3yl9HndhBHq/X78YQfyLWfiSPTnXX2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524663736; bh=QWkZxfQk3Z+rFMX35j1d3RBeUuwEZ7
    6zuKfgeMk9RPE=; b=YymSyv+3LUgGGuIxEi586Lqy+CqXR1DA/qCBXadmaAhN3/
    d7mNIcTw5FU08ziMVjX9QlWdyPQT6rbSQWCmIzAylppBq3MbhUSLQIl9jDeR4FOE
    qQFQmxBQvBULIh8a73uSXWbLBj0PC7j9RB3uN+jQXZuOtCL0MedgwO9X9EcuVJPj
    AGCQa8YcSNNBpTiORr+8PCceDHsiXn2C62TAwomOi1yMYe5NRgvQjV95QEN/nz+j
    7TRKSoq3ZM8BQY/gMldoIzarDCNri7dDBWi7K/nDtcQMphpqECtHnrwgqWtCuZl4
    s9A4uWe5yzWPDHvEWfCQ6pxEAdt+hFcx6y0legCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RsmIvddH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=svz+jL9I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RsmIvddH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=svz+jL9I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIpI8SvIjkAqJSXJCHxvivRvHnfzA+FIGWc6ZI42MPcQMX4bMqit4cnNIFOmKtT6RJTWncBP4R+PFrjePnWSmxuFmAhAMZh0dy0jSfHiB+ndEWJPcQTZ
    pvNNEIhfadWTTrH5fWQI/LJxZk025zRD+UM4NmY5X5CUja2RzZSQhfsk5F4eVa+SBa7ubw8uhDHwZgIMwxR2WdiUXRD3nNPSnPQ/LLcyQYDTbJWtuJZiQBCy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=IqxT9t_lmoMA:10
    a=Kd1tUaAdevIA:10 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=NaznbBQ52PCbIpHfrikA:9
    a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbeDYNmO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 09:42:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46496 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbeDYNmL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 09:42:11 -0400
X-Google-Smtp-Source: AIpwx4/vMeupYJaP3aq6HAX6KDtnbwxkkS4us7jg+qYvo6SMxKv93SQ9RLqaG+RxgVCdrzk3nZd62A==
From: Eyal Reizer <eyalreizer@gmail.com>
X-Google-Original-From: Eyal Reizer <eyalr@ti.com>
To: kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        robh@kernel.org, sre@kernel.org, tony@atomide.com,
        linux-kernel@vger.kernel.org
Cc: Eyal Reizer <eyalr@ti.com>, stable@vger.kernel.org
Subject: [PATCH] net: wireless: ti: wlcore: sdio: allow pm to handle sdio power
Date: Wed, 25 Apr 2018 16:41:50 +0300
Message-Id: <1524663710-31927-1-git-send-email-eyalr@ti.com>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pm_runtime handles sdio power on and power off transitions.
An old workaround for trying to control the power explicitly from the
driver was in fact causing failures on suspend/resume as the mmc layer
already power the module on resume.

In case of resume pm_runtime_get sync returns a positive device's usage
count causing the driver to try an re-initialize an already initialized
device. This was causing sdio bus failure on resume.

Remove this manual power on/off sequence as it is in-fact not needed.

Signed-off-by: Eyal Reizer <eyalr@ti.com>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/ti/wlcore/sdio.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 1f727ba..6dbe61d 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -155,17 +155,11 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 	struct mmc_card *card = func->card;
 
 	ret = pm_runtime_get_sync(&card->dev);
-	if (ret) {
-		/*
-		 * Runtime PM might be temporarily disabled, or the device
-		 * might have a positive reference counter. Make sure it is
-		 * really powered on.
-		 */
-		ret = mmc_power_restore_host(card->host);
-		if (ret < 0) {
-			pm_runtime_put_sync(&card->dev);
-			goto out;
-		}
+	if (ret < 0) {
+		pm_runtime_put_noidle(&card->dev);
+		dev_err(glue->dev, "%s: failed to get_sync(%d)\n",
+			__func__, ret);
+		goto out;
 	}
 
 	sdio_claim_host(func);
@@ -178,7 +172,6 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 
 static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 {
-	int ret;
 	struct sdio_func *func = dev_to_sdio_func(glue->dev);
 	struct mmc_card *card = func->card;
 
@@ -186,16 +179,8 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 	sdio_disable_func(func);
 	sdio_release_host(func);
 
-	/* Power off the card manually in case it wasn't powered off above */
-	ret = mmc_power_save_host(card->host);
-	if (ret < 0)
-		goto out;
-
 	/* Let runtime PM know the card is powered off */
-	pm_runtime_put_sync(&card->dev);
-
-out:
-	return ret;
+	return pm_runtime_put_sync(&card->dev);
 }
 
 static int wl12xx_sdio_set_power(struct device *child, bool enable)
-- 
2.7.4
