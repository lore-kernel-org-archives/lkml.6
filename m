Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE28520850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBypAcq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfAHDLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:11:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32919 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfAHDLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:11:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so2832242eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1qWC+eVN1k4ler/EqrFbu9Pj4IAc3px2CReajRy9As=;
        b=GBypAcq9ZSVM0kxOjOVHgRQb6BkiIWUIy6Wv6up2DCusRWzVMy2tVauhpd+QVBav90
         OzkaR7GLGLk/EcV0kxFR8+zCpQTXGlLdIKrVgPdouhK7M6r06yQar+W8pFGlRXpXn/FN
         hEIouBL1hLcnoqOApVHL+ET2x31apOh6v5tYOYpWFGqOUTtKxTV/dG7vBd+quPUe3Rv3
         1JNJvd4nTIfWPnw+z/PUwFHwABeFaAuhyT96yHtx1upCyknQWpCvYKEEENpmiFYSfDk8
         DJLxzV3HAqLYdZlwXO4UzYLSMb8vapgovgps5tdKrXq6cq9LMHazBZy82handoKa/Q6L
         NUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1qWC+eVN1k4ler/EqrFbu9Pj4IAc3px2CReajRy9As=;
        b=AcpQBX20pKqO9wN5l9tvagkCOUNLzdHxJL1Mu4qLMqzbbN4gnPmvT0xqjc5fe4ns+f
         N/sp8vcux/LYXWEoePut8aGLoSOaw9UUSX7po6Mm4s23onppa3vLd/jJjhkRZuw9r0xW
         BQZyJmQ4NUbDtUEX0OFeRkPwUEZVxfLRctWdaI7Zw2XckfISgQWZUVNO9XVgQQTjufSK
         SD2VA5phu9aRSREnFd7X7Oi6vbfV8pg5U1MjMsqPXt7xzGEaxloJzIR5e/kRf8ok1pyq
         6rDPIs05nsJR+2xx85959eAjUcNB9fvFfO0jHJJXzC29dIlpumtSdlw3rep8UsqrrPxA
         FeLA==
X-Gm-Message-State: AJcUukcRAAU/zqQZ7A7AaHVMJAXzHqYF0mRPt3xjMNoiUDsLo5t2xkN4
        KlnOMBkER32dxWNu71gBpMo=
X-Google-Smtp-Source: ALg8bN6RcpFpIyRphFlw0n/uU3WhwDa+i/407dygFNjwNRQXOLAeFr2B2xSbeNJKAtsnXSfPKUlvJA==
X-Received: by 2002:aa7:c352:: with SMTP id j18mr323119edr.295.1546917102526;
        Mon, 07 Jan 2019 19:11:42 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id m14sm39303015edc.27.2019.01.07.19.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:11:42 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH v4 2/2] kobject: drop newline from msg string
Date:   Mon,  7 Jan 2019 22:11:35 -0500
Message-Id: <2ba5177197f8b40e399867ea1f1aee2920c3cb49.1546915794.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1546915794.git.tsu.yubo@gmail.com>
References: <cover.1546915794.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a missing terminating newline in non-switch case
match,when msg == NULL

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
Changes in V4:
Recovery  originly declaration, requested by Greg.

Changes in V3:
Improve the commit log, requested by rafael.

Changes in V2:
According to Joe's suggestion, drop newline from msg string
---
 lib/kobject_uevent.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 499dfcdafcb0..118226a02707 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -200,7 +200,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 
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
 
@@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		pr_warn("synth uevent: %s: %s",
+		pr_warn("synth uevent: %s: %s\n",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
-- 
2.11.0

