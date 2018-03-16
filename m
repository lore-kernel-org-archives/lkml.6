Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191292-2-352827780953501955
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
    t=1521191291; b=g/eY3AbcIMz5fUFHktaxhvnmgL4O6MqrTVO+SH+02aiNhW+
    37VVrsexdQS7AMWJsjePK5T/8JnGoq/dSEYT1RqwogrhsYfbQqEG4diXfs8hxntA
    qlu9okxkL4rRYBz9RDcGuL17HVzsYIjpyRYZAU8OA1958z9hS/4YRkZ2aRuBy9bo
    FUR3ZYAKQWmRuOs8iNmWzQIyjAWwGQQFZ/TSmcnRVzOUzXeSsnpO+6Kqd6Hh3YLz
    6G0vz4tBtYI71+4RK7rkwUufAC/mtn/bbl6XqaTvus7H+iYOYI8kUt573vCA7M2w
    nC4SxocANgzV7p6dW7nWgMKNQZSKoXF8tr3ueOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191291; bh=Ckc7Ia6fskorrZXlqVmrl+aJiLJKi2RKKE4
    LDWa9T9g=; b=jZhxD/ruo+b7yao8U/sA5n8FfNMkYirmP/iXFRCmFvZiMI8QBUq
    Cmpqw1WR3fQ0yd1K7Cif/CcS+wqraIKXCkUBq+JmAmF7U8lgaRTFPpilosRomlGE
    dOcp+lspp5jl1iFFEH1AnBgJsUt7Nia+ASAxxltBNXGd6xos8IrINZjEuKxPvUHW
    jB3UHq7fJuwTsctLV6gSHjlMpx2SldmFtSI0tePRD8RANCEd9BNYll2qWwkh8CPQ
    qunfQfWhErs9K9Mo2vfTJqQDuol1PNYkJtMVGawSUUGPtL+S5d2t//Vte424ozIz
    3sjRsWb7V4TxTM2GSVvNWc7hahuIgMh0eHg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1753503AbeCPJH2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:07:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753147AbeCPJH0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:07:26 -0400
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
Subject: [RFC PATCH ghak32 V2 12/13] audit: NETFILTER_PKT: record each container ID associated with a netNS
Date: Fri, 16 Mar 2018 05:00:39 -0400
Message-Id: <66adde01c1dda792aff99a457eea576a0b08ca98.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID auxiliary record(s) to NETFILTER_PKT event standalone
records.  Iterate through all potential container IDs associated with a
network namespace.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c           |  1 +
 kernel/auditsc.c         |  2 ++
 net/netfilter/xt_AUDIT.c | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 08662b4..3c77e47 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2102,6 +2102,7 @@ int audit_log_container_info(struct audit_context *context,
 	audit_log_end(ab);
 	return 0;
 }
+EXPORT_SYMBOL(audit_log_container_info);
 
 void audit_log_key(struct audit_buffer *ab, char *key)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 208da962..af68d01 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -975,6 +975,7 @@ struct audit_context *audit_alloc_local(void)
 	context->in_syscall = 1;
 	return context;
 }
+EXPORT_SYMBOL(audit_alloc_local);
 
 inline void audit_free_context(struct audit_context *context)
 {
@@ -989,6 +990,7 @@ inline void audit_free_context(struct audit_context *context)
 	audit_proctitle_free(context);
 	kfree(context);
 }
+EXPORT_SYMBOL(audit_free_context);
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid, unsigned int sessionid,
diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
index c502419..edaa456 100644
--- a/net/netfilter/xt_AUDIT.c
+++ b/net/netfilter/xt_AUDIT.c
@@ -71,10 +71,14 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 {
 	struct audit_buffer *ab;
 	int fam = -1;
+	struct audit_context *context = audit_alloc_local();
+	struct audit_containerid *cont;
+	int i = 0;
+	struct net *net;
 
 	if (audit_enabled == 0)
 		goto errout;
-	ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
+	ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
 	if (ab == NULL)
 		goto errout;
 
@@ -104,7 +108,16 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 
 	audit_log_end(ab);
 
+	net = sock_net(NETLINK_CB(skb).sk);
+	list_for_each_entry(cont, &net->audit_containerid, list) {
+		char buf[14];
+
+		sprintf(buf, "net%u", i++);
+		audit_log_container_info(context, buf, cont->id);
+	}
+
 errout:
+	audit_free_context(context);
 	return XT_CONTINUE;
 }
 
-- 
1.8.3.1

