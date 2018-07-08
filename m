Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E2EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF63208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Z2+HuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF63208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933182AbeGHVHI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:07:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34265 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933317AbeGHVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so12152093pfn.1;
        Sun, 08 Jul 2018 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XmECklsvI6JZMVhaYSlokDz0nn5YXD3/ItbHQgCYTk0=;
        b=k3Z2+HuG0qqC4x20S7O+3PwH6HUPht2wv8kxC589RUbekVd6GaDuisowf97cfO6Z2c
         uEtLYQl61kmSt7C18wQ8gpo9Io5kWFFMnCHUl1pfFBDLZI2NyI8UIbKVKX40PMidR3IQ
         I/X9bSd7dkBeNaNlXCc0JdpPvd1Zw2B5KudWplIi1t5DCeGAxK0Be94saOAIFJYP2ews
         VqdbjH5eZtrXGcVHLueHBmF9BuYhvRHI+1r/zyfyBk3DIZf9lC3BOq9Kw/AAus1sqlbr
         sS6mCiIbqdIh9gcHLMPSvuvJB2e2aoRHtVevRVOr05dDqoTxzRuFxy9U72jEZ3Vgm1MG
         DUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XmECklsvI6JZMVhaYSlokDz0nn5YXD3/ItbHQgCYTk0=;
        b=bYcIrjYBHVxuc5b40M0YHOBguEOGrmVvxignBBUXmo5aLHKnqLtbJzvtP1/qM9EFBN
         tJ3EHUmzUg7wGr7B2eeE++A7I8opuK5CRSM4IywXedKm5x6sdn24pdhu0e0EahhLBG1K
         1JtC/pGH7K14i1orsV5sQIDLV3+cXyZUm3j/5XqWS+xJFFU5jS1RJOPNj7xG7OU//kaZ
         d2PJaZwZIIR3b9mJ9/nWPlqMCZMq+Lzpz3maPW6TTTSnvM+BLliVe4QvDCpl2DliW0ry
         Cu89guIS9J/LHskz2894ql35AQPsyO6uHNwk4unH2ZlLcoT7q6waHvihGLPSiswjueHk
         hzPQ==
X-Gm-Message-State: APt69E2zm08TBX0aZehMkyQkiOWol+84hD61u5QvDmH6+0D0el1w3pML
        wvI40K6BccO4N2B/CCpTkVE=
X-Google-Smtp-Source: AAOMgpeIJ6bIfdn8/HHXRTQNnS0G9m6rxwzJuScsax51f7kbxpz7Xdk3FGyH+PJpNcadbWK2LG8BXQ==
X-Received: by 2002:a62:5d55:: with SMTP id r82-v6mr9808150pfb.150.1531083943663;
        Sun, 08 Jul 2018 14:05:43 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:43 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 13/18] fsmount: removed unused variable 'inode'
Date:   Sun,  8 Jul 2018 14:01:49 -0700
Message-Id: <20180708210154.10423-14-ebiggers3@gmail.com>
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
 fs/namespace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7f0191bb5db46..0624af4806c4a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3230,7 +3230,6 @@ EXPORT_SYMBOL_GPL(kern_mount);
 SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags)
 {
 	struct fs_context *fc;
-	struct inode *inode;
 	struct file *file;
 	struct path newmount;
 	struct fd f;
@@ -3289,7 +3288,6 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 		goto err_fsfd;
 	}
 
-	inode = file_inode(f.file);
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
 		goto err_fsfd;
-- 
2.18.0

