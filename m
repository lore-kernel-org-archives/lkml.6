Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191342-2-12310636867727446501
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
    t=1521191341; b=nNj3MeyGWyxVKl/SxYk4tkYjF8hMW710uVQSrgdzVcgW0qK
    /DgAnGlYFhzKsaerQkv+9H+cDxwEr9IFshamL13kxtleaBBDyB9a65CjA2E4Si4G
    2MJoZXH10zsIn47KjLW0nzWpKwDE9NnQImgTgOQRtkBglXGO0zPa59RBc6jaqFxS
    RkU5XTGmFzOKczJgP1tJPdXDDPV5a54WyrzKdBj+JSAJw+vez2A65xZoY6MVtcE+
    YrnuWZX6WKvT9CfGdxPQ5KCjjft1vUVGqudil2Kg/vtWEh71x34NtY33WmyqYMM4
    BqK9X+hi1w0SnLYJIR0Kbml9OxjYR2dqiqUtwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191341; bh=b9k7WSoUbp8cT6QK7xXN2R4fM0yAge5pJUb
    TM1qJoR8=; b=kRAbwDKInXezf2W1stqvsA1qG+YeaOrjOKaEBv0vQQNyUvmcSNK
    RMffKcuDWiBf4TtYjieUsKFBwVTDqz/q43z+oHGy84zBUBZlPS7q+XOtWdeqx44x
    FM21rFn4Y15nSfdAopg+qZeXAnOH9nkIqoPLF4gU9FoTzBvkL/X4EqQSeRUSsH5i
    wOcFK6F2iUNU/JgqqDoZNXX7pOKKSFrrA3ifEtCI6zEGAO/4MF7UMemg2N98L5CJ
    lgE8htOxhD0NB5Qoadu3lWLg/LGPH2Ce3r+G6pxiniluNFKFBzEw2UQJBa2F9zRY
    3peQCqLVd64aeZqgnAkjIP8A930bQIyDtRw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1753432AbeCPJHL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:07:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751858AbeCPJHH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:07:07 -0400
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
Subject: [RFC PATCH ghak32 V2 09/13] audit: add containerid support for config/feature/user records
Date: Fri, 16 Mar 2018 05:00:36 -0400
Message-Id: <c34a7a95eb045a62e2443457979db9d7afbd9aee.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add container ID auxiliary records to configuration change, feature set change
and user generated standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c       | 50 ++++++++++++++++++++++++++++++++++++++++----------
 kernel/auditfilter.c |  5 ++++-
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index b238be5..08662b4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -400,8 +400,9 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 {
 	struct audit_buffer *ab;
 	int rc = 0;
+	struct audit_context *context = audit_alloc_local();
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return rc;
 	audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
@@ -411,6 +412,8 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 		allow_changes = 0; /* Something weird, deny request */
 	audit_log_format(ab, " res=%d", allow_changes);
 	audit_log_end(ab);
+	audit_log_container_info(context, "config", audit_get_containerid(current));
+	audit_free_context(context);
 	return rc;
 }
 
@@ -1058,7 +1061,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	return err;
 }
 
-static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
+static void audit_log_common_recv_msg(struct audit_context *context,
+				      struct audit_buffer **ab, u16 msg_type)
 {
 	uid_t uid = from_kuid(&init_user_ns, current_uid());
 	pid_t pid = task_tgid_nr(current);
@@ -1068,7 +1072,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 		return;
 	}
 
-	*ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
+	*ab = audit_log_start(context, GFP_KERNEL, msg_type);
 	if (unlikely(!*ab))
 		return;
 	audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
@@ -1097,11 +1101,12 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 				     u32 old_lock, u32 new_lock, int res)
 {
 	struct audit_buffer *ab;
+	struct audit_context *context = audit_alloc_local();
 
 	if (audit_enabled == AUDIT_OFF)
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
 	if (!ab)
 		return;
 	audit_log_task_info(ab, current);
@@ -1109,6 +1114,8 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 			 audit_feature_names[which], !!old_feature, !!new_feature,
 			 !!old_lock, !!new_lock, res);
 	audit_log_end(ab);
+	audit_log_container_info(context, "feature", audit_get_containerid(current));
+	audit_free_context(context);
 }
 
 static int audit_set_feature(struct sk_buff *skb)
@@ -1337,13 +1344,15 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
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
@@ -1359,6 +1368,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				audit_log_n_untrustedstring(ab, data, size);
 			}
 			audit_log_end(ab);
+			audit_log_container_info(context, "user",
+						 audit_get_containerid(current));
+			audit_free_context(context);
 		}
 		break;
 	case AUDIT_ADD_RULE:
@@ -1366,9 +1378,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -1376,17 +1393,23 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
@@ -1408,7 +1431,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		/* OK, here comes... */
 		err = audit_tag_tree(old, new);
 
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_common_recv_msg(context, &ab, AUDIT_CONFIG_CHANGE);
 
 		audit_log_format(ab, " op=make_equiv old=");
 		audit_log_untrustedstring(ab, old);
@@ -1418,6 +1441,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		audit_log_end(ab);
 		kfree(old);
 		kfree(new);
+		audit_log_container_info(context, "config",
+					 audit_get_containerid(current));
+		audit_free_context(context);
 		break;
 	}
 	case AUDIT_SIGNAL_INFO:
@@ -1459,6 +1485,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		struct audit_tty_status s, old;
 		struct audit_buffer	*ab;
 		unsigned int t;
+		struct audit_context *context = audit_alloc_local();
 
 		memset(&s, 0, sizeof(s));
 		/* guard against past and future API changes */
@@ -1477,12 +1504,15 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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

