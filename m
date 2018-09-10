Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC357C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F40920658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="dx8fef+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F40920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeIKAzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:55:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37531 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIKAzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:55:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so11007972pgo.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sBdJ9oYViXeZVkyZb9vjRimCOqGFkJZUAVyoAp38IlA=;
        b=dx8fef+b/pua3UaSNK05cTCINcCht2eSfodVHcxtrasMBnXWs8Jjz9rKHwTPUDqXeT
         B8baqPQOAxfFlm6Gltk1ndesmuE8msHK+ieqMgUdSlKMbsLDP507YY9N6rUzVTTMX/Se
         UXRgWkgpsbeJ2IulwLVnSnLU/3M6Lxc0DhEjnO/eCnrrLfMcMKZS8PU7Frcjh3qKaYO+
         oBbn/5zmC3ELyHl7Zj+2kAITJaha5OvwlP/W0aTNjs7qXX8j9DaylgM9QU80FWFEXZrI
         +XlanzAs9DBB6J9rCPb14atKBrB18WaQ8i6j2Qi6kc4pNRUd8rsLf36YreSJv/HUCH/2
         QRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sBdJ9oYViXeZVkyZb9vjRimCOqGFkJZUAVyoAp38IlA=;
        b=QiEY4qmN63tMkY/lWq6LkDZ372Agec9EVefMPWQevUdbjZ4cXLgFczV/pFHQ5TJSrl
         1R0lHiNtaaQr6DXqUMUtQYzu5poqp3YR6JCbjpoEaiuX6uq6SJLmu/uLJJOdWGkEdCJR
         p9WR9GgNDWmHp0gCru0hWOOsr+jLPJELhCS028lByGUBQwx14EftA/LCr7IUu7khYz48
         Hb5/ol/iRykLKvVg63NKb2fWJ1+nR6T1Oul/PL3+u3ChDDkKm2AO0PVwlWEtOoZAMQex
         oFtK71j7Jr92Dicm+8K9RqAJujcCAoZR9j3wbo9RvLQs0INNTZRzIkJC1RIyMbs7OUXk
         sHpw==
X-Gm-Message-State: APzg51Bpla0U9yCoNX2LBvWKi0AQpoRTV8WLnUTrsVcb5DSoI8bk0Vyk
        0L9DO7cgEHTMfNYtCu4Q/uDpXhe7IVlnPQ==
X-Google-Smtp-Source: ANB0VdY8cYQgm5jz9qIt2LyfT9BTsFS7HMi4OqEGJpWszBaYaUJPKvKqHJ1Td2C0utG03OOflpCKew==
X-Received: by 2002:a62:565c:: with SMTP id k89-v6mr25442861pfb.212.1536609561286;
        Mon, 10 Sep 2018 12:59:21 -0700 (PDT)
Received: from WorkZone.localdomain ([60.51.52.116])
        by smtp.gmail.com with ESMTPSA id l3-v6sm20062604pff.8.2018.09.10.12.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:59:20 -0700 (PDT)
From:   Fieah Lim <kw@fieahl.im>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:CPUIDLE DRIVERS)
Cc:     Fieah Lim <kw@fieahl.im>
Subject: [PATCH v2] cpuidle: Remove unnecessary wrapper cpuidle_get_last_residency()
Date:   Tue, 11 Sep 2018 03:59:01 +0800
Message-Id: <20180910195901.15200-1-kw@fieahl.im>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuidle_get_last_residency() is just a wrapper for retrieves
device's last_residency, it's also weirdly the only
wrapper function for accessing cpuidle_* struct member,
and my best guess is it could be a leftover from v2.x

Anyhow, since the only two users(ladder and menu governor)
can access dev->last_residency directly, and it's more intuitive,
let's just get rid of it.

This patch tidies up CPU idle driver a bit without functional changes.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
Changes from v1:
 - Rewrite changelog as Rafael J. Wysocki suggested
---
 drivers/cpuidle/governors/ladder.c |  2 +-
 drivers/cpuidle/governors/menu.c   |  2 +-
 include/linux/cpuidle.h            | 10 ----------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 704880a6612a..f0dddc66af26 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
+	last_residency = dev->last_residency - drv->states[last_idx].exit_latency;
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 1aef60d160eb..715520e339da 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -492,7 +492,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		measured_us = 9 * MAX_INTERESTING / 10;
 	} else {
 		/* measured value */
-		measured_us = cpuidle_get_last_residency(dev);
+		measured_us = dev->last_residency;
 
 		/* Deduct exit latency */
 		if (measured_us > 2 * target->exit_latency)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4325d6fdde9b..d262f620890e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -99,16 +99,6 @@ struct cpuidle_device {
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
-/**
- * cpuidle_get_last_residency - retrieves the last state's residency time
- * @dev: the target CPU
- */
-static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
-{
-	return dev->last_residency;
-}
-
-
 /****************************
  * CPUIDLE DRIVER INTERFACE *
  ****************************/
-- 
2.18.0

