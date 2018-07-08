Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E0C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D928A2084C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKKcoGB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D928A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeGHVI4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:08:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37453 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeGHVFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id n15-v6so845386pgv.4;
        Sun, 08 Jul 2018 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0zZrDFaUYH6tNLCEMNQxuslgb4FT2NkwdB6xP3Qwwyg=;
        b=NKKcoGB8pNJxeJsbsl/iYSZH2whmUvTpEX10H3ORxUst7ekV3At+gPDCCGSo/X84Lh
         x6t3bSSGuT63macMzHqAGXpVfaPYxfd943uhAz8JaM0yCngSxgL0HO7LkK1nFfwhLzlv
         XfuEt/ZaO2YXodLj+e2BfFEiFhk2wXqHqJSK00TQXMFNdP+A3NMJZMG+wMCYOJokZ5q1
         S2oFQpY0PHiijJ/h7oTZ05OliIhzvgrb9X4biX73TSUE6TsfvRLzmKuM/g+G66Q55GIb
         n3C1uxQ9PRVnSJcqSzjfYu06oNY+v0H4PEdkAfzpL3X1vbgVCmNBPIsW/2CDJVbH4VXh
         9l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0zZrDFaUYH6tNLCEMNQxuslgb4FT2NkwdB6xP3Qwwyg=;
        b=uOEG2EFGvoI340imBZRbJqC4Bfy5SBy6cmiMtUSUGjbbZGbqS6WsyyPaK/FzhKByha
         vU1+twUduqDjUn9olrIlcY954pKr/ZpWaEkQF9oMfHOH03BXQnl/cddCZvPEFOYLSpMa
         Vv03+bt7TP3NNQ4lE+E+BtJFl2mOAbMExI33EqBoxjhUbO4jeNhs1gF7gLfVzoyNn9jx
         4swdbrAMoV5h7rPBKp5f7dCUut86LTANWwNH4xWD8BFwuoVDw3RW5BD4/edmEL+zfOER
         LtZLdkimFzbiv1tg9wGge02XkgxbqHwjrov08Vvk+fzzhTzrqv45zda0/sdtOmlfGUw5
         MZgg==
X-Gm-Message-State: APt69E1JdBfOnE1lRJ15r0zkqpSnTZKlyjmjmFhj/VFGSvKTgxUqGSNY
        VqD6H2ZR9GnbNpMS879r2kg=
X-Google-Smtp-Source: AAOMgpfIxkgS07OWi8pUc3hvjEssbp2LOvaoAdxw+9I+pJGS/Bm+ReoivI2qFypJRaivQdp8pCdK0w==
X-Received: by 2002:a65:5907:: with SMTP id f7-v6mr16136687pgu.83.1531083937154;
        Sun, 08 Jul 2018 14:05:37 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:36 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 05/18] fs_context: fix mount option blacklist
Date:   Sun,  8 Jul 2018 14:01:41 -0700
Message-Id: <20180708210154.10423-6-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The blacklist didn't actually do anything, since match_token() always
returned 0.

Fixes: 8a2e54b8af88 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs_context.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a0e22f4c6b64a..7a8d1ed34ae71 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -65,26 +65,26 @@ static const match_table_t common_clear_sb_flag = {
 };
 
 static const match_table_t forbidden_sb_flag = {
-	{ 0,	"bind" },
-	{ 0,	"move" },
-	{ 0,	"private" },
-	{ 0,	"remount" },
-	{ 0,	"shared" },
-	{ 0,	"slave" },
-	{ 0,	"unbindable" },
-	{ 0,	"rec" },
-	{ 0,	"noatime" },
-	{ 0,	"relatime" },
-	{ 0,	"norelatime" },
-	{ 0,	"strictatime" },
-	{ 0,	"nostrictatime" },
-	{ 0,	"nodiratime" },
-	{ 0,	"dev" },
-	{ 0,	"nodev" },
-	{ 0,	"exec" },
-	{ 0,	"noexec" },
-	{ 0,	"suid" },
-	{ 0,	"nosuid" },
+	{ 1,	"bind" },
+	{ 1,	"move" },
+	{ 1,	"private" },
+	{ 1,	"remount" },
+	{ 1,	"shared" },
+	{ 1,	"slave" },
+	{ 1,	"unbindable" },
+	{ 1,	"rec" },
+	{ 1,	"noatime" },
+	{ 1,	"relatime" },
+	{ 1,	"norelatime" },
+	{ 1,	"strictatime" },
+	{ 1,	"nostrictatime" },
+	{ 1,	"nodiratime" },
+	{ 1,	"dev" },
+	{ 1,	"nodev" },
+	{ 1,	"exec" },
+	{ 1,	"noexec" },
+	{ 1,	"suid" },
+	{ 1,	"nosuid" },
 	{ },
 };
 
-- 
2.18.0

