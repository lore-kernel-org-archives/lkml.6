Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07687C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2E221902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBGMpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:19 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60564 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:17 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6FEEE5400A9;
        Thu,  7 Feb 2019 15:45:15 +0300 (MSK)
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
Subject: [PATCH 02/10] security: fix documentation for the syslog hook
Date:   Thu,  7 Feb 2019 15:44:50 +0300
Message-Id: <70ac80069eb645ffa3a30d8206acb066cb2810b9.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
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
 include/linux/lsm_hooks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index de179331be5c..a0555683db63 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1276,7 +1276,6 @@
  *	logging to the console.
  *	See the syslog(2) manual page for an explanation of the @type values.
  *	@type contains the type of action.
- *	@from_file indicates the context of action (if it came from /proc).
  *	Return 0 if permission is granted.
  * @settime:
  *	Check permission to change the system time.
-- 
2.17.2

