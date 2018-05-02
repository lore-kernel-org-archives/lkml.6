Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4181815-1525233932-2-12855724620952802560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525233931; b=nm7wl4LsXHSuQ6s6vVqq8Z8xTn0sdvYUtnIC6UDRMb7+TZc6FH
    gFoWP6SWnLtbUTsvU2Mmu9U00Vb8ck6cuo4OG0uQTVZV9YVeh3xZqn8rR2vCeLJu
    NExKkMkPLZ4GhrNted6h7emDZuhT7SO5U+knMWwTnuhHHyGsBy1FMT55buBwxfJD
    BLH186gIgPfr/Qf7/n+xmW0xex1i0sLPZw6ZmjRNygBoCwlVIfUQE2O8hg6YraBs
    FwUJJN5zhQfFgEF+ulPVzEBacWBvxMH34DI/UJKbfUns5qcF1z9FUpWW4TAvsHvH
    boaZiuAt7aJGjkt51EYoCmaGl0ty3137z9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525233931; bh=rx290
    r3m+LVdNpDbIgmbbJiZfsw3+Qcd9WdzysXkN+c=; b=YuESiZmBkNZiNFOp5Txrv
    1V9JgkTwBNRpeTUCmLLRTxGjd/my78lAjlc9b8CKhk4VZExKmOaY8IJ6/ChRFDO9
    zjLFljPk5EMBnvQsZLdRzvDKdlKvTP6Z+Bnf2tLprryImmi+GGJvpavKpXUYraES
    01sAkjmOeryvQvsd0X7LwZAdoHeonkVSkW1KJNB3Nnh3L1ISXVyn8IM3UZSdOoku
    qbLceopzyWZ2JXXvosm/3Q3asUB/B2tfuCEtZKFPwMMNO4JaUhT1qwqqvb7R14b3
    Wf2xT23ygkk/9ssr9M6j9w5eLLvQ8r9+R8tmhk4VwFH5YbOk7bBjfNkBQu3DlnnZ
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=me.com header.i=@me.com header.b=gLkOo3wW x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=me.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=me.com header.i=@me.com header.b=gLkOo3wW x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=me.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF9+Zw9lg0uy4wvlmLtyKzxYf4JEU7mx9TutBAJM1ynmXKllf65HI5lf38rONimaKTxNb5Z2ZWMWZ85islW7khAldK/t8RR6MhWeIybUMQVkIuPvlqoe
    KtaAE2Jsy7Mpmtk3ztQGp9/tSMejCEpBfh0daH65xmvNTqRw/nTHhlRirZxoMUE4Q6F0VidPZ9MMVFp3feUZRgXgRRgG3KnSZ0yjzVqEIzw4Pcj1gBmGzzmv
    bLHWj1czWFG80duMdc9CBg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=HHGDD-5mAAAA:8 a=DDOyTI_5AAAA:8 a=46IIjZ-JkNM1COGNEo4A:9
    a=z6dDOHJhoyVh766o:21 a=Cqk7TfsNk3d5aPvB:21 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-02_01:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805020039
From: Doug Oucharek <dougso@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Subject: [PATCH] staging: lustre: o2iblnd: Enable Multiple OPA Endpoints
 between Nodes
Date: Wed, 02 May 2018 00:05:14 -0400
Message-id: <1525233914-8266-1-git-send-email-dougso@me.com>
X-Mailer: git-send-email 1.8.3.1
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Doug Oucharek <doug.s.oucharek@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OPA driver optimizations are based on the MPI model where it is
expected to have multiple endpoints between two given nodes. To
enable this optimization for Lustre, we need to make it possible,
via an LND-specific tuneable, to create multiple endpoints and to
balance the traffic over them.

