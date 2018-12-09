Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF4EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ED420837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="imt7hWLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ED420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLISYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:24:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55403 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeLISY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:24:28 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so14187842itg.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fw0iadnZoE1rpR9EWful/wBtVOwH2siiPuGARnKBIfY=;
        b=imt7hWLve5ATBy9O5xDxc/cCYO20emdusQniNm46uIkiGMRaLLKUTj1RYeJTCbyBeh
         xcZhNvg2VfL8yGtJzVN56Ku0Q7JwL/5PShXC7Nyp0tb2gUjnSAo70eas73+YTPn+xgAK
         FzX0LGf3hYI8PxoMOBhg1We0LZh7UXnTIAcVN6rUlK+lfPZnbsa0nZQE6ir3FbeExsEP
         LrERMHblCB+zyCdulIJoujr0UCOIsPFfj/OF7RQIA7uQS17alqlBHsncGTq+xMB0m6Aa
         RDey2BrBIaZIchqSo65rUHWi2DSJzX+ijhlRmQcP0uj4J5l+5ZunZVoTHJS/J4bcCeRU
         1xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fw0iadnZoE1rpR9EWful/wBtVOwH2siiPuGARnKBIfY=;
        b=bMzrU5sNn+UUP2+dGUaa03Sm6Vl0LBR9Gbc4YuQ1hThYBZorJ/HBq88ieMCoUHkMlz
         jcpq+kT0q/Oj+3Pp/vqZUmEvZG8p3+OrNk886876sS2C93mq3hzfimfloXJc3rkmQ0t2
         24YbmZgsIquC3VUQ8ikhVGTYZEkaGXv2LdDSrLCTgOsSbsGAVD53OCyy+5eECCeTJSVv
         l8BQcYpPIhGmiE03VCkFm9bZ3zIfkWl7B2QfHMfLHjlXMl7tzOYghaeLhWl/7KZVPL0d
         jKSsVJ4nl97uKk+v7baKHVXDtU0RBKkdBLoJOqq7Qf/1VhSbNves1gxiT1Uhig1gyfF/
         OntA==
X-Gm-Message-State: AA+aEWYcEEGYzBUvvOKvvDXEOh0vhafMtoGE6b8YmLdzhEhN4UL1OFmC
        ngyCKYtQG5887kln8qWKBrPOsA==
X-Google-Smtp-Source: AFSGD/XNCwcmYGtvGtD5pL97D0XYClSe9qMi4nQVrc845xxLSQvYu2T+WUq0jVUmvQJi9D3uJc9mgg==
X-Received: by 2002:a02:1509:: with SMTP id j9mr9331726jad.5.1544379866835;
        Sun, 09 Dec 2018 10:24:26 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id l25sm3270631ioj.68.2018.12.09.10.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:24:26 -0800 (PST)
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
Subject: [PATCH v10 2/4] seccomp: switch system call argument type to void *
Date:   Sun,  9 Dec 2018 11:24:12 -0700
Message-Id: <20181209182414.30862-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209182414.30862-1-tycho@tycho.ws>
References: <20181209182414.30862-1-tycho@tycho.ws>
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
Acked-by: Serge Hallyn <serge@hallyn.com>
CC: Christian Brauner <christian@brauner.io>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
v10: change type in include/linux/syscalls.h too to avoid compilation error
     in the !CONFIG_ARCH_HAS_SYSCALL_WRAPPER case
---
 include/linux/seccomp.h  | 2 +-
 include/linux/syscalls.h | 2 +-
 kernel/seccomp.c         | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2ac3d13a915b..a60694fb0f58 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -879,7 +879,7 @@ asmlinkage long sys_renameat2(int olddfd, const char __user *oldname,
 			      int newdfd, const char __user *newname,
 			      unsigned int flags);
 asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
-			    const char __user *uargs);
+			    void __user *uargs);
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
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

