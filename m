Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1698BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9EA208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF90lB6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9EA208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933480AbeGHVFt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45471 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933401AbeGHVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:45 -0400
Received: by mail-pf0-f196.google.com with SMTP id i26-v6so719201pfo.12;
        Sun, 08 Jul 2018 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+r7gEYt/YDpzuanpxY4yUcIFWJT4rVS3DBsdnW4JdZY=;
        b=hF90lB6aFF1E1s2xLi195Y0RxLyhk0PGmFl0fg3t1nyb+aH0VgtNuYEt6r3F7TNeh5
         L7zWMldchbFEW9xVuWJetgoZpRtp+QHOKXMXZjas4kGD2+YaQpIOgPAJtmv/mF5H4iTN
         5DZVzw4CCzrK7QPiULPgqMHE6OUWIoETsA4LrXyi+Ix1uC9tLxRHLvigrTfUlvZc9j/r
         m1LW4EViQhUE23i1YFD1Q8yn6JZsKlJ/UTBL3fj4/2CcrH9Ve/dXSr4CarVzOMDItxgy
         z+bgiDC8C28zwPfIB+8EcYoIpyp6CJRI5LGqRzppWL2Zssx52oagq+i/OY6ttwSnaTNB
         KUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+r7gEYt/YDpzuanpxY4yUcIFWJT4rVS3DBsdnW4JdZY=;
        b=RKC7MZKaPEq2OarkAIIhGndXvMfSbpSATvYnkke6TlAqIY6hEOFQp9y92wt2XjN5sJ
         GLjcBcL8J6VwHUpeu50vOrwqXPojGRy1koswavPgAC2fBUbEcXBYZJnVlKKFmhZHmRNC
         7l8r15vDBANUvx9Iw82FR6GLG7hdtnFmHkAFlrOknTiPh3xSicasoZohYB82O6Ugu1cX
         WefSWIYV2Bm8bUxqx0plafOwAIr63sQ58bcb2q71ezNYDCHiD8/BqI0sg6jLiaFFasAu
         kZjBOjtLghKqIwdv1n5Ki5opz/UB0chNryIksHrs/10CubSdP4JsRrPQWOCoYtpCUc1v
         FT4A==
X-Gm-Message-State: APt69E2WFeuEqaorebpeOvNDHGYtYLBkuuedBhKGocpkPLjv+uZTigq0
        wT0J5RfwXbHULQkce0cH8po=
X-Google-Smtp-Source: AAOMgpfjVyHw5YDfLhnnOoLqP++LEc4M8eW3LdtQNnPGPXHmQb7dlFOiecABnwT2oB06MlGdu3Ce8A==
X-Received: by 2002:a62:675b:: with SMTP id b88-v6mr18948003pfc.24.1531083944446;
        Sun, 08 Jul 2018 14:05:44 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:43 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 14/18] fsopen,fspick: factor out log allocation
Date:   Sun,  8 Jul 2018 14:01:50 -0700
Message-Id: <20180708210154.10423-15-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index b3a22848f8eec..02edb4705fac2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -223,6 +223,16 @@ static int fsopen_create_fd(struct fs_context *fc, unsigned int o_flags)
 	return fd;
 }
 
+static int fscontext_alloc_log(struct fs_context *fc)
+{
+	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
+	if (!fc->log)
+		return -ENOMEM;
+	refcount_set(&fc->log->usage, 1);
+	fc->log->owner = fc->fs_type->owner;
+	return 0;
+}
+
 /*
  * Open a filesystem by name so that it can be configured for mounting.
  *
@@ -257,14 +267,12 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
-	ret = -ENOMEM;
-	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
-	if (!fc->log)
+	fc->phase = FS_CONTEXT_CREATE_PARAMS;
+
+	ret = fscontext_alloc_log(fc);
+	if (ret < 0)
 		goto err_fc;
-	refcount_set(&fc->log->usage, 1);
-	fc->log->owner = fs_type->owner;
 
-	fc->phase = FS_CONTEXT_CREATE_PARAMS;
 	return fsopen_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
 
 err_fc:
@@ -315,12 +323,9 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 
 	fc->phase = FS_CONTEXT_RECONF_PARAMS;
 
-	ret = -ENOMEM;
-	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
-	if (!fc->log)
+	ret = fscontext_alloc_log(fc);
+	if (ret < 0)
 		goto err_fc;
-	refcount_set(&fc->log->usage, 1);
-	fc->log->owner = fc->fs_type->owner;
 
 	path_put(&target);
 	return fsopen_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
-- 
2.18.0