Both sides of a connection must have this patch for it to work.
Only the active side of the connection (usually the client)
needs to have the new tuneable set > 1.

Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8943
Reviewed-on: https://review.whamcloud.com/25168
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
---
 .../lustre/include/uapi/linux/lnet/lnet-dlc.h      |  3 ++-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    | 17 ++++++++++++---
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 25 +++++++++++++++-------
 .../lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c  |  9 ++++++++
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h b/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
index e45d828..c1619f4 100644
--- a/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
+++ b/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
@@ -53,7 +53,8 @@ struct lnet_ioctl_config_o2iblnd_tunables {
 	__u32 lnd_fmr_pool_size;
 	__u32 lnd_fmr_flush_trigger;
 	__u32 lnd_fmr_cache;
-	__u32 pad;
+	__u16 lnd_conns_per_peer;
+	__u16 pad;
 };
 
 struct lnet_ioctl_config_lnd_tunables {
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
index ca6e09d..da8929d 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
@@ -568,6 +568,8 @@ struct kib_peer {
 	lnet_nid_t       ibp_nid;         /* who's on the other end(s) */
 	struct lnet_ni	*ibp_ni;         /* LNet interface */
 	struct list_head ibp_conns;       /* all active connections */
+	struct kib_conn	*ibp_next_conn;  /* next connection to send on for
+					    round robin */
 	struct list_head ibp_tx_queue;    /* msgs waiting for a conn */
 	__u64            ibp_incarnation; /* incarnation of peer */
 	/* when (in jiffies) I was last alive */
@@ -581,7 +583,7 @@ struct kib_peer {
 	/* current active connection attempts */
 	unsigned short		ibp_connecting;
 	/* reconnect this peer later */
-	unsigned short		ibp_reconnecting:1;
+	unsigned char		ibp_reconnecting;
 	/* counter of how many times we triggered a conn race */
 	unsigned char		ibp_races;
 	/* # consecutive reconnection attempts to this peer */
@@ -744,10 +746,19 @@ struct kib_peer {
 static inline struct kib_conn *
 kiblnd_get_conn_locked(struct kib_peer *peer)
 {
+	struct list_head *next;
+
 	LASSERT(!list_empty(&peer->ibp_conns));
 
-	/* just return the first connection */
-	return list_entry(peer->ibp_conns.next, struct kib_conn, ibc_list);
+	/* Advance to next connection, be sure to skip the head node */
+	if (!peer->ibp_next_conn ||
+	    peer->ibp_next_conn->ibc_list.next == &peer->ibp_conns)
+		next = peer->ibp_conns.next;
+	else
+		next = peer->ibp_next_conn->ibc_list.next;
+	peer->ibp_next_conn = list_entry(next, struct kib_conn, ibc_list);
+
+	return peer->ibp_next_conn;
 }
 
 static inline int
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index b4a182d..303e4e1 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1250,7 +1250,6 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 
 	LASSERT(net);
 	LASSERT(peer->ibp_connecting > 0);
-	LASSERT(!peer->ibp_reconnecting);
 
 	cmid = kiblnd_rdma_create_id(kiblnd_cm_callback, peer, RDMA_PS_TCP,
 				     IB_QPT_RC);
@@ -1332,7 +1331,7 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 
 	LASSERT(!peer->ibp_accepting && !peer->ibp_connecting &&
 		list_empty(&peer->ibp_conns));
-	peer->ibp_reconnecting = 0;
+	peer->ibp_reconnecting--;
 
 	if (!kiblnd_peer_active(peer)) {
 		list_splice_init(&peer->ibp_tx_queue, &txs);
@@ -1365,6 +1364,8 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 	rwlock_t *g_lock = &kiblnd_data.kib_global_lock;
 	unsigned long flags;
 	int rc;
+	int		   i;
+	struct lnet_ioctl_config_o2iblnd_tunables *tunables;
 
 	/*
 	 * If I get here, I've committed to send, so I complete the tx with
@@ -1461,7 +1462,8 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 
 	/* Brand new peer */
 	LASSERT(!peer->ibp_connecting);
-	peer->ibp_connecting = 1;
+	tunables = &peer->ibp_ni->ni_lnd_tunables->lt_tun_u.lt_o2ib;
+	peer->ibp_connecting = tunables->lnd_conns_per_peer;
 
 	/* always called with a ref on ni, which prevents ni being shutdown */
 	LASSERT(!((struct kib_net *)ni->ni_data)->ibn_shutdown);
@@ -1474,7 +1476,8 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 
 	write_unlock_irqrestore(g_lock, flags);
 
-	kiblnd_connect_peer(peer);
+	for (i = 0; i < tunables->lnd_conns_per_peer; i++)
+		kiblnd_connect_peer(peer);
 	kiblnd_peer_decref(peer);
 }
 
@@ -1923,6 +1926,9 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 	}
 
 	dev = ((struct kib_net *)peer->ibp_ni->ni_data)->ibn_dev;
+	if (peer->ibp_next_conn == conn)
+		/* clear next_conn so it won't be used */
+		peer->ibp_next_conn = NULL;
 	list_del(&conn->ibc_list);
 	/* connd (see below) takes over ibc_list's ref */
 
@@ -2192,7 +2198,11 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 	kiblnd_conn_addref(conn);
 	write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);
 
-	/* Schedule blocked txs */
+	/* Schedule blocked txs
+	 * Note: if we are running with conns_per_peer > 1, these blocked
+ 	 * txs will all get scheduled to the first connection which gets
+ 	 * scheduled.  We won't be using round robin on this first batch.
+ 	 */
 	spin_lock(&conn->ibc_lock);
 	list_for_each_entry_safe(tx, tmp, &txs, tx_list) {
 		list_del(&tx->tx_list);
@@ -2561,7 +2571,6 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 
 	LASSERT(conn->ibc_state == IBLND_CONN_ACTIVE_CONNECT);
 	LASSERT(peer->ibp_connecting > 0);     /* 'conn' at least */
-	LASSERT(!peer->ibp_reconnecting);
 
 	if (cp) {
 		msg_size = cp->ibcp_max_msg_size;
@@ -2579,7 +2588,7 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 	 */
 	reconnect = (!list_empty(&peer->ibp_tx_queue) ||
 		     peer->ibp_version != version) &&
-		    peer->ibp_connecting == 1 &&
+		    peer->ibp_connecting &&
 		    !peer->ibp_accepting;
 	if (!reconnect) {
 		reason = "no need";
@@ -2640,7 +2649,7 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 	}
 
 	conn->ibc_reconnect = 1;
-	peer->ibp_reconnecting = 1;
+	peer->ibp_reconnecting++;
 	peer->ibp_version = version;
 	if (incarnation)
 		peer->ibp_incarnation = incarnation;
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c
index b923540..39d0792 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c
@@ -57,6 +57,10 @@
 module_param(nscheds, int, 0444);
 MODULE_PARM_DESC(nscheds, "number of threads in each scheduler pool");
 
+static unsigned int conns_per_peer = 1;
+module_param(conns_per_peer, uint, 0444);
+MODULE_PARM_DESC(conns_per_peer, "number of connections per peer");
+
 /* NB: this value is shared by all CPTs, it can grow at runtime */
 static int ntx = 512;
 module_param(ntx, int, 0444);
@@ -271,6 +275,10 @@ int kiblnd_tunables_setup(struct lnet_ni *ni)
 		tunables->lnd_fmr_flush_trigger = fmr_flush_trigger;
 	if (!tunables->lnd_fmr_cache)
 		tunables->lnd_fmr_cache = fmr_cache;
+	if (!tunables->lnd_conns_per_peer) {
+		tunables->lnd_conns_per_peer = (conns_per_peer) ?
+			conns_per_peer : 1;
+	}
 
 	return 0;
 }
@@ -284,4 +292,5 @@ void kiblnd_tunables_init(void)
 	default_tunables.lnd_fmr_pool_size = fmr_pool_size;
 	default_tunables.lnd_fmr_flush_trigger = fmr_flush_trigger;
 	default_tunables.lnd_fmr_cache = fmr_cache;
+	default_tunables.lnd_conns_per_peer = conns_per_peer;
 }
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
