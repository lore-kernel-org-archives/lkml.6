Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CCB2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZS6HpZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfBZTgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35389 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZTg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id p19so6723297plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVXBfapIBPv9u2kzIyOKvGLdHh31BstlJtoKLehz/ro=;
        b=qZS6HpZMXIb4jSEp5ugOY+XQYJL3OF29uRIh7vTNcXnJt95jSpFxGSXZPy5b4BPJdn
         ex5rSQemwGkSj9lMe4Ir6DTBf9LlcWvvKpINvUinoWXunfuklh+dSO7V4dtn4BTuh/ns
         7aHRE+ZwGQ5wSTB2aAKfPSS84LLpqu7GXJe2R86Vp6mebrjCyvdFwiDTJdJrasZoU3do
         zus5suIVvq73t3tDJ3He0mJyu0zA9DB1zlYBaicP/y5nHiJAns410fTDx5uL+zDu+5u5
         MDPIj9vFbAYct3BXdxnaPnLVdjJ0ppCwIYyH3lmHD8wmHpTc6ArvaDrzOxv8Z4qtYJ5k
         BysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVXBfapIBPv9u2kzIyOKvGLdHh31BstlJtoKLehz/ro=;
        b=VGs//LAQ7e4Gb9Yjmc0WpIkor4GwzuLYCrimKsxWKh8ehmt2ebl4KgwHErcQbLtx+R
         QqG+005Bcvck6VXuisVPibJg5yG3V7ZNK9ru7tyuX6Fs/ewq6ppn3eOm72ePx+1F4ah8
         VFtTIFwc8bI9lpki0lDyF8Z7Mb7/cvDQAVBMD3sUPILEPPZ4/Az+2n9Vfw5ES1Zzouea
         ifFzCZnkkjhtQJR5RxUi7EN50fWcP047J8ePz4oZdncSOUg262QQigoP16fwxUBzYT0e
         Zxor2Xc656hulk4ZYTt34N+C5wL5CaGhQLTX1C8EVugT+2yjgsDZTL6OvuPL3n4XSRIi
         b6rA==
X-Gm-Message-State: AHQUAuZEksyt+BKNBqcE2fGQIawTNRCNRtKvkctLvrrGJPJX3WamIUWH
        6B35GJmIeC5LYwsJYShR3C8=
X-Google-Smtp-Source: AHgI3IYLOxDuyqQ8mbfqACEV3AngV+icEFTS1xsMJdZHGpimzvUBJXiQXvv8hLtOugAL7eLnbUyOog==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr6006380pls.130.1551209787748;
        Tue, 26 Feb 2019 11:36:27 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:26 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] drm/bridge: tc358767: Simplify tc_poll_timeout()
Date:   Tue, 26 Feb 2019 11:36:01 -0800
Message-Id: <20190226193609.9862-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of tc_poll_timeout() is almost a 100% copy-and-paste of
the code for regmap_read_poll_timeout(). Replace copied code with a
call to the original. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index e6403b9549f1..b0f8264a1285 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -252,24 +252,11 @@ static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
 				  unsigned int cond_value,
 				  unsigned long sleep_us, u64 timeout_us)
 {
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
 	unsigned int val;
-	int ret;
 
-	for (;;) {
-		ret = regmap_read(map, addr, &val);
-		if (ret)
-			break;
-		if ((val & cond_mask) == cond_value)
-			break;
-		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
-			ret = regmap_read(map, addr, &val);
-			break;
-		}
-		if (sleep_us)
-			usleep_range((sleep_us >> 2) + 1, sleep_us);
-	}
-	return ret ?: (((val & cond_mask) == cond_value) ? 0 : -ETIMEDOUT);
+	return regmap_read_poll_timeout(map, addr, val,
+					(val & cond_mask) == cond_value,
+					sleep_us, timeout_us);
 }
 
 static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
-- 
2.20.1

