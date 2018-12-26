Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE022C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB92214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ARu3GZjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeLZENt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 23:13:49 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34648 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLZENt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 23:13:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id A9BE1A98
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i6vBcaKgFRzO for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 22:13:47 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 81750A3E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:13:47 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id q23so18196781ior.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tb3/sD/iNxDOhyz6dlWBJct3pp9tkArv1Ug+ytgfJJw=;
        b=ARu3GZjPccefS2Trxx3s5rRn2HmriVip4Idb9oPklKrlao5rawWhaJpTE2ZWWGKc5V
         CTMY4nJtHeGxfklxVhNkTVQk28NrMGUfAkRzYYCzCiyzx4LNijYGCrn/8MzmyZ3jZiYB
         rsfkSlXu+TUkxKAg8AJI8QqzgVeDu4AGQtP08CCbi2bND7Yrhf8yqqztPBMT01TVX6ra
         TKvWgqz/pL19T+IK0mq4TfgBGfD//8+RquRAggSa6P2zLSguOirI6kkL48remOqnO3G7
         9+AoDZeL9hkK5h69o8BipLuoAONA2PBTe73AtbEug1wCoAwz7U1SUehDu4uS5q/YrRvp
         lCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tb3/sD/iNxDOhyz6dlWBJct3pp9tkArv1Ug+ytgfJJw=;
        b=I6pqzvH7+QlZECpCeeB08+fhvGUfttgOPDAJRIYaowJLfWwweTCNGdhHuJR8N8zMnf
         gFGpIKouNi4qVix53DjmzrThlkiNrCde4eImZDolIfs/l1ZQP+Nyu05SjUr8W7Ezuap0
         HujCpz9ptianDRYm0gtXRPGRVuC6u5LyFRP4yMqfKxHv6ouH0IOFW47hWGOkog2FpoYU
         /2/mYPe/n2oiWog0zEOw5cfL38dXeAPdd6iV4dq7PMqF0taHd8G9/xjmQcKk658YHrmU
         osfrZum1jvMJRa/yz2TNOp9RJXJR7nc7+iL1b/nnHkcv5kt9zHjhrwuFyF8d3R5F4+P8
         CE0Q==
X-Gm-Message-State: AJcUukfBQ9poj+tsIy6dWZMBrU2IZL9OaHGiCl4ftzXuxOiozAww2dNm
        yJn6Ia6RQgg98JySXzrvlWJ9V38gQrSAHJvW2SpyorsrhX/6eT50yje0oHhacKXMWZdl6CO+HVT
        4BMFCz1x2ejo8m6jVvFfW67x7F3ow
X-Received: by 2002:a24:d60a:: with SMTP id o10mr11315500itg.162.1545797626865;
        Tue, 25 Dec 2018 20:13:46 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VmvhPkHGA5J7gVGMQaiLXk9fVkHg/7Pp6ypt8eGQZ5heVzFXEFqIGp/jFojlIaCVJul/laCg==
X-Received: by 2002:a24:d60a:: with SMTP id o10mr11315489itg.162.1545797626651;
        Tue, 25 Dec 2018 20:13:46 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id w186sm12070358itb.15.2018.12.25.20.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 20:13:45 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] time: fix a missing check of rtc_read_time
Date:   Tue, 25 Dec 2018 22:13:18 -0600
Message-Id: <20181226041319.73854-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rtc_read_time fails, we shouldn't use it read time. The fix returns
with its error code when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 kernel/time/alarmtimer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index fa5de5e8de61..19ba8a1633e0 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -293,7 +293,9 @@ static int alarmtimer_suspend(struct device *dev)
 
 	/* Setup an rtc timer to fire that far in the future */
 	rtc_timer_cancel(rtc, &rtctimer);
-	rtc_read_time(rtc, &tm);
+	ret = rtc_read_time(rtc, &tm);
+	if (ret < 0)
+		return ret;
 	now = rtc_tm_to_ktime(tm);
 	now = ktime_add(now, min);
 
-- 
2.17.2 (Apple Git-113)

