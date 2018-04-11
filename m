Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523471877-3-1716926400864366092
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
    1523471876; b=dwKqaKxawrBRDkfP849cYNGvNUGWy1N7ntssQ5LdOJh0ieuFmV
    n8dn8P6Va2kSbn9kCJNKtkhSmi7FTdUr3QRZs2paa4Hen8zY+r33pSKyu55xx/fX
    qRNqqFbczvBu/KGtTRzPowRmasUZpYrWQ/LcGK91Kttgvjy0JGo2snPd8LuD6HGR
    X7ghBHu8Y8BaRH1jA0G8zYcl0oCi/7Q43ApDKLM6J5cBPyEsujpABO/SPyd/Tdu7
    Onr0UVdXqxl1xhTRTBAHFAGw3HzFvYbUenhWqgrQ4peLjXU5JQr37/UEkYC3u1q5
    WeUeHx4M7FK36px7no6FDXtgAmOcgeWCEk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523471876; bh=/Yd3bsQf7GwGAC1F6SSwz7lOg2gqp1
    8LM28HzqtOYko=; b=R67utQxXD2jtdirEv3yDnR2vCpSSc8N0iOpwGtQ2Sspfjr
    OgGqYDzrvkk+HJQc0Yv2fk/EyV9SePadBtJZiPEDBzt2a4gbVd8+ezkT1eEkE6Qm
    5tXFQrwsYwOdqtMC5b9hEO+v3O+VNGBmtigxJqp79ODpCPqALGPK/ISpyUtTgyE0
    sNbicdjK0cvCyZ3Rt2o0IrOGx8L4LoqVJcHKIP3JbXFut6/hbpgdBtcqQ+NNhymP
    xt5Ey4I0rx2C+lZeh577D1jHFgFOUFvmcVul3GtnbwdyOeJVQA4kIbMytq5OdbUX
    /g9EKBCEg9RcjR6JBd2w0419CATd0AagxKPJEl0Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOkqpckqH0YhC2zgpKPe+C/7eE7of7KNbdP1rFk81O/C2cZ32GMiwbE6N/grOpXGqnjJvbCnwoVrPn5cVHhmYwBnSxvv78sXw462GH027L2HpGMwYOWM
    cARIrt+Dbsl96KWuyDdSOestlbPGHr+Tb+vOSRv1HmvuWZKoivkXVoAEYaJDYqPtfAyp0/2+PTQHfHeB01rLYSfFHBmeXl4MxJ6YoLMmSrRmT9bRUD5UpkoH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VZJtwKKvAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=vKM2s00EAzgBiCKZ9gAA:9 a=QEXdDO2ut3YA:10 a=vzdIw8kzLcqZOxdJCU6L:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeDKShy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:37:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeDKShx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:37:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 001/121] NFSv4.1: RECLAIM_COMPLETE must handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION
Date: Wed, 11 Apr 2018 20:35:04 +0200
Message-Id: <20180411183456.283377457@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 0048fdd06614a4ea088f9fcad11511956b795698 ]

If the server returns NFS4ERR_CONN_NOT_BOUND_TO_SESSION because we
are trunking, then RECLAIM_COMPLETE must handle that by calling
nfs4_schedule_session_recovery() and then retrying.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c  |    7 ++++++-
 fs/nfs/nfs4state.c |   10 +++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7429,6 +7429,12 @@ static int nfs41_reclaim_complete_handle
 		/* fall through */
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 		return -EAGAIN;
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_DEADSESSION:
+	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+		nfs4_schedule_session_recovery(clp->cl_session,
+				task->tk_status);
+		break;
 	default:
 		nfs4_schedule_lease_recovery(clp);
 	}
@@ -7507,7 +7513,6 @@ static int nfs41_proc_reclaim_complete(s
 	if (status == 0)
 		status = task->tk_status;
 	rpc_put_task(task);
-	return 0;
 out:
 	dprintk("<-- %s status=%d\n", __func__, status);
 	return status;
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1563,13 +1563,14 @@ static void nfs4_state_start_reclaim_reb
 	nfs4_state_mark_reclaim_helper(clp, nfs4_state_mark_reclaim_reboot);
 }
 
-static void nfs4_reclaim_complete(struct nfs_client *clp,
+static int nfs4_reclaim_complete(struct nfs_client *clp,
 				 const struct nfs4_state_recovery_ops *ops,
 				 struct rpc_cred *cred)
 {
 	/* Notify the server we're done reclaiming our state */
 	if (ops->reclaim_complete)
-		(void)ops->reclaim_complete(clp, cred);
+		return ops->reclaim_complete(clp, cred);
+	return 0;
 }
 
 static void nfs4_clear_reclaim_server(struct nfs_server *server)
@@ -1616,13 +1617,16 @@ static void nfs4_state_end_reclaim_reboo
 {
 	const struct nfs4_state_recovery_ops *ops;
 	struct rpc_cred *cred;
+	int err;
 
 	if (!nfs4_state_clear_reclaim_reboot(clp))
 		return;
 	ops = clp->cl_mvops->reboot_recovery_ops;
 	cred = nfs4_get_clid_cred(clp);
-	nfs4_reclaim_complete(clp, ops, cred);
+	err = nfs4_reclaim_complete(clp, ops, cred);
 	put_rpccred(cred);
+	if (err == -NFS4ERR_CONN_NOT_BOUND_TO_SESSION)
+		set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
 }
 
 static void nfs_delegation_clear_all(struct nfs_client *clp)
