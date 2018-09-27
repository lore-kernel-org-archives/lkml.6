Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8256ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7056921571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="PQVjE0K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7056921571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeI0VaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:30:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35641 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeI0VaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:30:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so2147957pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5SJku3WcDtMpjnS0yXcbc9iM4AoahPeyBHdtmmQOzZY=;
        b=PQVjE0K7zokPLF7dhzi5BnwFXoh4Lt9wHjDuBTkr9j2sx0feg6KIe7nnbsDZkcXj21
         DBH610w5XIBCiRzWq8Tte4NREpxeyczILxyEPx96VdkxwekVeDGycylwG5qXfSCXkYUg
         +6XmV8SizoXMisaEFUW6mgh+9Wzd4Ffwkcayq8BszlokTtIH9tGy+/yziz8d1MCYwOwF
         1DIQ9a7L9Fg80+iVPqke6VQffvZae8Zh8Iw3TdAZ9VG5feWMuZBPfgKHZTeC9Eupgb4H
         xoZTjJsvqGkSmsEE9Q4cY6NE/OPh4Lha8VC+ufxUpkQ7kSmIeMQ+WVgk+vJQW0GQn2Q0
         E7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5SJku3WcDtMpjnS0yXcbc9iM4AoahPeyBHdtmmQOzZY=;
        b=udnhCFgt/ep/U/8l1wnCtrv80IUAmg38t/y8H22EEQ0bJXU8TBb609OVc7X+Sq9fSf
         11Ag6/xu+uac/gL49/0gBne6z4aQ4ooGcbzxazwyeo9lr9vQOYimBBKs/q7YO1FhqU0n
         BUb+eCP4uK+lp+CviWMBwQYeY6stKxqGmSXuSzYNmAp9AdKloRytZVNmr/umvNEOTKsr
         Ks2FIF06gxorjxejKlWcKUFUkQ77mqLqpDQDrbWMcGK2PB2y99EmcZl85ybh3edE3Bgi
         lovMBZfRA+d+7ErybVp/IMrMRi8D7rnGBDtsJ6AEdvVnqzGteF+KL2StyshoG5h3hVtU
         S1Ag==
X-Gm-Message-State: ABuFfojS9lxVAQXyT8wkXi9xEbmG1TLeT4Yn3D4zZzqxyW9K8WBGMche
        rNAO+q+9aBmORkQglglorh+pvQ==
X-Google-Smtp-Source: ACcGV61aLeOgzUclpCR9hmQjuj/BVtQOHdFkgvG81skl4CtF4Q4eR2v/p50Av8FnqN7KtRWSBYQYmQ==
X-Received: by 2002:a63:34c7:: with SMTP id b190-v6mr10612274pga.184.1538061099787;
        Thu, 27 Sep 2018 08:11:39 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id y19-v6sm5429610pff.14.2018.09.27.08.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:11:38 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v7 2/6] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
Date:   Thu, 27 Sep 2018 09:11:15 -0600
Message-Id: <20180927151119.9989-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927151119.9989-1-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we'll use this same mnemonic to get a listener for the
nth filter, so we need it available outside of CHECKPOINT_RESTORE in the
USER_NOTIFICATION case as well.

v2: new in v2
v3: no changes
v4: no changes
v5: switch to CHECKPOINT_RESTORE || USER_NOTIFICATION to avoid warning when
    only CONFIG_SECCOMP_FILTER is enabled.
v7: drop USER_NOTIFICATION bits

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 kernel/seccomp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index fa6fe9756c80..44a31ac8373a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1158,7 +1158,7 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 	return do_seccomp(op, 0, uargs);
 }
 
-#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
+#if defined(CONFIG_SECCOMP_FILTER)
 static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 					     unsigned long filter_off)
 {
@@ -1205,6 +1205,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 	return filter;
 }
 
+#if defined(CONFIG_CHECKPOINT_RESTORE)
 long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 			void __user *data)
 {
@@ -1277,7 +1278,8 @@ long seccomp_get_metadata(struct task_struct *task,
 	__put_seccomp_filter(filter);
 	return ret;
 }
-#endif
+#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_SECCOMP_FILTER */
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.17.1

