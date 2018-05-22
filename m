Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2671386-1527001746-2-3024311600893453282
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527001745; b=YDdy5FHrW1XDx1uNMgGgl+Qj0n09DQqrmsoeVSgm8bifSAe95P
    fph4qfGSTZf8HghDbWEtZWwQo5y7ETsL8O5yRNBjUxra89VFCHGvcTM3Prdrv4Sq
    Xutm6sfeb/dQT4NvtUST7iF67T2+mA/4lR9TfhPXugfXDDpsJjEgiUkX5gxgOA17
    KIhW/5/YXpEwgJnh2pe5c/MZQbR+TMZ6J+z9PY5nGPQMnIDAHH3JYkJ6Tt5Q75WV
    /BMojeNyEYRNUWMoZOvCkg/0pppalKm0zQvB8x8TBolq8Kt58vFRz97fyx1MxhLX
    OQ4KwzR054FQMrqUCv2YkAjH5HgpXkNjQXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527001745; bh=
    gHB2YrOyqhoTzWGWfq2H+JOJOmtl2ZyB750NFgj0tFI=; b=Nmk8iXc6RcJzpOqU
    g6D1tt8J2B/sX4qyTV4CjJADi0zJFKt4mmy3xwujBNvnlS5vKyQcD884dOjtZzxo
    dFf9epagGAfkg/Y/2oO+odoP9m/pqyoZDGEPj5Lzh4yDVikjEdQxU2NHxlB6WNr+
    YFQqcrA/A3w6JDA5X8ucOiZqFwAEKLFF3GwEyeNI06uyamd2/H463jYZ+ecOSgVk
    VbqZslZwPxOHEQGi9SjRsANbDThE8QS49oszgRfSkR15zJ0rOWjcztZ3mIL404c5
    D+ur8QZtxbe72ClSgUM9ZJbiXkctcgSdSn+fBwCyN7/8KLEDgAG6WypyY1+WA5rQ
    q527Nw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=IAr72Uma x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=IAr72Uma x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGe0iZ0Bo+iLjhlrOfOSDMO68PI12pm0/6LLpTL0oQ0XwpUypb6kHZGSGGmm0WKGVt/tKZhAvb3qQ4Ts4DJFiJNDKqVjGpLJvtUzHwfgoPOy/OFls1Ah
    OvKXGXvR37xHX4FhZUoM5t406RQOjKVDwiGnANLFW3NS5KUejXz2y0uPfJVIlHVzp1Qeew8XvwVhn3toN4QdWZXzWWWeHQ6l59j7sPKstI8wR6g78wiXGXxt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeEVPIr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:08:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23233 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeEVPH5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 11:07:57 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79548773"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 5/5] fs: iomap dio set bio prio from kiocb prio
Date: Tue, 22 May 2018 08:07:37 -0700
Message-Id: <20180522150737.9893-6-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180522150737.9893-1-adam.manzanares@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

Now that kiocb has an ioprio field copy this over to the bio when it is
created from the kiocb during direct IO.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index afd163586aa0..65aae194aeca 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -919,6 +919,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_iter.bi_sector =
 			(iomap->addr + pos - iomap->offset) >> 9;
 		bio->bi_write_hint = dio->iocb->ki_hint;
+		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-- 
2.15.1

