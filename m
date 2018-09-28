Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0656204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="D2r1jfuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0656204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeI1WLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:11:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32949 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeI1WLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:11:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so4781899pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GfFlAyQ73GQ0z1dAPtDMXujwpZSjnZdspLuCQZo6PKY=;
        b=D2r1jfuSUQvLPDRpKeUOFJUMc+Hu0V4AeEhAWpwJnAksvpXQPrj8v5zmWnh7tj5Zlg
         9+az9o7Dx5ySLDZNchXWVXJPcHNXIJ1GjMFdhQkNQUJiaQ7go95TCv8MkzcOZc9d9U8U
         Rh0q5nN+FOhvd+AMV4BDIQl+/c68hz+UOIcnqoBNvfrIZz5l4x8S+GLY5VVWeeBerFf0
         wmrdZS2sUYIeNyrSyNqv8B76GkWxY7DQdKvawGRBXXCdX0Wl3c2D2Iz2hQKKQJOTL2t4
         Q4jbHRGG/q63Ziw452754PReZrJI9qt0J0Bc7yjqdhZdhXMfmAUnc7PDryYHdO3BHizC
         8dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GfFlAyQ73GQ0z1dAPtDMXujwpZSjnZdspLuCQZo6PKY=;
        b=aOJgzktCeCh4zVg1xhj6vAcyH3ITFbwIfhh9UOAXM6TX8Jr3pvYVmnLMR+qI2u/n1H
         ULlrQH7cW+5wtZsQ2YhPEWehiiT612EHWmGVZXiuYCd+j1g6RY+V6Do5ieges8gwmk/y
         AJR5Oa+9fkZ/xqWwkQIbvgjMAkYdBEDySawKsizB7Us9IJmwUNlOo1HpfI3n0bajL021
         J2+LkV/o7Zvh4vxwvELCAzfafU038kar4OraZ3xdOAjgi78Gtwa/cno3d1AF3E8Ocsoo
         JvYsMqVgV3xtN5Zjo9xQFjMgNZ65vg8OCQwATc1voi2PtLJUwawaFstSpNFPlatWn1ub
         PT2Q==
X-Gm-Message-State: ABuFfohO54iVWTJtQh6xDZbMfiHRk8j0coU2NvM0gq3qR/BG4BgCwfoC
        QbH2BMcGuf+9EvWptnHIXu2UoQ==
X-Google-Smtp-Source: ACcGV61iMwUP9YL1FTYCeilC7OH9P4iZ694q56de6hvX4yXQHEkgfQclV/OjcUJuVV4VcSvMLlFWBQ==
X-Received: by 2002:a17:902:2804:: with SMTP id e4-v6mr16613082plb.327.1538149644573;
        Fri, 28 Sep 2018 08:47:24 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id c69-v6sm321532pfg.2.2018.09.28.08.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 08:47:23 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 2/3] seccomp: change return type of seccomp_get_filter to int
Date:   Fri, 28 Sep 2018 09:46:47 -0600
Message-Id: <20180928154648.6320-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928154648.6320-1-tycho@tycho.ws>
References: <20180928154648.6320-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jann pointed out in another thread, ptrace_requiest() returns an int, so
it makes sense for seccomp_get_filter() to return an int as well. The
return type of seccomp_get_filter() is bounded by the BPF_MAXINSNS check in
seccomp_prepare_filter(), so this conversion is safe.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
---
 include/linux/seccomp.h | 6 +++---
 kernel/seccomp.c        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index af972549a7b4..8429bdda947a 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -94,13 +94,13 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
 #endif /* CONFIG_SECCOMP_FILTER */
 
 #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
-extern long seccomp_get_filter(struct task_struct *task,
+extern int seccomp_get_filter(struct task_struct *task,
 			       unsigned long filter_off, void __user *data);
 extern int seccomp_get_metadata(struct task_struct *task,
 				unsigned long filter_off, void __user *data);
 #else
-static inline long seccomp_get_filter(struct task_struct *task,
-				      unsigned long n, void __user *data)
+static inline int seccomp_get_filter(struct task_struct *task,
+				     unsigned long n, void __user *data)
 {
 	return -EINVAL;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9f3721849747..ef80dd19f268 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1030,12 +1030,12 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 	return filter;
 }
 
-long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
-			void __user *data)
+int seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
+		       void __user *data)
 {
 	struct seccomp_filter *filter;
 	struct sock_fprog_kern *fprog;
-	long ret;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) ||
 	    current->seccomp.mode != SECCOMP_MODE_DISABLED) {
-- 
2.17.1

