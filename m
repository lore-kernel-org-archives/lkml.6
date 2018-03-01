Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933688-2-17946031699305606770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519933687; b=D25VDelc+BGdsehnRidwMFzPek2aDPLcGba6Y9OLXZxfRIj
    XC8QB+/kre94GAii8v08P9Qv3qLIY1iGqA4uIBReDn+emia/3FPBcR0zveN3dsOJ
    cCQtCzjYup8zrlpfqOULNT1DABOxAFqd/cYi4PtNSafaLd5m5TY+L/GvmE/9exx1
    QyiYPv1IYq8vN9C4R+GAE1GTK/0cgOZj5thHv4S941juT8GmORPdLHp1vqE9gXmz
    Wg7TA1QMK5A96LlvSGIV6uhtVxO+jRD7npuhClj1PBLzvfcKYYnZEo272Gcu3jnF
    7++H7e5i+PwcS6EkM56FW7Hhx3hyMlUHYIDe10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933687; bh=2WRwnyGKhy5jrti2VGlrfdp8IWeqfL0z11c
    rYZK6ApY=; b=RfXTVRHg4BRYRr0SWmtHNDkcmZau2EibCg4sXqa8OzizDuc3uZX
    dLoF0gMZRXt5C4d5YzgiePQPYGy69OiLEqnIcCiY0zEuw81m20G6VOLF/TYCksqp
    9nx9cgFRG+tAD/yks8tjdDmOYMuqRPJV+rWMOXxwIzD+H+gnS1+YTSNmU7Vp9OzA
    +w2m/m/RP7swTAH34JGCpD/PM3eF62cCZGUHWhzLuJ4ueUct58ZhAgMMfjUeKEw8
    UZXlqtWvp1qDuEt7dMdH5F7nJlsCED2hznrFPJxKuYbu8JZe1fQe2eh6goM5VqRY
    mvRkAnMYN3DQKeFCNRJix63+wOTcrSN/+Hw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033854AbeCATrV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:47:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033812AbeCATrR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:47:17 -0500
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
Subject: [RFC PATCH V1 10/12] audit: add containerid support for seccomp and anom_abend records
Date: Thu,  1 Mar 2018 14:41:13 -0500
Message-Id: <a7d7447356a7f6335d6a393ec97d1fbbc341ba33.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID information to secure computing and abnormal end
standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0cbd762..fcee34e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2569,6 +2569,7 @@ static void audit_log_task(struct audit_buffer *ab)
 void audit_core_dumps(long signr)
 {
 	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
 
 	if (!audit_enabled)
 		return;
@@ -2576,19 +2577,22 @@ void audit_core_dumps(long signr)
 	if (signr == SIGQUIT)	/* don't care for those */
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_ANOM_ABEND);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_ANOM_ABEND);
 	if (unlikely(!ab))
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld res=1", signr);
 	audit_log_end(ab);
+	audit_log_container_info(context, "abend", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 void __audit_seccomp(unsigned long syscall, long signr, int code)
 {
 	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_SECCOMP);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_SECCOMP);
 	if (unlikely(!ab))
 		return;
 	audit_log_task(ab);
@@ -2596,6 +2600,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 			 signr, syscall_get_arch(), syscall,
 			 in_compat_syscall(), KSTK_EIP(current), code);
 	audit_log_end(ab);
+	audit_log_container_info(context, "seccomp", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 struct list_head *audit_killed_trees(void)
-- 
1.8.3.1

