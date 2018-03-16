Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191301-2-16631548659208073652
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
    t=1521191300; b=V0I/kgu2s7n9ax71BiQ7kG7BWN9IgiQY7qWUJshSR6SdcvM
    +COg9rAKnL0odgH+s7weOkodcw2txLj+BimcK1Vizq0PQwvyQJ53NkvRaN+G/a9P
    1m6+jrfLMtwuZ0k1ixruUrj8tzkOD3BhlrQ34CDmyBHFWmOVkKJAJuRFa6R2JnEj
    lbDhgQyqZZsSPvqcRHI8Ah6tf8agE+c0oDsLrcEX6ctrH6g4ySu2HpbTwdMe4faf
    NYereuJKoC1zTQDOrxDNbAgKHumz5In4nMYmmdXd0bW/zoG2mYxAel0fwkWW5Jpo
    O93Bm9rWWvdVTRJ7qy5IdyFqF5EKS7q64TFnxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191300; bh=IzM9HeUtKpPLAzDNxPaUJNzPnbICcGUlxYD
    /MxU/b60=; b=unnsTiQvcrEpQFgGvVp5oUatIPMb/zNnGskqDCMTPnxoejcXyik
    Ghn84Ccm8Ujo0HcLSN4FGt62eCGrj3GbuF1GbnbGRD0JsvP+6abkrYmR6ijD1etN
    E2nlWLSnTqB2wd3FPqeC0EwYmT1jf6D0a9pyckvvZc9ReB8cxPBlWg0hgbUUqR+o
    k0dct73P+ytP0bDv0DTBAg3oUM8BGH6NW3iVhgtg7Aaeg9Bd9uCbHvTcuTZyluIH
    u+sgbyV6ndgJ5h2uENXSDwNNEngbSMQpQwGYP/Y+jn/MVcWj/Y9t0mjxg1/DTt8S
    LlmTEa0bELT65jP8WGHpIpzLlWcGyalEtLQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1753481AbeCPJHQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:07:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753463AbeCPJHO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:07:14 -0400
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
Subject: [RFC PATCH ghak32 V2 11/13] audit: add support for containerid to network namespaces
Date: Fri, 16 Mar 2018 05:00:38 -0400
Message-Id: <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Audit events could happen in a network namespace outside of a task
context due to packets received from the net that trigger an auditing
rule prior to being associated with a running task.  The network
namespace could in use by multiple containers by association to the
tasks in that network namespace.  We still want a way to attribute
these events to any potential containers.  Keep a list per network
namespace to track these container identifiiers.

Add/increment the container identifier on:
- initial setting of the container id via /proc
- clone/fork call that inherits a container identifier
- unshare call that inherits a container identifier
- setns call that inherits a container identifier
Delete/decrement the container identifier on:
- an inherited container id dropped when child set
- process exit
- unshare call that drops a net namespace
- setns call that drops a net namespace

See: https://github.com/linux-audit/audit-kernel/issues/32
See: https://github.com/linux-audit/audit-testsuite/issues/64
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h       |  7 +++++++
 include/net/net_namespace.h | 12 ++++++++++++
 kernel/auditsc.c            |  9 ++++++---
 kernel/nsproxy.c            |  6 ++++++
 net/core/net_namespace.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index c0b83cb..d9afb7d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <uapi/linux/audit.h>
+#include <linux/refcount.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -88,6 +89,12 @@ struct audit_field {
 	u32				op;
 };
 
+struct audit_containerid {
+	struct list_head	list;
+	u64			id;
+	refcount_t		refcount;
+};
+
 extern int is_audit_feature_set(int which);
 
 extern int __init audit_register_class(int class, unsigned *list);
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0490084..343a428 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -33,6 +33,7 @@
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 #include <linux/skbuff.h>
+#include <linux/audit.h>
 
 struct user_namespace;
 struct proc_dir_entry;
