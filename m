Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191366-2-3501046593537075134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1521191365; b=tlYCvn/rVyI6JXYo2rAz1zJ6609vYGWx8+0Uv4ZwoNl+P3i
    nVs+YlgJ0r8wKUNdwasgSRqMrAB1OR9LAmvL8TUDoqqs7FCL6RsNARwAXuAyimCF
    xfCl6zm/fNZLtb2O9eh7pMN+jJQqWb8yeO9gq+WkGO+i2lnaB8XiLJvyyne5AVVd
    pmPeuwXFtsYnTyuS8re65BMFsRvRaFbtRipyB0nfyFQcfW48nzZwzrwq5i8NenBw
    LiQmIEdF6z+vcY4ZYBbO3+QacOnJcsAOdWBo182pCD/y2AVeTetkrzcC/nDiBvqv
    qjOlwJnd4u1A0LSCTmgbZnD3A80uCmVPSyXTsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191365; bh=Nz0QCHC/Co0xwSLCbH4KK3T79/ywkdPvBXJ
    aglJPy6I=; b=k4+kYTcEgEOVYLZb6wG0tMO+pyN2cAHg3qUDJwWJS7wiQgtCxld
    9yAH5Aoj8IzsknGn7h12pTMliR/MQclyftGdoe37oa69+99ClX04sgP0UnWUQrwU
    uIxcwJhpUsskGGc7h8D/1pMEkjf3lQW2aV772X+8Xiyvks5HQhLk47vhbxkYStRM
    BpcjzURRYY9cS63tLyrHTwZ8JQGWh5ebPgNwY6JEawkmDTkUpXASpuNRfE2qRfqY
    DMpDutZxUjRKJoR3pV73xR495CVqJi//RwXxQEl4V65pjmooljJgSJUuF3mSkjob
    y3fPCiJc6hm8MHP3DrwIQwtXDLzCOgdHXOQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeCPJJB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:09:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752048AbeCPJHK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:07:10 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak32 V2 10/13] audit: add containerid support for seccomp and anom_abend records
Date: Fri, 16 Mar 2018 05:00:37 -0400
Message-Id: <11174597083f89352f1d6491ec94e27f882625d9.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID auxiliary records to secure computing and abnormal end
standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7103d23..2f02ed9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2571,6 +2571,7 @@ static void audit_log_task(struct audit_buffer *ab)
 void audit_core_dumps(long signr)
 {
 	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
 
 	if (!audit_enabled)
 		return;
@@ -2578,19 +2579,22 @@ void audit_core_dumps(long signr)
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
@@ -2598,6 +2602,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 			 signr, syscall_get_arch(), syscall,
 			 in_compat_syscall(), KSTK_EIP(current), code);
 	audit_log_end(ab);
+	audit_log_container_info(context, "seccomp", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 struct list_head *audit_killed_trees(void)
-- 
1.8.3.1

