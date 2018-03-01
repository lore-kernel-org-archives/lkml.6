Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3692783-1519933731-2-15692103927580961640
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
    t=1519933730; b=ION8nqCoFRhDaB1+/Pz1SbrSF05NHymU4/ZipwmVe2rdz7A
    NLE7cOGkH0gq59xfFPUVJ8JbscpHSfsgcZzrwIp1nUcQcoMJuxGxeoB95np1sPxO
    XBErs+Dt2fKR+b9Ho2eOxyoO6fuesO4bUPH+fXQfVLj3R8sUMugtxpEvlU4K1r+J
    Rc2AyqCkSDHK02iUmgqcvV3OAqy6o6B+UMwlBc3IEyKmUmHkWYDS6UP3RhjPfSZj
    0ZenHOfYNXu3I47myHSjq2m+//PB4TaeMTnE0Buj3YrBSWVehUa0TJhU56/LoalJ
    QiVi0rC/J/kfBZJ7eCCptf7RJ5hk0lAf+lgHriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933730; bh=3EL4AzDq7Ll+e0C18ZV5PSVL3Nl6rlBzHEf
    kRLweXw8=; b=a9cNXGSi4ASoxOQS/G0tWYgnb9khyOhTkmtmaF9imphObtaVBr2
    pfHWeeGO6TawzdGXcofklVIYZbUVwhi2sCegt6n0k9Ykxq4r5l/nVOvmm0ZsgBZ/
    vjIezjgw0qu/jMl9wUZIq/x9xcyCB3wINcy00nYFlH31pj/jp/Jvlsc5KJ2evBl5
    wdvNbD4CrMCZaoA5tU05Q8z5scfIbpxzJhG8nYpb1yPJbrxJJmULDBoXL7UE4bW8
    qfcfHFNWdim0+qb1zjd+DVTYZo/wAdiDZ4P7Y8wAsubKduD18Yw+DM5cNr4CcXUy
    I+vbRb3y3gXx56kKZWeRzpK0tX1dhh4NyxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034227AbeCATsc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:48:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033783AbeCATrN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:47:13 -0500
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
Subject: [RFC PATCH V1 09/12] audit: add containerid support for config/feature/user records
Date: Thu,  1 Mar 2018 14:41:12 -0500
Message-Id: <5e116a00c87ddf4c2f991f2f2fb2cf7d6a22d4f7.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID information to configuration change, feature set change
and user generated standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c       | 50 ++++++++++++++++++++++++++++++++++++++++----------
 kernel/auditfilter.c |  5 ++++-
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index f5cd0bc..a4c0bad 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -358,8 +358,9 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 {
 	struct audit_buffer *ab;
 	int rc = 0;
+	struct audit_context *context = audit_alloc_local();
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return rc;
 	audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
@@ -369,6 +370,8 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 		allow_changes = 0; /* Something weird, deny request */
 	audit_log_format(ab, " res=%d", allow_changes);
 	audit_log_end(ab);
+	audit_log_container_info(context, "config", audit_get_containerid(current));
+	audit_free_context(context);
 	return rc;
 }
 
@@ -1016,7 +1019,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	return err;
 }
 
-static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
+static void audit_log_common_recv_msg(struct audit_context *context,
+				      struct audit_buffer **ab, u16 msg_type)
 {
 	uid_t uid = from_kuid(&init_user_ns, current_uid());
 	pid_t pid = task_tgid_nr(current);
@@ -1026,7 +1030,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 		return;
 	}
 
-	*ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
+	*ab = audit_log_start(context, GFP_KERNEL, msg_type);
 	if (unlikely(!*ab))
 		return;
 	audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
@@ -1055,16 +1059,19 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 				     u32 old_lock, u32 new_lock, int res)
 {
 	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
 
 	if (audit_enabled == AUDIT_OFF)
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
 	audit_log_task_info(ab, current);
 	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
 			 audit_feature_names[which], !!old_feature, !!new_feature,
 			 !!old_lock, !!new_lock, res);
 	audit_log_end(ab);
