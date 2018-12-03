Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46753206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="UCE81nHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46753206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeLCD2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:28:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38405 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeLCD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:28:47 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so9214083ioj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 19:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dQPDPGD9mX4mC2MQjq9uNpauIwSjlBqSmF3g+ICxLo=;
        b=UCE81nHn+tNOwlnvpSVmqm8N6HUyunDGiPhW7RbQ7vuJRjnrsNjpFE3UvepvPQpbLW
         BA5JkqRBmfEzP1MkKiFNQkvBcQXGXo4yCsu6X4+eaODijh0fnw+iagHbPtYgfDzt9/Fx
         r6NBYcqBAv2dSdLDQfmwmJbAdmIvF+55qA3fdsDEdjyiKO4phMFMkpwQXMTefPBJnlH6
         8Am7onc3jZVGMjax038/Mo6oTaR0q2J/2MjPVTWIugwaL2BGWfRUGzIpH0vwAdTmRM0e
         8iWOlO+y62QbI2vXxt4B7XfOhMPIUQe0mXfVQ5P7TFXr3MLFczPz6+nD9+eJS0zmdZJ0
         di7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dQPDPGD9mX4mC2MQjq9uNpauIwSjlBqSmF3g+ICxLo=;
        b=FF/6jYfO7yN9qEwPwSaqbMUdF+0cLgX43R+slPTQpS5N3xAss3h+RHPvWRgCi3IvQw
         SZsuo0HCyKaMh6SOuEpeegAothU+creSLh51ifloLyPEgGGgXyX9IdS3TbXFdfzr9Xiy
         UGxfI6CX088UZsU5AlN0qd089Rjd/2aB5Vbq21Or+u9Sdl+qavQOAWqOXGP9s6xvQt1O
         6VpEyz9eir3knRh0ZebwmekAaFQYrxLbYf6uPeOotGM+sTkF0nJzygkfNHAszpas6NnG
         iRqqbM2pizWduUYcl0VaAcawS8vK9Kh+B+0fIpI4Qe6s0E3tRsZyDQv0zCQjz0vOjiG+
         STcQ==
X-Gm-Message-State: AA+aEWZDeLR+tQ6lbOLLNbmG8YbhScs5O6RUgpT4wF4ngNYxZlS0PQcX
        KIkRCxqSgol/OHVJTMQcNjPrAA==
X-Google-Smtp-Source: AFSGD/WNHLmBScrlLzufuLDAh6IXEgMgRa0v8iq4MjvdzfQHSwwfprPjtcW6AOUXZSYWiHBqnHQ/cg==
X-Received: by 2002:a6b:ab85:: with SMTP id u127mr11350076ioe.143.1543807724110;
        Sun, 02 Dec 2018 19:28:44 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id n136sm3243529itb.35.2018.12.02.19.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 19:28:43 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v9 2/4] seccomp: switch system call argument type to void *
Date:   Sun,  2 Dec 2018 20:28:25 -0700
Message-Id: <20181203032827.27978-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203032827.27978-1-tycho@tycho.ws>
References: <20181203032827.27978-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The const qualifier causes problems for any code that wants to write to the
third argument of the seccomp syscall, as we will do in a future patch in
this series.

The third argument to the seccomp syscall is documented as void *, so
rather than just dropping the const, let's switch everything to use void *
as well.

I believe this is safe because of 1. the documentation above, 2. there's no
real type information exported about syscalls anywhere besides the man
pages.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian@brauner.io>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 include/linux/seccomp.h | 2 +-
 kernel/seccomp.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index e5320f6c8654..b5103c019cf4 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -43,7 +43,7 @@ extern void secure_computing_strict(int this_syscall);
 #endif
 
 extern long prctl_get_seccomp(void);
-extern long prctl_set_seccomp(unsigned long, char __user *);
+extern long prctl_set_seccomp(unsigned long, void __user *);
 
 static inline int seccomp_mode(struct seccomp *s)
 {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 96afc32e041d..393e029f778a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -924,7 +924,7 @@ static long seccomp_get_action_avail(const char __user *uaction)
 
 /* Common entry point for both prctl and syscall. */
 static long do_seccomp(unsigned int op, unsigned int flags,
-		       const char __user *uargs)
+		       void __user *uargs)
 {
 	switch (op) {
 	case SECCOMP_SET_MODE_STRICT:
@@ -944,7 +944,7 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 }
 
 SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
-			 const char __user *, uargs)
+			 void __user *, uargs)
 {
 	return do_seccomp(op, flags, uargs);
 }
@@ -956,10 +956,10 @@ SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
+long prctl_set_seccomp(unsigned long seccomp_mode, void __user *filter)
 {
 	unsigned int op;
-	char __user *uargs;
+	void __user *uargs;
 
 	switch (seccomp_mode) {
 	case SECCOMP_MODE_STRICT:
-- 
2.19.1

