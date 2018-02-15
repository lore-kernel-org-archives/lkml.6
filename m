Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720361-2-6464680831075939099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720360; b=uHk6JKkijaxjt07d06OKQxHqSBwbXVsvuktEz3mdtE2b/9I
    bJ47Cx+MiOjDBv4hFOx9ClxgaP6CwZScD/CptBICnDaPbYYoH1unKsfAzmDnNLn3
    rMB+9DLlxnm76M/g/wjwD7kM2F+xV/8muvWTzsUMlihbHPmVG36mX7YX11Jslbyy
    EQsUvwq+eU+4sY1RzhwAKg7wS4zesIhmxsPNLlv4xkaN3uUd4CCagcwVrp45CF5G
    OlpPKlcwZUe+ADDnx7SO6ev50tOPfwp1lhfdQ/vv2GIQnxoSosPDCwp98Rk0FqFv
    NxgMqw84MZ7V8H469lYguLqqYnTfiXjsbGsIwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720360; bh=yYYSBiixpo5ppcUYJtoAC2+Rkb
    yKGARdLPFtcx64b+M=; b=dPN34NwHc6qJIyXWVM5V+UJVEPyDBkA4mbqrbcM2d3
    kdXuLLLb94qvQVuBP9lJhAZnCyfvkJ4mq8kToTwFNQEYBoIrP8RViwtP5QhyixgB
    Fg93X8+9aiyun0DIuL+D0jqjknvLkQNSTdqvz13OCYA2Jnbp9l8H1yXnlqH8cUah
    kDtONQiikxPeScz0WVSpmYj5Qf/qxIMBYGEGcPSMRp829IJZRLSypzJT/Qm3NFT4
    uOkdYFyZr6joQR3sL9C76l/yQkpd9JiMHVcyI5dvgbM8UTQY5GPz1w/UlasOXRL9
    6s20qD6GuZSeEYW5DTt/cgZcwogy84FtfgnIjpDM3iWA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162427AbeBOPWs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:22:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPWq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4.4 046/108] netfilter: nf_queue: Make the queue_handler pernet
Date: Thu, 15 Feb 2018 16:16:43 +0100
Message-Id: <20180215151228.845739977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit dc3ee32e96d74dd6c80eed63af5065cb75899299 upstream.

Florian Weber reported:
> Under full load (unshare() in loop -> OOM conditions) we can
> get kernel panic:
>
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> IP: [<ffffffff81476c85>] nfqnl_nf_hook_drop+0x35/0x70
> [..]
> task: ffff88012dfa3840 ti: ffff88012dffc000 task.ti: ffff88012dffc000
> RIP: 0010:[<ffffffff81476c85>]  [<ffffffff81476c85>] nfqnl_nf_hook_drop+0x35/0x70
> RSP: 0000:ffff88012dfffd80  EFLAGS: 00010206
> RAX: 0000000000000008 RBX: ffffffff81add0c0 RCX: ffff88013fd80000
> [..]
> Call Trace:
>  [<ffffffff81474d98>] nf_queue_nf_hook_drop+0x18/0x20
>  [<ffffffff814738eb>] nf_unregister_net_hook+0xdb/0x150
>  [<ffffffff8147398f>] netfilter_net_exit+0x2f/0x60
>  [<ffffffff8141b088>] ops_exit_list.isra.4+0x38/0x60
>  [<ffffffff8141b652>] setup_net+0xc2/0x120
>  [<ffffffff8141bd09>] copy_net_ns+0x79/0x120
>  [<ffffffff8106965b>] create_new_namespaces+0x11b/0x1e0
>  [<ffffffff810698a7>] unshare_nsproxy_namespaces+0x57/0xa0
>  [<ffffffff8104baa2>] SyS_unshare+0x1b2/0x340
>  [<ffffffff81608276>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> Code: 65 00 48 89 e5 41 56 41 55 41 54 53 83 e8 01 48 8b 97 70 12 00 00 48 98 49 89 f4 4c 8b 74 c2 18 4d 8d 6e 08 49 81 c6 88 00 00 00 <49> 8b 5d 00 48 85 db 74 1a 48 89 df 4c 89 e2 48 c7 c6 90 68 47
>

The simple fix for this requires a new pernet variable for struct
nf_queue that indicates when it is safe to use the dynamically
allocated nf_queue state.

As we need a variable anyway make nf_register_queue_handler and
nf_unregister_queue_handler pernet.  This allows the existing logic of
when it is safe to use the state from the nfnetlink_queue module to be
reused with no changes except for making it per net.

The syncrhonize_rcu from nf_unregister_queue_handler is moved to a new
function nfnl_queue_net_exit_batch so that the worst case of having a
syncrhonize_rcu in the pernet exit path is not experienced in batch
mode.

Reported-by: Florian Westphal <fw@strlen.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/netfilter/nf_queue.h |    4 ++--
 include/net/netns/netfilter.h    |    2 ++
 net/netfilter/nf_queue.c         |   17 ++++++++---------
 net/netfilter/nfnetlink_queue.c  |   18 ++++++++++++------
 4 files changed, 24 insertions(+), 17 deletions(-)

--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -28,8 +28,8 @@ struct nf_queue_handler {
 						struct nf_hook_ops *ops);
 };
 
