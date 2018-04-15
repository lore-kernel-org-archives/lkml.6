Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804503-2-13032532373088008493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523804502; b=pYBi/ooTpUAiASl4NWsG0jVpLEQ2g100Jsf39Zaf/BvyM4zaV4
    5uQDnTSYqDq9o+J2lPbKRvC5vIUyiqIoCe1hrwcjHMxMuhn3H1X03g7u3EhQ1+EW
    5oogiVVgEAaLR6Byc+7IYzClfYwI/4Ie1IlQo8Vq0vSB8mX+Y8aFejSknYan55qT
    D0J92AgCUnpLCikxVvqKA5/8RsvM80SutEhFvpHS1LLHJklhLO1Mj3aWBbovqIlN
    JDujGxuRzS6TPhh5bLunAoSDgC1va/lfPcLp6e5zTdRMN+9oGYN96iP+X4nNPVss
    f+JU7qmcs4e9FykJhFYo2T8PPUUldBvggyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523804502; bh=
    6fSBwUuWL4DqeTGbvZH7xuNYfxH6kmLf5vlKJ/Gu+AI=; b=EHaat+wRRkGcYfRo
    hGCFUOZ7EJEMnJo3GG1GJnIajF7PnQ6d5ape1/Kc6fRhKhJcQ7b70wGrC1c4padI
    h8oX9LxSwxSLljD0WkP42Y+SonGMt+quHU6R6b/ZmRDJ0x1LER7Iv+l3SPf+q4dA
    /XX3bNIJYUmSea0MvsHzpgVQJEpBEvjjDLLG49Qr+jPJbSJxqiew4mMG5G7K7Vfl
    m4XknmI4+k98Bpxant5ot5vzWYq+hqDT4nz1ob/ZX8OS4KHyy4Ff9bwM8MQDUi/u
    C+l2TkPm4H11qxmglekFVkWpmmc5M3CmF8dfvDCnGia6Mu7LwReeyvo/Ml3vyBEN
    uPpOkA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eZY6r3p4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eZY6r3p4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA27/cD9hOBjA9Ibi1oGDL/dej6kcDKDtA4tuWbcCSrecBzji5p7IjpVw04NT2NSjipqni3apBcgaOy9yIFhOE+DGV/N178X3dKBkKKmP9Ljt4PS4nXa
    kThueyePr1Lk2rIsfJPwzmBqYJbnu5/PZZwZismDQWcA4lR36gZkEzHW+yFavfzJ/UUyAoZb8AUsRa5wy2cB4p3hySZshUzvoZLGUVckaBa3/WqaJ9S8TQ7S
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=Wu8SW7n-U5sUsz4C55sA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDOPBj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:01:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeDOPBe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Apr 2018 11:01:34 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] aio: remove the extra get_file/fput pair in io_submit_one
Date: Sun, 15 Apr 2018 17:01:05 +0200
Message-Id: <20180415150108.1341-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415150108.1341-1-hch@lst.de>
References: <20180415150108.1341-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If we release the lockdep write protection token before calling into
->write_iter and thus never access the file pointer after an -EIOCBQUEUED
return from ->write_iter or ->read_iter we don't need this extra
reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 18507743757a..d7be32cdd1db 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1515,16 +1515,17 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
-		req->ki_flags |= IOCB_WRITE;
-		file_start_write(file);
-		ret = aio_ret(req, call_write_iter(file, req, &iter));
 		/*
 		 * We release freeze protection in aio_complete().  Fool lockdep
 		 * by telling it the lock got released so that it doesn't
 		 * complain about held lock when we return to userspace.
 		 */
-		if (S_ISREG(file_inode(file)->i_mode))
+		if (S_ISREG(file_inode(file)->i_mode)) {
+			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+		}
+		req->ki_flags |= IOCB_WRITE;
+		ret = aio_ret(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
 	return ret;
@@ -1599,7 +1600,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	req->ki_user_iocb = user_iocb;
 	req->ki_user_data = iocb->aio_data;
 
-	get_file(file);
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
 		ret = aio_read(&req->common, iocb, false, compat);
@@ -1618,7 +1618,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		ret = -EINVAL;
 		break;
 	}
-	fput(file);
 
 	if (ret && ret != -EIOCBQUEUED)
 		goto out_put_req;
-- 
2.17.0

