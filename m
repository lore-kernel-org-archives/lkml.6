Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BEB204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="nADs2Ahg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BEB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeIFUFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:05:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36109 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbeIFUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:05:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id 93-v6so7590667qks.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4N5JhkRgF226RrUGxow0Fgcw8yOtLmkY4sHBc8BRVtk=;
        b=nADs2Ahgykbm8fyEmRiJotwzIAQZi+QChwZCu4xMAylwRb/wHc2ONy1o7ChNwPXD8A
         aV+SwlxMXgJe7v0F7Ef8fbva0LRC5XVUAodfvqRiybKhtdK54tMRUDHwi3zKLHuUAwPj
         vP2aYmyboyLA9tSDDVr9fR78bClWjObQJ0FzPWj/6PPFzWqwUvLBAns3n6ZfAS2EOrio
         lchYBTtdVbZRfShZSve7zblBsvlK+dnIf7gPRts4Kwspm2l3qj7oPI7FxFHJtsDRgfzx
         u5f3VRLm+PwIhLd4i8adBe0CPcAou5cUQxkhYeyWDBtrZyJbzNyf/H4/nB35Xfd4sZG8
         r28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4N5JhkRgF226RrUGxow0Fgcw8yOtLmkY4sHBc8BRVtk=;
        b=PhZX99EeLa1wk4W163gUS3xREwKqiqtNF85tUIPIL0H83/ipNfjd8adUMqUYwK328z
         3JQBrYZPb6NCwbnQyRF6KgB9gbE+QA2dU5x4veXhddxtyeNk5MefJKRzoJ5mS4Opuywf
         f1KcC0RrxIw1EwN7R9PshzFy3Xr7+TcX2/m0jB7T1WA+dj3Im7Un7/bQtPJJY82ZcRqX
         zSZ0mAeCs2OB8pJiPBSXvdxrE1T0QRUTmarkub2gGbX/9VZRduk8IWReIvT9u6pJTkTW
         DLVvWd6oH67VumoVsJw3C9K3bDS2fcUi1UMlZcNBHDDZU2aL/0+lQUAZbRQcMWtK33gx
         LelA==
X-Gm-Message-State: APzg51Db72Nb9Ui/UBY0AekMjIpwLh3VS5aBguRLTqj3XjrPdIcxsipE
        xHcyRyDbwSsmNvC7v4oB83Gaew==
X-Google-Smtp-Source: ANB0VdYINatPBTtZ1gIjwQRVkhR/tvbD7iH3B7dVZlwhWIdpPfHd5v3fxS2WrIMou8+RrFGdjhK1+w==
X-Received: by 2002:a37:6d0:: with SMTP id 199-v6mr2477137qkg.71.1536247779094;
        Thu, 06 Sep 2018 08:29:39 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3254507qtk.38.2018.09.06.08.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:29:38 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v6 2/5] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
Date:   Thu,  6 Sep 2018 09:28:56 -0600
Message-Id: <20180906152859.7810-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906152859.7810-1-tycho@tycho.ws>
References: <20180906152859.7810-1-tycho@tycho.ws>
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
 kernel/seccomp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index a09eb5c05f68..ed786655186d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1188,7 +1188,8 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 	return do_seccomp(op, 0, uargs);
 }
 
-#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
+#if defined(CONFIG_CHECKPOINT_RESTORE) || \
+	defined(CONFIG_SECCOMP_USER_NOTIFICATION)
 static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 					     unsigned long filter_off)
 {
@@ -1235,6 +1236,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 	return filter;
 }
 
+#if defined(CONFIG_CHECKPOINT_RESTORE)
 long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 			void __user *data)
 {
@@ -1307,7 +1309,8 @@ long seccomp_get_metadata(struct task_struct *task,
 	__put_seccomp_filter(filter);
 	return ret;
 }
-#endif
+#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_SECCOMP_FILTER */
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.17.1

