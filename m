Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C85AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E85120864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkZoNBem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E85120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965158AbeFNXrk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:47:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33774 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965001AbeFNXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:47:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so3619559pgq.0;
        Thu, 14 Jun 2018 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzxlJPCgLWvSKXPajxKaJnmmaMkzzFbi7bj7RF7h3Dc=;
        b=jkZoNBemhGFvJOnjKDdIKCjsO4rCYD6i/4zpFkBvE+MBx++EfWghjgsopuJIo0lMt/
         txjjQZfRKrRiSBXajhIhkwhDpQxfqk0Wai1sm1Q3Kp54aLS2QCDEZInj703r/6fekUm2
         xSXeD8/lKuBuerUZAxwMqT/oy/BkGl8ZixBYFC825K+ewdeAXgpvDAoV12sqz7RuNPzH
         Vb8cSeTpUf+mcyXJrRGj5ZZlvitVYk9vlZRJjmgUEfVd5D6oKIFHs5tuUydGh7EQ6nfv
         Z/Uf4GWhAfDkZ0JXoVUImcN64RPB28hvUC+npf4u7sFV8Eiv4yE+/p5Zid2MCq9XzqPy
         Zspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzxlJPCgLWvSKXPajxKaJnmmaMkzzFbi7bj7RF7h3Dc=;
        b=H4TJEOja2+23ErlLTenX9GQhFdjOUBz652QqNpAYOtYNfHAIFu8KLl9sPQsS1Mo3ab
         50/i/9INuYq/8BAb4L4yDoZq/8tXPeqwZ8gFa79GcuRYRARwInS28LhbGdPx4P+kTDKP
         61X4P1duvY1QvKmW13tmKliAkYQmDDbqhJXvmx/lVYHE9gEk0V79Fey5dNQ0/VdJ0L0i
         K89jcWKrJ9nB1+Z0HRvFJU3vOkMfLLmDBSx2hyP/1pSB4NeIT6kJu5RLyTVCUkfzvXVr
         TRCsrLxoIZ+4+xtoykfQT6txnDNyo+dmuiIfflbmFbTusZNw7pgGVp4Ovtkmj7zAQxZG
         TgSA==
X-Gm-Message-State: APt69E0h1VmAb+Yz8iaWB9bAaCHPb59FbV6EQpkxgoMFdzfZHogNexVb
        /rBnIQPpXXFR8fOhN25xsHQ=
X-Google-Smtp-Source: ADUXVKLXFkaSJg2awdOzUXNj8G9Xx1T7TjCTU0Dg1VqUPzHmlqj5vjbKopAu7PjzDmLS7I+bJ5E+ug==
X-Received: by 2002:a63:7741:: with SMTP id s62-v6mr4113059pgc.103.1529020057573;
        Thu, 14 Jun 2018 16:47:37 -0700 (PDT)
Received: from xldev-tmpl.dev.purestorage.com ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id b15-v6sm8075193pgu.54.2018.06.14.16.47.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 16:47:36 -0700 (PDT)
Date:   Thu, 14 Jun 2018 17:47:34 -0600
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] block: fix bsg_unregister and bsg_open race
Message-ID: <20180614234733.GA38460@xldev-tmpl.dev.purestorage.com>
References: <20180613221417.GA22778@xldev-tmpl.dev.purestorage.com>
 <20180614083806.GA18966@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614083806.GA18966@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Christoph. Good catch releasing the mutex on failure path.
V2 patch with your suggestions applied.


From 7a8dc4b10f344d915658549581158f3da2cc1f91 Mon Sep 17 00:00:00 2001
From: Anatoliy Glagolev <glagolig@gmail.com>
Date: Wed, 13 Jun 2018 15:38:51 -0600
Subject: [PATCHv2] Fix race of bsg_open and bsg_unregister
Signed-Off-By: Anatoliy Glagolev <glagolig@gmail.com>

---
 block/bsg.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 132e657..66602c4 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -693,6 +693,8 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 	struct bsg_device *bd;
 	unsigned char buf[32];
 
+	lockdep_assert_held(&bsg_mutex);
+
 	if (!blk_get_queue(rq))
 		return ERR_PTR(-ENXIO);
 
@@ -707,14 +709,12 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 	bsg_set_block(bd, file);
 
 	atomic_set(&bd->ref_count, 1);
-	mutex_lock(&bsg_mutex);
 	hlist_add_head(&bd->dev_list, bsg_dev_idx_hash(iminor(inode)));
 
 	strncpy(bd->name, dev_name(rq->bsg_dev.class_dev), sizeof(bd->name) - 1);
 	bsg_dbg(bd, "bound to <%s>, max queue %d\n",
 		format_dev_t(buf, inode->i_rdev), bd->max_queue);
 
-	mutex_unlock(&bsg_mutex);
 	return bd;
 }
 
@@ -722,7 +722,7 @@ static struct bsg_device *__bsg_get_device(int minor, struct request_queue *q)
 {
 	struct bsg_device *bd;
 
-	mutex_lock(&bsg_mutex);
+	lockdep_assert_held(&bsg_mutex);
 
 	hlist_for_each_entry(bd, bsg_dev_idx_hash(minor), dev_list) {
 		if (bd->queue == q) {
@@ -732,7 +732,6 @@ static struct bsg_device *__bsg_get_device(int minor, struct request_queue *q)
 	}
 	bd = NULL;
 found:
-	mutex_unlock(&bsg_mutex);
 	return bd;
 }
 
@@ -746,17 +745,18 @@ static struct bsg_device *bsg_get_device(struct inode *inode, struct file *file)
 	 */
 	mutex_lock(&bsg_mutex);
 	bcd = idr_find(&bsg_minor_idr, iminor(inode));
-	mutex_unlock(&bsg_mutex);
 
-	if (!bcd)
-		return ERR_PTR(-ENODEV);
+	if (!bcd) {
+		bd = ERR_PTR(-ENODEV);
+		goto out_unlock;
+	}
 
 	bd = __bsg_get_device(iminor(inode), bcd->queue);
-	if (bd)
-		return bd;
-
-	bd = bsg_add_device(inode, bcd->queue, file);
+	if (!bd)
+		bd = bsg_add_device(inode, bcd->queue, file);
 
+out_unlock:
+	mutex_unlock(&bsg_mutex);
 	return bd;
 }
 
-- 
1.9.1

