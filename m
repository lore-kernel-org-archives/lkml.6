Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90256C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634D421902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBGMpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:25 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60590 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:23 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 58A675400AD;
        Thu,  7 Feb 2019 15:45:21 +0300 (MSK)
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
Subject: [PATCH 03/10] security: fix documentation for the socket_post_create hook
Date:   Thu,  7 Feb 2019 15:44:51 +0300
Message-Id: <79859c6d228789c3f287ccb46bd0ddeb46aefcdd.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
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
index a0555683db63..80e5f3421b91 100644
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

