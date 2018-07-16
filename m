Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CE0208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iCPypr9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CE0208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGPSxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:53:43 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:41641
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730116AbeGPSxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765498; bh=S6kfSMHiA2o3tOIIBGBvILhHz0X55moGxLv2ZnIk8/M=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=iCPypr9B6ZCIkpT4IFzUI2ba+2qwYqEzl7+VhIgokpKQDFMD3zqOlQoTvU9dhQQFEyaD6nCt6WAfkvrxjbHgYSdMXx5nPJkZ2tHL6b/L6J+LmRveL5VDLYxB8H48hI7qAqmOrDWokSx7VkrhNIZHvbnaQNNKT/7iXsjTJLvmjZc+6+Im5rnK7oIoIhrfkFKq3bEowzAuuPvdG9xnFQg0XUCL+ezfXz8LazD11UlI0nM+nfl48Y6cZdtl8srGU6XnLhDxtJ7BSl5b/muucFulMrdtN0yfssQPEw2tudFLIF4k6qS/Kq9lqEyguUypxAiNzbnNxpVGtijqTOCeFhYkpg==
X-YMail-OSG: oPQwB20VM1kCSvEz1m_x_itv4cKTN4lxfLvY7mPcu4bijyyD6Gvtzinw9sBZcXr
 IRPrKW_ziiFK9_btELFzmdxSn7WKwi1URHEED5lHGKvLgZ0OoX32U.A74bai9GUiMBS6yn7s4yQq
 spM_W.MF1qTy4TQ4nBkYI_yfyL.H0rcOBH0YBXapFz63BJ_QuIDH_cES2DEEDbDaHUTxuhJtjs4K
 2.mYwH6xf4nqCQC_2DIqRreW1j_r_13e8rFIvYrgeWQUzxANI2oX_pm8G2Lzm.P6nwUs704yK9lF
 p3dNEfPNSmPhji9zifxV7.zqhDHAO8ufn9j7dF4js5Pq4qa1YiGDZsUjRFpJqitWXRbWPNc.sZ_o
 Y5XAEgCJgtDEIduZ2v4cKfkApRup0D8LyPp5kHC01D9vEVt5aADSe3lATLlYZQpeVWoIpZRqpFv9
 NVkFo3a1xLp6Bs9mSU1gI2HP.KcFjulA0KSlFR9iILIMG8mz9ZzyhNu_LRw7GFk0ft_nI3sKCyC8
 hI0bLkXEHjZs5l7QyplQgUuQJX4MXi3pFXQNe.IearyGJMxxvfClE04Vsf.6UbvXIbn5.jIU5lJR
 CmLk7t8vURya9E.PtUUG8CneDnT_9KuZSPp8yqEQRXZM4l7NvD73ao844ZiXQ2fGjxV6WJaDoBT7
 Ie26m3461PS__iLDiFwrwLs3gSTVShEfxHDquE2mTUSH0uXb.POq1DQpB_vZQoHNyB.kWMnKRAt1
 LOg.okKfRRRFTdnTcB9.0nhiJcpU9H0MtV0SicY5zhkqvT2uSUVKyOkmQKchJWQ0niXjEoCJcLJR
 jExYt7CKqRFVleABZY9.StVhZjeL_wlSIh5LUKqFMA1EJueRVbaiWi17Cm3AutpMYhQt6VQ8Zywk
 wKccVCFC.K_BZc4qxnU1bvVI1IlcsEat9f2X7TYpp_Qw0XcUBuGr2dUjESbneF8iBjdZ2pPhDsmH
 17PB6DjszewpY9N_pv5xRNbG9IehXqBHu.H9sWB_W04vIdoQzAbjUs64mJ4RlAMUplDAkZomkmaZ
 _k.0db2mqVzw2biyX.WzjcOyFDRlR10I-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:24:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5fda23149e2f675c85529559eb9f071c;
          Mon, 16 Jul 2018 18:24:57 +0000 (UTC)
Subject: [PATCH v1 22/22] Netfilter: Add a selection for Smack
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bbc76246-22b7-4629-cfd9-8efc938d4743@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:24:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Netfilter: Add a selection for Smack

