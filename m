Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D13DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E862080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EV6rhLEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E862080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeJaCzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:55:04 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54875 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbeJaCzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:55:04 -0400
Received: by mail-qt1-f202.google.com with SMTP id 31-v6so14089822qta.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lN9YFitiwSnfZGf0b4XkVoqbBW9W2gqEsy/+ywXQewI=;
        b=EV6rhLEx9TOLwJ/GdA/TBguZNQCIS6yj7AOf779DcECIDSMGFEvje3l95UR3huy7nQ
         nr+ItaEYaCs9zPSDZP5EyLUTTtOdXGB06T/nF7Ay6JsD+koDmuzC0EbjvFvgRihJTWbI
         Xo/0TxOsBFB2P3wVAiZXfEFmb2y+Ns43vH+o0CFbV5GffZ6/bYfmQQHjSK0rky72bQuY
         S7gpkrQ8WPbh/HGg6TCNRAqL+Lt4rxg72sIBN3ecndAwYNEVKWHQKl8gr7F5puNcvWGu
         tnKVjtZl/n9D5GatBoX+y/xyQalWtHcLVgBRSvd3CRiSPuHn3cq+zHlGsfXPaRuXky8Q
         erYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lN9YFitiwSnfZGf0b4XkVoqbBW9W2gqEsy/+ywXQewI=;
        b=Yc2BE2wmw5TDLJkcL1DpPPsD3tllSyA3u/EEiR53E6KX5U30PDzzsGqdbQJFn2SRcY
         LFtOXglWqvIABE8C8KhUs2PzM77B9bM7Ntla7jKx3n7f3YV2yROWH/dkiX5lS+Tdr96D
         XMnrlt703kmrQRZMwC34TS3FLqzn18ZDwMeQ37vV8pWeFclKazCHmbYD6aO95W9UClGZ
         1UuRfhcgh2JmcjEwG12YeyVVjEXlLizmO8X63NqVAYNhYbqvijpvEPAuR5wzX+0yznPq
         4Dpho6f73oyLfC1I24wvUdlwv8vmB8i2cq6/3JAwqsdncEve6VxwAacEoG3wczN9sJEt
         TUuw==
X-Gm-Message-State: AGRZ1gLHDbp8CuKrJXeG2KBokUjMXDXuv7Yrxjxhnmwzu1eYPCMw4v1h
        l8vUEmVQ8Q2DSXfgZVMK90kc6aKW7d43PxphhLlTRpU/dTD7hACSQJrFcCYwSvVfcLTmAJ/F3ns
        WnEo7C0jEIpgLo2sN6N0cQgCqd/sHGl9/EC1d7Q+9UpQS9XnLvxFUj23WfNsh6F7ndylX0L8vHP
        4=
X-Google-Smtp-Source: AJdET5d2q4zXx23nkPKeBmnbUNWufNOzJGke6iwt1kExPjvGOQXoIu5w5l4C3DVil6NObrB2BEiujAJdCTz9og==
X-Received: by 2002:ae9:f404:: with SMTP id y4mr8770362qkl.27.1540922434837;
 Tue, 30 Oct 2018 11:00:34 -0700 (PDT)
Date:   Tue, 30 Oct 2018 12:00:12 -0600
Message-Id: <20181030180012.232896-1-bmgordon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] proc: use ns_capable instead of capable for timerslack_ns
From:   Benjamin Gordon <bmgordon@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Gordon <bmgordon@google.com>,
        John Stultz <john.stultz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oren Laadan <orenl@cellrox.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Rom Lemarchand <romlem@android.com>,
        Todd Kjos <tkjos@google.com>, Colin Cross <ccross@android.com>,
        Nick Kralevich <nnk@google.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Elliott Hughes <enh@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
in its effective capability set, but the current check looks in the root
namespace instead of the process' user namespace.  Since a process is
allowed to do other activities controlled by CAP_SYS_NICE inside a
namespace, it should also be able to adjust timerslack_ns.

Signed-off-by: Benjamin Gordon <bmgordon@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Oren Laadan <orenl@cellrox.com>
Cc: Ruchi Kandoi <kandoiruchi@google.com>
Cc: Rom Lemarchand <romlem@android.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Colin Cross <ccross@android.com>
Cc: Nick Kralevich <nnk@google.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Elliott Hughes <enh@google.com>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Changes from v1:
  - Use the namespace of the target process instead of the file opener.
    Didn't carry over John Stultz' Acked-by since the changes aren't
    cosmetic.

 fs/proc/base.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c78d8da09b52c..bdc093ba81dd3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2385,10 +2385,13 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 		return -ESRCH;
 
 	if (p != current) {
-		if (!capable(CAP_SYS_NICE)) {
+		rcu_read_lock();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+			rcu_read_unlock();
 			count = -EPERM;
 			goto out;
 		}
+		rcu_read_unlock();
 
 		err = security_task_setscheduler(p);
 		if (err) {
@@ -2421,11 +2424,14 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
 		return -ESRCH;
 
 	if (p != current) {
-
-		if (!capable(CAP_SYS_NICE)) {
+		rcu_read_lock();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+			rcu_read_unlock();
 			err = -EPERM;
 			goto out;
 		}
+		rcu_read_unlock();
+
 		err = security_task_getscheduler(p);
 		if (err)
 			goto out;
-- 
2.19.1.568.g152ad8e336-goog

