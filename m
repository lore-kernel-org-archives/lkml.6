Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1F021529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbeITU41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55341 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733292AbeITU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id f21-v6so10396638wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVfCHCWltHby4LkZUP1IHTTHkaGRqyiEBRTXLSOUhA8=;
        b=p+GP/4l9SlwdT3BaAxPZGEXW9stya7p7Jc0lRzvhMdQvbdSMyxCyiwh9DG/4Y3KC2R
         IyOt/NsU47ju+8P9jZbiLp7OlcxUnogmh5DUtxchbNPuMqJfDWMPLt8xjTpJk/NVAQbV
         ZcWW1jC8vP0XfaLeXV6JSIlMWqacaMfn9W5OHrj2FK4vSjgiHDQfxkia6ftLohrkiIpJ
         nxhpIMAbVVjmwnPeyQAqfcBLLbnckYcvAU4YORncn4iMmDH0IcqnoihMY5o9WcODvyx7
         T88MD7dZ7+6yOzxOjzMHGwaBN0UpqnyoKRFjiLbWr+jC2MQHGmdA80DUybG+CbF6Onpg
         6W5w==
X-Gm-Message-State: APzg51CAIA4aMttfKds9AEZtq+/34+DNkt/QFEmeg7oyCHWvHa5I3cZD
        yz6ljWjZ9E9ncXkr5XNQVDoXNg==
X-Google-Smtp-Source: ANB0Vdb2/c1Ewj7xGqP8c3nCRRDeZ1eNh93H9kCtIc1ziv7EtEqfdB7uMEx/sFTu+zJQOOW6uWR72A==
X-Received: by 2002:a1c:bc87:: with SMTP id m129-v6mr3043187wmf.158.1537456349445;
        Thu, 20 Sep 2018 08:12:29 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:28 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] fsconfig: rename FSCONFIG_CMD_CREATE to FSCONFIG_CMD_OBTAIN
Date:   Thu, 20 Sep 2018 17:12:14 +0200
Message-Id: <20180920151214.15484-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180920151214.15484-1-mszeredi@redhat.com>
References: <20180920151214.15484-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old name strongly implies that a new superblock will be created from
the fs_context.  This is not true: filesystems are free to retuse an
existing superblock and return that (for good reason).

To avoid confusion, rename this command to something more appropriate.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fsopen.c                | 6 +++---
 include/uapi/linux/fs.h    | 2 +-
 samples/vfs/test-fsmount.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 9ead9220e2cb..bf1ff70b1fe2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -311,7 +311,7 @@ static int vfs_fsconfig_action(struct fs_context *fc, enum fsconfig_command cmd)
 	int ret = -EINVAL;
 
 	switch (cmd) {
-	case FSCONFIG_CMD_CREATE:
+	case FSCONFIG_CMD_OBTAIN:
 		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
 			return -EBUSY;
 		fc->phase = FS_CONTEXT_CREATING;
@@ -434,7 +434,7 @@ SYSCALL_DEFINE5(fsconfig,
 		if (!_key || _value || aux < 0)
 			return -EINVAL;
 		break;
-	case FSCONFIG_CMD_CREATE:
+	case FSCONFIG_CMD_OBTAIN:
 	case FSCONFIG_CMD_RECONFIGURE:
 		if (_key || _value || aux)
 			return -EINVAL;
@@ -523,7 +523,7 @@ SYSCALL_DEFINE5(fsconfig,
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret == 0) {
 		switch (cmd) {
-		case FSCONFIG_CMD_CREATE:
+		case FSCONFIG_CMD_OBTAIN:
 		case FSCONFIG_CMD_RECONFIGURE:
 			ret = vfs_fsconfig_action(fc, cmd);
 			break;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 7f01503a9e9b..169642bb2656 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -366,7 +366,7 @@ enum fsconfig_command {
 	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
 	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
 	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
-	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
+	FSCONFIG_CMD_OBTAIN	= 6,	/* Obtain new or existing superblock */
 	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
 };
 
diff --git a/samples/vfs/test-fsmount.c b/samples/vfs/test-fsmount.c
index 74124025ade0..a161dc530a91 100644
--- a/samples/vfs/test-fsmount.c
+++ b/samples/vfs/test-fsmount.c
@@ -101,7 +101,7 @@ int main(int argc, char *argv[])
 	}
 
 	E_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "#grand.central.org:root.cell.", 0);
-	E_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	E_fsconfig(fsfd, FSCONFIG_CMD_OBTAIN, NULL, NULL, 0);
 
 	mfd = fsmount(fsfd, 0, MS_RDONLY);
 	if (mfd < 0)
-- 
2.14.3

