Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0FAC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8004C20896
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6svWdLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8004C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbeGHVIT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:08:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40564 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933241AbeGHVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so12151717pfe.7;
        Sun, 08 Jul 2018 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZvP7xzX2M/u7KGjTkhIerCLDk/27sw7BMl9bNxyCSE=;
        b=T6svWdLrvU3owQ7EoLQ2t5UWHbd5qWssqn930z6cG/74DYzdZ6DcjQ78I1XGbjMzzv
         EayTbuXDSFT9GybtbMnZv0J9Mex3DPtR5Mq2yMxZnK/I0szFXxTu0HLmyzx96zpS7seM
         ksec9i46UTEtC0R3C66DRlhraLM/1/5xJAoVuN+YN99fwsnfL094LE4TJVnPmL2slr4t
         s+qdfJGhTrN28vHnWUyKt4wSorpPudkVv79Anpf2Tgxb6RjDc1oza+BChX1jN/7v+PNi
         rnkOhVLZKo6PwkG4QXBzYDnGvZIC01xyeYrF+i8CvMq3XuDlJhB/NJPOrkcJ1FIQFob4
         rNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZvP7xzX2M/u7KGjTkhIerCLDk/27sw7BMl9bNxyCSE=;
        b=ftW/AONbR6M1eQt1zpkO8Hy6ryijizFy4U42E69weYyFDqD4bgDzYKzQ3DRhVkFITx
         W23Os5ROTNDtnzKseQpdfAlUK7lfxLmf+XPAzQDD1/i1UoWuqPnxF+WT8S23wSS5GMu5
         ZITVScrVhIfG8e44uvCBEjdfV7zgJVTK7mqzxFf5MYhCDW8L5fg927UAIjIG6HvtAbLe
         n28O+/xy302aHe06lWhKAPG/t2CJ6E7aCSdVRAOlbZAxZKzV6j10QfCwOCkInAwSyO+v
         ryf7HjFSCmL9FtFpjOLwmlZgkCjjerntr0tRTfp/myjc6Y59YeLuA44ikM+pPH+Nc5bR
         Ol9Q==
X-Gm-Message-State: APt69E2ezqrobEnd2rVY6BoyQUmVejFDitnI1AOyffEe7mRWTxCsEtjl
        H41XaSYb6Dy0SgtMSM4zXWk=
X-Google-Smtp-Source: AAOMgpetxmg59rezQwTpuEFxSlYsoHwPg1/t830rJw6YBJXaAHC8aqHsqCRj31OtMzk+aTsvzrsJyA==
X-Received: by 2002:a62:2541:: with SMTP id l62-v6mr18812910pfl.0.1531083940365;
        Sun, 08 Jul 2018 14:05:40 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:39 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 09/18] fsmount: fix handling FSMOUNT_CLOEXEC
Date:   Sun,  8 Jul 2018 14:01:45 -0700
Message-Id: <20180708210154.10423-10-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fixes: 0c65353ab9f5 ("vfs: Implement fsmount() to effect a pre-configured mount")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9cde133d0a9c4..8ac9e8fb31c9f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3339,7 +3339,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	}
 	file->f_mode |= FMODE_NEED_UNMOUNT;
 
-	ret = get_unused_fd_flags(flags & FSMOUNT_CLOEXEC);
+	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
 	if (ret >= 0)
 		fd_install(ret, file);
 	else
-- 
2.18.0

