Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A3C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960BC218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfBZUvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:51:04 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45376 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbfBZUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:51:01 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id E34F55400DC;
        Tue, 26 Feb 2019 23:50:58 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] LSM: fix documentation for the path_chmod hook
Date:   Tue, 26 Feb 2019 23:49:07 +0300
Message-Id: <50913403d6aefd7e490ddf4315084b2de336cd80.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The path_chmod hook was changed in the commit
"switch security_path_chmod() to struct path *" (cdcf116d44e7).
The argument @mnt was removed from the hook, @dentry was changed
to @path. This patch updates the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 79011eff9795..feedd03cbd59 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -303,10 +303,11 @@
  *	@new_dentry contains the dentry structure of the new link.
  *	Return 0 if permission is granted.
  * @path_chmod:
- *	Check for permission to change DAC's permission of a file or directory.
- *	@dentry contains the dentry structure.
- *	@mnt contains the vfsmnt structure.
- *	@mode contains DAC's mode.
+ *	Check for permission to change a mode of the file @path. The new
+ *	mode is specified in @mode.
+ *	@path contains the path structure of the file to change the mode.
+ *	@mode contains the new DAC's permission, which is a bitmask of
+ *	constants from <include/uapi/linux/stat.h>
  *	Return 0 if permission is granted.
  * @path_chown:
  *	Check for permission to change owner/group of a file or directory.
-- 
2.17.2

