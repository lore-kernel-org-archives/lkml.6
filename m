Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C3CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D772083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Y56DFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBCHt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:49:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38773 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBCHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:49:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so5356989plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 23:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yAVGCwR4YHv/p1wmhEDFGFfEYHAHeNLmDj21CMHWU6Q=;
        b=j1Y56DFt2NGTw05nbH9Ot/jBLN9I4HvEBXpI4jjrNCzm4/SEvmrSYGmb6x8bTvbSZ/
         U/JLUjOXltv3TOUdcxq5mAWUBi3DEwN25OQDq64DdFbQkhvQvdr1wLC2319Qs4q5eaC4
         vh5d3fZAT6JJmjEMLLYaD4Dh3KWSydeRISIyYK6nia0t6ilmc05vU/gwl8NuFD+k5BL9
         E9ZcaL4osTMs5J+citQcyP8HakaTP954MFfphOlPnrB8/2lkugVxcp3Ag8z5oiUjRGmS
         lxblVNpxch899icoqgA8Hq7mkVy+oT28zulPIB9pAaHyBrK5DxAoOYZrqfr3qHo43JHi
         Zklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yAVGCwR4YHv/p1wmhEDFGFfEYHAHeNLmDj21CMHWU6Q=;
        b=QoJS7Ywfx+CgUHgIJm1y/iFby13qw6qABwwcwM1hYtn0Vp/4DjOCCvpDQBY7kIEQ1w
         HKofeWZBlQd8DYjDqmbJ+uc3HzKkSc83JuwHiR29Rew9MO2K2TW8f8yzgetHoMPrfYHF
         Z/usWuqsej7Lgt7V3St/JXVSJBhO7SLSYssrtNPAxINgfBHkuJ9ZJI+/vZpTK/+peHmk
         492KUKqh9jNjniPyaQUwXTs1jIo2q9afoYlM2TxIM6Y01Ip46FqEiqT+UP4ywNBTRAmF
         eG1plfshzQG6fWPW86qbAHj0Ap3a62meneP/lbloxYReWc2GeY9ge3SmHiHf5EqeuOMF
         9eaQ==
X-Gm-Message-State: AJcUukdCCGD3cN5W1Ga1Pw1hsaMh1YJLHoK1UUi59G5OHwTPLL5lCg+A
        EfHFX+b+FhpId1UJ2Mo6xxIS1EkiVJc=
X-Google-Smtp-Source: ALg8bN6j72E0NyqThHWcMQxyc0jCNu3+sl+f5WTdCI/pa6bObZbFxwR/QMFNx05Acpz3jNoJWFs4Aw==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr48097381plp.9.1549180195978;
        Sat, 02 Feb 2019 23:49:55 -0800 (PST)
Received: from ghor.localdomain ([2605:e000:110e:4146:e508:6f47:a727:f2ae])
        by smtp.gmail.com with ESMTPSA id e2sm10821857pga.92.2019.02.02.23.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 23:49:55 -0800 (PST)
From:   Jack Andersen <jackoalan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Jack Andersen <jackoalan@gmail.com>
Subject: [PATCH] signal: always allocate siginfo for SI_TKILL
Date:   Sat,  2 Feb 2019 21:49:38 -1000
Message-Id: <20190203074939.7261-1-jackoalan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch titled
`signal: Never allocate siginfo for SIGKILL or SIGSTOP`
created a regression for users of PTRACE_GETSIGINFO needing to
discern signals that were raised via the tgkill syscall.

A notable user of this tgkill+ptrace combination is lldb while
debugging a multithreaded program. Without the ability to detect a
SIGSTOP originating from tgkill, lldb does not have a way to
synchronize on a per-thread basis and falls back to SIGSTOP-ing the
entire process.

This patch allocates the siginfo as it did previously whenever the
SI_TKILL code is present.

Signed-off-by: Jack Andersen <jackoalan@gmail.com>
---
 kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9a32bc2088c9..7a810aefb5df 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1058,9 +1058,11 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	result = TRACE_SIGNAL_DELIVERED;
 	/*
 	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
-	 * and kernel threads.
+	 * and kernel threads. SI_TKILL is an exception to allow
+	 * processes to discern signals originating from tgkill.
 	 */
-	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+	if ((sig_kernel_only(sig) && info->si_code != SI_TKILL) ||
+	    (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.20.1