If you are running a single security module it's
fine to tell the netfilter system that your security
filters are for SELinux, and everything will work just
fine. If you have Smack and SELinux at the same time
you need to be able to differentiate. The netfilter
secmark (xt_SECMARK) code is set up for multiple security
modules, although as a comment points out, only one at
a time. The code wasn't set up to pass the information
about who should process the secmark in the case of
multiple security modules, so that had to be fixed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h                 |  4 +-
 include/linux/security.h                  | 20 ++++----
 include/uapi/linux/netfilter/xt_SECMARK.h |  1 +
 kernel/audit.c                            |  2 +
 kernel/auditsc.c                          |  2 +
 net/netfilter/nf_conntrack_netlink.c      | 10 ++++
 net/netfilter/nf_conntrack_standalone.c   |  5 ++
 net/netfilter/nfnetlink_queue.c           |  5 ++
 net/netfilter/xt_SECMARK.c                | 39 +++++++++++++---
 net/netlabel/netlabel_user.c              |  2 +-
 net/unix/af_unix.c                        |  8 +++-
 security/security.c                       | 37 +++++++++++----
 security/selinux/hooks.c                  | 13 +++++-
 security/smack/smack_lsm.c                | 56 +++++++++++++++++++----
 security/smack/smack_netfilter.c          | 11 +++++
 15 files changed, 175 insertions(+), 40 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3db1004ead19..8db997acaba6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1696,8 +1696,8 @@ union security_list_options {
 				const struct request_sock *req);
 	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
 	int (*secmark_relabel_packet)(struct secids *secid);
-	void (*secmark_refcount_inc)(void);
-	void (*secmark_refcount_dec)(void);
+	void (*secmark_refcount_inc)(u8 lsm);
+	void (*secmark_refcount_dec)(u8 lsm);
 	void (*req_classify_flow)(const struct request_sock *req,
 					struct flowi *fl);
 	int (*tun_dev_alloc_security)(void **security);
diff --git a/include/linux/security.h b/include/linux/security.h
index aa2263deb80d..e40fb16db274 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -80,15 +80,9 @@ enum lsm_event {
 
 struct secids {
 	u32 common;
-#ifdef CONFIG_SECURITY_SELINUX
 	u32 selinux;
-#endif
-#ifdef CONFIG_SECURITY_SMACK
 	u32 smack;
-#endif
-#ifdef CONFIG_SECURITY_APPARMOR
 	u32 apparmor;
-#endif
 	u32 flags;
 };
 
@@ -1295,8 +1289,9 @@ void security_inet_csk_clone(struct sock *newsk,
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb);
 int security_secmark_relabel_packet(struct secids *secid);
-void security_secmark_refcount_inc(void);
-void security_secmark_refcount_dec(void);
+void security_secmark_refcount_inc(u8 lsm);
+void security_secmark_refcount_dec(u8 lsm);
+int security_secmark_mode(u8 lsm);
 int security_tun_dev_alloc_security(void **security);
 void security_tun_dev_free_security(void *security);
 int security_tun_dev_create(void);
@@ -1474,14 +1469,19 @@ static inline int security_secmark_relabel_packet(struct secids *secid)
 	return 0;
 }
 
-static inline void security_secmark_refcount_inc(void)
+static inline void security_secmark_refcount_inc(u8 lsm)
 {
 }
 
-static inline void security_secmark_refcount_dec(void)
+static inline void security_secmark_refcount_dec(u8 lsm)
 {
 }
 
