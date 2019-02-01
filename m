Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE0820855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjGOEUoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfBAPpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:45:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40954 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbfBAPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:45:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so3389684plq.7;
        Fri, 01 Feb 2019 07:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=QjGOEUoGYiSgnlu0vJkEHikrYPT82PlKExVCAuxtb9sSIQ3afpMf2JK14NKVRdzzE7
         V/uqSZtpTTJ8PRNHJtoYnYvId7TLjGr+OBAtduZ2VUX4Q1wA+L+Xze08Q81x/8wi3Nwq
         KEgSiHcReKxJZdSRwsfYqYTOCvQvWAZpobx0r3OeNnqTMTyQXdOJRhhYyQnb2ozBWzQS
         kqPkQ7bKAFo0uYGqDqiaQYqYDzYuHjvYsbc3HDq9CmxJYupXmfoFWxyyGR7vTscsKUaY
         U4uvBED5mXiyHB+XQPHz/XKAmMZX8RBR+jCuHV5KXG8O0UUFVth9pKgA5AFkXCUwzzo3
         RnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=eXM1X0/dh1fk9OYy3EDAi8HLPYKOKvT5/MRjXc8k7vEWQzeINRfa7F0b+oi56b/sXY
         w834/n7XPq9e0g+YSbV4fbgpZOTqXP7LCXPjwzA3bOgFNnTg5NPss5og/dW2hT052zMm
         CLRIKJsmZsoQPXwaWmS46JKP1z/7dYxCYvXGqP8HjiPpynmwkG0g6k05M2Oai/aqzFdn
         X5B5CcJb9LWN4s3lH83Xc/psKGxaha4djSM1/F4xJHSXKwqRpNBrQnE6VVjMCUUdcWD5
         QM9IdAPcYQ594i54ocaus6TBQCcjE2ygc/nVdfPqURqi3UQ+H187ElgRg0wmy/lGsYaz
         KVDQ==
X-Gm-Message-State: AJcUukcPi3zwMgQcnpPT2BAdi++2cTMx8DT0c+t1Pruf7Y3HSj4h0XzR
        QPRKWYps0x70WThGvy+5xu3oprFZMVA=
X-Google-Smtp-Source: ALg8bN5YGn9jh50ZC/gzs1eWTbUphKjTALgnx020Wd3HVV1QYY3mVxsjX9zQq3eQMfbLXnXeB5ulrA==
X-Received: by 2002:a17:902:280b:: with SMTP id e11mr40067168plb.269.1549035901315;
        Fri, 01 Feb 2019 07:45:01 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:45:00 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        sparclinux@vger.kernel.org
Subject: [PATCH net-next v4 05/12] arch: sparc: Override struct __kernel_old_timeval
Date:   Fri,  1 Feb 2019 07:43:49 -0800
Message-Id: <20190201154356.15536-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct __kernel_old_timeval is supposed to have the same
layout as struct timeval. But, it was inadvarently missed
that __kernel_suseconds has a different definition for
sparc64.
Provide an asm-specific override that fixes it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/uapi/asm/posix_types.h | 10 ++++++++++
 include/uapi/linux/time.h                 |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index fec499d6efb7..f139e0048628 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -19,6 +19,16 @@ typedef unsigned short         __kernel_old_gid_t;
 typedef int		       __kernel_suseconds_t;
 #define __kernel_suseconds_t __kernel_suseconds_t
 
+typedef long		__kernel_long_t;
+typedef unsigned long	__kernel_ulong_t;
+#define __kernel_long_t __kernel_long_t
+
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_suseconds_t tv_usec;
+};
+#define __kernel_old_timeval __kernel_old_timeval
+
 #else
 /* sparc 32 bit */
 
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..04d5587f30d3 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -63,10 +63,12 @@ struct __kernel_itimerspec {
  * here, this is probably because it is not y2038 safe and needs to
  * be changed to use another interface.
  */
+#ifndef __kernel_old_timeval
 struct __kernel_old_timeval {
 	__kernel_long_t tv_sec;
 	__kernel_long_t tv_usec;
 };
+#endif
 
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
-- 
2.17.1

