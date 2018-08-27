Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D614C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C05208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZCxAtEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C05208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeH1DEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:54 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46232 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeH1DE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:27 -0400
Received: by mail-ed1-f44.google.com with SMTP id k14-v6so421392edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3Op+bKBKI0WHhSz2U8GtUnIk3zUPlfbkdpOF3B/Wm8=;
        b=nZCxAtEp5lxqcxBaS/feXLjPoPQwSoT1EdBphqHZ55VauR7P1Wa/Q2U3RGBuRsmM7s
         Niqjrk3qvQ4TfvBd7F3xejiDAIvcFi+WNNdrBMeGkV9mEnocnew7rnWTGffPCDdg1G2N
         YmAWqO/Tq6urP91KbytChEeTc1mPXT85d0hwPc7daDksCMJS6SX62lihR8o5gO9syp6V
         MmeBPv2baMCVRO4xyYwwFbseotTp6lqgOjL+9kFhgzRcZGVsZHocjRF/jKUrdee/0W9r
         WWtctSCQuCQezVB2w1b0RRGau9O/rleQ1pnrl2xvCK68tGr20i7J76xClnGZdZ7CRRwA
         Y3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3Op+bKBKI0WHhSz2U8GtUnIk3zUPlfbkdpOF3B/Wm8=;
        b=KULHnInXxLS2TQocwVoaLkfwebeEasO+Vk5Jv3znnONlz9VRCsxcVdjPNOsVgyv5oG
         Uf44Lfuf+zlOqqvREI9gE/6Kh+iYtldEIkt6hf3SW3DStFbW73Iu/hT7J5oxkWU207qA
         tU6Q2nIGI5d8U64FdsBP0SsDhXdAARolvdme8W/xnyDr2na+jNdhUwWNOxWU9mfXm7AF
         4POstRRPwNi+BPFD4Unoj+Lu+gaJx4FrY8d99E1EAzF+j79D8n4qkfagE9qKyrJyeKen
         UW8CI9c5Xg5BUQhdaO7ZZhECSlZ8bqkPYSsi5kYTlgV9CFcVTLSMQ1YQ8ctZEcggu9Ov
         Qfng==
X-Gm-Message-State: APzg51DbjGKE1gC1+BSPbGkq37x8Bg1RvD/TrsPf2vI/hi+W2SQ+7eaE
        S1qSGnji1H621OxcJykox9ScDWk=
X-Google-Smtp-Source: ANB0VdbtwN2n5o+DkuUGCFWp9r5uD5JLsBeTeP/FSNoG6INCaWSKFDqWYhrDdTCb88QCPOuy0aVKOw==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr19228204edk.245.1535411740910;
        Mon, 27 Aug 2018 16:15:40 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:40 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 10/13] proc: convert readdir /proc to _print_integer()
Date:   Tue, 28 Aug 2018 02:15:00 +0300
Message-Id: <20180827231503.26899-10-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark readdir("/proc") 2^13 times with 2K processes in a pid
namespace:

	850.3750 us per readdir
	786.5625

	-7.5%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 79d2f7d72ad1..33f444721965 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3223,16 +3223,15 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 	for (iter = next_tgid(ns, iter);
 	     iter.task;
 	     iter.tgid += 1, iter = next_tgid(ns, iter)) {
-		char name[10 + 1];
-		unsigned int len;
+		char name[10], *p = name + sizeof(name);
 
 		cond_resched();
 		if (!has_pid_permissions(ns, iter.task, HIDEPID_INVISIBLE))
 			continue;
 
-		len = snprintf(name, sizeof(name), "%u", iter.tgid);
+		p = _print_integer_u32(p, iter.tgid);
 		ctx->pos = iter.tgid + TGID_OFFSET;
-		if (!proc_fill_cache(file, ctx, name, len,
+		if (!proc_fill_cache(file, ctx, p, name + sizeof(name) - p,
 				     proc_pid_instantiate, iter.task, NULL)) {
 			put_task_struct(iter.task);
 			return 0;
-- 
2.16.4

