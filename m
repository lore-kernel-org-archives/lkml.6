Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06720C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5434218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfBZUu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:50:59 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45352 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:50:59 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 46F825400C4;
        Tue, 26 Feb 2019 23:50:56 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     Stephen Smalley <sds@tycho.nsa.gov>
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
Subject: [PATCH v2 05/11] LSM: fix documentation for the socket_getpeersec_dgram hook
Date:   Tue, 26 Feb 2019 23:49:06 +0300
Message-Id: <b6a9ba2ba6f106d3bb0ba82c5edae8ed461e63ea.1551213058.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
References: <cover.1551213058.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socket_getpeersec_dgram hook was changed in the commit
"[AF_UNIX]: Kernel memory leak fix for af_unix datagram
getpeersec patch" (dc49c1f94e34). The arguments @secdata
and @seclen were changed to @sock and @secid. This patch
updates the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 603659fb795a..79011eff9795 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -857,13 +857,13 @@
  * @socket_getpeersec_dgram:
  *	This hook allows the security module to provide peer socket security
  *	state for udp sockets on a per-packet basis to userspace via
- *	getsockopt SO_GETPEERSEC.  The application must first have indicated
- *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
+ *	getsockopt SO_GETPEERSEC. The application must first have indicated
+ *	the IP_PASSSEC option via getsockopt. It can then retrieve the
  *	security state returned by this hook for a packet via the SCM_SECURITY
  *	ancillary message type.
- *	@skb is the skbuff for the packet being queried
- *	@secdata is a pointer to a buffer in which to copy the security data
- *	@seclen is the maximum length for @secdata
+ *	@sock contains the peer socket. May be NULL.
+ *	@skb is the sk_buff for the packet being queried. May be NULL.
+ *	@secid pointer to store the secid of the packet.
  *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
-- 
2.17.2

