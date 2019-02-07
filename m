Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1CF218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfBGHqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:46:49 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44291 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfBGHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:46:49 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 Feb 2019 09:46:44 +0200
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.137.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x177kiud026759;
        Thu, 7 Feb 2019 09:46:44 +0200
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x177khSM030222;
        Thu, 7 Feb 2019 09:46:43 +0200
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x177khSM030221;
        Thu, 7 Feb 2019 09:46:43 +0200
From:   Eli Cohen <eli@mellanox.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     simon.horman@netronome.com, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com, Eli Cohen <eli@mellanox.com>
Subject: [PATCH net-next 2/2] net: Change TCA_ACT_* to TCA_ID_* to match that of TCA_ID_POLICE
Date:   Thu,  7 Feb 2019 09:45:49 +0200
Message-Id: <20190207074549.29861-3-eli@mellanox.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190207074549.29861-1-eli@mellanox.com>
References: <20190207074549.29861-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the kernel users of the TCA_ACT_* macros to use TCA_ID_*. For
example, use TCA_ID_GACT instead of TCA_ACT_GACT. This will align with
TCA_ID_POLICE and also differentiates these identifier, used in struct
tc_action_ops type field, from other macros starting with TCA_ACT_.

To make things clearer, we name the enum defining the TCA_ID_*
identifiers and also change the "type" field of struct tc_action to
id.

