Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB75C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2FD208B7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5FjXRTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2FD208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbeHGA3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:29:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46637 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbeHGA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:29:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14-v6so6308422pgv.13;
        Mon, 06 Aug 2018 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7OufTL9uIyO71Njch/UbCGdSbo/gh+FH/4qlnwRVFOw=;
        b=R5FjXRTZ5nrvZCjDTJsdhOXMDh4xjB3iKpouf+KcHWc42kIX2ZOCy6iDxqyBz8dLK6
         bK3Z5m18ipx+jTUpnDcs4kBdvb3rMqTl0CSOCiVWLuxQ73rbHTDH/7KjqbZv71OBIysX
         O+aAlXgrvb/5BYBt4HPdSzT73VlrVCHsqVosoQLOAy2XsqkVP5/tn59OIwEzzBW78HcF
         z68QX4jmOsExTc5EzA0VZo643RWNCGuByOATOzLeHtsSWoZdHa1XPookrKLtPWP63RJC
         Ix+A8u7+mSfA/GKKDbn0nkYkwRZjto+guUB4gIflgMyTKvy7gQjL+0CFsEtZYw85a/qI
         TSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7OufTL9uIyO71Njch/UbCGdSbo/gh+FH/4qlnwRVFOw=;
        b=qu0GkaP4Ssz5Zm9ikwFmDACQ3lLr068RmRIEXUB3JjD6of0TJLWKHQOmt5U8zo1SWq
         2Ul77Lm5wWeGba4WNi9O9fhDWVn29iPW/VrsYKfTWUiXjAO96CQDTMa+vrBkkY/u5NOj
         YuKrUv9Z+t2yyDuXHySQOLCCd0PTeuGJAsw7AKkxam2zsPangvNsJWYC2M676miLOwPo
         FgFJBBg63d3zvGP1WIBtwDoWaRHSMIs5TKn+7qoJsZVOcrUwGSSmx8GNseT0qa3IVRp4
         yoMhiKF8HH8Grr8fM0bl2KSS+My+sEy2frWtiPq26jMhjxyqwH1pMVGDWi2orXw5417a
         SHyA==
X-Gm-Message-State: AOUpUlGzhL0MIg21ItFYYOobS6RNTk10qO7dhrrbyj0r3JYEMo646mq/
        Y1JkmYk5PC9ouLM9pFk6tHCXoVLZ
X-Google-Smtp-Source: AAOMgpe4vEfRgzSSt7jcgUsou/oJ9+tzWt5EfqvJV88tAiMZ20Fee4FXYCataVX5vFbrCPdQClsOhg==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr16078836pgs.350.1533593917678;
        Mon, 06 Aug 2018 15:18:37 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l27-v6sm25232084pfi.180.2018.08.06.15.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:18:36 -0700 (PDT)
Date:   Mon, 6 Aug 2018 15:18:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: do not use WARN() in input_alloc_absinfo()
Message-ID: <20180806221834.GA140172@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of fuzzers set panic_on_warn=1 so that they can handle WARN()ings
the same way they handle full-blown kernel crashes. We used WARN() in
input_alloc_absinfo() to get a better idea where memory allocation
failed, but since then kmalloc() and friends started dumping call stack
on memory allocation failures anyway, so we are not getting anything
extra from WARN().

Because of the above, let's replace WARN with dev_err(). We use dev_err()
instead of simply removing message and relying on kcalloc() to give us
stack dump so that we'd know the instance of hardware device to which we
were trying to attach input device.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 90453e2ab6cf..260f00ebe34d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -481,11 +481,19 @@ EXPORT_SYMBOL(input_inject_event);
  */
 void input_alloc_absinfo(struct input_dev *dev)
 {
-	if (!dev->absinfo)
-		dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo),
-					GFP_KERNEL);
+	if (dev->absinfo)
+		return;
 
-	WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
+	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_KERNEL);
+	if (!dev->absinfo) {
+		dev_err(dev->dev.parent ?: &dev->dev,
+			"%s: unable to allocate memory\n", __func__);
+		/*
+		 * We will handle this allocation failure in
+		 * input_register_device() when we refuse to register input
+		 * device with ABS bits but without absinfo.
+		 */
+	}
 }
 EXPORT_SYMBOL(input_alloc_absinfo);
 
-- 
2.18.0.597.ga71716f1ad-goog


-- 
Dmitry
