Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67071C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303AF21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBGMpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:46 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60706 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:43 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id B25845400AA;
        Thu,  7 Feb 2019 15:45:41 +0300 (MSK)
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
Subject: [PATCH 07/10] security: fix documentation for the audit_* hooks
Date:   Thu,  7 Feb 2019 15:44:55 +0300
Message-Id: <f898992a1f64c816b945fd3b6208b2f82ed95d15.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation for the audit_* hooks
to use the same arguments names as in the hook's declarations.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5d6428d0027b..307714b8b072 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,7 +1329,7 @@
  * @audit_rule_known:
  *	Specifies whether given @rule contains any fields related to
  *	current LSM.
- *	@rule contains the audit rule of interest.
+ *	@krule contains the audit rule of interest.
  *	Return 1 in case of relation found, 0 otherwise.
  *
  * @audit_rule_match:
@@ -1338,14 +1338,14 @@
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

