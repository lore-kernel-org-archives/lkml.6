Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CAECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF9721569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vc0zlRYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF9721569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbeIVGJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:09:00 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:39910 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391734AbeIVGJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575463; bh=IMmQkbUcHQ8vi6SVn3BZgviVDtcaEzGW2cw/jNYk9Ds=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Vc0zlRYpNTzSqAO7GlZUTUpq3RdjFUPbqz3IwsETErRTeOJvDaCTYT8B65bTpbAHdMTV4nycqPcY2K2t7x+4uropOcorKcWHgWU2l/tMEQc7XNrgErfqkBHJLGILzPHyQALzjpLBc0hkonpg7dIU2HD3idx75XvwJC7ApbUFPBjbD0PVi81gYxDpWv2mQhlug620+v8VWOhLx+36vj2VfIgGsPCmvbQ6qJ5+AJmavBpL6E4sM7IJlvCmABP5HiZGbeveIfCRI/W/+UOHc+TIA2cvjPXD7YVaAYNu5jh5+zDTGQX9sb/rHvwLVo6Q59Lc/gYmLvNorn3GFnE+KkIdCw==
X-YMail-OSG: 1Xg8rXMVM1nd86E8JcTqcoiU.FmDSMDjbGAR3aQZDaMg0JHesakLCi8KJ.b2xv0
 j8WINHOOXpkuw7IuODZkSE5rv5jUJMboVvFK._Ib3f0fnXoigQZSBjL08XHNwuiCsIGTMbU90jSQ
 23iFFMDjDaCxYYy8fR5QfDFHPRyXgBEPcRaqrVtPj6RmukbemzgdtYHyp3QXYYddZogwhjHxYkWF
 .cZKGhNRywp.QmZYS1Z7Q3F7R4OIh_eDPK_h857EwOU4bpyoB3H6e8.KGIQgvthfkpKL0Cbw7pyP
 EKRgzwdcSLCAqNRMbiKcS0vydzD8FZP3mE9L59ao6ExUYYiom_vDQgPHpOThAAPsoonEEEf_ZpJC
 k9MQgtOIjNTK94AEiEfh1RAEOY7cITpIjnrvYQiqVtsDnBKOewoaSnf4VOeb9eFVwQPYkt1LxkBa
 X_Fp8_B_m2PIf4H8jTwxs8yUsoZNRLhTc4p32RCDmLsf2qNZ.Wn_kaeXPISOAQUIn3Ype5IRGtaM
 kEB4vxyIJ_24zKntHeY_cxk3Hl9xqfDG5G1JWj9eX4kp.P6sGfJeXFolEU1_qlduJUnP_jk0A6Rd
 vjpkG0rWJc1Tf4na2jFqW8.0IIyh5goCfeQqef4X_6TOBpf2pYyPePUgIk46hFEth.P1bruqoi9L
 fMwZeAsDv11iGjTE5eRp48.B6tBDggEio3SbRQPuF2st1o_aZSFB9ONXwc.d3ncwj5l9tOiIC1bA
 lWgzAcW4Il_I2Z_eFeLSxQ.yUwxL4QA2mOJUxnZugeIhiIMkhc4aX1AcwFrxXSZsj5oBOM4OniVJ
 jNhS.YB3LIcK7_rorr5QY_2dH1_kEa0SgqRWUiobDzxbHPplhAwXceXtYD1Tuui2GD6_QNFZb8m3
 IWvRlei8DbJCz_78dtUioL0JuX.T9Eha551..V.Zm.C_8CVgu6pqBxDu0C0CnAW_IGFrMptDWs__
 ca_H4TQwG_gFFJDYqXbAiVi0nD119XVWqMZUiP7G.XuNeMelnp1xX10WfWdmHjZFGD955kXDwd3y
 .1sh4TSY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:17:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cce5fe6cae5445a550b287377f7a228d;
          Sat, 22 Sep 2018 00:17:40 +0000 (UTC)
Subject: [PATCH v4 05/19] SELinux: Remove unused selinux_is_enabled
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
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c7a864e4-1297-2973-9d4c-7c855a20a06d@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:17:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