+static inline int security_secmark_mode(u8 lsm)
+{
+	return 0;
+}
+
 static inline int security_tun_dev_alloc_security(void **security)
 {
 	return 0;
diff --git a/include/uapi/linux/netfilter/xt_SECMARK.h b/include/uapi/linux/netfilter/xt_SECMARK.h
index 1f2a708413f5..5245a9748599 100644
--- a/include/uapi/linux/netfilter/xt_SECMARK.h
+++ b/include/uapi/linux/netfilter/xt_SECMARK.h
@@ -12,6 +12,7 @@
  * packets are being marked for.
  */
 #define SECMARK_MODE_SEL	0x01		/* SELinux */
+#define SECMARK_MODE_SMACK	0x02		/* Smack */
 #define SECMARK_SECCTX_MAX	256
 
 struct xt_secmark_target_info {
diff --git a/kernel/audit.c b/kernel/audit.c
index 1d3e0aa10cdf..bec7e2d98099 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2171,7 +2171,9 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 		u32 len;
 		if (security_secid_to_secctx(
 			&n->osid, &ctx, &len)) {
+#ifndef CONFIG_SECURITY_STACKING
 			audit_log_format(ab, " osid=%u", n->osid.common);
+#endif
 			if (call_panic)
 				*call_panic = 2;
 		} else {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1dc426b2793d..7175b26c4d25 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1214,7 +1214,9 @@ static void show_special(struct audit_context *context, int *call_panic)
 			char *ctx = NULL;
 			u32 len;
 			if (security_secid_to_secctx(&osid, &ctx, &len)) {
+#ifndef CONFIG_SECURITY_STACKING
 				audit_log_format(ab, " osid=%u", osid.common);
+#endif
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 9b4f56e7f2cd..5d0bbc3e7c83 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -314,8 +314,13 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	char *secctx;
 	struct secids secid;
 
+#ifdef CONFIG_SECURITY_STACKING
 	secid_init(&secid);
+	secid.selinux = ct->secmark;
+	secid.smack = ct->secmark;
+#else
 	secid.common = ct->secmark;
+#endif
 
 	ret = security_secid_to_secctx(&secid, &secctx, &len);
 	if (ret)
@@ -598,8 +603,13 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 	int len, ret;
 	struct secids secid;
 
+#ifdef CONFIG_SECURITY_STACKING
 	secid_init(&secid);
+	secid.selinux = ct->secmark;
+	secid.smack = ct->secmark;
+#else
 	secid.common = ct->secmark;
+#endif
 
 	ret = security_secid_to_secctx(&secid, NULL, &len);
 	if (ret)
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 2c808149938b..1a0af9887d56 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -183,8 +183,13 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	char *secctx;
 	struct secids secid;
 
+#ifdef CONFIG_SECURITY_STACKING
 	secid_init(&secid);
+	secid.selinux = ct->secmark;
+	secid.smack = ct->secmark;
+#else
 	secid.common = ct->secmark;
+#endif
 
 	ret = security_secid_to_secctx(&secid, &secctx, &len);
 	if (ret)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 14935dd445bf..89876bb2bc29 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -316,8 +316,13 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
+#ifdef CONFIG_SECURITY_STACKING
 		secid_init(&secid);
+		secid.selinux = skb->secmark;
+		secid.smack = skb->secmark;
+#else
 		secid.common = skb->secmark;
+#endif
 		security_secid_to_secctx(&secid, secdata, &seclen);
 	}
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 6af1f4fc837d..a4646c301307 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -41,6 +41,9 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	case SECMARK_MODE_SEL:
 		secmark = info->secid;
 		break;
+	case SECMARK_MODE_SMACK:
+		secmark = info->secid;
+		break;
 	default:
 		BUG();
 	}
@@ -59,7 +62,16 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
 				       &secid);
-	info->secid = secid.selinux;
+	switch (info->mode) {
+	case SECMARK_MODE_SEL:
+		info->secid = secid.selinux;
+		break;
+	case SECMARK_MODE_SMACK:
+		info->secid = secid.smack;
+		break;
+	default:
+		BUG();
+	}
 
 	if (err) {
 		if (err == -EINVAL)
@@ -80,7 +92,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	security_secmark_refcount_inc();
+	if (mode)
+		security_secmark_refcount_inc(mode);
 	return 0;
 }
 
@@ -96,15 +109,23 @@ static int secmark_tg_check(const struct xt_tgchk_param *par)
 		return -EINVAL;
 	}
 
