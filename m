Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69978213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0xrM5F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbeL3Dtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 22:49:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41204 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeL3Dte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 22:49:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so11536914plm.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 19:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MI9xDZS1GPFABOcB3hJqapR1vDAPVYxbXhjN4VVkhyE=;
        b=L0xrM5F9wPBLUdRnPiXjndGkQDzUNM1pQQYM/N9VujRcmdnZzBebvozIedFQDF1Efh
         kz7wkMmEdJN+O00pxSyRil+4cuIiLF8r4ZondXiT2OgT/6yaHMhrghIQuowDx7fR7U71
         qp7tmj58r0vifKLRaKK8HrYizMZPhNF00Pu5erQVhvOaKTC0xYhaRmhf7S6sqk/430UD
         P55ILL4hirm/ddkHfLIXrwZYyDkWasXN9T+zAiWHd7zAeLsfgzrmM3NiupwSf3jFr8io
         Hkub32WBBCZvhfDy7OTBn8OR9hxJnbJdG3UQehomXIgjWzMGXMHb6FBdungBFqPUVenm
         G+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MI9xDZS1GPFABOcB3hJqapR1vDAPVYxbXhjN4VVkhyE=;
        b=HV3CdNHfw1YXLF3mBz9PMP58tEUDJGjdSe+UNo912tH+4TBg0k6P/IBr6+MkAsdOH6
         PhiDG38B2BwVP08p5GGLiSuk0JdK9HSHqQ2Nsldby20rdY3QR57irUH2bevWntuF+u/9
         6nYoRg3LSIg0jNAuSMYn+cmHHbqj+CEM427EKuhS0qJoGi48QmyjsjXhBAYs9xvA7EqI
         rW79keXeKFiY5xnTMVyCWKAWzkRmEIGWYsbNg4/sfrg7nmtWYWc0Nu6ECDzeXpLcrFXh
         ssRnANGtv+kTnzSHv0e72TYbzUeLt6vf3gyphRzW165yPfQJkloEQdF8NehJFOpeLuX/
         Z0KQ==
X-Gm-Message-State: AJcUukcRy/4gYp/CfSQ6oDo2Kv2Inaan8x8d7Jbcrx2Ugs/eRh6Icb0n
        stGMIH5UvJpoOcxzZlu51hE=
X-Google-Smtp-Source: ALg8bN6+WaGZPDSo6vfuoD6MkvVx1PZKtV8Kdpn78Iist9SiCErjP2HLCIl7rcmqSdz6fb0/4na7tQ==
X-Received: by 2002:a17:902:20c6:: with SMTP id v6mr33438972plg.156.1546141774092;
        Sat, 29 Dec 2018 19:49:34 -0800 (PST)
Received: from localhost.localdomain (node-hau.pool-101-108.dynamic.totbb.net. [101.108.87.150])
        by smtp.gmail.com with ESMTPSA id z62sm90976569pfi.4.2018.12.29.19.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 19:49:33 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] debugfs: debugfs_use_start/finish do not exist anymore
Date:   Sun, 30 Dec 2018 12:46:52 +0900
Message-Id: <20181230034652.6214-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_use_file_start() and debugfs_use_file_finish() do not exist
since commit c9afbec27089 ("debugfs: purge obsolete SRCU based removal
protection"); tweak debugfs_create_file_unsafe() comment.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/debugfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..4354069101b4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -422,8 +422,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file);
  * debugfs core.
  *
  * It is your responsibility to protect your struct file_operation
- * methods against file removals by means of debugfs_use_file_start()
- * and debugfs_use_file_finish(). ->open() is still protected by
+ * methods against file removals by means of debugfs_file_get()
+ * and debugfs_file_put(). ->open() is still protected by
  * debugfs though.
  *
  * Any struct file_operations defined by means of
-- 
2.20.1

