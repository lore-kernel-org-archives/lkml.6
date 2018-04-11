Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464234-2-11577602499866110744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464233; b=li3UvN70HlPZXuzhws0F3vrEpbcZriGWCsQiZxMqScFjA8Ll8g
    p0tEbuf3WwlldBeij1Ooy2DeMWjRPRJEa2NsXfL4mjWKRYHHixVao/oG+eAYnniq
    04yhOXkkrImOxHf2dtGN7DEfO7iQFS953+HWj33xWfzHwfvgcS/vxsAKjzgP28Sd
    71R7fTeDaWy42yG2+lHHExH/54Bj/u46SMibjyExholQxO6UPhNNavYkO5gnPsCW
    F1vFsi476phdnYmgfMD/a7rIoj0EuKBL8xUKxomXHedmQERxF2JlPeJcUF1R+R7j
    V4EseX+HZX/S0LYW6abgfhpwudVLAVIn2+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464233;
    bh=FcOnBgDFm75L7TdCjfgB7ldaWBBGb4nal3hE/va0bc0=; b=r1FzFGBo1+pq
    7X55BX6fP6mPWRn1nvIbbhpyyEFCifviZZK+g0B3ZfMqEluZgTyORoLtEtW7qMF9
    Ei31RnK67hLHcpTb83UxT/RB53hNJH6L9bVzcD1m7uzkM2b0tHwa4mibewzJakV9
    3EkwErcHwSop/EyNoF6PmMtbii1UIqibMrQlQTZk3IIZRwzq+8VntF5X/O4viIFR
    fqpJyuyXFMpFSfPvjl5qFkvGhx6Nfr4DIRmz1eZjR6JiaQ+8zAAVF6Pd3uzs5HiX
    SC2rG+fTwmULtVIkBd+Chs3fyo/wEL6VPKeykazIOTLAJXAAxtbQTM9jBHGwo9Pd
    6n58gzHl6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAoUCvvorDfq3vtTqUruExIe3xYSDh3702HmtKTPe+imQksNibZxConIeYa98n4YgLLqqV7IwRQerh+R6LiCyBhUG8+V6tcXlwkDA+AdcfePY8BoYXuR
    WwSXOic8U016+4jn+YvKb2Vzz4Z4fCg31hlC2vTQuDpZQOeAIouuvXlWRyigmxfkEaXUaPjTp3/JWw2mH+rM+3TuQEZqusgEgUu1DBeRb3V7nhbTb+5MC/VZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
    a=5b9ipl2Uh9xIKf7PROsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeDKQZK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbeDKQZH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:07 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/24] Enforce module signatures if the kernel is locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:05 +0100
Message-ID: <152346390539.4030.2913584917609215556.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the kernel is locked down, require that all modules have valid
signatures that we can verify or that IMA can validate the file.

I have adjusted the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
     ENOKEY), then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If IMA will have validated the image, return 0 (okay).

     (c) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
     return the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not
be valid or might not have been transferred to the kernel's clock yet.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: "Lee, Chun-Yi" <jlee@suse.com>
cc: James Morris <james.l.morris@oracle.com>
---

 kernel/module.c |   56 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index a6e43a5806a1..9c1709a05037 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/ima.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2761,10 +2762,12 @@ static inline void kmemleak_load_module(const struct module *mod,
 #endif
 
 #ifdef CONFIG_MODULE_SIG
-static int module_sig_check(struct load_info *info, int flags)
+static int module_sig_check(struct load_info *info, int flags,
+			    bool can_do_ima_check)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2779,19 +2782,46 @@ static int module_sig_check(struct load_info *info, int flags)
 		err = mod_verify_sig(mod, &info->len);
 	}
 
-	if (!err) {
+	switch (err) {
+	case 0:
 		info->sig_ok = true;
 		return 0;
-	}
 
-	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !sig_enforce)
-		err = 0;
+		/* We don't permit modules to be loaded into trusted kernels
+		 * without a valid signature on them, but if we're not
+		 * enforcing, certain errors are non-fatal.
+		 */
+	case -ENODATA:
+		reason = "Loading of unsigned module";
+		goto decide;
+	case -ENOPKG:
+		reason = "Loading of module with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "Loading of module with unavailable key";
+	decide:
+		if (sig_enforce) {
+			pr_notice("%s is rejected\n", reason);
+			return -EKEYREJECTED;
+		}
 
-	return err;
+		if (can_do_ima_check && is_ima_appraise_enabled())
+			return 0;
+		if (kernel_is_locked_down(reason))
+			return -EPERM;
+		return 0;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		return err;
+	}
 }
 #else /* !CONFIG_MODULE_SIG */
-static int module_sig_check(struct load_info *info, int flags)
+static int module_sig_check(struct load_info *info, int flags,
+			    bool can_do_ima_check)
 {
 	return 0;
 }
@@ -3651,13 +3681,13 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static int load_module(struct load_info *info, const char __user *uargs,
-		       int flags)
+		       int flags, bool can_do_ima_check)
 {
 	struct module *mod;
 	long err;
 	char *after_dashes;
 
-	err = module_sig_check(info, flags);
+	err = module_sig_check(info, flags, can_do_ima_check);
 	if (err)
 		goto free_copy;
 
@@ -3846,7 +3876,7 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	if (err)
 		return err;
 
-	return load_module(&info, uargs, 0);
+	return load_module(&info, uargs, 0, false);
 }
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
@@ -3873,7 +3903,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	info.hdr = hdr;
 	info.len = size;
 
-	return load_module(&info, uargs, flags);
+	return load_module(&info, uargs, flags, true);
 }
 
 static inline int within(unsigned long addr, void *start, unsigned long size)

