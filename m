Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E76F81838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5CD21569
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maitDEE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5CD21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeIMVWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:22:32 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54086 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIMVWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:22:32 -0400
Received: by mail-qk1-f202.google.com with SMTP id f64-v6so5196354qkb.20
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zGk//fqE+XT9HqJjdclLb8ahsHMYDLzUz4mSW+Kg4lk=;
        b=maitDEE90y9ZpFHAvvMn/x1SytBhaKJE5hwOmHROvuWoDrF91leA+Kts1l/tZa12op
         d/MzxPKgEESRfOrY50abSzYIK3S5cTfTnhzR2s+GuTVelh1kcvk18rM5GpefuQjW0FXX
         Z0RfOarFMB9GUUKEhc9tSHwAufHMcC/eQ3RGdQ6eQSvKjVvcV3uDb584H6219Wzg/FUL
         wa/OmCWjcJwRUN0EB25QTl3HkXIEIcwsc3lweUzo+2BWVViWEd1t8auGzkku2Wn5BJ1p
         bGMi6EcNhGZDNFhYPpQo4sP7+k0fL91y5VfIqiRDAHb1mKAuzFRVVrw+SOU5ohgEKqRz
         9atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zGk//fqE+XT9HqJjdclLb8ahsHMYDLzUz4mSW+Kg4lk=;
        b=DM8qaPqkaVxrBClU6jPoXJ//S7DsMXYSE+7NotBQnw4/XsIx5WuwolonJeg5R2hRFn
         wGu85wrDlCArZssDNVlrAmJMVKavS0ocOJ1Np9PNZWD5YWPyr25CTFjzZrsUkzHw56Wq
         k6v7r0Kr4R5/HNWsf1X9gXiZLNaVJ4/sWwvxqgr2JdO7359Fz4QXmewxt4LYyly4qeTn
         UFeBh9XWpCwfSI1TAcG22ByYezeNQfomXtyVktD08X2dtidOvERk/KVgczuoplDB4yjb
         eAdLvu4/Pbz5W8H/eXIosLK75GLCz8bbKr3E1sPL4HYEXXbLWmz6DNHyuonoErM6D8Eb
         efOQ==
X-Gm-Message-State: APzg51C+Wsxr55oJsko0/9dE7vR7FNPz5Z1vwcOJ7HZUjXeDxPfVbCcZ
        EsseF8RMsXSCUFRVqUpIras+5YTqIw==
X-Google-Smtp-Source: ANB0VdZDd8To0hItpH5LDcNvjkrYhQCXXILiiZ9or+yhHtpA4lvAi3gqmEP3EooKoNW00xOGwcXn5FBfog==
X-Received: by 2002:a0c:bd26:: with SMTP id m38-v6mr2462679qvg.53.1536855140660;
 Thu, 13 Sep 2018 09:12:20 -0700 (PDT)
Date:   Thu, 13 Sep 2018 18:12:09 +0200
Message-Id: <20180913161209.63693-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] apparmor: don't try to replace stale label in ptrace access check
From:   Jann Horn <jannh@google.com>
To:     John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a comment above begin_current_label_crit_section() explains,
begin_current_label_crit_section() must run in sleepable context because
when label_is_stale() is true, aa_replace_current_label() runs, which uses
prepare_creds(), which can sleep.
Until now, the ptrace access check (which runs with a task lock held)
violated this rule.

Also add a might_sleep() assertion to begin_current_label_crit_section(),
because asserts are less likely to be ignored than comments.

Signed-off-by: Jann Horn <jannh@google.com>
---
I have tested that just the might_sleep() yells a lot, and adding the
rest of the patch stops the yelling.

 security/apparmor/include/cred.h | 2 ++
 security/apparmor/lsm.c          | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index e287b7d0d4be..265ae6641a06 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -151,6 +151,8 @@ static inline struct aa_label *begin_current_label_crit_section(void)
 {
 	struct aa_label *label = aa_current_raw_label();
 
+	might_sleep();
+
 	if (label_is_stale(label)) {
 		label = aa_get_newest_label(label);
 		if (aa_replace_current_label(label) == 0)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..e3f40c20b9b4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -114,13 +114,13 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
 	struct aa_label *tracer, *tracee;
 	int error;
 
-	tracer = begin_current_label_crit_section();
+	tracer = __begin_current_label_crit_section();
 	tracee = aa_get_task_label(child);
 	error = aa_may_ptrace(tracer, tracee,
 			(mode & PTRACE_MODE_READ) ? AA_PTRACE_READ
 						  : AA_PTRACE_TRACE);
 	aa_put_label(tracee);
-	end_current_label_crit_section(tracer);
+	__end_current_label_crit_section(tracer);
 
 	return error;
 }
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

