Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56F3C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DA62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="skIuVzj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DA62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeK0KpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:45:01 -0500
Received: from sonic309-48.consmr.mail.ne1.yahoo.com ([66.163.184.174]:46852
        "EHLO sonic309-48.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbeK0KpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276149; bh=mOH1jMGSjEQ/xFrT6GtLpC/r3huR+zGxEWp8FnuIDGw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=skIuVzj6GesAhMBCuXNCurKLMmgw4kDrOdXkmSGufOMk+tgiE20NK6w3dvGRd/qDOOj3DxHP1xotD77hN2vYTC833ZV9j9isL5NiHGnG5+nhB/WgmpIUYb5Jo9WbrvkhsSQxDL0x3q+6FUTPI/na/xrHqiooY/CoBL0B8KA/8gUxzp0XzM5xQ9m839OIBCjq5XA6Nr7ghaYxJCQbjfcbuuIRZ40g4UdnH6sPg5rEnSEU1mH1vx7O+9UDCtIP+GrN19TCV1j0YbLWw3cuDGmdoeBSdToSzKyWKik1PlKaLzrvGTIoKqXxord/NSkH5fadeGHBDm6h9Nhg41X+TXjO8Q==
X-YMail-OSG: d3pmbgEVM1llWOF2tZuzwc9V9jVaNTKNwr9e4YE8huehbYkgGKsge_S0oUfznnR
 lXhuy_6UO3A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:49:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5288dd96c25f63a0964f292e22c42e02;
          Mon, 26 Nov 2018 23:45:08 +0000 (UTC)
Subject: [PATCH v5 24/38] SELinux: Remove unused selinux_is_enabled
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8b7b3c7e-acd1-cd0f-95a3-02f09bfbfc96@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:45:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/cred.h             |  1 -
 include/linux/selinux.h          | 35 -----------------------------------
 security/selinux/Makefile        |  2 +-
 security/selinux/exports.c       | 23 -----------------------
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
index 41b230d459a6..c82f11270de6 100644
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
index 12e414394530..1a745e2f49a9 100644
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
2.14.5


