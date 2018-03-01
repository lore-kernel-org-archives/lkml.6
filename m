Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933787-2-16716587523428617526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519933786; b=N6LOVWRNVu3VLnPpq/DXrj0BS1CFRrzpZHgcuhOredx/E9w
    fDAw6qGLBdc6seNwTvP5/maSAfa6H/pWxLAXUYJircegbjIbItB+yD8O9nguGFXD
    wMMm+Ler7PMBv4FaRzAIU8mJNlGXKNY9uZQN6wLyAAx/5MH2ll/B4E0b9kOTngHM
    ChJ05kby/0sX6TeUvnq9SL+S+GbFX4GI+oBGZLd7pX7NnZExJeUHgieA8IMUHF1M
    4sTE7wPuGowVsvnUjXf0FnUdcopOzJUti1eU3oQkHmkMV5yTEjcLyJQIk12JhWhe
    V0v/dDXgRxP7cr3j4a/lGWwbOMDEf7/0U44Ku5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933786; bh=+xvR4+zNDYkbElos6/OGAsAVX425qNFIt/w
    xvUSWmyk=; b=GXDa65zsp6O99Fxgljas+wtgFKn85efGP7VldVf5JXzNb11AROa
    INRCgZPQFsgEamYDh8DGq4fPOZ2uO4U4j63Mnduubr3pHWircJycGO8cefMtRYz1
    tyiGYGq+AeYvnlK239RZDIEdrS7k2gVYGdjfMRzL3n0Nj7E4xpsIayYhAzoyFx7w
    Ny56pSNwPDx/yl/rFGQG8UUWJa6bpws6rrVlM/keYg/uPiBNlcY8gVS9raQ/A8zP
    z7gBkgSkWISdPDqT0y7a20vtc3J4ywZOzMXFhYqzC/yLJhUhvahIvbMJgY7sEPUY
    VB6mR+ziI09Tq5WjWzowWrUQjMkCr+eogow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033719AbeCATq6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:46:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033276AbeCATqz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:46:55 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: mszeredi@redhat.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, trondmy@primarydata.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com, madzcar@gmail.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH V1 06/12] audit: add support for non-syscall auxiliary records
Date: Thu,  1 Mar 2018 14:41:09 -0500
Message-Id: <e26d089d495f2ffd1d4e1f3de7730aa209340a59.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Standalone audit records have the timestamp and serial number generated
on the fly and as such are unique, making them standalone.  This is a
prototype of a method to generate a local audit context that will be
used only for a standalone record and its auxiliary record.  The context
is discarded immediately after the local associated records are
produced.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h |  8 ++++++++
 kernel/auditsc.c      | 20 +++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index ed16bb6..c0b83cb 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -227,7 +227,9 @@ static inline int audit_log_container_info(struct audit_context *context,
 /* These are defined in auditsc.c */
 				/* Public API */
 extern int  audit_alloc(struct task_struct *task);
+extern struct audit_context *audit_alloc_local(void);
 extern void __audit_free(struct task_struct *task);
+extern void audit_free_context(struct audit_context *context);
 extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
@@ -472,6 +474,12 @@ static inline int audit_alloc(struct task_struct *task)
 {
 	return 0;
 }
+static inline struct audit_context *audit_alloc_local(void)
+{
+	return NULL;
+}
+static inline void audit_free_context(struct audit_context *context)
+{ }
 static inline void audit_free(struct task_struct *task)
 { }
 static inline void audit_syscall_entry(int major, unsigned long a0,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0e41884..0cbd762 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -959,8 +959,26 @@ int audit_alloc(struct task_struct *tsk)
 	return 0;
 }
 
-static inline void audit_free_context(struct audit_context *context)
+struct audit_context *audit_alloc_local(void)
 {
+	struct audit_context *context;
+
+	if (likely(!audit_ever_enabled))
+		return NULL; /* Return if not auditing. */
+
+	context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
+	if (!context)
+		return NULL;
+	context->serial = audit_serial();
+	context->ctime = current_kernel_time64();
+	context->in_syscall = 1;
+	return context;
+}
+
+inline void audit_free_context(struct audit_context *context)
+{
+	if (!context)
+		return;
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
 	free_tree_refs(context);
-- 
1.8.3.1

