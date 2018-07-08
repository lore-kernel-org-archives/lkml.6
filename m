Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DEDC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96A120896
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBjpRY/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96A120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeGHVIE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:08:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35421 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933320AbeGHVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id q7-v6so11040887pff.2;
        Sun, 08 Jul 2018 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97y20UZa6OWy15fXSUc6AB18PPxAzJa3NJJvwI7loKE=;
        b=PBjpRY/AvhRdo+UaYyEWkFPo0/1KRHM8+8Lc0ITZSHCwqgpXP32huoDZLXydNWKzhI
         /G3UHRBuAdhYLuUySY5vObYpY8UVFDO3ROcY02i8AmxRet/UKnhdd1YlIBw0OrXnhgNS
         WJUQ0nPlsvpQz0SkaaHf2fjlVL4P2wn/UtLrSBxPIOqU18l/6/PSE8mfSE4f3z7UFVTV
         4YE9YpThrCoTM9nUpvYf1mC14g8p+0xIJM2shBXPpeY9xBxkiaalLVWDSBRwr8KoPz6b
         yn8L3dUMHJMsT2gK7N0jYlChvAkv00bU6pxI0ibqho4IR7wa8xrlirI1BMCrvgHxt0lt
         ECqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97y20UZa6OWy15fXSUc6AB18PPxAzJa3NJJvwI7loKE=;
        b=CaGQtMgkl00/Gv+3duGEizuc0356C9ZTKlmn+75T+G34qbcJZG1FISeLnmLvMJupXn
         HanOydmC4gYTSSqqKPx9qKIt0mLMCiFv+fh0Hr/7KDkkn1froQsMm8Rjh/4j1WuAbkk4
         MN8uba4E4Gk371+1G8Joy6VfSLKSsnQs+I3cqzjdj5X+yMMcSUsjS7ssLuEJHsA3Ij99
         gqAVmh7LNKE6pUNb3oYfdefu0V/m2emK+jcwO3Ks572KnZr5wG9J3nbupBsAY4V2u5+R
         1TiDEB4X6PEknm1rg50mXp26a7e/YkYDVgKaJJxxyoUoZPhdJ3JrPU8qc+dJrRyAqTWM
         U71w==
X-Gm-Message-State: APt69E1ZPJu8AjgEXCvbt8zolCvBjNierOUZq6ruQDzhddzNQmo8f2wR
        SmK+8Fx9+E1SPGZq7vYAo70=
X-Google-Smtp-Source: AAOMgpeAo7Pd1SFrM5Zz/s4EiOnmyk8MTm9wupnAJv/iD8xVpAU+cnqhObMlNCuTE8wnfvhdqVPPrQ==
X-Received: by 2002:a62:6147:: with SMTP id v68-v6mr18705807pfb.115.1531083941139;
        Sun, 08 Jul 2018 14:05:41 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:40 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 10/18] fsmount: fix bypassing SB_MANDLOCK permission check
Date:   Sun,  8 Jul 2018 14:01:46 -0700
Message-Id: <20180708210154.10423-11-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fc->sb_flags can be modified up until fc->uapi_mutex is taken, so the
permission check for SB_MANDLOCK needs to happen under the mutex.

Also move the may_mount() check as early as possible.

Fixes: 0c65353ab9f5 ("vfs: Implement fsmount() to effect a pre-configured mount")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8ac9e8fb31c9f..7f0191bb5db46 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3237,6 +3237,9 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	unsigned int mnt_flags = 0;
 	long ret;
 
+	if (!may_mount())
+		return -EPERM;
+
 	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
 		return -EINVAL;
 
@@ -3275,11 +3278,6 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 
 	fc = f.file->private_data;
 
-	ret = -EPERM;
-	if (!may_mount() ||
-	    ((fc->sb_flags & SB_MANDLOCK) && !may_mandlock()))
-		goto err_fsfd;
-
 	/* There must be a valid superblock or we can't mount it */
 	ret = -EINVAL;
 	if (!fc->root)
@@ -3300,6 +3298,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	if (fc->phase != FS_CONTEXT_AWAITING_MOUNT)
 		goto err_unlock;
 
+	ret = -EPERM;
+	if ((fc->sb_flags & SB_MANDLOCK) && !may_mandlock())
+		goto err_unlock;
+
 	newmount.mnt = vfs_create_mount(fc, mnt_flags);
 	if (IS_ERR(newmount.mnt)) {
 		ret = PTR_ERR(newmount.mnt);
-- 
2.18.0

