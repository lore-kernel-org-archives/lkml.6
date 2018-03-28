Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1769925-1522223020-2-17453097363626861668
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522223020; b=EIkeKYtKbPrC2Fc5BsTbjgJGiz5YbCOiOrSAgtk443+HYWE
    kP1G4BSsDEot9fLFRC72DhOZ2b8lO2AwMC8ti1HBhQaU78K3AdFM2bF1phMRWDLS
    A8mpJMzWRyEIaPa7pZtjQBaeADKbGrjly9kP84DMxogRparfJy7M9RFFUx7kW4Dk
    XQm84r7wHE3eCeE2gVYqHSkU90FV4E1rSK910XgJ5q+Lo5Hyzw7CBb2Vj8stvMhT
    bPdwRZQKb15HaUgu8992YpxTPPIEADIMGdib+SOOmrA6YgwNfdP7kCLvVugEaCV5
    IjO8FWfmfeqVHsg2xYmd6owCtywiTrUGEYtrfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522223020;
    bh=/dK9faJ730KBCPDZarrTATWY0VUDwsoVBuAZ9LWhKBo=; b=qdveRHvZR7qe
    AZoUC2a7UbT0svqPQ/RYda4K+RyzUSDp5GMKB/VO4/dXDqd7cpuoO11GPW74ND2U
    s6yrRySo46bitUPHhxG7+kqrnJWk38jbYD+oea3k2u5NYSpog/mb9OFLIsjzf8kf
    1sWrlJY29FGVenifiy0/tXPEPtJU8N5a3puIc9Tyv0dtw4D8U1wjG3chix5TwY6T
    pSQ5zfvAppDthf4HmEZN8b87GrbyxHG+QIGmyrQXSETkVc53BUInMLipjnD5glRx
    Nt5A1V7e7j4TSVEyxog56ldqilE2+0Y+8fq2WKJR7j9SXlHvE/GzBGmpqll9Kw/b
    0yI2Q2bocQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FcIoAqUK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FcIoAqUK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMAKQBKkPLP+S4mndGbH2vxqcdzko29erSCwPF0Zve+8E8OCiset/XeVCSvAq/KO2u5OhwMtetBlyXvQqDBOeePinWSKg6fWV1BS+dSwRBoi+wuGoy9V
    A6WXzfZXUzS3leS6Tt3X4jhlwEP3Xz6W54hLD6qeJH4q6Of+e/VktuT0fAXcU/0abQxBZngUBL0ugjAXPmNVSr5FQ78+3VX9fk7CWkNX4oOuWnvGJOu81cVw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=HZieObWGZi2sKBCXc30A:9
    a=ex3JTfH0ZkJMGWAz:21 a=Na2JX_2fIBq9m8En:21 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeC1H3i (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:29:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbeC1H3f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:29:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/30] fs: unexport poll_schedule_timeout
Date: Wed, 28 Mar 2018 09:28:57 +0200
Message-Id: <20180328072926.17131-2-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No users outside of select.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/select.c          | 3 +--
 include/linux/poll.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index b6c36254028a..686de7b3a1db 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -233,7 +233,7 @@ static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
 	add_wait_queue(wait_address, &entry->wait);
 }
 
-int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
+static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 			  ktime_t *expires, unsigned long slack)
 {
 	int rc = -EINTR;
@@ -258,7 +258,6 @@ int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 
 	return rc;
 }
-EXPORT_SYMBOL(poll_schedule_timeout);
 
 /**
  * poll_select_set_timeout - helper function to setup the timeout value
diff --git a/include/linux/poll.h b/include/linux/poll.h
index f45ebd017eaa..a3576da63377 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -96,8 +96,6 @@ struct poll_wqueues {
 
 extern void poll_initwait(struct poll_wqueues *pwq);
 extern void poll_freewait(struct poll_wqueues *pwq);
-extern int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
-				 ktime_t *expires, unsigned long slack);
 extern u64 select_estimate_accuracy(struct timespec64 *tv);
 
 #define MAX_INT64_SECONDS (((s64)(~((u64)0)>>1)/HZ)-1)
-- 
2.14.2

