Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D318ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04EB20657
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRKF2UtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04EB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeIWXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 19:24:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeIWXY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 19:24:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so35489wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Kjk+PkTj+/YPBtbU6OM7pfzzUXRVxvsO3invjyYcBQ=;
        b=PRKF2UtWzY+Yylm8OwLlJCD1JqqPSjyAPDw3Y3ndym75FDVLDxAn0huWYUjnGsAZC2
         r0k0DoSUN39MTNOtm0g9qSsOI0Ab+KyvL99cTwdoxsHdPw6a7oh94XO0/c9fYvmP6lwz
         TOOkDRkNfos9qAEpGBKyNFNPaX5yNweZaQmlFyEDkrVKMOsD+wFGQcfAnyGHsBBdtuOp
         gPwMJwVmCmaJXvfQ5FbFqfh12VyC32NVtsNm4nmsrnq1nRpyNDK0zvw6Pgcauv/9zMRA
         ktRMezGcU4ESgtp7bixQvbjpzC7SbgiceHm+5lWbRu48+DmSLiNow038/aSjbOQ56dsd
         Khdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Kjk+PkTj+/YPBtbU6OM7pfzzUXRVxvsO3invjyYcBQ=;
        b=WGnngb5sSH1spaK+cGKgXP3RlrXAbemKDKHTjuwgv2BM4ixdUyklVxiT46Q4fTpGG6
         2AJFKTzJecQOcsSc50b/+rXZfI+inF/bTB8wQetAKHLy1Zf1aMmr6dwIIi5h01ldxFPq
         HFBrt50+cmNHoZsFF8iDv3VEz77tX5r+yzKmy235eJxyaIpUwjBUCWy+PQ+ZfgFmSP8T
         P9WAd0KIrfaUv6WxTc4wWqw8LXPah+FZ/sgqiESGOiODyg1pXZYIf/drRrDvsSXgBUiQ
         5FlzE7ifRSjnhmnJ4fZWvlSe+lL8D8zZCo2IYFApINRJan07XQzTq9KYz5rh0cEzrPiW
         tCBg==
X-Gm-Message-State: ABuFfoiuJiHCP7/yMTLDwBcZKS4xMQ0ugp/mZiLi8YTrz0PkZqYVU6g+
        sQrAXuIx7NK/XWh1lmQbHrs=
X-Google-Smtp-Source: ACcGV62YbxgRGAyP4JUxEyaWaejsFO3q2pfeMAWC58dK7wLL7YmJDL3Y1sPsNs3MOBNLqtXXF+jjSg==
X-Received: by 2002:a1c:80d8:: with SMTP id b207-v6mr4961829wmd.146.1537723575313;
        Sun, 23 Sep 2018 10:26:15 -0700 (PDT)
Received: from debian.localdomain (cpc88612-newt36-2-0-cust956.19-3.cable.virginm.net. [86.22.3.189])
        by smtp.gmail.com with ESMTPSA id x16-v6sm24355808wro.84.2018.09.23.10.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 10:26:14 -0700 (PDT)
From:   benmoore422@gmail.com
To:     w@1wt.eu, miguel.ojeda.sandonis@gmail.com, geert+renesas@glider.be
Cc:     linux-kernel@vger.kernel.org, benmoore422@gmail.com
Subject: [PATCH] [PATCHv2 TRIVIAL] auxdisplay: remove unnecessary braces
Date:   Sun, 23 Sep 2018 18:25:43 +0100
Message-Id: <20180923172543.5391-1-benmoore422@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Moore <benmoore422@gmail.com>

I have removed some unnecessary braces from if statements.
As well as inspecting the other driverfiles for similar
style issues.

Signed-off-by: Ben Moore <benmoore422@gmail.com>
---
 drivers/auxdisplay/ht16k33.c | 4 ++--
 drivers/auxdisplay/panel.c   | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a43276c76fc6..854bb2b90368 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -479,9 +479,9 @@ static int ht16k33_probe(struct i2c_client *client,

 	err = of_property_read_u32(node, "default-brightness-level",
 				   &dft_brightness);
-	if (err) {
+	if (err)
 		dft_brightness = MAX_BRIGHTNESS;
-	} else if (dft_brightness > MAX_BRIGHTNESS) {
+	else if (dft_brightness > MAX_BRIGHTNESS) {
 		dev_warn(&client->dev,
 			 "invalid default brightness level: %u, using %u\n",
 			 dft_brightness, MAX_BRIGHTNESS);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 3b25a643058c..f769431fbb52 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -695,11 +695,10 @@ static void lcd_send_serial(int byte)
 	for (bit = 0; bit < 8; bit++) {
 		clear_bit(LCD_BIT_CL, bits);	/* CLK low */
 		panel_set_bits();
-		if (byte & 1) {
+		if (byte & 1)
 			set_bit(LCD_BIT_DA, bits);
-		} else {
+		else
 			clear_bit(LCD_BIT_DA, bits);
-		}

 		panel_set_bits();
 		udelay(2);  /* maintain the data during 2 us before CLK up */
--
2.11.0

