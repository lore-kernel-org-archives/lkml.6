Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B0C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A702083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4DGJxx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A702083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeKFMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:04:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeKFMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:04:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so5424671pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 18:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GLAq8GY8CZsb5fB6RWVYwTg7W6cIpwgOEdXW0XhH0p8=;
        b=N4DGJxx/x+lzANEnLwpIMq1LOxYA7LAVeSHtlNIJWz8608dyTbfg4SRrcyCuqs0ONk
         ntlHr2YTisMJyZe3LbMCQ5qP1qzkNlD6uyEkBMT6rykPo2lsb7PEhvSou2Q7HGiGVoap
         /rCa3oDsdIKh4+qZ97tlhfhb+MSKMCFsT8l7CphM+5og1I2bdeLWkbyVRzJ9am9N/ap0
         WUlheUL2uh8OSqvUL5GKqnCu+I+ZTMFh9JbdwB/aRx5z5iIPBXbIojcnTjIysq6/9B+S
         zwI79tWcbRHswX+S64tAQLC3nyP1i+bGQcUJXFgjx+S+h6dpMC19BiMHvrhhXAlI6BPA
         i+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GLAq8GY8CZsb5fB6RWVYwTg7W6cIpwgOEdXW0XhH0p8=;
        b=jvpzdAclh+6Q0ycQqPeKZoe1ZJr1VIjvBMF5vAfFJmpeppXssPB2o4SgRxrdQ/STOo
         AEWDFo42/P9Ta9s2sjOZqqvvSnRfpBuFmA23Jb8SZ7sgFtRAkDEaxVhk39GFFiCI3uAE
         9uP6PaEXA9F0AlV6XdO6+PaeWxSTS7iMs5hQrqMQoWr33LeMawjgpSd+DcyIqMeskTrG
         KlmyAcbCV2seoT+RIsSyZmvDq9CAyAqjHWLZdhirhBYH7gY733sH84FI9GT/GhDu7FMZ
         WrXPWHfE3FKNhA9yXFAmACs9Lvjrj9BhQXEH5EWohn/jj3pBdYiSJmpfwB+C0dJtC/0P
         Lmqw==
X-Gm-Message-State: AGRZ1gIt6UIp3HAvxz3X1ag7WIf0ZOSQFC8sUImQSbeo9/yVE4GLAUBO
        M8HDpndduW1gwF6mYOrOOYM=
X-Google-Smtp-Source: AJdET5frKk02mG+cfy18NAejik87h9VXUdPIrrmws3G3c6UYZbh+vHX3B/MtigXZ1CHsHrKJnN+f1w==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr24645210plb.241.1541472119788;
        Mon, 05 Nov 2018 18:41:59 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id f13-v6sm50520506pfa.109.2018.11.05.18.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 18:41:59 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Bo YU <tsu.yubo@gmail.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: [PATCH v2] kobject: to use pr_warn replace KERN_WARNING
Date:   Mon,  5 Nov 2018 21:41:43 -0500
Message-Id: <1541472103-6212-1-git-send-email-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning form checkpatch, use pr_warn replace KERN_WARNING

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
changes in v2:
According to Joe's suggestion,drop newline from msg, otherwise
it can be unterminated with newline.
---
 lib/kobject_uevent.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 63d0816ab23b..1837765ebf01 100644
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
-		printk(KERN_WARNING "synth uevent: %s: %s",
+		char *devpath = kobject_get_path(kobj, GFP_KERNEL);
+
+		pr_warn("synth uevent: %s: %s\n",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
-- 
2.11.0

