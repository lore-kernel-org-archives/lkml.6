Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A22DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46075218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfBZUui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:50:38 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45222 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:50:37 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7B8FC5400C1;
        Tue, 26 Feb 2019 23:50:35 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     Eric Paris <eparis@parisplace.org>
Cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] LSM: fix documentation for the syslog hook
Date:   Tue, 26 Feb 2019 23:49:03 +0300
Message-Id: <28416926bb1df87b8b72588999dd90d64ecc9e87.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syslog hook was changed in the commit
"capabilities/syslog: open code cap_syslog logic to
fix build failure" (12b3052c3ee8). The argument @from_file
was removed from the hook. This patch updates the
documentation for the syslog hook accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1a01383403b3..3f0a0e2c5fba 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1275,8 +1275,7 @@
  *	Check permission before accessing the kernel message ring or changing
  *	logging to the console.
  *	See the syslog(2) manual page for an explanation of the @type values.
- *	@type contains the type of action.
- *	@from_file indicates the context of action (if it came from /proc).
+ *	@type contains the SYSLOG_ACTION_* constant from <include/linux/syslog.h>
  *	Return 0 if permission is granted.
  * @settime:
  *	Check permission to change the system time.
-- 
2.17.2

