Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF5BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E182084C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKoG4YPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E182084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeGHVJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:09:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37711 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933033AbeGHVFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id x10-v6so2291777pfm.4;
        Sun, 08 Jul 2018 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ic95r9CUwqwLACIDyPDH9dFY//qraNC0pvr+AmdEoMM=;
        b=MKoG4YPcec83UoTKNWCB7U6+jyNhApJzwUJImjNUE6IyzYbfNY/bl7TBwI6jL2/uYF
         TnWcsoQgw94qVTt7C1x89e0hCObZ8abGzv4F9ovBOjFPHVnPwW6JtMpvZU2CIblTbRAA
         xjvzaEv/6TNt8VfYjiTJbvMVpE33BOFXY5M+Ojt6qcnu8c9xYc6oZquKimHw43TzjNqP
         ww49PQ24v57OK2QEZlQezASLxTARZqly4Z8sqCkvbEAUY88H3c/6Z6dQ9et1ICNE75Ge
         LwYdipx8bvmxn4CDVEUG6YSQFuJDjn8t5RjqUwBHCERb4w0KRmymEKg/M3R8o7ru5G43
         //iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ic95r9CUwqwLACIDyPDH9dFY//qraNC0pvr+AmdEoMM=;
        b=lcdM+hKrylEQavoY8MknMhmOnyZH+lgPb15eaBA3Sz1TK6nNvFcEZzoTSNHjQB4ecq
         Ckz1QXQh5eTphibrbtO37XP3NJpJmQz+HXgn4LQg8A+JtZvGCyVI/5z0zVil44hOWXwn
         bCptA9hFrMb5BWx6R5sTtl2ovicSWYlzacbCLQubWTy0QpdMnaMHagNO9o3VsK7NS5Ui
         VrqNzT3CJxB/n/c76AmwL7OYzII1CJIyl3t3T0x8/DNEUDvQEnjqmf7YO16f6GzHBe9c
         SlXF4rrQd7Jq1slwQFv/aarVrZsirbxgeDpsRWTx2Vrnc3Vbw3/yVJiO7gVpo6hMI6X8
         m3VQ==
X-Gm-Message-State: APt69E0o5YCT9tl+VT9Sw/pMdQx52ZMXcxpwW4h75mCZmXekPogOVgma
        bbpet0/nWIexlFr6Xl0A9Zg=
X-Google-Smtp-Source: AAOMgpenX6vEr7j4i8RSUR9Lg2ZnAd4QRYSYbamnAwdNbFm672MoJNuvsLuVGWHgMLE0qLD8STGYTA==
X-Received: by 2002:a63:383:: with SMTP id 125-v6mr10762509pgd.421.1531083935400;
        Sun, 08 Jul 2018 14:05:35 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:34 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 03/18] fs_context: fix detecting full log buffer
Date:   Sun,  8 Jul 2018 14:01:39 -0700
Message-Id: <20180708210154.10423-4-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When 'head' and 'tail' wrap around, 'log->head - log->tail' will be
something like '4 - 252 = -248', and comparing that directly to the
array size is wrong.  Fix by casting to 'u8'.

Fixes: 09aeca629fb3 ("vfs: Implement logging through fs_context")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs_context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 97e8c1dc4e3b1..a0e22f4c6b64a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -418,7 +418,9 @@ void logfc(struct fs_context *fc, const char *fmt, ...)
 	freeable = 0;
 store_string:
 	index = log->head & (logsize - 1);
-	if ((int)log->head - (int)log->tail == 8) {
+	BUILD_BUG_ON(sizeof(log->head) != sizeof(u8) ||
+		     sizeof(log->tail) != sizeof(u8));
+	if ((u8)(log->head - log->tail) == logsize) {
 		/* The buffer is full, discard the oldest message */
 		if (log->need_free & (1 << index))
 			kfree(log->buffer[index]);
-- 
2.18.0