+	audit_log_container_info(context, "feature", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 static int audit_set_feature(struct sk_buff *skb)
@@ -1293,13 +1300,15 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		err = audit_filter(msg_type, AUDIT_FILTER_USER);
 		if (err == 1) { /* match or error */
+			struct audit_context *context = audit_alloc_local();
+
 			err = 0;
 			if (msg_type == AUDIT_USER_TTY) {
 				err = tty_audit_push();
 				if (err)
 					break;
 			}
-			audit_log_common_recv_msg(&ab, msg_type);
+			audit_log_common_recv_msg(context, &ab, msg_type);
 			if (msg_type != AUDIT_USER_TTY)
 				audit_log_format(ab, " msg='%.*s'",
 						 AUDIT_MESSAGE_TEXT_MAX,
@@ -1315,6 +1324,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				audit_log_n_untrustedstring(ab, data, size);
 			}
 			audit_log_end(ab);
+			audit_log_container_info(context, "user",
+						 audit_get_containerid(current));
+			audit_free_context(context);
 		}
 		break;
 	case AUDIT_ADD_RULE:
@@ -1322,9 +1334,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		if (nlmsg_len(nlh) < sizeof(struct audit_rule_data))
 			return -EINVAL;
 		if (audit_enabled == AUDIT_LOCKED) {
-			audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+			struct audit_context *context = audit_alloc_local();
+
+			audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
 			audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
 			audit_log_end(ab);
+			audit_log_container_info(context, "config",
+						 audit_get_containerid(current));
+			audit_free_context(context);
 			return -EPERM;
 		}
 		err = audit_rule_change(msg_type, seq, data, nlmsg_len(nlh));
@@ -1332,17 +1349,23 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_LIST_RULES:
 		err = audit_list_rules_send(skb, seq);
 		break;
-	case AUDIT_TRIM:
+	case AUDIT_TRIM: {
+		struct audit_context *context = audit_alloc_local();
 		audit_trim_trees();
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
 		audit_log_format(ab, " op=trim res=1");
 		audit_log_end(ab);
+		audit_log_container_info(context, "config",
+					 audit_get_containerid(current));
+		audit_free_context(context);
 		break;
+	}
 	case AUDIT_MAKE_EQUIV: {
 		void *bufp = data;
 		u32 sizes[2];
 		size_t msglen = nlmsg_len(nlh);
 		char *old, *new;
+		struct audit_context *context = audit_alloc_local();
 
 		err = -EINVAL;
 		if (msglen < 2 * sizeof(u32))
@@ -1364,7 +1387,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		/* OK, here comes... */
 		err = audit_tag_tree(old, new);
 
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
 
 		audit_log_format(ab, " op=make_equiv old=");
 		audit_log_untrustedstring(ab, old);
@@ -1374,6 +1397,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		audit_log_end(ab);
 		kfree(old);
 		kfree(new);
+		audit_log_container_info(context, "config",
+					 audit_get_containerid(current));
+		audit_free_context(context);
 		break;
 	}
 	case AUDIT_SIGNAL_INFO:
@@ -1415,6 +1441,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		struct audit_tty_status s, old;
 		struct audit_buffer	*ab;
 		unsigned int t;
+		struct audit_context *context = audit_alloc_local();
 
 		memset(&s, 0, sizeof(s));
 		/* guard against past and future API changes */
@@ -1433,12 +1460,15 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		old.enabled = t & AUDIT_TTY_ENABLE;
 		old.log_passwd = !!(t & AUDIT_TTY_LOG_PASSWD);
 
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
 		audit_log_format(ab, " op=tty_set old-enabled=%d new-enabled=%d"
 				 " old-log_passwd=%d new-log_passwd=%d res=%d",
 				 old.enabled, s.enabled, old.log_passwd,
 				 s.log_passwd, !err);
 		audit_log_end(ab);
+		audit_log_container_info(context, "config",
+					 audit_get_containerid(current));
+		audit_free_context(context);
 		break;
 	}
 	default:
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index c4c8746..5f7f4d6 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1109,11 +1109,12 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
 	struct audit_buffer *ab;
 	uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(current));
 	unsigned int sessionid = audit_get_sessionid(current);
+	struct audit_context *context = audit_alloc_local();
 
 	if (!audit_enabled)
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (!ab)
 		return;
 	audit_log_format(ab, "auid=%u ses=%u" ,loginuid, sessionid);
@@ -1122,6 +1123,8 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
 	audit_log_key(ab, rule->filterkey);
 	audit_log_format(ab, " list=%d res=%d", rule->listnr, res);
 	audit_log_end(ab);
+	audit_log_container_info(context, "config", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 /**
-- 
1.8.3.1

