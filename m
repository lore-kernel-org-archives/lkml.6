Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B7C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639BE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0vgPnLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639BE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGKV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:21:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36976 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:21:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so1538936pge.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aiu+6XztfPZTrAfY/hBXeeiKQGRSBMgrn4AYx0QFBW0=;
        b=b0vgPnLRp4i7Ph5Ddi/B8M70GWwzQUbwvHy2kTgdsre98Ip/kU2mhzbXjj1yFlw/iZ
         1/iZZ8kagoUyofZvqRW5O/SjVTjLZlP11RcMneYiJtqwJB39Y8qRICe1yLqR6FGK0ATK
         hcuaS/YS6zUL1KxPS4mAmuwEHoeCnpCk83vxqm5XOxePrsMbPHh2PsR0RSj5qotxUqkz
         Fz7VifxDLcEHFckQfjz06WhN3tOn9CuIAIh5eMopRnUosfJ+bfgIb2j3JvUwEycHu+h1
         aX9HhZPj1+EP7yATsa54RrIPaGvP5LUivRpdn1CxJPHkVZAnHHK0TmeOAGsGqimTR76E
         YaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aiu+6XztfPZTrAfY/hBXeeiKQGRSBMgrn4AYx0QFBW0=;
        b=cZ1NS4ZtVxyccjLRQ/zb2q+s2+vHQC95mID6DEZW1f+1cKsnDo0/DBbQrnely8r7C4
         UTORqYEXPcESjxjCTlGK7fRYykbwbOmUhJxYEIZAdBiGcxu75WV/cfnjgNfSsndPDLep
         DEFlsMgNp1N2W9bVJfNFyLYxeHzPGh5w4WYkB6jCkxGtXk4Q7nPmxO/rs7w1EAoRrbSw
         BldpZV0+Ttc14GcF1iSd+60l4yx0K/UHA66E3SbBVZD3cJf7yDYz1BcvxuMAdunIufpW
         37gVR4NRutNF/fwy5cLfqAjB6UfRZ9ZB+Rlq9Lux2Z4yyY6TI/ms8yVfZ5t5/PZEB6Co
         hsfw==
X-Gm-Message-State: AA+aEWaMiDznTn6UkVUNMFS6ZAzKaVOuFNnFyf5y642cH3+fHXaYk+eK
        zzYZ/LM8rpxRCTi3p+qE2lc=
X-Google-Smtp-Source: AFSGD/VKarNQWfL+aMYaRQra1f60sz1spCe8QpabQorFD/MXyV6gW4bit+c2kkX2WRy3h7OXGvT+ig==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr1380609pge.437.1544178115457;
        Fri, 07 Dec 2018 02:21:55 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id a9sm2936408pgq.20.2018.12.07.02.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:21:55 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH v3 2/2] kobject: drop newline from msg string
Date:   Fri,  7 Dec 2018 05:21:49 -0500
Message-Id: <f03d23a34df36d55274c5cce7d4081d9017668c1.1544175417.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544175417.git.tsu.yubo@gmail.com>
References: <cover.1544175417.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a missing terminating newline in non-switch case
match, when msg == NULL.

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
Changes in v3:
Improve the commit log,requested by rafael.

Changes in v2:
According to Joe's suggestion,drop newline from msg

 lib/kobject_uevent.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index b7c088c902a2..1837765ebf01 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 	enum kobject_action action;
 	const char *action_args;
 	struct kobj_uevent_env *env;
-	const char *msg = NULL, *devpath;
+	const char *msg = NULL;
 	int r;

 	r = kobject_action_type(buf, count, &action, &action_args);
 	if (r) {
-		msg = "unknown uevent action string\n";
+		msg = "unknown uevent action string";
 		goto out;
 	}

@@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 	r = kobject_action_args(action_args,
 				count - (action_args - buf), &env);
 	if (r == -EINVAL) {
-		msg = "incorrect uevent action arguments\n";
+		msg = "incorrect uevent action arguments";
 		goto out;
 	}

@@ -223,8 +223,9 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 	kfree(env);
 out:
 	if (r) {
-		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		pr_warn("synth uevent: %s: %s",
+		char *devpath = kobject_get_path(kobj, GFP_KERNEL);
+
+		pr_warn("synth uevent: %s: %s\n",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
--
2.11.0

