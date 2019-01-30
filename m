Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B92C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981C82087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cID0mH/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbfA3Q3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:29:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42971 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfA3Q3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:29:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so32386pga.9;
        Wed, 30 Jan 2019 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6ARi3fgM5FB7ByuhHtUfvHSlCseInHPzRPNVTDoxzuU=;
        b=cID0mH/YM9pv83OthwbAk/9u4x3LrFawe+AKDYLQjxQHIKRXSG3oTAc2G4DwlYk1MS
         c/WXmT6AfqeMb2r1Q3MaiNqJbr6Jx+BLwjViFEdwc08mrj2UkETR3Ck7mZLzAo63uaml
         uv9N7nUIgmUoREydC/tMmUq8GI6DF7EKU4BdyRvD1zhl5V17B0uCgLSLAx6H2jLlpFDY
         Kl32j8IzNu+qgrEJr1zQjpbdeNDzIXGw+H1Eid+2A9YkgjeQf4t7ngFRYLoPTniFQ2nz
         VP+reWLFpAh2/Hh1CXX5qG4ZTiqJml3uXbQX0ZbMVlCz5Hl6kDyLe7CjVG7N4ouQSnlc
         tm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ARi3fgM5FB7ByuhHtUfvHSlCseInHPzRPNVTDoxzuU=;
        b=NhbzPjhWaleFP5w8BBViRscZ1tPwx28/pQiYJsrdzxXP2jsG4JqgJUUWQFDUrbiFIv
         QZHHFN/YU+wf5INtidWleBea8vtbxJizatraBok9CfPG8s40jZwo2+SAGo36JI8kKP1v
         dxDeMk0jQ1gVjGHlLJMEtnYnKUwxgJ4NKdmbsXqZ44VrJAQVOShhCmJVwYB+vzcExa+S
         5a3UwTg+M63jXcwSyyzqLBku3KP91BXL+A9QSu2FHzKV+IXyJXK4/JKuRdeBSkwrfELP
         jUkHV6MSAqM7tq0QhFb0aDswwOgbnlO8VFeyypxOmvUHreqSEqCOPS8Ng67NTMAUdDmt
         E12Q==
X-Gm-Message-State: AJcUukfa5jS4Lv9XdXzXLHuKf/0sKntDgn67vR9Vlv2KyfPMG2a00527
        7ozkRN0zoFVUj/AXPtwgjCA=
X-Google-Smtp-Source: ALg8bN6GMsKlqIREzV8c2KY7Nk5ZxtD2EQ4KMB7ATl4F8BJUD1qUukZxunoQIxbTFcKP2w1i7HCvHQ==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr28789553pgo.264.1548865777005;
        Wed, 30 Jan 2019 08:29:37 -0800 (PST)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id u123sm3876421pfb.1.2019.01.30.08.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 08:29:36 -0800 (PST)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     rjw@rjwysocki.net
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: poll_state: Fix default time limit.
Date:   Wed, 30 Jan 2019 08:28:22 -0800
Message-Id: <1548865702-3524-1-git-send-email-dsmythies@telus.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default time is declared in units of microsecnds,
but is used as nano seconds, resulting in significant
accounting errors for idle state 0 time when all idle
states deeper than 0 are disabled.

Under these unusual conditions, we don't really care
about the poll time limit anyhow.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpuidle/poll_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index b17d153..23a1b27 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -21,7 +21,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
-		u64 limit = TICK_USEC;
+		u64 limit = TICK_NSEC;
 		int i;
 
 		for (i = 1; i < drv->state_count; i++) {
-- 
2.7.4

