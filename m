Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB17C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A549218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfBZUvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:51:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45394 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbfBZUvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:51:06 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6FA0F5400DD;
        Tue, 26 Feb 2019 23:51:03 +0300 (MSK)
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
Subject: [PATCH v2 07/11] LSM: fix documentation for the audit_* hooks
Date:   Tue, 26 Feb 2019 23:49:08 +0300
Message-Id: <dcb793c5cf4212c2f1adaaed2d0bf62c36fd489b.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation for the audit_* hooks
to use the same arguments names as in the hook's declarations.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index feedd03cbd59..1d60b07f30ab 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,9 +1329,9 @@
  *	-EINVAL in case of an invalid rule.
  *
  * @audit_rule_known:
- *	Specifies whether given @rule contains any fields related to
+ *	Specifies whether given @krule contains any fields related to
  *	current LSM.
- *	@rule contains the audit rule of interest.
+ *	@krule contains the audit rule of interest.
  *	Return 1 in case of relation found, 0 otherwise.
  *
  * @audit_rule_match:
@@ -1340,14 +1340,14 @@
  *	@secid contains the security id in question.
  *	@field contains the field which relates to current LSM.
  *	@op contains the operator that will be used for matching.
- *	@rule points to the audit rule that will be checked against.
+ *	@lsmrule points to the audit rule that will be checked against.
  *	@actx points to the audit context associated with the check.
  *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
  *
  * @audit_rule_free:
  *	Deallocate the LSM audit rule structure previously allocated by
  *	audit_rule_init.
- *	@rule contains the allocated rule
+ *	@lsmrule contains the allocated rule.
  *
  * @inode_invalidate_secctx:
  *	Notify the security module that it must revalidate the security context
-- 
2.17.2

