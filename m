Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2571388-1521191381-2-7295439630383792125
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
    t=1521191380; b=q2OuoA7auU9rMEs3DncCL6dBHGZoDrNRA7DPbQETKPAJWlL
    hqpy6lxhuB24hdHgv50KMY4IxM2Lqu818IoEbxPZgzCHSQTaXdXJnDQiZNYJ0kL0
    lCtFpzzA/9asNlmbQC+LAM7pHRx86rGEOyNh3hitxMqBNfKHqUZ13huhC4cGbgq3
    IO0iTnWCkMAPaphVVvyrTJ2jWevicHGE07LINR8R/QbEUWO3HJQzO4imjNJv3IRH
    rOvrN0KHvPp4h5AmUG08LZ1ENS44wXRFwKdL8+/yYFRjQEApKBzUKe6yaih0q/PC
    /ua/m0KH2vBDhJNsthT0T9pnq0hZTL9pd2yrrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191380; bh=xFoEPDL1bR3M1sg/coX4YuwKXOUlq/9itjE
    k1AbZy0s=; b=l5Er5tuReUYoA4axF0iKg61FTPkCBs1crPSiLjKMgqUoxxzvkAa
    CfucjK5QaZYEIAatxnR3zxkHGB5fSbZ4U+M1xXcSArheTSrTY9iwVJ/S24/bsz4t
    mF+ev/Vb4ej8So3RjU4D9xVHI4d5ACmhqaTHo0Hlj1+CAntxi67uSlqpjsn3vdxs
    Vs+3dkZKzqnr0ieeN7K0dAjPvndHuK1h6uh6ADTNooub0L59SXm23lShPqbau1q/
    V32fw6cbqF8/HTl53U9fJfiWpPsaMlkn1QvS9gSKvNRstU8O32+qae5+ZVIH62Yn
    Llht7/6iNXzzmyipmgoAzx7KwRrFPT/yPpw==
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
        id S1753098AbeCPJGw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:06:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751724AbeCPJGt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:06:49 -0400
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
Subject: [RFC PATCH ghak32 V2 07/13] audit: add container aux record to watch/tree/mark
Date: Fri, 16 Mar 2018 05:00:34 -0400
Message-Id: <737f914a88d048b9985984c0ce1f946c30ca374c.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID auxiliary record to mark, watch and tree rule
configuration standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit_fsnotify.c |  5 ++++-
 kernel/audit_tree.c     |  5 ++++-
 kernel/audit_watch.c    | 33 +++++++++++++++++++--------------
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 52f368b..18c110d 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -124,10 +124,11 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
 {
 	struct audit_buffer *ab;
 	struct audit_krule *rule = audit_mark->rule;
+	struct audit_context *context = audit_alloc_local();
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_NOFS, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "auid=%u ses=%u op=%s",
@@ -138,6 +139,8 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
 	audit_log_key(ab, rule->filterkey);
 	audit_log_format(ab, " list=%d res=1", rule->listnr);
 	audit_log_end(ab);
+	audit_log_container_info(context, "config", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 void audit_remove_mark(struct audit_fsnotify_mark *audit_mark)
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 67e6956..7c085be 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -496,8 +496,9 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 static void audit_tree_log_remove_rule(struct audit_krule *rule)
 {
 	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "op=remove_rule");
@@ -506,6 +507,8 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
 	audit_log_key(ab, rule->filterkey);
 	audit_log_format(ab, " list=%d res=1", rule->listnr);
 	audit_log_end(ab);
+	audit_log_container_info(context, "config", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 static void kill_rules(struct audit_tree *tree)
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 9eb8b35..60d75a2 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -238,20 +238,25 @@ static struct audit_watch *audit_dupe_watch(struct audit_watch *old)
 
 static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watch *w, char *op)
 {
-	if (audit_enabled) {
-		struct audit_buffer *ab;
-		ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
-		if (unlikely(!ab))
-			return;
-		audit_log_format(ab, "auid=%u ses=%u op=%s",
-				 from_kuid(&init_user_ns, audit_get_loginuid(current)),
-				 audit_get_sessionid(current), op);
-		audit_log_format(ab, " path=");
-		audit_log_untrustedstring(ab, w->path);
-		audit_log_key(ab, r->filterkey);
-		audit_log_format(ab, " list=%d res=1", r->listnr);
-		audit_log_end(ab);
-	}
+	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
+
+	if (!audit_enabled)
+		return;
+
+	ab = audit_log_start(context, GFP_NOFS, AUDIT_CONFIG_CHANGE);
+	if (unlikely(!ab))
+		return;
+	audit_log_format(ab, "auid=%u ses=%u op=%s",
+			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
+			 audit_get_sessionid(current), op);
+	audit_log_format(ab, " path=");
+	audit_log_untrustedstring(ab, w->path);
+	audit_log_key(ab, r->filterkey);
+	audit_log_format(ab, " list=%d res=1", r->listnr);
+	audit_log_end(ab);
+	audit_log_container_info(context, "config", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 /* Update inode info in audit rules based on filesystem event. */
-- 
1.8.3.1

