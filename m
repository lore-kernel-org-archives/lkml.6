Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13335C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B692246A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="JUmYgiMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B692246A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeFUWEz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:04:55 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35251 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933854AbeFUWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:04:46 -0400
Received: by mail-qk0-f194.google.com with SMTP id d130-v6so2681005qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PsmeKqHoGCAX8hCCZKW5Vb0YycjOyzLqBbvuDEprP7A=;
        b=JUmYgiMwrxsr4f5ASogusQ4Z8gE/eSkXqxdXni/GmJ4orVIbomiQGpzqUF0W5UWmLo
         hwChL4m/v/Hd/rrZnJVE569OAn7D9O7GRk8afpatO3GbYLzvAY1D9urie0MdGJOnPlpt
         /oj/GAZJgoECRotd1LHtWsvJ+j6fF0c5aSOQ7fwkA1yJFARtpZYuibC7GBM6ToKLDzCw
         Mw+srCzHYTJsKi/NZq6muhVRKD1qEJ1pu0Jb82eydiX67fv0jIKfSuCTIkoawgtw+B03
         IFMgsqY+/KHVeX7g+QuJ5gYhWviKwqb8VlFhlhnE9T9wnMPvZtLD4tY/ZdFYzU3ZUkL+
         pxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PsmeKqHoGCAX8hCCZKW5Vb0YycjOyzLqBbvuDEprP7A=;
        b=ietPHHnI1m47l0pz0fDiGHNKBV5SFivjFpLUWAM8ibc/sehEwx/6L2WNWFFDQk3vTl
         X6DMNM7jM6nGBjDVGM7TujeG3Gjd1LJowYfWvqLcz4U1vAbCHOu4TlJqo3YMuFAMJyM5
         jGO3NBFl6F+mxr4owP9/1B1ueHO9f6s2j0CfJimyvrGnytcmzaYYaMV3wS+tkMfEWwhx
         Vo5XUJ0f/Qx5msMdP2EmXFzcEn9sAACCYkaEBbK3LMEDSAbBMmzEyXwfJYoU6fB3GzPB
         0rfDlWduXJ7ivZ+5sRmaU536qFeDrj0aITemOTEIQb+MRx2vXyomLJaiHk7Ryhtj7h+M
         gbfA==
X-Gm-Message-State: APt69E35x80Xc4eIk6+xD3bwEF94DGTq288Pwl3gUNXhc3l7TfaA5r0q
        bT0+v573eh8iQOiIWHnQHzTCO4Khr9w=
X-Google-Smtp-Source: ADUXVKLwD5iJe6R4UwjQwkFxIqd+K4bbDChg7qsN0L/EWY2aJbDy82y0dylvBmkH0szP66D4LT0XhQ==
X-Received: by 2002:a37:15aa:: with SMTP id 42-v6mr3344405qkv.428.1529618685788;
        Thu, 21 Jun 2018 15:04:45 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id l73-v6sm6668473qkl.78.2018.06.21.15.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:04:44 -0700 (PDT)
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
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v4 2/4] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
Date:   Thu, 21 Jun 2018 16:04:14 -0600
Message-Id: <20180621220416.5412-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621220416.5412-1-tycho@tycho.ws>
References: <20180621220416.5412-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we'll use this same mnemonic to get a listener for the
nth filter, so we need it available outside of CHECKPOINT_RESTORE. This is
slightly looser than necessary, because it really could be
CHECKPOINT_RESTORE || USER_NOTIFICATION, but it's declared static and this
complicates the code less, so hopefully it's ok.

v2: new in v2
v3: no changes

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
index 24949478a812..bbc24938c51d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1184,7 +1184,7 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 	return do_seccomp(op, 0, uargs);
 }
 
-#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
+#if defined(CONFIG_SECCOMP_FILTER)
 static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 					     unsigned long filter_off)
 {
@@ -1231,6 +1231,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 	return filter;
 }
 
+#if defined(CONFIG_CHECKPOINT_RESTORE)
 long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 			void __user *data)
 {
@@ -1303,7 +1304,8 @@ long seccomp_get_metadata(struct task_struct *task,
 	__put_seccomp_filter(filter);
 	return ret;
 }
-#endif
+#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_SECCOMP_FILTER */
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.17.1