-void nf_register_queue_handler(const struct nf_queue_handler *qh);
-void nf_unregister_queue_handler(void);
+void nf_register_queue_handler(struct net *net, const struct nf_queue_handler *qh);
+void nf_unregister_queue_handler(struct net *net);
 void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict);
 
 void nf_queue_entry_get_refs(struct nf_queue_entry *entry);
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -5,11 +5,13 @@
 
 struct proc_dir_entry;
 struct nf_logger;
+struct nf_queue_handler;
 
 struct netns_nf {
 #if defined CONFIG_PROC_FS
 	struct proc_dir_entry *proc_netfilter;
 #endif
+	const struct nf_queue_handler __rcu *queue_handler;
 	const struct nf_logger __rcu *nf_loggers[NFPROTO_NUMPROTO];
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *nf_log_dir_header;
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -26,23 +26,21 @@
  * Once the queue is registered it must reinject all packets it
  * receives, no matter what.
  */
-static const struct nf_queue_handler __rcu *queue_handler __read_mostly;
 
 /* return EBUSY when somebody else is registered, return EEXIST if the
  * same handler is registered, return 0 in case of success. */
-void nf_register_queue_handler(const struct nf_queue_handler *qh)
+void nf_register_queue_handler(struct net *net, const struct nf_queue_handler *qh)
 {
 	/* should never happen, we only have one queueing backend in kernel */
-	WARN_ON(rcu_access_pointer(queue_handler));
-	rcu_assign_pointer(queue_handler, qh);
+	WARN_ON(rcu_access_pointer(net->nf.queue_handler));
+	rcu_assign_pointer(net->nf.queue_handler, qh);
 }
 EXPORT_SYMBOL(nf_register_queue_handler);
 
 /* The caller must flush their queue before this */
-void nf_unregister_queue_handler(void)
+void nf_unregister_queue_handler(struct net *net)
 {
-	RCU_INIT_POINTER(queue_handler, NULL);
-	synchronize_rcu();
+	RCU_INIT_POINTER(net->nf.queue_handler, NULL);
 }
 EXPORT_SYMBOL(nf_unregister_queue_handler);
 
@@ -103,7 +101,7 @@ void nf_queue_nf_hook_drop(struct net *n
 	const struct nf_queue_handler *qh;
 
 	rcu_read_lock();
-	qh = rcu_dereference(queue_handler);
+	qh = rcu_dereference(net->nf.queue_handler);
 	if (qh)
 		qh->nf_hook_drop(net, ops);
 	rcu_read_unlock();
@@ -122,9 +120,10 @@ int nf_queue(struct sk_buff *skb,
 	struct nf_queue_entry *entry = NULL;
 	const struct nf_afinfo *afinfo;
 	const struct nf_queue_handler *qh;
+	struct net *net = state->net;
 
 	/* QUEUE == DROP if no one is waiting, to be safe. */
-	qh = rcu_dereference(queue_handler);
+	qh = rcu_dereference(net->nf.queue_handler);
 	if (!qh) {
 		status = -ESRCH;
 		goto err;
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1382,21 +1382,29 @@ static int __net_init nfnl_queue_net_ini
 			 net->nf.proc_netfilter, &nfqnl_file_ops))
 		return -ENOMEM;
 #endif
+	nf_register_queue_handler(net, &nfqh);
 	return 0;
 }
 
 static void __net_exit nfnl_queue_net_exit(struct net *net)
 {
+	nf_unregister_queue_handler(net);
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("nfnetlink_queue", net->nf.proc_netfilter);
 #endif
 }
 
+static void nfnl_queue_net_exit_batch(struct list_head *net_exit_list)
+{
+	synchronize_rcu();
+}
+
 static struct pernet_operations nfnl_queue_net_ops = {
-	.init	= nfnl_queue_net_init,
-	.exit	= nfnl_queue_net_exit,
-	.id	= &nfnl_queue_net_id,
-	.size	= sizeof(struct nfnl_queue_net),
+	.init		= nfnl_queue_net_init,
+	.exit		= nfnl_queue_net_exit,
+	.exit_batch	= nfnl_queue_net_exit_batch,
+	.id		= &nfnl_queue_net_id,
+	.size		= sizeof(struct nfnl_queue_net),
 };
 
 static int __init nfnetlink_queue_init(void)
@@ -1417,7 +1425,6 @@ static int __init nfnetlink_queue_init(v
 	}
 
 	register_netdevice_notifier(&nfqnl_dev_notifier);
-	nf_register_queue_handler(&nfqh);
 	return status;
 
 cleanup_netlink_notifier:
@@ -1429,7 +1436,6 @@ out:
 
 static void __exit nfnetlink_queue_fini(void)
 {
-	nf_unregister_queue_handler();
 	unregister_netdevice_notifier(&nfqnl_dev_notifier);
 	nfnetlink_subsys_unregister(&nfqnl_subsys);
 	netlink_unregister_notifier(&nfqnl_rtnl_notifier);
