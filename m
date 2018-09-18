Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E68ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF8214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMynRSCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FF8214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeIRGRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40148 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeIRGRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so102258plp.7;
        Mon, 17 Sep 2018 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkjzQCWB8ZZ5VtAYMN5MrijD10AZ6RpRKaEwok1IRjQ=;
        b=cMynRSCNi8e3Dv/V3CYa55Zm4jzropiPQc0UIWQ9N2ZUNu2df8rKCdJKjLv3biBgdt
         //2Pb3LSjiVrhlUoXJ1jpgELeVJDGuIs6FVzlB85J7WdTKojezyVvANKHYot24xXWPh4
         H+obM98SEjHl4xAwrzdOqTL3rcszDFuBijzrzTpJlZaDQAX3lMFp3yjvCYhnN6rFq4f9
         fUYsMg5RxON0APB/I2801LjAfDbco4bVAginlJOeVEiHLdtV1K/w50UI/N8hJeMGvq4B
         fEK/6C5VGPOxLKv+71+bQxvXzwSQ3yfGWg7ea/xy4dewpJay7wZo+uC0Ac8EBagqQyhk
         ZHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkjzQCWB8ZZ5VtAYMN5MrijD10AZ6RpRKaEwok1IRjQ=;
        b=dE2cP5dcVcus9lrV5DN9igahCNHPj1T5eLV0j3rIok+MbQiZ5rr4PKweWveIVb64ne
         qlHIjNWa6HJSRlMLnG7ndhaBhWBX1sWmZBEvJIOxjBhsdAkFtRLNSBNQYbc+N3QW+Y3D
         PdKxkqhLgJWAEwKPSjVkHM6ZMJA0MiaxMtyv/4phVUFX7/AHrfKb6kp7sWcheGfp7Yo1
         tMw0WUnF/YJg1ylnwg85RlaT/5Yr4eqYpJEK/Y74vjbLMwJZTMdKQaNUI+7iorGfRsGb
         7aMstzK6dT7EUt1V6g8M8HtgIvOCOXZ/KtaRNJhIGfxGcnRXlj7cfeeEAfKaBZ/z5VeA
         abdQ==
X-Gm-Message-State: APzg51C058LX8ABh+/uhupv+vGuoA2PpeuqOqLtLzZIydoCjuR9Vf/MZ
        RrZMzx1a/l0V9oGuQb6fwcIshtAZ
X-Google-Smtp-Source: ANB0VdYb64832uGHouizYpMLa0h78RWaKl81TTCnQmdXrlSioqDX1kKM0mX3vB2Q8fbo4KcCLzz0Bg==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr26178364plb.146.1537231656298;
        Mon, 17 Sep 2018 17:47:36 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:35 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] Input: iforce - remove "being used" silliness
Date:   Mon, 17 Sep 2018 17:47:13 -0700
Message-Id: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is supposed to handle multiple devices, static flags
in packet handling code will never work.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This is a random assortment of iforce patches that I made a few weeks back.

Tim, I do not have hardware, so I was bound to screw it up, but if you
have some time I'd appreciate if you try them out (and if I indeed broke
things if you could identify issues that would be even more awesome).

Thanks!


 drivers/input/joystick/iforce/iforce-packets.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index c10169f4554e..91893c751524 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -149,12 +149,6 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 {
 	struct input_dev *dev = iforce->dev;
 	int i;
-	static int being_used = 0;
-
-	if (being_used)
-		dev_warn(&iforce->dev->dev,
-			 "re-entrant call to iforce_process %d\n", being_used);
-	being_used++;
 
 #ifdef CONFIG_JOYSTICK_IFORCE_232
 	if (HI(iforce->expect_packet) == HI(cmd)) {
@@ -165,10 +159,8 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 #endif
 	wake_up(&iforce->wait);
 
-	if (!iforce->type) {
-		being_used--;
+	if (!iforce->type)
 		return;
-	}
 
 	switch (HI(cmd)) {
 
@@ -233,7 +225,6 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			}
 			break;
 	}
-	being_used--;
 }
 
 int iforce_get_id_packet(struct iforce *iforce, char *packet)
-- 
2.19.0.397.gdd90340f6a-goog

