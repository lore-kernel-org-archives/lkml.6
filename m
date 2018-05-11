Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526036904-2-11959191392572647450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526036904; b=J3xMFPK1kyqJfJsLzmDEBKAQN3tQ+Iro+I5W6T6YKYfgX7Y3PQ
    GOml4fVe5JslAJ3uv6bcDH2Zv6SFD8S8bb5Ebq70VBiV2qL0lCvVq8JeaxrvLnIr
    xrS89/+ZVcHX/aXweMxUzZdo4o7fouM5i5blwxbC7VektEu9kyRX2M7zbc9T3SnH
    OrLr+2LUrd83QpPWFRRHojxZ156EvVeUQY1ZTWVn5U825S3X8bM5/jG9k4c5Bbul
    svx1Nk8nUhL5TKdPE9oQMNxKzfxQ6rBAcFQO+yDKOETLCH6jygxFA/wr3897ylyO
    btqJhYIEEMCZddOtT3rd00uDnXVX2eqf0hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526036904; bh=
    HniXHEEQLp8dYZswypFEpwmGtREL+15LHz6tGMUZuZ4=; b=nJpUdEf1hPBS9wyZ
    LbzmZ58CN9eSLNSEqQCmhRJzb+YiJC28VaFiftGzn+1ufEJc3eRZX4OBbQdqdQha
    BOZMeidIWiX8quWwEjxAOeU5ovQWDncRJx4KhRHbuMdep2t4i5W0FdTXOPIsP+JV
    mtkLs8fo0AkxMP5zMSPVPJ3hw3AMaU/qQGilufyUQcl+gpnNxOpknZQgKghdMogp
    NXW/rKqaE3dF+W7GvMD3nP4MPx6wd/f402hogJbDz11HVYyrDPZbL6CvB+7hLZXk
    atpnn0sVQOnWII90A5wTSXahsyPJz7hpBrSXG/maLvFZHW5OynieyVASFh84ByIC
    TYZZdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=TPw8aE3v
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=TPw8aE3v
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIv8iiN3fRptMsK3+L7JzoSVfPo/ihr39lUUMjn92UtEpDhvdgMH4wBpofAflHi1HleCdXPC306LBPwGOzy4U+/fz4sNN/DhsIoC+NgZA7R7EhPwbvTW
    pIYZo285XQvdyQ2jkx7hIBVtYVJHv3LlLpWAYXHx5uQd2ymi/Go8K2j4CGJTgKAuR+7zbbYooQeJJAL+sAWCygv2pCxF1MUBjp8PBJPNhRCcObtTqF+fwoWS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=cMft6xD86Lnvze5u8R8A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeEKLIV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:08:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbeEKLIT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:19 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/32] fs: update documentation to mention __poll_t and match the code
Date: Fri, 11 May 2018 13:07:34 +0200
Message-Id: <20180511110803.10910-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/Locking | 2 +-
 Documentation/filesystems/vfs.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 75d2d57e2c44..220bba28f72b 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -439,7 +439,7 @@ prototypes:
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
-	unsigned int (*poll) (struct file *, struct poll_table_struct *);
+	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 5fd325df59e2..f608180ad59d 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -856,7 +856,7 @@ struct file_operations {
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
-	unsigned int (*poll) (struct file *, struct poll_table_struct *);
+	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
-- 
2.17.0

