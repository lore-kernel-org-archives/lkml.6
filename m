Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37186C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44C220834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oofBVPX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44C220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHaCj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45231 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id u83-v6so8525703lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cb0i0yY79UsjTmqBkl+c30qpYH2cRVxQD+Siu+u/UGU=;
        b=oofBVPX94tXFXnYMvyYFf7jRBWL4Oh9SXAh5ohGLQulhz0Iwp6Wom8s4b/O849WEJ+
         o/Z6On7RhZ94WDUfn/kPwNFpLId+LRi6T5oLveYabwKWzYsWvcFZbG2k3Vrq9JkT4kGV
         WnH5tB2m1pTzFTjl8G5igIjJUi4hKb+5sS7ihrNQJEOwvdh1oFY9Nc7H6g3aeaFm1/cK
         yAwK5zFwle/g8XKhA7aHeOmbbRDB90w+bgICDkB3/xAD48R29OsxKy7nBoULgUmcggxy
         JPr4yX7Jbv7ECJF87DfbiSQVxcLpdQxDhNSYL1P62IL4uxBYUk5I4n3ltCF+Gt074wDt
         tnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cb0i0yY79UsjTmqBkl+c30qpYH2cRVxQD+Siu+u/UGU=;
        b=NT2h0111rUPZI8YKRvxvYc7Q6X7rTEsxwsPsKirVNzyKixH4LJo1+aSV4o8u3XgfDz
         c/r6GHyzYFRISgiJ4tzSvHrngzyvQNWhXeY4WwIRFAWqepTaBEsmzTPnGrGatz7zlAzo
         DXKt7ZwJwI6zzPyqtVc3soIiq5huRhbIokqyg44kmzDtWmNcRkCrlVD52V3uaTTMiucc
         joWRATAK8M1do+xw4wEl9rLJc8sYEYiUKwXdolKSPvwX5CEsQ6xS9NGKIxUdlt/qT2IV
         YHV6X/1W6vJfrG15NxwnID3m33MnfbRYAaqURYLOloe7sO/GwmtXSb2vmlSlrizU6Uii
         62Mg==
X-Gm-Message-State: APzg51A/ANJbUcVmo0cf30Dch/3hdEzSVr1MTLhlzKrd03WaaTcNDhIo
        ZjvTutoBIc9Hhonlm5WQi3KkQoILdyE=
X-Google-Smtp-Source: ANB0VdZgJQALPXDVQezNnNbu4DxXaTdWDLZt+l/NUfv6KrdQft/34z6gvM0UlDcQ15vx4qm3H86ffA==
X-Received: by 2002:a2e:5f4f:: with SMTP id t76-v6mr9056846ljb.140.1535668531001;
        Thu, 30 Aug 2018 15:35:31 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:30 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 07/23] seccomp: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:13 +0300
Message-Id: <20180830223429.30051-8-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index fd023ac24e10..5a2a9af4663e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -195,7 +195,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			READ_ONCE(current->seccomp.filter);
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
-	if (unlikely(WARN_ON(f == NULL)))
+	if (WARN_ON(f == NULL))
 		return SECCOMP_RET_KILL_PROCESS;
 
 	if (!sd) {
@@ -297,7 +297,7 @@ static inline pid_t seccomp_can_sync_threads(void)
 		/* Return the first thread that cannot be synchronized. */
 		failed = task_pid_vnr(thread);
 		/* If the pid cannot be resolved, then return -ESRCH */
-		if (unlikely(WARN_ON(failed == 0)))
+		if (WARN_ON(failed == 0))
 			failed = -ESRCH;
 		return failed;
 	}
-- 
2.17.1

