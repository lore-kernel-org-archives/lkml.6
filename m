Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D30BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE732083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="qa5uF/vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE732083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeIGXhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:37:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40415 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeIGXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:37:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so7429802pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PEmKaa9wrp957I5Y93g81S/yFO6BjLKXLep4hfxrNzo=;
        b=qa5uF/vXUjdZB/1Z8l4hMRfVD6dvd19grKTmSXIv322QUFiNCXXEtKodOSD8gG4HVy
         WV1tp6SwdvUbVynORM1VKez89Bqh5yO6DRpiKHsIALcyuiVtAOqrQIy60HTD2bKpPVVJ
         HGLqivyfbum4pAspC0uon4X53I0VaaK2wzLflBPzIyH3G8Ez2/wihsvtTfPSwBtiRvOK
         SiJOjEBtQJfOUwIi2WfRhPOtK21yOvk+fVfrvNcZtl1FXlzoZQ+fYOUdUl+9Mc8wvUdW
         kkF5puk9ThSTEhRfrU1sGfXrUMTtBztx0MSrzRpq4KFA1vDwC9bKx/W8SZg86y4WN9XZ
         fbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PEmKaa9wrp957I5Y93g81S/yFO6BjLKXLep4hfxrNzo=;
        b=IAv39eeOd9rHw2d0pHIzZ8CeKXk8d7xiHz2UQBJSGciPCYr2KTSIlYzdo/iH1tAS8+
         tOwU8owD1L8O03dcv01zopUSOwIZUh8e5pbwmBReuBew1Q3+VLUvHXsQ6mczu9SkIzAo
         Umv0nLjUOrufq6PAJ1aMQopDvkcmXFAodbZCR/w/lzwgCB+dRBqbnMKFdMxyl6kH+0Md
         EMjyzSLgopDTsKrs/YlFT4CIEe+2otuTPy8VMHPvuXxTcPazA51y9KTDNs3eCh6xjRlS
         YiL2XYh4wkKaep4IP2LBtFEub6xiJ3PuZctXZc97Y6LyPYQtN2f48A07v1PFMxMZktH8
         lusQ==
X-Gm-Message-State: APzg51Bq2059bm4EGkeoh8e3Gb3ShTM0Gg7IXycpOXh1AGSMTmiF6L1c
        ol3GUV6rOPxxZz4tZ4twxl9jlQ==
X-Google-Smtp-Source: ANB0VdbsW5Fr6HNTqE+MB9a3W+TmIRhapW8xpRAzUcb0W7Z9qjgkUgxhuG6Q9XuI9DdieHx6t2fe2A==
X-Received: by 2002:a63:455d:: with SMTP id u29-v6mr9589085pgk.342.1536346527135;
        Fri, 07 Sep 2018 11:55:27 -0700 (PDT)
Received: from WorkZone.localdomain ([175.138.183.133])
        by smtp.googlemail.com with ESMTPSA id a90-v6sm19794249pfg.106.2018.09.07.11.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:55:26 -0700 (PDT)
From:   Fieah Lim <kw@fieahl.im>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:CPUIDLE DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Fieah Lim <kw@fieahl.im>
Subject: [PATCH] cpuidle: enter_state: Don't needlessly calculate diff time
Date:   Sat,  8 Sep 2018 02:54:48 +0800
Message-Id: <20180907185448.30987-1-kw@fieahl.im>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ktime_us_delta() is not that cheap on some platform,
and I think this is also the right thing to do.
While at it, fix some coding style as well.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
 drivers/cpuidle/cpuidle.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6df894d65d9e..5f6b2c9b6555 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
 
-	diff = ktime_us_delta(time_end, time_start);
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
+	dev->last_residency = 0;
 
 	if (entered_state >= 0) {
-		/* Update cpuidle counters */
-		/* This can be moved to within driver enter routine
+		/* Update cpuidle counters
+		 * This can be moved to within driver enter routine,
 		 * but that results in multiple copies of same code.
 		 */
+		diff = ktime_us_delta(time_end, time_start);
+		if (diff > INT_MAX)
+			diff = INT_MAX;
+
+		dev->last_residency = (int)diff;
 		dev->states_usage[entered_state].time += dev->last_residency;
 		dev->states_usage[entered_state].usage++;
-	} else {
-		dev->last_residency = 0;
 	}
 
 	return entered_state;
-- 
2.18.0

