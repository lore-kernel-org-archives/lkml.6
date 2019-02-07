Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2FBC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B221916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBGMpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60540 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:14 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id B4C865400AA;
        Thu,  7 Feb 2019 15:45:12 +0300 (MSK)
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
Subject: [PATCH 01/10] security: fix documentation for the sb_copy_data hook
Date:   Thu,  7 Feb 2019 15:44:49 +0300
Message-Id: <163c782b51c696ea210dfa9043ea64cabac44ef7.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @type argument of the sb_copy_data hook was removed
in the commit "LSM/SELinux: Interfaces to allow FS to control
mount options" (e0007529893c). This commit removes the description
of the @type argument from the LSM documentation.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9a0bdf91e646..de179331be5c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -111,7 +111,6 @@
  *	options cleanly (a filesystem may modify the data e.g. with strsep()).
  *	This also allows the original mount data to be stripped of security-
  *	specific options to avoid having to make filesystems aware of them.
- *	@type the type of filesystem being mounted.
  *	@orig the original mount data copied from userspace.
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
-- 
2.17.2

