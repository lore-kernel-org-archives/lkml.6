Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522168833-2-12528088146294445813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168833; b=jCD9lZhaqO/0Y/W2B6kEOCpCw+7F93Yb0wkTJDM2nOsllQ3
    eJ9a6ooeILpBllTajwSCjULa8rHo2lOdkDU/9evVSBZ9/KQgJs7dbDxS6v4CO37E
    Xm1xYmQa6ApmqjopLIuBflNW73h1wJFHUE3RF+cHtINim1cMtRs7gr7x7EvsS4JK
    CTvEYgM5OFyGeIRp5dJBQcRbvImnMfZ2Ub6qbyc4SfxD2XI0rCpomnDRazWAFXUF
    zdgqHST/pOphS+oFcZrcd0RbGodc6r2SBGKgHEaq/Y/nLydz5mFTlFHfa6xGIhTd
    8LGLPP3uZpojzukVGd9MJUWe5PtEnmyXqtf5vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168833; bh=YgNUOa5QIbr+7aebYdh9iEEEuy
    Of7vYBJUgrFvFCAVM=; b=TIGYE4tb0JEJtlAar7wpGR4Yhfc1pUk4P3ZA7eGhLf
    GXeHZjxH0SahJUZunOZuS2C/s+g/qQ4LiELv3fL1cCOQYqOYVbJum1Ssxg5DT9dY
    tkHOVC+gUxuzgA368vQj66bGLidzd17zawhSKH9z7nB5Bd36YRKD6zNHnccN+x25
    2OqDiKW6Lszb5OGN22fekDN6Kg5C9nlJRPxTIMvuNYGh/Ss7tyjQuIQ0ZmOH6nKJ
    JgU8MShBZ8u6cgd+7OLkc6H7KZPpgxR3wcMGSI/ZUtpFs75LQ1jtLN5nPX2syexz
    KVmTc6iPbavL5m1wY1zpFAYY4aEe6Hzf9yQKV85Eul4Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOulrMhJoQxoBikZ3XIwS1kRyLGxbVI/QSJF9TMf6vJ4fklm4f3DOIl4Fvs6HO1X+QziBdjcYjsY8mGwchufcXeAkz3IvmJzq9a7tBdiEGD+fh7spEaV
    Y8ulH+7E4hGvBGEMkKRczhu9BXFXuNcXcd4/xv9n/5nAYMvSJtpn8eXL6s9YuHiGDcwlOG4gqk90uYgFFew6T5CNBMSxxIP/Er5l9xc9mnRUkQaVAGvw5vSZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=48MP9QBOpEWeHOstcRYA:9
    a=H-X78mQMgptIupqs:21 a=iqMJXxTxJWG-YWpg:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeC0Qk0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:40:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755413AbeC0QkW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:40:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Sorenson <fsorenso@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.15 045/105] nfsd: remove blocked locks on client teardown
Date: Tue, 27 Mar 2018 18:27:25 +0200
Message-Id: <20180327162800.036007854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@redhat.com>

commit 68ef3bc3166468678d5e1fdd216628c35bd1186f upstream.

We had some reports of panics in nfsd4_lm_notify, and that showed a
nfs4_lockowner that had outlived its so_client.

Ensure that we walk any leftover lockowners after tearing down all of
the stateids, and remove any blocked locks that they hold.

With this change, we also don't need to walk the nbl_lru on nfsd_net
shutdown, as that will happen naturally when we tear down the clients.

Fixes: 76d348fadff5 (nfsd: have nfsd4_lock use blocking locks for v4.1+ locks)
Reported-by: Frank Sorenson <fsorenso@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Cc: stable@vger.kernel.org # 4.9
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |   62 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 19 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -268,6 +268,35 @@ free_blocked_lock(struct nfsd4_blocked_l
 	kfree(nbl);
 }
 
+static void
+remove_blocked_locks(struct nfs4_lockowner *lo)
+{
+	struct nfs4_client *clp = lo->lo_owner.so_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	struct nfsd4_blocked_lock *nbl;
+	LIST_HEAD(reaplist);
+
+	/* Dequeue all blocked locks */
+	spin_lock(&nn->blocked_locks_lock);
+	while (!list_empty(&lo->lo_blocked)) {
+		nbl = list_first_entry(&lo->lo_blocked,
+					struct nfsd4_blocked_lock,
+					nbl_list);
+		list_del_init(&nbl->nbl_list);
+		list_move(&nbl->nbl_lru, &reaplist);
+	}
+	spin_unlock(&nn->blocked_locks_lock);
+
+	/* Now free them */
+	while (!list_empty(&reaplist)) {
+		nbl = list_first_entry(&reaplist, struct nfsd4_blocked_lock,
+					nbl_lru);
+		list_del_init(&nbl->nbl_lru);
+		posix_unblock_lock(&nbl->nbl_lock);
+		free_blocked_lock(nbl);
+	}
+}
+
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
@@ -1866,6 +1895,7 @@ static __be32 mark_client_expired_locked
 static void
 __destroy_client(struct nfs4_client *clp)
 {
+	int i;
 	struct nfs4_openowner *oo;
 	struct nfs4_delegation *dp;
 	struct list_head reaplist;
@@ -1895,6 +1925,16 @@ __destroy_client(struct nfs4_client *clp
 		nfs4_get_stateowner(&oo->oo_owner);
 		release_openowner(oo);
 	}
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		struct nfs4_stateowner *so, *tmp;
+
+		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
+					 so_strhash) {
+			/* Should be no openowners at this point */
+			WARN_ON_ONCE(so->so_is_open_owner);
+			remove_blocked_locks(lockowner(so));
+		}
+	}
 	nfsd4_return_all_client_layouts(clp);
 	nfsd4_shutdown_callback(clp);
 	if (clp->cl_cb_conn.cb_xprt)
@@ -6358,6 +6398,7 @@ nfsd4_release_lockowner(struct svc_rqst
 	}
 	spin_unlock(&clp->cl_lock);
 	free_ol_stateid_reaplist(&reaplist);
+	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
 
 	return status;
@@ -7143,6 +7184,8 @@ nfs4_state_destroy_net(struct net *net)
 		}
 	}
 
+	WARN_ON(!list_empty(&nn->blocked_locks_lru));
+
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&nn->unconf_id_hashtbl[i])) {
 			clp = list_entry(nn->unconf_id_hashtbl[i].next, struct nfs4_client, cl_idhash);
@@ -7209,7 +7252,6 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfs4_delegation *dp = NULL;
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd4_blocked_lock *nbl;
 
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
@@ -7230,24 +7272,6 @@ nfs4_state_shutdown_net(struct net *net)
 		nfs4_put_stid(&dp->dl_stid);
 	}
 
-	BUG_ON(!list_empty(&reaplist));
-	spin_lock(&nn->blocked_locks_lock);
-	while (!list_empty(&nn->blocked_locks_lru)) {
-		nbl = list_first_entry(&nn->blocked_locks_lru,
-					struct nfsd4_blocked_lock, nbl_lru);
-		list_move(&nbl->nbl_lru, &reaplist);
-		list_del_init(&nbl->nbl_list);
-	}
-	spin_unlock(&nn->blocked_locks_lock);
-
-	while (!list_empty(&reaplist)) {
-		nbl = list_first_entry(&reaplist,
-					struct nfsd4_blocked_lock, nbl_lru);
-		list_del_init(&nbl->nbl_lru);
-		posix_unblock_lock(&nbl->nbl_lock);
-		free_blocked_lock(nbl);
-	}
-
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
 }
