Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB2D2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNb0Od7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfAHD1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:27:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44282 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfAHD1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:27:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1186013pfh.11;
        Mon, 07 Jan 2019 19:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=XNb0Od7EOJvc+wI+J7ooq6WYnFU/slJKZXOe/bmLsAFpeiWy35RbIXHJEhI+onLdoM
         yc2EVZNXvs4f4XYtEZObGWBf7q8Y+EobP1gK5qosBISdY7cis5JS0aKmrYMboyXzD6ri
         f5m1LaOjQkixuRsETHQoxWZ/L/EKk9e6mVdJQ0heQAwyTd0K53vhznqMzrP89POD7iav
         qdrFfeHFLQmSDmAdH40FWfAwVs9k+Arrw5Tbif4VO1qPhBYkNzQ85AaR0D1/qW05wlis
         gbn5yi0E9QOyFSAlVtONN4QMZdJFUxht/aV4GfTC7OcKRdJt4mmDIE/Ttrmpmi3UXIcj
         eK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=szyy1Ua4JD16cR8x0jHYIK2HEDcSv3JDVRZSN6GS92gsf+CBKlk+rxlPXfQURYnbv2
         zC7rI3s+KuruaHZnDK8ObbTtQjwvucupU6t9iToonR9OgwgP10j7KIp/vcItYbAxBpmd
         7CLmv4q8ni7qSkMgCHwa+sLv9aekAsE9SUDOeWagXIw4UIA4oDjaSoQSV6XrY7N1uoqi
         MI7PJqZpANiT9Mgq2Z4ibpZEx6opE2JjEUSt+bDBbFQ5JXr2SbuYRIPyLP0iG4iXxj90
         qSJLS4q5iG9qSvyMs/vwqWeLzo9Bh+JC8tNGeQ9Qclc9cvn/vBv8JqGihS/XJlqgbLbf
         lIvA==
X-Gm-Message-State: AJcUukf/ET7IL/CKr297T0JClVqgaTolSBrf8yls0LwRqoeYqqz9Uqxc
        Qw3No2xgpLhdS/IK2l2qGlY=
X-Google-Smtp-Source: ALg8bN77mdbmAGcSL8VeNrh/ggD7fN3PvFpYFYieehBJ4JOcNAsUJhkZ1X5RhE/31o8WxhhLCTUQaA==
X-Received: by 2002:a63:990a:: with SMTP id d10mr70294pge.279.1546918066748;
        Mon, 07 Jan 2019 19:27:46 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id v5sm117327735pgn.5.2019.01.07.19.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:27:46 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 3/8] arch: sparc: Override struct __kernel_old_timeval
Date:   Mon,  7 Jan 2019 19:26:52 -0800
Message-Id: <20190108032657.8331-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108032657.8331-1-deepa.kernel@gmail.com>
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
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

