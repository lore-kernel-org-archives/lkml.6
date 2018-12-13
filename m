Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E596C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A37820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MLFD1iEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A37820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeLMEey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:34:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35588 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbeLMEew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:34:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so919128edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cm38oINcLG5XGUCUAQ9j58l/pe6tRlIMeIheYi170Yw=;
        b=MLFD1iELn/iNfIACUM6xLVDTUdj6GnH7S5Tvu2uWV2+whASKPLZ5PLjsuIWGzWSYWc
         42MfMycdEWFzFunVUAtqVrsEL9TLTpxHX3LqLXMIivT7FOtTCkwRJ9Dnv8lkoqpcWYnB
         n2Aut0bqKQ8hhd6MoIIcfO0O9X2AzT6Fg3ZOqUuRhtR7jWl8Ape0ckwGTEJqJRDInXGz
         KDZn5I8RFK47jA6DA1D+l6Gf+ftuLYglScx85W17rnY/SotkPyqXR4D7LTBc+AMoLliw
         yimzo6LF21CgVE36N7LlVLuHdpA21ldXEhB5R83WtVt6KBnocKW50Sc3nXvy3kw+hmLV
         G+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cm38oINcLG5XGUCUAQ9j58l/pe6tRlIMeIheYi170Yw=;
        b=UAybJyCEiin7/hVVNnKAWi86fsYvX91LP5W9SjHJF+IsTKiNWvbK++T9RwsnShdirf
         HWOwQ8V/BN9QYpz8ML+giZiBErH3krl1jmhtaf155ZHBlW3/2F5+r7jy6k1fTh0oC9Lp
         LEK3KvD8qADfFUkSe/shu4w2EHqybM25OYQ7DYNUltNXQ8nUmjaAZ0L01xgXPb8dtEhB
         o0/gpKHQzF3usTcr554L90qxv8K6wyhrEZEAj0eO/ewb1hmsxYmIh2jnVvStKGgyLc6q
         1/UfHKgdoc6Ymlxy6U4OlZnUYvLOPWmze/6D5as2pis2vUIG4hGTUulxTRAbRY3AAtWS
         G0eA==
X-Gm-Message-State: AA+aEWbFVkYvMkrFc8ToJ9P7Vyz4OZIVeoLsRwHTNnebJaK6OfS4/cbj
        qiJsEL/+bFeHLNYg9Aay0sYV83zSouA=
X-Google-Smtp-Source: AFSGD/UOLuuEUrj8ppQLJCkNyT1pT+cyr3m/Nt06hnRKE4u4m/i/cZVg4y1X1VxTdD6IgctPbddW7g==
X-Received: by 2002:a17:906:81cc:: with SMTP id e12-v6mr17560370ejx.138.1544675689276;
        Wed, 12 Dec 2018 20:34:49 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j8sm298416ede.55.2018.12.12.20.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:34:48 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] debugobjects: Warn wrong annotation outside bucket lock
Date:   Thu, 13 Dec 2018 04:34:46 +0000
Message-Id: <20181213043447.23006-1-dima@arista.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugobjects checks during initialization where the real object resides.
Kernel must use debug_object_init() or debug_object_init_on_stack()
accordingly. I'm not sure if it's worth to check debug_object
initialization place, but it seems to be well-documented.

If initialization function finds that the debug object actually resides
in a different place than was annotated, warning is being printed.

Unfortunately, it becomes error-prone to use WARN() or printing under
debugobjects bucket lock: printk() may defer work to workqueue, and
realization of workqueues uses debugobjects. Further, console drivers
use page allocator, potentially vmalloc() or slub/slab. Which reasonably
makes lockdep to go nuts as there are debug_check_no_obj_freed() checks
in allocators.

Move printings out of debugobjets bucket lock to address the potential
lockups.

Link: lkml.kernel.org/r/20181211091154.GL23332@shao2-debian
Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 lib/debugobjects.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 55437fd5128b..98968219405b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -368,13 +368,14 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
-static void
-__debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
+static bool
+__debug_object_init(void *addr, struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool allocated = false;
 
 	fill_pool();
 
@@ -389,9 +390,9 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 			debug_objects_enabled = 0;
 			raw_spin_unlock_irqrestore(&db->lock, flags);
 			debug_objects_oom();
-			return;
+			return false;
 		}
-		debug_object_is_on_stack(addr, onstack);
+		allocated = true;
 	}
 
 	switch (obj->state) {
@@ -406,7 +407,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		debug_object_fixup(descr->fixup_init, addr, state);
-		return;
+		return allocated;
 
 	case ODEBUG_STATE_DESTROYED:
 		debug_print_object(obj, "init");
@@ -416,6 +417,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	return allocated;
 }
 
 /**
@@ -428,7 +430,8 @@ void debug_object_init(void *addr, struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
-	__debug_object_init(addr, descr, 0);
+	if (__debug_object_init(addr, descr))
+		debug_object_is_on_stack(addr, 0);
 }
 EXPORT_SYMBOL_GPL(debug_object_init);
 
@@ -443,7 +446,8 @@ void debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
-	__debug_object_init(addr, descr, 1);
+	if (__debug_object_init(addr, descr))
+		debug_object_is_on_stack(addr, 1);
 }
 EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 
-- 
2.20.0

