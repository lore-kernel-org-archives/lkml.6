Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933750-2-7603627544767824896
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
    t=1519933749; b=EVLUX/XjF176z4ryVx0G2dzvum2/FdGSGE3SFdkZf3pZ18a
    WZIUUJRkrEyxsNTuCw3yDJ9u/pbwZCNlV8Vh0ju2aa3T+iv6LVtxs5g2u/wRJKV/
    4MLEs8Cc5kQ31aNYySpThhSYuhxOQM9XCoy8545AFCI6630QK1S9AcsgGlKc218U
    ERAGgADo9A/p0HViJ+lLxZzIUhvbIFkx6uQE7wbHceS1Qo8b+H2criaV912deMLe
    NRNVtPLnjiO79v8zx6vjQLNA6/ChpvpBY3FdErKx1uW7h3bT5csiDd5llyVQe/xq
    19G+u+iIjp0dVdsX+Ivg7+GLHRvr4u9vbGVch9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933749; bh=rN1YNRQqliP4t4T+9iy7AS8XBdKEynYsebi
    /lY2q3cw=; b=jmtY35ScD5X2P0Tcvlu6FUrocmo5ebJLU5Q3ANx+/GI6IDQBLHo
    cEM4qBbj3qQ2mEYkOHd2JeZW/mDkQnBXjVxCs9PPa7vyQHlmX0yJm9NpLZ0/76AJ
    S6jFlHn4TnvfTa3n1JeeKSvux/Q1LIG44U5VXQfQY0OEc8bV8x4J/EdS2M9mUrR9
    rcSRedjD2Qf/eIAVF0LkN8gP6eovkOjOpCzLNXFLJFMIRPj73BSzQOe98qXz4lJy
    p6ZE0/FSlIW2jg4wxZcgjIeo44aYRNRFcRAjje3pBuQ+S3L4QoEF0sF7zlZWuOrr
    CTdQGvfaZC3vs+utkOW8/FS9bFlRt89T6HA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033673AbeCATrK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:47:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161460AbeCATrC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:47:02 -0500
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
Subject: [RFC PATCH V1 08/12] audit: add containerid support for tty_audit
Date: Thu,  1 Mar 2018 14:41:11 -0500
Message-Id: <2542bf0c5446777b0d47fc16a7864212f13d2f4a.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID information to tty logging rule standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 drivers/tty/tty_audit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index e30aa6b..48ee4b7 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
 	uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
 	uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
 	unsigned int sessionid = audit_get_sessionid(tsk);
+	struct audit_context *context = audit_alloc_local();
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
 	if (ab) {
 		char name[sizeof(tsk->comm)];
 
@@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
 		audit_log_n_hex(ab, data, size);
 		audit_log_end(ab);
 	}
+	audit_log_container_info(context, "tty", audit_get_containerid(tsk));
+	audit_free_context(context);
 }
 
 /**
-- 
1.8.3.1

