Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BD5ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38E92150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PchEoz7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38E92150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbeITGAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:00:53 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:46344 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727632AbeITGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402825; bh=tW98kW7ydoNWqgAJkvlmczWEOzk/bW3JvbuBz1eIV90=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=PchEoz7Wm3QEQwqzRHgYQ+hGUrXqpCOMO8A/f3N6IK8v/4bsKec4nWxhBk3a+WQjZuirjOGIA05McHfnGSPtjL6giIkc3PoLKzVw8daR3joLmRn+xG22QI6CKMnI2ACbJ49rVefJGifc/TsvJBJ4C0KaKjGkupA18O3IkNChd7EJIetwo4Mt/DrwDNeIGIW4Dpz1i1+/ClKaJL8hVRKjdzt+lWTMX0q4JP3rAVsjHRKze0Mt0cR0v9iG+4tmxGws6chZWbigJB5+TK921Qyab4ZxLWQEbflg+7mu4xkcNC5lx57aJu6sYQ+dz3gqqyGyCpHfiR6rwkJGEhzTb3fxEQ==
X-YMail-OSG: 0CAhtPwVM1mEe.NS_d65L5bvbWz1hNlEQEbcLDEKpfPLbpoyO5b9nICyjoUJCdG
 mQACUaZgDxR2xBMlOnyPY9F4QB00WUw2.gSlVgaumd9gs.NLCuJlN2P1nBTVsjZ5eSXGOTEoaZ0_
 wy6R6NHb_iVfh6oleKG5QNyI.qf9rivXqeIyr562TJFnzf.OupbYkJ8F.PIFni_Ljus9_.0YnN6Y
 8ZWG5dS0J_jI8X2ZSGxzs2vdxgC6Co1Gjz.taAw0M7PSJtO0IIqqJkQCZluBqVH_DYXOUn5ECUIT
 OR..sM24E.CT71lJxJlPGSFOb59ou.I6GKkI.obmykJMq3Aty3YKn4M3u7rImFJeyCMFFoNbpZyU
 GIlr5PC4vjZyhIJpb01Pjc_uZKdZ1mnuckvs0TRB69JCRw5vxxxYwO5GTz6pK9oUkAVDjnqvf6N1
 nDWKnXq.axcD8OhnKT9xV3OuWiK8S3Qa42MTGDAY96.f_ZCED9lhTe6jkI8vA.IBdSSRFpbOcpsA
 l9CXiY494zB82eSF0NNIyG3cimkl5SQ2th69wAp9DKDe8WJjfnbJDxaP0oX5.qB3iYmSqpl1sFuL
 E6mMgR4u2lpNG1PFpOFehNftA76UB5B2PeSw.Zwog20_tben0iKvbvuxnnj2CLb_4zGV5uozpNYP
 jpfFya7HEIkl0WNW0ho.qZJQIOefcqw4kuL2_JPie2pBGSLTmWCVhgLyI4JyltPvhg7Ra51PPGhm
 7C48rj5dbsI3dWBhXroXtvgJWCQS3sWH92vOqKhaBaFbl_T5xIicCSnLfP6CT6UYUA1QzlNV6JFJ
 XzqWz4crF8Qwb.wEvIN8hxzZntWl_WtfJi4qEJHhxR1c6cSlwUab9VGHnfplbbrfTSSuNth_D6Gx
 .cmUXgckCf7gw35oDe8iON7EeAovqNRf2y0Gjdr3N381VqfNTxEH_YZnsdyWjFQ80d8tggknMTtL
 d04bNQGdRzu_xSBDl8N9wi6xE1IvLHW._CB4eff8xT7oMhaZw6FeWmRJ01TcUuj9fJ3wsSnpcmnw
 rNcXIFog-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:20:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 007b3a714951275b603f755216446471;
          Thu, 20 Sep 2018 00:20:24 +0000 (UTC)
Subject: [PATCH v3 05/16] SELinux: Remove unused selinux_is_enabled
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bc0785c2-604b-2204-9103-ac9e70d18b8a@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:20:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SELinux: Remove unused selinux_is_enabled

There are no longer users of selinux_is_enabled().
Remove it. As selinux_is_enabled() is the only reason
for include/linux/selinux.h remove that as well.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h             |  1 -
 include/linux/selinux.h          | 35 --------------------------------
 security/selinux/Makefile        |  2 +-
 security/selinux/exports.c       | 23 ---------------------
 security/selinux/hooks.c         |  1 -
 security/selinux/include/audit.h |  3 ---
 security/selinux/ss/services.c   |  1 -
 7 files changed, 1 insertion(+), 65 deletions(-)
 delete mode 100644 include/linux/selinux.h
 delete mode 100644 security/selinux/exports.c

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 7eed6101c791..2e715e202e6a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -15,7 +15,6 @@
 #include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/key.h>
-#include <linux/selinux.h>
 #include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/sched.h>
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
deleted file mode 100644
index 44f459612690..000000000000
--- a/include/linux/selinux.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * SELinux services exported to the rest of the kernel.
- *
- * Author: James Morris <jmorris@redhat.com>
- *
- * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
- * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2,
- * as published by the Free Software Foundation.
- */
-#ifndef _LINUX_SELINUX_H
-#define _LINUX_SELINUX_H
-
-struct selinux_audit_rule;
-struct audit_context;
-struct kern_ipc_perm;
-
-#ifdef CONFIG_SECURITY_SELINUX
-
-/**
- * selinux_is_enabled - is SELinux enabled?
- */
-bool selinux_is_enabled(void);
-#else
-
-static inline bool selinux_is_enabled(void)
-{
-	return false;
-}
-#endif	/* CONFIG_SECURITY_SELINUX */
-
-#endif /* _LINUX_SELINUX_H */
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8792b2..ccf950409384 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o ibpkey.o exports.o \
+	     netnode.o netport.o ibpkey.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
deleted file mode 100644
index e75dd94e2d2b..000000000000
--- a/security/selinux/exports.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * SELinux services exported to the rest of the kernel.
- *
- * Author: James Morris <jmorris@redhat.com>
- *
- * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
- * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2,
- * as published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/selinux.h>
-
-#include "security.h"
-
-bool selinux_is_enabled(void)
-{
-	return selinux_enabled;
-}
-EXPORT_SYMBOL_GPL(selinux_is_enabled);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 80614ca25a2b..82b28ee878c4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -79,7 +79,6 @@
 #include <linux/personality.h>
 #include <linux/audit.h>
 #include <linux/string.h>
-#include <linux/selinux.h>
 #include <linux/mutex.h>
 #include <linux/posix-timers.h>
 #include <linux/syslog.h>
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 1bdf973433cc..36e1d44c0209 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -1,9 +1,6 @@
 /*
  * SELinux support for the Audit LSM hooks
  *
- * Most of below header was moved from include/linux/selinux.h which
- * is released under below copyrights:
- *
  * Author: James Morris <jmorris@redhat.com>
  *
  * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f3def298a90e..e2235f1a99aa 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -49,7 +49,6 @@
 #include <linux/sched.h>
 #include <linux/audit.h>
 #include <linux/mutex.h>
-#include <linux/selinux.h>
 #include <linux/flex_array.h>
 #include <linux/vmalloc.h>
 #include <net/netlabel.h>
-- 
2.17.1