Signed-off-by: Eli Cohen <eli@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/act_api.h              | 2 +-
 include/net/tc_act/tc_csum.h       | 2 +-
 include/net/tc_act/tc_gact.h       | 2 +-
 include/net/tc_act/tc_mirred.h     | 4 ++--
 include/net/tc_act/tc_pedit.h      | 2 +-
 include/net/tc_act/tc_sample.h     | 2 +-
 include/net/tc_act/tc_skbedit.h    | 2 +-
 include/net/tc_act/tc_tunnel_key.h | 4 ++--
 include/net/tc_act/tc_vlan.h       | 2 +-
 include/uapi/linux/pkt_cls.h       | 2 +-
 net/sched/act_api.c                | 2 +-
 net/sched/act_bpf.c                | 2 +-
 net/sched/act_connmark.c           | 2 +-
 net/sched/act_csum.c               | 2 +-
 net/sched/act_gact.c               | 2 +-
 net/sched/act_ife.c                | 2 +-
 net/sched/act_ipt.c                | 4 ++--
 net/sched/act_mirred.c             | 2 +-
 net/sched/act_nat.c                | 2 +-
 net/sched/act_pedit.c              | 2 +-
 net/sched/act_police.c             | 2 +-
 net/sched/act_sample.c             | 2 +-
 net/sched/act_simple.c             | 4 +---
 net/sched/act_skbedit.c            | 2 +-
 net/sched/act_skbmod.c             | 2 +-
 net/sched/act_tunnel_key.c         | 2 +-
 net/sched/act_vlan.c               | 2 +-
 27 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index dbc795ec659e..c745e9ccfab2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -80,7 +80,7 @@ static inline void tcf_tm_dump(struct tcf_t *dtm, const struct tcf_t *stm)
 struct tc_action_ops {
 	struct list_head head;
 	char    kind[IFNAMSIZ];
-	__u32   type; /* TBD to match kind */
+	enum tca_id  id; /* identifier should match kind */
 	size_t	size;
 	struct module		*owner;
 	int     (*act)(struct sk_buff *, const struct tc_action *,
diff --git a/include/net/tc_act/tc_csum.h b/include/net/tc_act/tc_csum.h
index 32d2454c0479..68269e4581b7 100644
--- a/include/net/tc_act/tc_csum.h
+++ b/include/net/tc_act/tc_csum.h
@@ -21,7 +21,7 @@ struct tcf_csum {
 static inline bool is_tcf_csum(const struct tc_action *a)
 {
 #ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->type == TCA_ACT_CSUM)
+	if (a->ops && a->ops->id == TCA_ID_CSUM)
 		return true;
 #endif
 	return false;
diff --git a/include/net/tc_act/tc_gact.h b/include/net/tc_act/tc_gact.h
index ef8dd0db70ce..ee8d005f56fc 100644
--- a/include/net/tc_act/tc_gact.h
+++ b/include/net/tc_act/tc_gact.h
@@ -22,7 +22,7 @@ static inline bool __is_tcf_gact_act(const struct tc_action *a, int act,
 #ifdef CONFIG_NET_CLS_ACT
 	struct tcf_gact *gact;
 
-	if (a->ops && a->ops->type != TCA_ACT_GACT)
+	if (a->ops && a->ops->id != TCA_ID_GACT)
 		return false;
 
 	gact = to_gact(a);
diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
index a2e9cbca5c9e..c757585a05b0 100644
--- a/include/net/tc_act/tc_mirred.h
+++ b/include/net/tc_act/tc_mirred.h
@@ -17,7 +17,7 @@ struct tcf_mirred {
 static inline bool is_tcf_mirred_egress_redirect(const struct tc_action *a)
 {
 #ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->type == TCA_ACT_MIRRED)
+	if (a->ops && a->ops->id == TCA_ID_MIRRED)
 		return to_mirred(a)->tcfm_eaction == TCA_EGRESS_REDIR;
 #endif
 	return false;
@@ -26,7 +26,7 @@ static inline bool is_tcf_mirred_egress_redirect(const struct tc_action *a)
 static inline bool is_tcf_mirred_egress_mirror(const struct tc_action *a)
 {
 #ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->type == TCA_ACT_MIRRED)
+	if (a->ops && a->ops->id == TCA_ID_MIRRED)
 		return to_mirred(a)->tcfm_eaction == TCA_EGRESS_MIRROR;
 #endif
 	return false;
diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index fac3ad4a86de..748cf87a4d7e 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -23,7 +23,7 @@ struct tcf_pedit {
 static inline bool is_tcf_pedit(const struct tc_action *a)
 {
 #ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->type == TCA_ACT_PEDIT)
+	if (a->ops && a->ops->id == TCA_ID_PEDIT)
 		return true;
 #endif
 	return false;
diff --git a/include/net/tc_act/tc_sample.h b/include/net/tc_act/tc_sample.h
index 01dbfea32672..0a559d4b6f0f 100644
--- a/include/net/tc_act/tc_sample.h
+++ b/include/net/tc_act/tc_sample.h
@@ -20,7 +20,7 @@ struct tcf_sample {
 static inline bool is_tcf_sample(const struct tc_action *a)
 {
 #ifdef CONFIG_NET_CLS_ACT
-	return a->ops && a->ops->type == TCA_ACT_SAMPLE;
+	return a->ops && a->ops->id == TCA_ID_SAMPLE;
 #else
 	return false;
 #endif
diff --git a/include/net/tc_act/tc_skbedit.h b/include/net/tc_act/tc_skbedit.h
index 911bbac838a2..85c5c4756d92 100644
--- a/include/net/tc_act/tc_skbedit.h
+++ b/include/net/tc_act/tc_skbedit.h
@@ -44,7 +44,7 @@ static inline bool is_tcf_skbedit_mark(const struct tc_action *a)
 #ifdef CONFIG_NET_CLS_ACT
 	u32 flags;
 
-	if (a->ops && a->ops->type == TCA_ACT_SKBEDIT) {
+	if (a->ops && a->ops->id == TCA_ID_SKBEDIT) {
 		rcu_read_lock();
 		flags = rcu_dereference(to_skbedit(a)->params)->flags;
 		rcu_read_unlock();
diff --git a/include/net/tc_act/tc_tunnel_key.h b/include/net/tc_act/tc_tunnel_key.h
index 46b8c7f1c8d5..23d5b8b19f3e 100644
--- a/include/net/tc_act/tc_tunnel_key.h
+++ b/include/net/tc_act/tc_tunnel_key.h
@@ -34,7 +34,7 @@ static inline bool is_tcf_tunnel_set(const struct tc_action *a)
 	struct tcf_tunnel_key *t = to_tunnel_key(a);
 	struct tcf_tunnel_key_params *params = rtnl_dereference(t->params);
 
-	if (a->ops && a->ops->type == TCA_ACT_TUNNEL_KEY)
+	if (a->ops && a->ops->id == TCA_ID_TUNNEL_KEY)
 		return params->tcft_action == TCA_TUNNEL_KEY_ACT_SET;
 #endif
 	return false;
@@ -46,7 +46,7 @@ static inline bool is_tcf_tunnel_release(const struct tc_action *a)
 	struct tcf_tunnel_key *t = to_tunnel_key(a);
 	struct tcf_tunnel_key_params *params = rtnl_dereference(t->params);
 
-	if (a->ops && a->ops->type == TCA_ACT_TUNNEL_KEY)
+	if (a->ops && a->ops->id == TCA_ID_TUNNEL_KEY)
 		return params->tcft_action == TCA_TUNNEL_KEY_ACT_RELEASE;
 #endif
 	return false;
diff --git a/include/net/tc_act/tc_vlan.h b/include/net/tc_act/tc_vlan.h
index 22ae260d6869..fe39ed502bef 100644
--- a/include/net/tc_act/tc_vlan.h
+++ b/include/net/tc_act/tc_vlan.h
@@ -30,7 +30,7 @@ struct tcf_vlan {
 static inline bool is_tcf_vlan(const struct tc_action *a)
 {
 #ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->type == TCA_ACT_VLAN)
+	if (a->ops && a->ops->id == TCA_ID_VLAN)
 		return true;
 #endif
 	return false;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 7ab55f97e7c4..51a0496f78ea 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -85,7 +85,7 @@ enum {
 #define TCA_ACT_SAMPLE 26
 
 /* Action type identifiers*/
-enum {
+enum tca_id {
 	TCA_ID_UNSPEC = 0,
 	TCA_ID_POLICE = 1,
 	TCA_ID_GACT = TCA_ACT_GACT,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index d4b8355737d8..aecf1bf233c8 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -543,7 +543,7 @@ int tcf_register_action(struct tc_action_ops *act,
 
 	write_lock(&act_mod_lock);
 	list_for_each_entry(a, &act_base, head) {
-		if (act->type == a->type || (strcmp(act->kind, a->kind) == 0)) {
+		if (act->id == a->id || (strcmp(act->kind, a->kind) == 0)) {
 			write_unlock(&act_mod_lock);
 			unregister_pernet_subsys(ops);
 			return -EEXIST;
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index c7633843e223..aa5c38d11a30 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -396,7 +396,7 @@ static int tcf_bpf_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_bpf_ops __read_mostly = {
 	.kind		=	"bpf",
-	.type		=	TCA_ACT_BPF,
+	.id		=	TCA_ID_BPF,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_bpf_act,
 	.dump		=	tcf_bpf_dump,
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 8475913f2070..5d24993cccfe 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -204,7 +204,7 @@ static int tcf_connmark_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_connmark_ops = {
 	.kind		=	"connmark",
-	.type		=	TCA_ACT_CONNMARK,
+	.id		=	TCA_ID_CONNMARK,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_connmark_act,
 	.dump		=	tcf_connmark_dump,
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 3dc25b7806d7..945fb34ae721 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -660,7 +660,7 @@ static size_t tcf_csum_get_fill_size(const struct tc_action *act)
 
 static struct tc_action_ops act_csum_ops = {
 	.kind		= "csum",
-	.type		= TCA_ACT_CSUM,
+	.id		= TCA_ID_CSUM,
 	.owner		= THIS_MODULE,
 	.act		= tcf_csum_act,
 	.dump		= tcf_csum_dump,
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index b61c20ebb314..93da0004e9f4 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -253,7 +253,7 @@ static size_t tcf_gact_get_fill_size(const struct tc_action *act)
 
 static struct tc_action_ops act_gact_ops = {
 	.kind		=	"gact",
-	.type		=	TCA_ACT_GACT,
+	.id		=	TCA_ID_GACT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_gact_act,
 	.stats_update	=	tcf_gact_stats_update,
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 30b63fa23ee2..9b1f2b3990ee 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -864,7 +864,7 @@ static int tcf_ife_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_ife_ops = {
 	.kind = "ife",
-	.type = TCA_ACT_IFE,
+	.id = TCA_ID_IFE,
 	.owner = THIS_MODULE,
 	.act = tcf_ife_act,
 	.dump = tcf_ife_dump,
diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 8af6c11d2482..1bad190710ad 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -338,7 +338,7 @@ static int tcf_ipt_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_ipt_ops = {
 	.kind		=	"ipt",
-	.type		=	TCA_ACT_IPT,
+	.id		=	TCA_ID_IPT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_ipt_act,
 	.dump		=	tcf_ipt_dump,
@@ -387,7 +387,7 @@ static int tcf_xt_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_xt_ops = {
 	.kind		=	"xt",
-	.type		=	TCA_ACT_XT,
+	.id		=	TCA_ID_XT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_ipt_act,
 	.dump		=	tcf_ipt_dump,
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index c8cf4d10c435..6692fd054617 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -400,7 +400,7 @@ static void tcf_mirred_put_dev(struct net_device *dev)
 
 static struct tc_action_ops act_mirred_ops = {
 	.kind		=	"mirred",
-	.type		=	TCA_ACT_MIRRED,
+	.id		=	TCA_ID_MIRRED,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_mirred_act,
 	.stats_update	=	tcf_stats_update,
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index c5c1e23add77..543eab9193f1 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -304,7 +304,7 @@ static int tcf_nat_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_nat_ops = {
 	.kind		=	"nat",
-	.type		=	TCA_ACT_NAT,
+	.id		=	TCA_ID_NAT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_nat_act,
 	.dump		=	tcf_nat_dump,
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 2b372a06b432..4039385442e6 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -470,7 +470,7 @@ static int tcf_pedit_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_pedit_ops = {
 	.kind		=	"pedit",
-	.type		=	TCA_ACT_PEDIT,
+	.id		=	TCA_ID_PEDIT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_pedit_act,
 	.dump		=	tcf_pedit_dump,
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index ec8ec55e0fe8..8271a6263824 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -366,7 +366,7 @@ static int tcf_police_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_police_ops = {
 	.kind		=	"police",
-	.type		=	TCA_ID_POLICE,
+	.id		=	TCA_ID_POLICE,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_police_act,
 	.dump		=	tcf_police_dump,
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 1a0c682fd734..203e399e5c85 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -233,7 +233,7 @@ static int tcf_sample_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_sample_ops = {
 	.kind	  = "sample",
-	.type	  = TCA_ACT_SAMPLE,
+	.id	  = TCA_ID_SAMPLE,
 	.owner	  = THIS_MODULE,
 	.act	  = tcf_sample_act,
 	.dump	  = tcf_sample_dump,
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 902957beceb3..d54cb608dbaf 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -19,8 +19,6 @@
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 
-#define TCA_ACT_SIMP 22
-
 #include <linux/tc_act/tc_defact.h>
 #include <net/tc_act/tc_defact.h>
 
@@ -197,7 +195,7 @@ static int tcf_simp_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_simp_ops = {
 	.kind		=	"simple",
-	.type		=	TCA_ACT_SIMP,
+	.id		=	TCA_ID_SIMP,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_simp_act,
 	.dump		=	tcf_simp_dump,
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 64dba3708fce..39f8a67ea940 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -305,7 +305,7 @@ static int tcf_skbedit_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_skbedit_ops = {
 	.kind		=	"skbedit",
-	.type		=	TCA_ACT_SKBEDIT,
+	.id		=	TCA_ID_SKBEDIT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_skbedit_act,
 	.dump		=	tcf_skbedit_dump,
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 59710a183bd3..7bac1d78e7a3 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -260,7 +260,7 @@ static int tcf_skbmod_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_skbmod_ops = {
 	.kind		=	"skbmod",
-	.type		=	TCA_ACT_SKBMOD,
+	.id		=	TCA_ACT_SKBMOD,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_skbmod_act,
 	.dump		=	tcf_skbmod_dump,
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 8b43fe0130f7..9104b8e36482 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -563,7 +563,7 @@ static int tunnel_key_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_tunnel_key_ops = {
 	.kind		=	"tunnel_key",
-	.type		=	TCA_ACT_TUNNEL_KEY,
+	.id		=	TCA_ID_TUNNEL_KEY,
 	.owner		=	THIS_MODULE,
 	.act		=	tunnel_key_act,
 	.dump		=	tunnel_key_dump,
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 93fdaf707313..ac0061599225 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -297,7 +297,7 @@ static int tcf_vlan_search(struct net *net, struct tc_action **a, u32 index)
 
 static struct tc_action_ops act_vlan_ops = {
 	.kind		=	"vlan",
-	.type		=	TCA_ACT_VLAN,
+	.id		=	TCA_ID_VLAN,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_vlan_act,
 	.dump		=	tcf_vlan_dump,
-- 
1.8.3.1

