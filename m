Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933768-2-2528431221030478435
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
    t=1519933767; b=AAOXLB0MKwz70uS8BGJYNq1ziui4KLytyULx63aGLCkDiuw
    Zv8dpaSFKGSAYaf1aSW6Cl4V90nvM3DR9xczHlQzGY6GO9OxRCdHJIqQeqhJHVm/
    zmPj/a6X7rAmOOFOqeuC/qehxQydNlc7sJDxWVaj799lIoGyCn2Hdqf51WAA2lpY
    JB+CM/glREq7eKzwK7GQlEqgkDqHB9dXDaDCWdurSxsAcnshnLYBu4YJD+xHqgXB
    9er9MDZ2dYpnSGL9jr9Zu/Bf6MpBiWvjZcwdbhdsEY0lqq48Rh0HM4yxU8bG0QIR
    C2+4n6nBKZI7XSlDCSBx+ngZxOztH1efrgHWEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933767; bh=nZg/0ysmCSabbuimeREQRb8c+0Q4Wg6tcEG
    jO1/Lq7E=; b=rtYSI8zmowGtbQTWkmE3KhrDDg4NsnJTrykiykjfEfWxpvIpzEq
    udTClQtZOrHjvtAOmTFwdHVOFBMjqLXZLExIPQvjQ2kXYxk8tKOtm7vjoPPifAjY
    VdFezuQt/tzpc46LwF1ZpIW1D3QJ0uwx2jyC3GZsQtMKAbUKDnk7UkIuo4dh835K
    aeuIwYB/yPePRE7CaVI2M4B5dsYM1abIEOLrryejpg1s0aNao4irKNqpQsru3T0D
    jLK5KNGys4z++LjtAmB3B/Og5BWM400fWww9sz94c3/u4WO49TFmiW3u1Iuz78Q2
    9to8cv5/xpdV1QUyirhAszt+u+A1RNEV3vA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033647AbeCATrB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:47:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1034175AbeCATq7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:46:59 -0500
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
Subject: [RFC PATCH V1 07/12] audit: add container aux record to watch/tree/mark
Date: Thu,  1 Mar 2018 14:41:10 -0500
Message-Id: <6c071b3e4fbe848ccd692c7dc27c9f75589852c0.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID information to mark, watch and tree rule standalone
records.

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
index fd35312..2ad85d4 100644
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

