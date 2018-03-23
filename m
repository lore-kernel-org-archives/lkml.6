Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806610-2-11220629253919993790
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
    t=1521806610; b=ZF011AWrAoG21CH+pF53YAVGR4k5N2EQFsL1dLVGyzLIgNI
    jPu5sjCAq1YDFqtzXA5NCirFptwRSPlTqJE/DCrO3WSBfqhxHyFOjqvRbxu0WBJT
    huq0/hTaMMU8Nlr1dQ6OegPQbcnxIXCFgHFdYHumoudyMYJSLHLckwIAPbqg2tD6
    hacqjQtpWEjjLKFKuBXN4Mo+j5V3EPWCsnvj9QlkFUE+hKd0kNw2mXFBSNt0xZ07
    T6MJTMeyLrO+SyXVkoEzdWh7bQNHe7JYZKh5foxhm1EL/D1takOOuGa951JS7/dw
    kBWP0P+eGIcnKxI/p5M5TK5luW8PWDBy2NgDSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806610; bh=cg9BAwDYV2a//euARg8T5ZmCBO
    IpLGu1DeDl3GZL+wA=; b=E8DYiHs9pDSXv/GoDXs2DlXdtK+zkZE3Ar2M60fXcJ
    SKWmNY+oSs/S/g3Bsn3c+skN6Yug88g8rIVH0742C18AlGktf/7MZ7uoDoLnmeVJ
    Y6hmE8NkRqClJpZusVhQzlCKcx/oc7uNr98KijfSszbIXtqj1CyOWRlRn/N9pWY3
    6owxz/UpDuFNvZJEZTUq4stY6zbNyvPQgvdQeW5DnW0JIGDAcrYYcp1jwA6eeKKR
    wWUjK31+HzKb1w8smoV66CoL98UH4O/m5R8qjW24zytd/51cuT828BdQF8kjgTOj
    4SU6361NIJsCb17nbS/CEumdmLsRjnZPo8TQUsEKpORA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1753079AbeCWJ7u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbeCWJ7q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 69/84] nfsd4: permit layoutget of executable-only files
Date: Fri, 23 Mar 2018 10:54:23 +0100
Message-Id: <20180323095422.390997428@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
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
@@ -1363,14 +1363,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
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
