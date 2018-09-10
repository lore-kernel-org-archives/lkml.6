Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA8320866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="cs6iqBy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA8320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeIKCni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:43:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38147 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeIKCni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:43:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so9287516pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rZ/OKmh2EdrSEB5JUF2McdFFK7q1SMCf21VNiWROUfY=;
        b=cs6iqBy3EEC29HrzYfFu7m2lUOMMpd7xKn5tgdkc2y/GDdYoJhVRGid7tIWAbwLnme
         uDKYIrokqyTxeuMzTxm3KaWaXNQLiZCGzsAFxYAqIpSnQ5kC18Pi7dKgnp6BiccxAlKI
         fAlMk0N5gTWO9mRVYjiDSbX3JWMjgb5c4nUeb2CgAdqGu/Ccn1dv60/nK+qFsWwnpHNF
         hsRfLvHfocsnPhOnsxnJKkL2eoSNVoRcUam2kzm8Uw+4OEy0YdRqhA1k7fF5sJGpYsTS
         pi0wuJ2HFrEG3GqiE/v6agNFgrZ0DbknF6t/VCI6sX4divEuIzAfi0CduYDHpzmVXJhR
         YbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rZ/OKmh2EdrSEB5JUF2McdFFK7q1SMCf21VNiWROUfY=;
        b=InvStJqZsHNs3C65tIJ9B+1JX/0GpBLZGIQnJxLljcITpnuSokhYPu7JXqSeGApWrs
         YyF3GTwlO358gdEXtZ9uO6/t6n8jUXJetatnXJ8ngYGmVn6ug6AXTUnkpuH7P+B4MM4u
         pJWE+NOyK50SyZ6dubL0o2kFduzthhwxAWVcdi8Ylg28aGjePkgPUegNbRn39tk8XRT1
         TncSH6KJIB1TQ+WQK/B2ZD0tGi/CNdshpRi/3UOt/XwpeFwP4gz9iWekmiqCoigqDer7
         vlkL2pitvoEOd9gNHNWVONMokCKee0Z8s5ncWyXXVZ+qVP/Sfl5dNMRIFFxHu0l7+6Mu
         appQ==
X-Gm-Message-State: APzg51DhNBoKLPAEX4K0OaTo9JHqL3oH1nxK96uF80s5UGYYduat6HRB
        7eKGBfhuO8IRVSJ6ttm+1lv0gg==
X-Google-Smtp-Source: ANB0VdZtXHMUZ5HuNzD/jw4bO10g+4YXCbNAaIESvr0UIjO1GWj8edQPkqGGwhky4LdklDnkqyADZw==
X-Received: by 2002:a63:7f06:: with SMTP id a6-v6mr25035424pgd.296.1536616054622;
        Mon, 10 Sep 2018 14:47:34 -0700 (PDT)
Received: from WorkZone.localdomain ([60.51.52.116])
        by smtp.gmail.com with ESMTPSA id o21-v6sm24454323pfi.165.2018.09.10.14.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:47:33 -0700 (PDT)
From:   Fieah Lim <kw@fieahl.im>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:CPUIDLE DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Fieah Lim <kw@fieahl.im>
Subject: [PATCH v3] cpuidle: enter_state: Don't needlessly calculate diff time
Date:   Tue, 11 Sep 2018 05:47:25 +0800
Message-Id: <20180910214725.19525-1-kw@fieahl.im>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use ktime_us_delta() to calculate last residency and
state usage unconditionally, it makes no sense to do this calculation
when we fails to enter any idle state.
It can be optimize by moving the calculation after entered_state >= 0

While at it, merge those comment blocks into one and remove a
space between type casting of diff.

This patch has no functional changes.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
Changes from v1:
 - Rewrite changelog as Rafael J. Wysocki suggested
Changes from v2:
 - Minor adjustment
---
 drivers/cpuidle/cpuidle.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6df894d65d9e..40442c3631ce 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -247,17 +247,16 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
 
-	diff = ktime_us_delta(time_end, time_start);
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
-
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
 	} else {
-- 
2.18.0

