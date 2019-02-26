Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D100CC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C414218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfBZUus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:50:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45266 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:50:48 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id E90575400C2;
        Tue, 26 Feb 2019 23:50:45 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Denis Efremov <efremov@ispras.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] LSM: fix documentation for the socket_post_create hook
Date:   Tue, 26 Feb 2019 23:49:04 +0300
Message-Id: <a49b30ab49e56a4865980b73f37ccd2c3b0634d6.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch slightly fixes the documentation for the
socket_post_create hook. The documentation states that
i_security field is accessible through inode field of socket
structure (i.e., 'sock->inode->i_security'). There is no inode
field in the socket structure. The i_security field is accessible
through SOCK_INODE macro. The patch updates the documentation
to reflect this.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3f0a0e2c5fba..90bbc11fdc13 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -752,9 +752,9 @@
  *	socket structure, but rather, the socket security information is stored
  *	in the associated inode.  Typically, the inode alloc_security hook will
  *	allocate and and attach security information to
- *	sock->inode->i_security.  This hook may be used to update the
- *	sock->inode->i_security field with additional information that wasn't
- *	available when the inode was allocated.
+ *	SOCK_INODE(sock)->i_security.  This hook may be used to update the
+ *	SOCK_INODE(sock)->i_security field with additional information that
+ *	wasn't available when the inode was allocated.
  *	@sock contains the newly created socket structure.
  *	@family contains the requested protocol family.
  *	@type contains the requested communications type.
-- 
2.17.2

