Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805599-2-3029293572269299181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805598; b=gNJDrMOTCN5Rd8OTo98XgW+MrC8KKPC23y8afNI1ognebg5
    JhMHRF3hFA762lO3vVBZ8qp09QbWEttsFE3nlO7rRpjMyjC/aInVnNo+W5jIZ1A4
    i76kjA9mySzqVMszodkEA5R4CxriB/WoKIZAgNG3YsSxifICjFqJLIbxbrZ+VmFg
    1UJ5P+22vgxRoLiAQV7Zh+5KuJNPTSW6oG0zDSJEjHFSMsmYc2z0/lpLgKHkWXN5
    jqMLuNZWBn1SoWsmDxnGEUWebY6UtROkgh+1HRAKFM4SK/QhPnZRO2MVSEB7uyzV
    TOBpieVria/ozxX++/1SSX2DbIRFwNUIS0RrCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805598; bh=HxU+rKpwSt3v5JVgMJnwWcTbuh
    8oUR62aSRDAlffu0c=; b=ATn1cUf8WDp2OMx7LyiY5EMTMNQwO8Msk2X8OjSDqO
    Xzj1EszuYq9fedOOm8RxSsZQVJ6+hNUde5oM5+HBeWii5Piz086dlDLTQ9Qb3L9W
    lH2uvn//qhhZRLe8zNNIaHuYbcqeN4IaJ2QMHfBLpfyuDB86GLHUQBw0KyMVfF0e
    8wzyNfDXHXVLz96OX1G0owYa14zCYJjzvbDkSnyNrboi/Ep0K1CTn/zMVjQrw9/T
    NZKoskJgZOFaa63OkjL0Dj2r8wiPeVG5LQwGJjGMVy+fdGNrr3iF/oWEDxJvkd2P
    BPHSKDX9mnzhXeWQUaBG6HYclOvIdQalQQDVr+DTP0IA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeCWKCv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:02:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbeCWKCt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 60/77] nfsd4: permit layoutget of executable-only files
Date: Fri, 23 Mar 2018 10:54:34 +0100
Message-Id: <20180323094146.294924043@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>


[ Upstream commit 66282ec1cf004c09083c29cb5e49019037937bbd ]

Clients must be able to read a file in order to execute it, and for pNFS
that means the client needs to be able to perform a LAYOUTGET on the file.

This behavior for executable-only files was added for OPEN in commit
a043226bc140 "nfsd4: permit read opens of executable-only files".

This fixes up xfstests generic/126 on block/scsi layouts.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1372,14 +1372,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_ops *ops;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
-	int accmode;
+	int accmode = NFSD_MAY_READ_IF_EXEC;
 
 	switch (lgp->lg_seg.iomode) {
 	case IOMODE_READ:
-		accmode = NFSD_MAY_READ;
+		accmode |= NFSD_MAY_READ;
 		break;
 	case IOMODE_RW:
-		accmode = NFSD_MAY_READ | NFSD_MAY_WRITE;
+		accmode |= NFSD_MAY_READ | NFSD_MAY_WRITE;
 		break;
 	default:
 		dprintk("%s: invalid iomode %d\n",
