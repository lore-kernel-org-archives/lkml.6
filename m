Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C10C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5345C2175D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDQfTDzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5345C2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbeHGMCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:02:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35571 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeHGMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:02:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10-v6so748785pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ald4abrKdW8AbO7gX/eespEZrXh8gG1ZicKya1SVk3k=;
        b=KDQfTDzCOQXKgVbxJ2h8CRnEcctIBr+Scp4ni7JU2Y7qc95aUYHO6U3ycWqUbCeL8/
         ICJFtarUrkXKiivSC8fhOQFIs9jvkiQf/xsErI/bLjxg+BedPKmcDYxR4WwSgG0wPLx1
         nH9qgvv8tOSfkvpSQcIwi6bM9+f5OD/0ae2d3UX7R2d+eyEESJbsypqhxmGmOILLH0tF
         U6U0BiBN9uNx4S4O+/4oxyyzf+Q0gnRH78GGbLu6RU4EPZWWNEP/6SKRMnchU41LHCt0
         2DHcI076/OkFBbXrnNMPKDPB/5Ye3rufTneeuVnwkKU92R5GZXJaYeUVLGZm46wIkN3C
         gCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ald4abrKdW8AbO7gX/eespEZrXh8gG1ZicKya1SVk3k=;
        b=nw+nulALn4YzW8Qcdz/ZAAnxISmbv/icZOJYGIUB2aXwymCpHLoTa3ze9LJjli+KIl
         ySgJkzhHb185Oy+RrH4IWwikwiUk/85B1AJQ/LNmhDmvvB0Wn4QXOx/RElYxKhA6J3/y
         s6+4k91MWUwsstePQQT32k+b3QN8AXmD3JKeezmToOsNYFbDoWWOitSfuO5b0gsPUuRc
         Cxqwwm3KvFZkVQdJoTkYBtpWSUYlyz6c8G6bHba8pyJgc8PTV0gbjMuOkyN2hDoRpi9G
         O44eBA4dfH06djFuT+ZzsXERyVYgkatEDuTn8S3rhEAUg9KQHQgOwgU6k15dLVTFsV5I
         YzaQ==
X-Gm-Message-State: AOUpUlGcqhS3GgPK2d8lm04HJFF7sts/4mXPZGwPxM+akLnT4e5ex7Vv
        Bk/0JKWEsIxFS7J0PdBtAIeOnJKU
X-Google-Smtp-Source: AAOMgpcOuLkJTXTgx5Ahs2qgFGJYpwio434OznzIlxG3x0vJTJq7vD22du+VjXIO4T/LOTxx1VtLaA==
X-Received: by 2002:a65:46ca:: with SMTP id n10-v6mr18320991pgr.345.1533635356894;
        Tue, 07 Aug 2018 02:49:16 -0700 (PDT)
Received: from localhost (outboundhk.mxmail.xiaomi.com. [207.226.244.123])
        by smtp.gmail.com with ESMTPSA id f186-v6sm1459529pgc.4.2018.08.07.02.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 02:49:16 -0700 (PDT)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] squashfs-tools: Add posix acl support
Date:   Tue,  7 Aug 2018 17:49:09 +0800
Message-Id: <98e59e006ceccfb6821b54cfa93f3dc18489d8b7.1533630965.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533630854.git.geliangtang@gmail.com>
References: <cover.1533630854.git.geliangtang@gmail.com>
In-Reply-To: <1702a314dc9de4626fbefc788213a578be88f184.1533630854.git.geliangtang@gmail.com>
References: <cover.1533630854.git.geliangtang@gmail.com> <1702a314dc9de4626fbefc788213a578be88f184.1533630854.git.geliangtang@gmail.com>
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

