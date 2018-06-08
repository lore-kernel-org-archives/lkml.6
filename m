Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J0YzMoz5GlvYZAAAmS7hNA
	; Fri, 08 Jun 2018 21:47:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A5BDC607E4; Fri,  8 Jun 2018 21:47:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cK62uaBt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F8C0601B4;
	Fri,  8 Jun 2018 21:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F8C0601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeFHVry (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:47:54 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:39976 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbeFHVrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:47:52 -0400
Received: by mail-it0-f74.google.com with SMTP id r7-v6so2934570ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=G9MTq4awSsB86JSx1LFZR7GxenXD68YGNE1DhM/fISA=;
        b=cK62uaBtT1vZF/Bd7NQMhorM3o6FGHrUGeiLblZzQj/5cMDmyrgSt0xj6m+noppRkS
         IQJgR0uu6ttJRhooZcvNBt2MEinZ0UBLcxyl6GDq5De3Jw+MXMqfQjbScROoRvl9tWZx
         tyGoVCX1y9Wj74TLBr44uvEsn9YAdRp6RMhdXqBgEnX0JT+hKF+trkBUifp7+bVW4noc
         7je28MODtjFwdOHT1gmrLEMmmTzFAnQ1F1zHFn8pZFGxB5N2slTsvWPaQDWXjEh+EBYD
         UOb6ZlyLd+HhadD7JtNlawhO3QPSMUDC81d2tUOhBlcjWvhzXWRN34V4YLJZwsCE3zOJ
         qqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=G9MTq4awSsB86JSx1LFZR7GxenXD68YGNE1DhM/fISA=;
        b=QaYBH/cg5KVXfQyua8gmPhay9981zD1ih2N4CeBTv/P9uYHMMdHx8FmbhSrel0pQT4
         0YcM3SJNDTKWTvHNF9OAKqWcix2chqghya9KsvzUgSWThfb+CJft5iL5Z+fhTevEQEUe
         WDqfn16sAX1GmgM5Fy07vGN5yH9O8rt+w25j/2HfzvScYivQtSXanOcMyqVBXMghHHBv
         uy5X43hDppTtfBoKW4jULHGDeWNNijtn6VEGXLt0mca0mTmLuOiieozXyh1QOvuL7QP5
         s9cZ6K7WKLcpwIfmuJJb1ZNRckpYy/v+49jubZ2Fo+fIEgstmZ1boCjxEyoBgiUTf87V
         Mn5w==
X-Gm-Message-State: APt69E1K9zha0t/ZvxaAe7fBGxh/cN6YSySlOaG8ksbDuG6TeyCzQp1P
        S6yNwWmNLS+KyCF+XkfXwJHJx0Ljo2gO
X-Google-Smtp-Source: ADUXVKKTAVv16dNs7F0rU4c9BX6vApkkxnBKk6tqpW+Ug3chMSww/7O2sNnCCJ9EbOViELEjrihzyv+pRiiR
MIME-Version: 1.0
X-Received: by 2002:a24:568a:: with SMTP id o132-v6mr3800793itb.5.1528494471746;
 Fri, 08 Jun 2018 14:47:51 -0700 (PDT)
Date: Fri,  8 Jun 2018 14:47:46 -0700
Message-Id: <20180608214746.136554-1-gthelen@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH] trace: fix SKIP_STACK_VALIDATION=1 build
From: Greg Thelen <gthelen@google.com>
To: Andi Kleen <andi@firstfloor.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
SKIP_STACK_VALIDATION=1 fail.
Example output:
  /bin/sh: init/.tmp_main.o: Permission denied

commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
added a mismatched endif.  This causes cmd_objtool to get mistakenly
set.

Relocate endif to balance the newly added -record-mcount check.

Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 34d9e9ce97c2..e7889f486ca1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -239,6 +239,7 @@ cmd_record_mcount =						\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
 	fi;
+endif # -record-mcount
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
@@ -263,7 +264,6 @@ ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
 endif
-endif
 
 
 ifdef CONFIG_MODVERSIONS
-- 
2.18.0.rc1.242.g61856ae69a-goog
