Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5219C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B620657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t540qs20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfAROtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:49:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41315 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfAROtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:49:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so11301215edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXKzSzeudUuPwHtY75HWLbr6PVGsuWm/q7TiL7pl4/U=;
        b=t540qs20UAxmRFAnPkoKbyM6MTzYgnthaL8L13yCt/qJSx6cybbxmnBxWHE6CidlsD
         87t7bVNULUacKxeuCeoD3gXsQyQez6WN1sQ6yT6t4r4Pyz2SzMwo+1JlyKGIiTQOz0Uf
         jWCPoQnBsuLCWw0X9VEG15NwljINtTw6nwb5WvykufwoFhc/w3jlEsNHmqBB3JtksDVr
         Kl8u4lXVwK2qxYysTSMmk3Ei2uZnRnmSGOKvxZVI+2P4x5CKyMUeGhNLO/gYvVLRSsXZ
         1RQ0wZsKuG1fXVn3rC35luzli+G+Hsi5bFBUCbBwv8qsxOYOHDKcfh7gRmaCK18uRxzI
         YadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXKzSzeudUuPwHtY75HWLbr6PVGsuWm/q7TiL7pl4/U=;
        b=DtFd9Tpi+Vk3zIHqfrhTkOA+8rAECgv6cECBKfSBNQAmp2rMRRJbRzvIf6AO3yRuaN
         sCC1VQ6uClxoHup52MqG3xUBWxePBigqjnuh3vnnOyD0EZY2BA2AReHrMXbpI+IMPyPW
         5cNlMGa4hcDTLGOhy3+8ILFmk+wu+4HDGRljq3xm9Caja8tC75uogorxu6wYURSy1Fa/
         5GalnB/IbyBHIqOKbEF7YtRiFcxZhMlVfo1gjt6i1bz7Y3adN9jc9TUcm3n5QJVgrvPA
         3GpZt2mDgpIEIfb28+6wAFcDXAtDX0WogKUeCWTbSy8TKiCnIbMfmKgz/LVhB60zS7jF
         QtIA==
X-Gm-Message-State: AJcUukfBJUkmxentjCcqcg0EHTllp2rZEFz5+6WCmsH8RfJepoHQR4j2
        6KORTLUbgJCjARriLB3/ID5vVMIC
X-Google-Smtp-Source: ALg8bN7JKqbVn0zDvghwuwPlGbQ3B+AFWBaGRb6ut/00sb9CgsaP0YIbWZPysWUa01U1WdU65RJwhw==
X-Received: by 2002:a17:906:1001:: with SMTP id 1-v6mr14307823ejm.91.1547822948240;
        Fri, 18 Jan 2019 06:49:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40fa:9f00:74c6:12d0:25bf:3ed0])
        by smtp.gmail.com with ESMTPSA id u33sm7149757edm.88.2019.01.18.06.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:49:07 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Akash Goel <akash.goel@intel.com>, Jens Axboe <axboe@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] relay: fix percpu annotation in struct rchan
Date:   Fri, 18 Jan 2019 15:49:02 +0100
Message-Id: <20190118144902.79065-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.20.0
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

CC: Akash Goel <akash.goel@intel.com>
CC: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-kernel@vger.kernel.org
Fixes: 017c59c04 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/relay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e1bdf01a8..c759f96e3 100644
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

