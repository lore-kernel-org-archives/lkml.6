Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CDC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D03C21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBGMp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:29 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60632 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:26 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7DA575400AA;
        Thu,  7 Feb 2019 15:45:24 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
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
Subject: [PATCH 04/10] security: fix documentation for the task_setscheduler hook
Date:   Thu,  7 Feb 2019 15:44:52 +0300
Message-Id: <ea5e1cb926ccf815803e1fc4967e1bf8a390b07e.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task_setscheduler hook was changed in the commit
"security: remove unused parameter from security_task_setscheduler()"
(b0ae19811375). The arguments @policy, @lp were removed from the hook.
This patch updates the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 80e5f3421b91..09223911876e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -655,10 +655,8 @@
  *	Return 0 if permission is granted.
  * @task_setscheduler:
  *	Check permission before setting scheduling policy and/or parameters of
- *	process @p based on @policy and @lp.
+ *	process @p.
  *	@p contains the task_struct for process.
- *	@policy contains the scheduling policy.
- *	@lp contains the scheduling parameters.
  *	Return 0 if permission is granted.
  * @task_getscheduler:
  *	Check permission before obtaining scheduling information for process
-- 
2.17.2