-	if (mode && mode != info->mode) {
-		pr_info_ratelimited("mode already set to %hu cannot mix with rules for mode %hu\n",
-				    mode, info->mode);
+	if (mode) {
+		if (mode != info->mode) {
+			pr_info("mode already set to %hu cannot mix with "
+				"rules for mode %hu\n", mode, info->mode);
+			return -EINVAL;
+		}
+	} else if (security_secmark_mode(info->mode)) {
+		pr_info("mode already set and cannot mix with "
+			"rules for mode %hu\n", info->mode);
 		return -EINVAL;
 	}
 
 	switch (info->mode) {
 	case SECMARK_MODE_SEL:
 		break;
+	case SECMARK_MODE_SMACK:
+		break;
 	default:
 		pr_info_ratelimited("invalid mode: %hu\n", info->mode);
 		return -EINVAL;
@@ -123,8 +144,14 @@ static void secmark_tg_destroy(const struct xt_tgdtor_param *par)
 {
 	switch (mode) {
 	case SECMARK_MODE_SEL:
-		security_secmark_refcount_dec();
+		break;
+	case SECMARK_MODE_SMACK:
+		break;
+	default:
+		pr_info("invalid mode: %hu\n", mode);
+		return;
 	}
+	security_secmark_refcount_dec(mode);
 }
 
 static struct xt_target secmark_tg_reg __read_mostly = {
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index e4360d03706a..560680d2348c 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -112,7 +112,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid.common != 0 &&
+	if (secid_valid(&audit_info->secid) &&
 	    security_secid_to_secctx(&audit_info->secid,
 				     &secctx,
 				     &secctx_len) == 0) {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index cbf8b1971b9e..672ea4a06cd3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -141,9 +141,10 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid.common;
 #ifdef CONFIG_SECURITY_STACKING
 	secid_to_skb(&scm->secid, skb);
+#else
+	UNIXCB(skb).secid = scm->secid.common;
 #endif
 }
 
@@ -158,7 +159,12 @@ static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return memcmp(&scm->secid, &(UNIXCB(skb).secid),
+		      sizeof(scm->secid)) == 0;
+#else
 	return (scm->secid.common == UNIXCB(skb).secid);
+#endif
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index 7821a6c10ee8..242dde44f854 100644
--- a/security/security.c
+++ b/security/security.c
@@ -346,10 +346,9 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
 	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-#ifdef CONFIG_NETWORK_SECMARK
+#ifdef CONFIG_SECURITY_NETWORK
 	/*
-	 * Store the most likely secmark with the socket
-	 * so that it doesn't have to be a managed object.
+	 * Store the secids with the socket for UDS.
 	 */
 	if (needed->lbs_sock && blob_sizes.lbs_sock == 0)
 		blob_sizes.lbs_sock = sizeof(struct secids);
@@ -2214,11 +2213,17 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 #ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	int rc = -ENOPROTOOPT;
+	int trc;
 
 	secid_init(secid);
 	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
-				list)
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+				list) {
+		trc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (trc == 0)
+			rc = 0;
+		else if (trc != -ENOPROTOOPT)
+			return trc;
+	}
 
 	return rc;
 #else
@@ -2308,18 +2313,32 @@ int security_secmark_relabel_packet(struct secids *secid)
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
-void security_secmark_refcount_inc(void)
+void security_secmark_refcount_inc(u8 lsm)
 {
-	call_void_hook(secmark_refcount_inc);
+	call_void_hook(secmark_refcount_inc, lsm);
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
-void security_secmark_refcount_dec(void)
+void security_secmark_refcount_dec(u8 lsm)
 {
-	call_void_hook(secmark_refcount_dec);
+	call_void_hook(secmark_refcount_dec, lsm);
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
+static u8 security_secmark_mode_value;
+
+int security_secmark_mode(u8 lsm)
+{
+	if (security_secmark_mode_value == 0) {
+		security_secmark_mode_value = lsm;
+		return 0;
+	}
+	if (security_secmark_mode_value == lsm)
+		return 0;
+	return -EBUSY;
+}
+EXPORT_SYMBOL(security_secmark_mode);
+
 int security_tun_dev_alloc_security(void **security)
 {
 	return call_int_hook(tun_dev_alloc_security, 0, security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ae0331b45700..d33a126cb3c9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -50,6 +50,7 @@
 #include <linux/mount.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/netfilter/xt_SECMARK.h>
 #include <linux/tty.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
@@ -5329,13 +5330,21 @@ static int selinux_secmark_relabel_packet(struct secids *secid)
 			    PACKET__RELABELTO, NULL);
 }
 
-static void selinux_secmark_refcount_inc(void)
+static void selinux_secmark_refcount_inc(u8 lsm)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SEL)
+		return;
+#endif
 	atomic_inc(&selinux_secmark_refcount);
 }
 
-static void selinux_secmark_refcount_dec(void)
+static void selinux_secmark_refcount_dec(u8 lsm)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SEL)
+		return;
+#endif
 	atomic_dec(&selinux_secmark_refcount);
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 26d0db6f3344..6476e038e7c1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -34,6 +34,7 @@
 #include <net/cipso_ipv4.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <linux/netfilter/xt_SECMARK.h>
 #include <linux/audit.h>
 #include <linux/magic.h>
 #include <linux/dcache.h>