@@ -150,6 +151,7 @@ struct net {
 #endif
 	struct sock		*diag_nlsk;
 	atomic_t		fnhe_genid;
+	struct list_head	audit_containerid;
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
@@ -301,6 +303,16 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #define __net_initconst	__initconst
 #endif
 
+#ifdef CONFIG_NET_NS
+void net_add_audit_containerid(struct net *net, u64 containerid);
+void net_del_audit_containerid(struct net *net, u64 containerid);
+#else
+static inline void net_add_audit_containerid(struct net *, u64)
+{ }
+static inline void net_del_audit_containerid(struct net *, u64)
+{ }
+#endif
+
 int peernet2id_alloc(struct net *net, struct net *peer);
 int peernet2id(struct net *net, struct net *peer);
 bool peernet_has_id(struct net *net, struct net *peer);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2f02ed9..208da962 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -75,6 +75,7 @@
 #include <linux/uaccess.h>
 #include <linux/fsnotify_backend.h>
 #include <uapi/linux/limits.h>
+#include <net/net_namespace.h>
 
 #include "audit.h"
 
@@ -2175,16 +2176,18 @@ static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainer
  */
 int audit_set_containerid(struct task_struct *task, u64 containerid)
 {
-	u64 oldcontainerid;
+	u64 oldcontainerid = audit_get_containerid(task);
 	int rc;
-
-	oldcontainerid = audit_get_containerid(task);
+	struct net *net = task->nsproxy->net_ns;
 
 	rc = audit_set_containerid_perm(task, containerid);
 	if (!rc) {
+		if (cid_valid(oldcontainerid))
+			net_del_audit_containerid(net, oldcontainerid);
 		task_lock(task);
 		task->containerid = containerid;
 		task_unlock(task);
+		net_add_audit_containerid(net, containerid);
 	}
 
 	audit_log_set_containerid(task, oldcontainerid, containerid, rc);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index f6c5d33..d9f1090 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -140,6 +140,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
+	u64 containerid = audit_get_containerid(tsk);
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
@@ -167,6 +168,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 		return  PTR_ERR(new_ns);
 
 	tsk->nsproxy = new_ns;
+	net_add_audit_containerid(new_ns->net_ns, containerid);
 	return 0;
 }
 
@@ -217,6 +219,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 {
 	struct nsproxy *ns;
+	u64 containerid = audit_get_containerid(p);
 
 	might_sleep();
 
@@ -224,6 +227,9 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 	ns = p->nsproxy;
 	p->nsproxy = new;
 	task_unlock(p);
+	net_del_audit_containerid(ns->net_ns, containerid);
+	if (new)
+		net_add_audit_containerid(new->net_ns, containerid);
 
 	if (ns && atomic_dec_and_test(&ns->count))
 		free_nsproxy(ns);
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 60a71be7..ae30d33 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -22,6 +22,7 @@
 #include <net/netlink.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/nsproxy.h>
 
 /*
  *	Our network namespace constructor/destructor lists
@@ -290,6 +291,7 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	net->user_ns = user_ns;
 	idr_init(&net->netns_ids);
 	spin_lock_init(&net->nsid_lock);
+	INIT_LIST_HEAD(&net->audit_containerid);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
@@ -1067,6 +1069,49 @@ void unregister_pernet_device(struct pernet_operations *ops)
 EXPORT_SYMBOL_GPL(unregister_pernet_device);
 
 #ifdef CONFIG_NET_NS
+void net_add_audit_containerid(struct net *net, u64 containerid)
+{
+	struct audit_containerid *cont;
+
+	if (!cid_valid(containerid))
+		return;
+	if (!list_empty(&net->audit_containerid))
+		list_for_each_entry(cont, &net->audit_containerid, list)
+			if (cont->id == containerid) {
+				refcount_inc(&cont->refcount);
+				return;
+			}
+	cont = kmalloc(sizeof(struct audit_containerid), GFP_KERNEL);
+	if (!cont)
+		return;
+	INIT_LIST_HEAD(&cont->list);
+	cont->id = containerid;
+	refcount_set(&cont->refcount, 1);
+	list_add(&cont->list, &net->audit_containerid);
+}
+
+void net_del_audit_containerid(struct net *net, u64 containerid)
+{
+	struct audit_containerid *cont = NULL;
+	int found = 0;
+
+	if (!cid_valid(containerid))
+		return;
+	if (!list_empty(&net->audit_containerid))
+		list_for_each_entry(cont, &net->audit_containerid, list)
+			if (cont->id == containerid) {
+				found = 1;
+				break;
+			}
+	if (!found)
+		return;
+	list_del(&cont->list);
+	if (refcount_dec_and_test(&cont->refcount))
+		kfree(cont);
+}
+#endif
+
+#ifdef CONFIG_NET_NS
 static struct ns_common *netns_get(struct task_struct *task)
 {
 	struct net *net = NULL;
-- 
1.8.3.1

