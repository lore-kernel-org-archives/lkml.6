Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524655975-2-15033587508150642641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524655974; b=bLPcOojHZIDrWCFx/WqQn6exd8pQS/SrMOckxE7ERHPTDU5Rog
    f3lmWDKXXzWvGWja5dl4HVPfEhei27+nlU9G8nX5d5/Th6Xws3v/MstUWp84lmPb
    urS82ZEAaDJ/vO9BYU+aSJ1bAKkcenBQZv+G0cKiJx6yfA7FJdrtbGP/RCPKluYs
    zL9TMZLEPapa+oXIMQbQbgzq/+cq3TyZaeSTYBLXzpkNC7Xu/67deWvjV+7ib4bP
    Ga2mNI8rLKuzp19puQDPG6e31ltD94wAaoEL+rHkURgmgj0N18rsZSE+7FI7pBMK
    kiB7e2UeKoFMDGAcZziSJ/2z5QTKUQM4lUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524655974; bh=3yr3WksF0K6KEqbHE1y2ol1JhUNW9b
    2SxZ2q3CJKMXg=; b=aP2PZFRQdXrzdYf0bWpxr+uB38mZG/tWlbROmy8ncowlYj
    VFg6x7TXb9z2DGBF2dK5NEXrTkn5B1LgbMNOH9Y1SZouMUEygGDEmUC5kNAMoVrA
    30N8P8VG7D3atIrxgSUVNhOowwFRtNW9tKfrSddPr5j7087jV1/npQKgsNcWwvwz
    rpv22XO0zbdTi8rL7PcrQn27Ouwk/M5wXcXOEBMDGT9igdFnvVn72v7gK7gSnSOG
    Jt/pIOEB11rGrfXHkwirqplyoM+P/0tvQQgjMIqmVlabLwHv9qU7wMWqEVRcUJxh
    jXKUFSBRh32fAw56gL0Tj9I5gL5zvmaVYghZYJ+Q==
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
X-CM-Envelope: MS4wfFqUULabA3ohynjx9QoCUh4ZrUYoHyJgbUI7Kk8ECfYvlt9WGiJUIAHp8fpPrJBo7iFN2AdtmdshHKD9H+BagBuT0iPI8QjJRp2OlxsX7Vw3X3fuKi4L
    s/V2kUwxMJQkQEtwPxqq4Sl/22fHeMZwj02KUw2bK+Phwy2k0I1h28Dw5KKBdFJoB7MEydHzDLXZ/azOmfzk0nsch/vE7dcIet4C/qtNmBv9fARkou7nASEO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=GdkpVorZ_D9Ip3Clk5gA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=vzdIw8kzLcqZOxdJCU6L:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeDYLcl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:32:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeDYKh1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 018/183] NFSv4: always set NFS_LOCK_LOST when a lock is lost.
Date: Wed, 25 Apr 2018 12:33:58 +0200
Message-Id: <20180425103243.340689265@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>


[ Upstream commit dce2630c7da73b0634686bca557cc8945cc450c8 ]

There are 2 comments in the NFSv4 code which suggest that
SIGLOST should possibly be sent to a process.  In these
cases a lock has been lost.
The current practice is to set NFS_LOCK_LOST so that
read/write returns EIO when a lock is lost.
So change these comments to code when sets NFS_LOCK_LOST.

One case is when lock recovery after apparent server restart
fails with NFS4ERR_DENIED, NFS4ERR_RECLAIM_BAD, or
NFS4ERRO_RECLAIM_CONFLICT.  The other case is when a lock
attempt as part of lease recovery fails with NFS4ERR_DENIED.

In an ideal world, these should not happen.  However I have
a packet trace showing an NFSv4.1 session getting
NFS4ERR_BADSESSION after an extended network parition.  The
NFSv4.1 client treats this like server reboot until/unless
it get NFS4ERR_NO_GRACE, in which case it switches over to
"nograce" recovery mode.  In this network trace, the client
attempts to recover a lock and the server (incorrectly)
reports NFS4ERR_DENIED rather than NFS4ERR_NO_GRACE.  This
leads to the ineffective comment and the client then
continues to write using the OPEN stateid.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c  |   12 ++++++++----
 fs/nfs/nfs4state.c |    5 ++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1885,7 +1885,7 @@ static int nfs4_open_reclaim(struct nfs4
 	return ret;
 }
 
-static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const nfs4_stateid *stateid, int err)
+static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const nfs4_stateid *stateid, struct file_lock *fl, int err)
 {
 	switch (err) {
 		default:
@@ -1932,7 +1932,11 @@ static int nfs4_handle_delegation_recall
 			return -EAGAIN;
 		case -ENOMEM:
 		case -NFS4ERR_DENIED:
-			/* kill_proc(fl->fl_pid, SIGLOST, 1); */
+			if (fl) {
+				struct nfs4_lock_state *lsp = fl->fl_u.nfs4_fl.owner;
+				if (lsp)
+					set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
+			}
 			return 0;
 	}
 	return err;
@@ -1968,7 +1972,7 @@ int nfs4_open_delegation_recall(struct n
 		err = nfs4_open_recover_helper(opendata, FMODE_READ);
 	}
 	nfs4_opendata_put(opendata);
-	return nfs4_handle_delegation_recall_error(server, state, stateid, err);
+	return nfs4_handle_delegation_recall_error(server, state, stateid, NULL, err);
 }
 
 static void nfs4_open_confirm_prepare(struct rpc_task *task, void *calldata)
@@ -6595,7 +6599,7 @@ int nfs4_lock_delegation_recall(struct f
 	if (err != 0)
 		return err;
 	err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-	return nfs4_handle_delegation_recall_error(server, state, stateid, err);
+	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
 struct nfs_release_lockowner_data {
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1447,6 +1447,7 @@ static int nfs4_reclaim_locks(struct nfs
 	struct inode *inode = state->inode;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct file_lock *fl;
+	struct nfs4_lock_state *lsp;
 	int status = 0;
 	struct file_lock_context *flctx = inode->i_flctx;
 	struct list_head *list;
@@ -1487,7 +1488,9 @@ restart:
 		case -NFS4ERR_DENIED:
 		case -NFS4ERR_RECLAIM_BAD:
 		case -NFS4ERR_RECLAIM_CONFLICT:
-			/* kill_proc(fl->fl_pid, SIGLOST, 1); */
+			lsp = fl->fl_u.nfs4_fl.owner;
+			if (lsp)
+				set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
 			status = 0;
 		}
 		spin_lock(&flctx->flc_lock);
