Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D06ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9BA213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UypDWgKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9BA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJRGqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:46:31 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:39892 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:46:31 -0400
Received: by mail-io1-f74.google.com with SMTP id x5-v6so26158291ioa.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/WEG5alQV8deoJacRf98q8sRKe7r6vxygkJNMMDzrCQ=;
        b=UypDWgKrtCrxxK19zNS/Hj43+B1iYXERQmC8XAm9FI2JzIBeZ66sz2HQXEM4AC3kHt
         c7pfRdhPZn87D9FJO0eBk4JX3VXByBdc1BzbmtynhG9pK42/fS8vojPhiQUn4aeVXqGg
         7qB6bSXBSkNkX4y2bidm6hhiVKaVzFXpmID9BxIYMN1+rv15PkxSNTGvsa4sdbjudVym
         mLGr9lB5aD914QhgyI1hg3pPMoPpjKy+n4byQNO7HblCKPdFW9zcookOYHFgt5nxEtZR
         FVkcsee8CU3FVtyqEYve6FgKPvcrSD1GEqVp1Ap0vQUoPvU8gMmxGVZ0YSeTmxBeqGO8
         a+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/WEG5alQV8deoJacRf98q8sRKe7r6vxygkJNMMDzrCQ=;
        b=jZLWbUkPqbN7Yrxh9HQZF+HI7MOmNg8JWt7+5AZ8i65fr/weJZszVqrsKktC8qPiHJ
         OkaFS3QUr2iGyZQ8M/Kc06lDH1B7FIv+yW69jSClC6+09OHXBhGK7829CI+djNoS9nc0
         aYUB7D41rs/7X6toXBvO15K5T7a/Kyn+tGq2AQA47Z5Dosd7gJHRxD6Pj3uxyXe6TqMq
         UYfOjYejKMxVuSFY7KEnY/772Yt7+aR9vq0JDIJ1wlb0jW0NCi42sBOjTHzj7a1TS4Tn
         OXvndA092gio1RZ9lLDLtbwAt0tqfHWWdefCVder5Jn0gExJs5fj270Xwz1+jV6rNquV
         qAUw==
X-Gm-Message-State: ABuFfojcf2BpcxbGVkRdULL234gvmNFsVI3eipi1mzKvwdTrQYf2qVuu
        x4Z3pIgun/7yEENJrgaZPAthuQZl99sItbSNC15Ql0MVKvEeyh9tY5kGL9apfLPjXiKrmNY3zI9
        qN00ecyRrtFPphmqKSer+tGaeh4qTe7SOlsN76weCdXOe5sqJZviXXkXbhO7VJFnxugfPgX66HT
        c=
X-Google-Smtp-Source: ACcGV60fOI8tEG9NUJ1ZRH9C4lYfeTZ1NnEiYOTrt+rIOUuMFVYVq2EDrSabru9A5yaI0tyozLLK/TtpCwDtJA==
X-Received: by 2002:a24:5517:: with SMTP id e23-v6mr1102568itb.1.1539816518527;
 Wed, 17 Oct 2018 15:48:38 -0700 (PDT)
Date:   Wed, 17 Oct 2018 16:47:38 -0600
Message-Id: <20181017224738.193598-1-bmgordon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH] proc: use ns_capable instead of capable for timerslack_ns
From:   bmgordon@google.com
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Gordon <bmgordon@google.com>,
        John Stultz <john.stultz@linaro.org>,
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

From: Benjamin Gordon <bmgordon@google.com>

Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
in its effective capability set, but the current check looks in the root
namespace instead of the process' user namespace.  Since a process is
allowed to do other activities controlled by CAP_SYS_NICE inside a
namespace, it should also be able to adjust timerslack_ns.

Signed-off-by: Benjamin Gordon <bmgordon@google.com>
Cc: John Stultz <john.stultz@linaro.org>
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
 fs/proc/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7e9f07bf260d..4b50937dff80 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2356,7 +2356,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 		return -ESRCH;
 
 	if (p != current) {
-		if (!capable(CAP_SYS_NICE)) {
+		if (!ns_capable(file->f_cred->user_ns, CAP_SYS_NICE)) {
 			count = -EPERM;
 			goto out;
 		}
@@ -2393,7 +2393,7 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
 
 	if (p != current) {
 
-		if (!capable(CAP_SYS_NICE)) {
+		if (!ns_capable(seq_user_ns(m), CAP_SYS_NICE)) {
 			err = -EPERM;
 			goto out;
 		}
-- 
2.19.1.331.ge82ca0e54c-goog

