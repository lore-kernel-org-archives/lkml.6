Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D08EC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A7520881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enDt6rEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfAaCXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:23:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34122 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:23:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so1357098ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QPiyMAcDRri+dceZy9yvCJRDHdeJZPlPkfakOicKfc=;
        b=enDt6rEX40mOTT0w+aiT8XOU+slGoFcEBr01eY4Xp/JJuuXkHG25PYZUu5+UPaVgAc
         2xr42ZvxnkWT2V4IF3VHXOkSHRO2L/5proMX2+WUH7c7asR70ZSumenGW24dBUkBcVX3
         S2tPn+nskdsa1eIFo8hLN6eaaqjKR7RVO9cOHxwpNFFzuAZo1IZi98RYmpmz3ZoGgsQx
         rXxUT/23+tADTv6Zg5yQAH3Y1jJV6/QOkpiPkbOZoXLBLK6QfjkIfDGYIuIF8sGwnBS5
         XD3J5KZUddPvwYaayl8p8xSeMBL7qi/Bt9nyMRGaP4VNobmZVGCiweHAavkcDQPe/nXb
         E52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QPiyMAcDRri+dceZy9yvCJRDHdeJZPlPkfakOicKfc=;
        b=PdDdRS6UtKel1hwEA0tcwel4k2iSSpFdK8IbOEcqqyVezEdqyVwrhfTj4+DunvXWzU
         f0O7tKweYlOweQU5GjRuvZspVquydZp45EBzPYea1MyV+1OBKnADN5oeBX0tGym7RYaO
         VwyQ+sevP9nfiGvq7qal3TP8qEQCxC7rztwDryAeQKDIyzHuHjW7WieaBewmDFcDcKu7
         gr9BeNo/yHb9fWXEStDDzydb2PpzN6cDuK3jCh2PpKVNbHKPYDT4bibGTeN9839iQaI6
         OAdYw4r4QCLyZEkJ7U7FgqOFfz5GONOoXbi1ByhN+71/+tG3bnLl2uBFEkiCkNyArd9d
         Yy3Q==
X-Gm-Message-State: AJcUukfGGAp3bacy+5XfhDmgSucZKIRW3mF8Fn2sLuRJtl/OaI8F2QTf
        qqbT6jEhAdYZeQRZ411rQZX4dnFe
X-Google-Smtp-Source: ALg8bN4tHrw8EcoNsSAfrl3stwgRLTASbIMu3CdJbmof5jd26OloHZ5+bf4VYQJbmqQfq4WGRge7vQ==
X-Received: by 2002:a50:b964:: with SMTP id m91mr32412258ede.184.1548901393308;
        Wed, 30 Jan 2019 18:23:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40eb:400:e:1ffe:8722:6695])
        by smtp.gmail.com with ESMTPSA id 97sm923114edq.45.2019.01.30.18.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 18:23:12 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] relay: fix percpu annotation in struct rchan
Date:   Thu, 31 Jan 2019 03:23:04 +0100
Message-Id: <20190131022304.48365-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190131105937.62023ef1@canb.auug.org.au>
References: <20190131105937.62023ef1@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu member of this structure is declared as:
	struct ... ** __percpu member;
So its type is:
	__percpu pointer to pointer to struct ...

But looking at how it's used, its type should be:
	pointer to __percpu pointer to struct ...
and it should thus be declared as:
	struct ... * __percpu *member;

So fix the placement of '__percpu' in the definition of this
structures.

This silents a few Sparse's warnings like:
	warning: incorrect type in initializer (different address spaces)
	  expected void const [noderef] <asn:3> *__vpp_verify
	  got struct sched_domain **

CC: Jens Axboe <axboe@kernel.dk>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-kernel@vger.kernel.org
Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
Changes since v1:
* use core.abbrev = auto for 'Fixes: 017c59c04...'
* remove bouncing email address

---
 include/linux/relay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e1bdf01a86e2..c759f96e39c1 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -66,7 +66,7 @@ struct rchan
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
-	struct rchan_buf ** __percpu buf; /* per-cpu channel buffers */
+	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
 	struct dentry *parent;		/* parent dentry passed to open */
-- 
2.20.0

