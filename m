Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA31C282C7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCB221915
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2xLYMFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfAYI2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:28:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43222 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:28:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so4222154plb.10;
        Fri, 25 Jan 2019 00:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ald4abrKdW8AbO7gX/eespEZrXh8gG1ZicKya1SVk3k=;
        b=T2xLYMFtx+L7IjLMnkMWJlZN63nwMAbk/TTNCH3N1EPIKkrQdcfnEsOUKITtudtWbP
         rR9Xw/leT4eiM0paY/1PHBj28Z8YLhOb1Y5sIdhBUPD/1/iw9CnnFUJYTnkuTRvCgVZz
         N88Z7PHY1wzhj9tHjcPvf715hIPrLsSRaS+k8SyNlxT23swWU2GNDOGuqCsZMFfAJCnu
         I/dCFbNdcwv/gke23OFjTtaufzDjjHIZrwVBIESVTfIG6ZJSa5savi6K4zpJW2YzdoJy
         6ElVo/S1eLsWi8oK+tD9TxqI4ttAJ49gMfC0vh1iy8gEjipBQmbZRYG+QXwauPOgzSHM
         8DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ald4abrKdW8AbO7gX/eespEZrXh8gG1ZicKya1SVk3k=;
        b=G3mqMh8fL8Q2rT5RqszJIBKwmwCw2rvLj70Gic5G8C6PY2X+ZFb4N35HPdNhfvrX8+
         SB0wpkKjQ/2w2hGUKi+GCuHKucHTDITXq+YOonHaLgFnVGdHi/xBIX3jKSadFq+bK7wX
         aevc8x7AxkKQOFB3vaX0Yhnh2XCsrNW2N3oGQ7rH+jFDSIPrpQLZ9Db10c+N5eZsFnS9
         N1Pm3Snh/+XqSEP/vtuXByQFNQ5WQQ3cLaw+BmFcPa3iGm5/oH731HOOvHtT6dvV56E/
         LqxO7rI8vsc4I0atqeEbC9f6QCX3hGKJjWW8IgOQjYBCK/U1MjYluhrD4ckFKRfXlHD6
         HrNQ==
X-Gm-Message-State: AJcUuke3eWfmspK7AWVDdrn98Q84jOOTJVY5guqy/q6CBO9rOV7Hx74Y
        AwYoGoHlMdWzKWVzOqyG2RM=
X-Google-Smtp-Source: ALg8bN76XELN2ulmqfyeUP7Qy8m1ycVt/8nE09w3b5CPY2oQ1iILqLW1zrOzHiXNhh4q/BSp9D6fXg==
X-Received: by 2002:a17:902:28aa:: with SMTP id f39mr10084545plb.297.1548404888110;
        Fri, 25 Jan 2019 00:28:08 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id j21sm32602274pfn.175.2019.01.25.00.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 00:28:07 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coly Li <colyli@suse.de>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] squashfs-tools: Add posix acl support
Date:   Fri, 25 Jan 2019 16:27:48 +0800
Message-Id: <8ccfc9ba88a466cf046c366f07e994ca7a46ac0a.1548401987.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548403955.git.geliangtang@gmail.com>
References: <cover.1548403955.git.geliangtang@gmail.com>
In-Reply-To: <cover.1548403955.git.geliangtang@gmail.com>
References: <cover.1548403955.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds posix acl (Access Control Lists) support to squashfs-tools.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 squashfs-tools/read_xattrs.c |  2 ++
 squashfs-tools/squashfs_fs.h | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/squashfs-tools/read_xattrs.c b/squashfs-tools/read_xattrs.c
index 42106f5..8ef8291 100644
--- a/squashfs-tools/read_xattrs.c
+++ b/squashfs-tools/read_xattrs.c
@@ -64,6 +64,8 @@ static long long xattr_table_start;
  */
 struct prefix prefix_table[] = {
 	{ "user.", SQUASHFS_XATTR_USER },
+	{ "system.", SQUASHFS_XATTR_POSIX_ACL_ACCESS },
+	{ "system.", SQUASHFS_XATTR_POSIX_ACL_DEFAULT },
 	{ "trusted.", SQUASHFS_XATTR_TRUSTED },
 	{ "security.", SQUASHFS_XATTR_SECURITY },
 	{ "", -1 }
diff --git a/squashfs-tools/squashfs_fs.h b/squashfs-tools/squashfs_fs.h
index afca918..040035c 100644
--- a/squashfs-tools/squashfs_fs.h
+++ b/squashfs-tools/squashfs_fs.h
@@ -122,11 +122,13 @@
 #define SQUASHFS_LSOCKET_TYPE		14
 
 /* Xattr types */
-#define SQUASHFS_XATTR_USER		0
-#define SQUASHFS_XATTR_TRUSTED		1
-#define SQUASHFS_XATTR_SECURITY		2
-#define SQUASHFS_XATTR_VALUE_OOL	256
-#define SQUASHFS_XATTR_PREFIX_MASK	0xff
+#define SQUASHFS_XATTR_USER			0
+#define SQUASHFS_XATTR_POSIX_ACL_ACCESS		1
+#define SQUASHFS_XATTR_POSIX_ACL_DEFAULT	2
+#define SQUASHFS_XATTR_TRUSTED			3
+#define SQUASHFS_XATTR_SECURITY			4
+#define SQUASHFS_XATTR_VALUE_OOL		256
+#define SQUASHFS_XATTR_PREFIX_MASK		0xff
 
 /* Flag whether block is compressed or uncompressed, bit is set if block is
  * uncompressed */
-- 
2.17.1

