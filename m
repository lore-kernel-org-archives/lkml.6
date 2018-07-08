Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA7C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529E3208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3qWdJHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529E3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeGHVFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45470 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932974AbeGHVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id i26-v6so719214pfo.12;
        Sun, 08 Jul 2018 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLZnuyIOr1znETYlyoQHZ3GgUmU6Mx7N6q8g0vwm/Z8=;
        b=c3qWdJHsDVnkgjOxAtzNs08f/9Eld36izaV46L+oP41f2F4YQb8klruGopODQ1U/5G
         +cYjfoKS7/MjuD1gM8mFhubojMFeY98I+NYwIt6ZN6EbxQ7tWRUL6XaLTY+yv96h6+cq
         lQrhlhvBf2myKMDltBm3sKdylln9SopCUlJXV5jWWjqay7gqbGl1acPzswrl7rb0a9SJ
         +M49Yyi362tYq+7rsIFvnacHXVFIBL2v7xkd4LmECqvZTsDfR2Q1ZYKvksR60U/K4x87
         adJvfM9YEi+dpKqOy7hCnOcbQCSwnHjgMiVwmTAH+wcW7Cb4nlH4QQfHIqHpCjercOvp
         utnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLZnuyIOr1znETYlyoQHZ3GgUmU6Mx7N6q8g0vwm/Z8=;
        b=gV9zEP5QBXtk3zN9nCxp56grPtvNMeEYDu9gfOZKWoJUYVY0jzdBiSJ7ChUTzkUuFf
         FCBau3wpLojQ7y195S3TB26Z1WOuQPdXpKaQSjz0JzMLcyccsyJdCcKCMDu8nE2TkU1x
         7KpnlVlRL3dHWc3l43/cjU8mar5ZhpCryefyIWxZYcWMziUlS5iOTZm67/Bw+fBrk2LZ
         zvuJ1OcWnE9SjUzUOxQ/OrzNp+uFp0iJ93ZrLRXwwDR9ZUO78va+DsEyiTe1oNsq8rab
         vBiynBSoHhpD97CretxEuqEw9rwA8Hh4amGqHLlQojAt1KQ79sV515OWZs6tdxnAoXqz
         Z0tA==
X-Gm-Message-State: APt69E1Ccgfyn2qCQlLbPvAbVpXVyG2/jxm6F4VLmxD60i+pcF5cjVCW
        9Rspaub+a6e58AyZWJ6sKYI=
X-Google-Smtp-Source: AAOMgpcqB6QcAMrVHVonW9fqbD7jkE27GUikz7GWzos54QKXJwmZayOAfG+U7E65WH8iRPQEfchg5Q==
X-Received: by 2002:a63:1a20:: with SMTP id a32-v6mr10332287pga.446.1531083945306;
        Sun, 08 Jul 2018 14:05:45 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:44 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 15/18] fsopen,fspick: rename fsopen_create_fd() to fscontext_create_fd()
Date:   Sun,  8 Jul 2018 14:01:51 -0700
Message-Id: <20180708210154.10423-16-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It's used for both fsopen() and fspick(), not just fsopen().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 02edb4705fac2..1fbd8b0ca194b 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -212,7 +212,7 @@ const struct file_operations fscontext_fs_fops = {
 /*
  * Attach a filesystem context to a file and an fd.
  */
-static int fsopen_create_fd(struct fs_context *fc, unsigned int o_flags)
+static int fscontext_create_fd(struct fs_context *fc, unsigned int o_flags)
 {
 	int fd;
 
@@ -273,7 +273,7 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	if (ret < 0)
 		goto err_fc;
 
-	return fsopen_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
+	return fscontext_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
 
 err_fc:
 	put_fs_context(fc);
@@ -328,7 +328,7 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 		goto err_fc;
 
 	path_put(&target);
-	return fsopen_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
+	return fscontext_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
 
 err_fc:
 	put_fs_context(fc);
-- 
2.18.0