@@ -51,6 +52,11 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
+/*
+ * SECMARK reference count
+ */
+static atomic_t smack_secmark_refcount = ATOMIC_INIT(0);
+
 #ifdef SMACK_IPV6_PORT_LABELING
 DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
@@ -3804,6 +3810,19 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 }
 #endif /* CONFIG_IPV6 */
 
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+static bool smack_owns_secmark(const struct sk_buff *skb)
+{
+	if (skb == NULL || skb->secmark == 0)
+		return false;
+#ifdef CONFIG_SECURITY_STACKING
+	return atomic_read(&smack_secmark_refcount) != 0;
+#else
+	return true;
+#endif
+}
+#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3834,7 +3853,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * If there is no secmark fall back to CIPSO.
 		 * The secmark is assumed to reflect policy better.
 		 */
-		if (skb && skb->secmark != 0) {
+		if (smack_owns_secmark(skb)) {
 			skp = smack_from_secid(skb->secmark);
 			goto access_check;
 		}
@@ -3879,7 +3898,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		if (skb)
+		if (smack_owns_secmark(skb))
 			skp = smack_from_secid(skb->secmark);
 		else
 			skp = smack_ipv6host_label(&sadd);
@@ -3976,7 +3995,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		if (skb->secmark) {
+		if (smack_owns_secmark(skb)) {
 			s = skb->secmark;
 			if (s != 0)
 				break;
@@ -3997,7 +4016,8 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		if (smack_owns_secmark(skb))
+			s = skb->secmark;
 #endif
 		break;
 	}
@@ -4075,11 +4095,9 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * If there is no secmark fall back to CIPSO.
 	 * The secmark is assumed to reflect policy better.
 	 */
-	if (skb) {
-		if (skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
-			goto access_check;
-		}
+	if (smack_owns_secmark(skb)) {
+		skp = smack_from_secid(skb->secmark);
+		goto access_check;
 	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
@@ -4155,6 +4173,24 @@ static void smack_inet_csk_clone(struct sock *sk,
 		ssp->smk_packet = NULL;
 }
 
+static void smack_secmark_refcount_inc(u8 lsm)
+{
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SMACK)
+		return;
+#endif
+	atomic_inc(&smack_secmark_refcount);
+}
+
+static void smack_secmark_refcount_dec(u8 lsm)
+{
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SMACK)
+		return;
+#endif
+	atomic_dec(&smack_secmark_refcount);
+}
+
 /*
  * Key management security hooks
  *
@@ -4663,6 +4699,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
+	LSM_HOOK_INIT(secmark_refcount_inc, smack_secmark_refcount_inc),
+	LSM_HOOK_INIT(secmark_refcount_dec, smack_secmark_refcount_dec),
 
  /* key management security hooks */
 #ifdef CONFIG_KEYS
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 701a1cc1bdcc..596aba2e4d6b 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -16,6 +16,7 @@
 
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/netfilter/xt_SECMARK.h>
 #include <linux/netdevice.h>
 #include <net/inet_sock.h>
 #include <net/net_namespace.h>
@@ -31,6 +32,11 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
+#ifdef CONFIG_SECURITY_STACKING
+	if (security_secmark_mode(SECMARK_MODE_SMACK))
+		return NF_ACCEPT;
+#endif
+
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
@@ -49,6 +55,11 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
+#ifdef CONFIG_SECURITY_STACKING
+	if (security_secmark_mode(SECMARK_MODE_SMACK))
+		return NF_ACCEPT;
+#endif
+
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-- 
2.17.1


