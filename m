Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1415877-1519989596-2-10013108042528418506
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
    t=1519989595; b=CrHpiBFaXEVPucQTrl+7xJbFKDFsy7M9b96LBik+vxNY0qD
    apwn9/2FvCZBL++Bd9DK4oZlZLE88FgUvNCuBQC+DwFo1wks8ZE3JVa0voslQDTs
    e3U7VU3TRqtya0s+eJxA8N34VOrWyNOxdNxcOXRqOGw4oo81A8uf8qXW6k+jQz4J
    me5uZIZ3Ht+deg0LLFlf687yiK7WYEXzLY80sGi69jYVTwD0Uj4uHOZ1llmcRYlW
    lB8u8gmXshBzNKiKFMHM8K/CR36tYccK+AK4wxpl6TEgvwy35pLNx3xbeNPPSWEx
    VsXMmFuXACfQkK9ZZPHD5geV0o9IW0Am7lJg0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989595; bh=muPoKjS/DEJj247RMdTFTnuwem
    0ibVsUclli3oJO0pk=; b=MIa2YY5L1eaWrG8txJWKjKjPiwQw8ufrAZ/Vu5F+2Q
    Nxp0/3EgOuQd9/vap7+whtU1/AzkKu0Cdluh/Jgreb/iacM7yt+qm7ePNbzoXv1h
    JJh/XGQjpBLCakHD9B+ssSCEa2bGmM5hfMOF8tAQ3O+S3zgE4uNImR2jY31OwmIR
    aLLA85Rs+uCiewsvMXeABE6TDV+r8HSSx9XlLHFs2yYQM87A5+MoOSXCmaL1izUk
    5m8fbLVp7cvvC6J2VnAw3LfyG+FmUnPsTg8S6FXk7fuf5uBYgmRVWm+xt43Sq+MD
    dXWgFB3CB6D859GMi74ImT2WbgG55Qcz36driPPQAToQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423343AbeCBLTc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:19:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423202AbeCBIvx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:51:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 15/24] xfs: quota: check result of register_shrinker()
Date: Fri,  2 Mar 2018 09:51:12 +0100
Message-Id: <20180302084239.907036727@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aliaksei Karaliou <akaraliou.dev@gmail.com>


[ Upstream commit 3a3882ff26fbdbaf5f7e13f6a0bccfbf7121041d ]

xfs_qm_init_quotainfo() does not check result of register_shrinker()
which was tagged as __must_check recently, reported by sparse.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
[darrick: move xfs_qm_destroy_quotainos nearer xfs_qm_init_quotainos]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_qm.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -49,7 +49,7 @@
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
 
-
+STATIC void	xfs_qm_destroy_quotainos(xfs_quotainfo_t *qi);
 STATIC void	xfs_qm_dqfree_one(struct xfs_dquot *dqp);
 /*
  * We use the batch lookup interface to iterate over the dquots as it
@@ -662,9 +662,17 @@ xfs_qm_init_quotainfo(
 	qinf->qi_shrinker.scan_objects = xfs_qm_shrink_scan;
 	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
 	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
-	register_shrinker(&qinf->qi_shrinker);
+
+	error = register_shrinker(&qinf->qi_shrinker);
+	if (error)
+		goto out_free_inos;
+
 	return 0;
 
+out_free_inos:
+	mutex_destroy(&qinf->qi_quotaofflock);
+	mutex_destroy(&qinf->qi_tree_lock);
+	xfs_qm_destroy_quotainos(qinf);
 out_free_lru:
 	list_lru_destroy(&qinf->qi_lru);
 out_free_qinf:
@@ -673,7 +681,6 @@ out_free_qinf:
 	return error;
 }
 
-
 /*
  * Gets called when unmounting a filesystem or when all quotas get
  * turned off.
@@ -690,19 +697,7 @@ xfs_qm_destroy_quotainfo(
 
 	unregister_shrinker(&qi->qi_shrinker);
 	list_lru_destroy(&qi->qi_lru);
-
-	if (qi->qi_uquotaip) {
-		IRELE(qi->qi_uquotaip);
-		qi->qi_uquotaip = NULL; /* paranoia */
-	}
-	if (qi->qi_gquotaip) {
-		IRELE(qi->qi_gquotaip);
-		qi->qi_gquotaip = NULL;
-	}
-	if (qi->qi_pquotaip) {
-		IRELE(qi->qi_pquotaip);
-		qi->qi_pquotaip = NULL;
-	}
+	xfs_qm_destroy_quotainos(qi);
 	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
@@ -1574,6 +1569,24 @@ error_rele:
 }
 
 STATIC void
+xfs_qm_destroy_quotainos(
+	xfs_quotainfo_t	*qi)
+{
+	if (qi->qi_uquotaip) {
+		IRELE(qi->qi_uquotaip);
+		qi->qi_uquotaip = NULL; /* paranoia */
+	}
+	if (qi->qi_gquotaip) {
+		IRELE(qi->qi_gquotaip);
+		qi->qi_gquotaip = NULL;
+	}
+	if (qi->qi_pquotaip) {
+		IRELE(qi->qi_pquotaip);
+		qi->qi_pquotaip = NULL;
+	}
+}
+
+STATIC void
 xfs_qm_dqfree_one(
 	struct xfs_dquot	*dqp)
 {
