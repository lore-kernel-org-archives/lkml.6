Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE23C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13B20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="S9H/S21c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeLMEe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:34:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33852 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeLMEex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:34:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so921819ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEyrh2NO3Vk+hne2VETLKd/G0B/66642vqCGYFlsSRU=;
        b=S9H/S21c6LH9MWQdZTXVPm402DvVCyxEgEpFKU3k+sLE9AdfanY8827YwEIK8MlIU6
         JXw/+qzScr/YZ+7ZIXPbITaq0mqGGbLNqquXf/8AXDnxOE01dxltcK2LPxv71HUPOVHR
         ADGaFbKTv3ppombdFwcZZd+Sfne1LpaJq+/gIYX2mVRGrQACv4CFLYwl4po4X9jV4GzG
         2ix7tDK8Sg86xVH9qoSTlOHmmnR8g7XPbIYRP1JkIUVHrUShnCkc5l2Cw2TCbvRk5I3v
         7FRnqBb4KCDZP1oAmNlc7/XN3E15osUZ2rnkkF6sO15uFSdsLY+sZ4wy1bTUOx3AdBn5
         jvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEyrh2NO3Vk+hne2VETLKd/G0B/66642vqCGYFlsSRU=;
        b=cLk1PK/kkE3WRiOw9W3+xtFoxfDBQT2wqMkOYvKrQyppC/fwPwIOlx1LHc6UwUNUF7
         9p7CL5LHqBwPTQPF2rUnMKCtex3l3Ev3fcX+YiP3mPewgw8eEbmQwyss1xICRVy9C5g7
         +djGdpAU62nhUY1JNhY6/Nvang+EZyQC5oz8PJqo/sYGfYFSu7vHq+2YTpRkqipO3X5f
         g8btiKCtCmFox4HDVZlHEl3Q4fvbTowB0Zw7CqSXLWQfxHqfnYTPigYc2iI/pCk6GKd2
         yXI9cM3OeXt2f/ld6dLzZZkmHd6RCmyGcZARD13yK/cL/k3Xiy90mcbR2+9VwQdxUWGf
         PHtg==
X-Gm-Message-State: AA+aEWapWTLfP3SZey658Sy9eo5jiKWu4bFbLGUAkUBzs9j8riczdz5K
        64jji2f/1v8suT4BmZyN5We+NOTSmRs=
X-Google-Smtp-Source: AFSGD/U48oCU/I8PGN4UZJZEorF0gP3T0HqyTnvvlAcJtPlqssuGytb3Z9GnhLGGWlN8Fq2yf8WdQQ==
X-Received: by 2002:a50:b205:: with SMTP id o5mr20691403edd.245.1544675690594;
        Wed, 12 Dec 2018 20:34:50 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j8sm298416ede.55.2018.12.12.20.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:34:50 -0800 (PST)
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
Subject: [PATCH 2/2] debugobjects: Print warnings outside bucket lock
Date:   Thu, 13 Dec 2018 04:34:47 +0000
Message-Id: <20181213043447.23006-2-dima@arista.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181213043447.23006-1-dima@arista.com>
References: <20181213043447.23006-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever debugobjects finds invalid pattern during life time of a kernel
object such as:
-  Activation of uninitialized objects
-  Initialization of active objects
-  Usage of freed/destroyed objects
it prints a warning and tries to make fixup over an object.

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
 lib/debugobjects.c | 89 ++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 98968219405b..0c92e46cb588 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -313,7 +313,7 @@ static struct debug_bucket *get_bucket(unsigned long addr)
 	return &obj_hash[hash];
 }
 
-static void debug_print_object(struct debug_obj *obj, char *msg)
+static void __debug_print_object(struct debug_obj *obj, char *msg)
 {
 	struct debug_obj_descr *descr = obj->descr;
 	static int limit;
@@ -330,6 +330,14 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	debug_objects_warnings++;
 }
 
+#define debug_print_object(obj, msg, lock, flags)			\
+	do {								\
+		struct debug_obj tmp = *obj;				\
+									\
+		raw_spin_unlock_irqrestore(lock, flags);		\
+		__debug_print_object(&tmp, msg);			\
+	} while(0)
+
 /*
  * Try to repair the damage, so we have a better chance to get useful
  * debug output.
@@ -403,15 +411,14 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr)
 		break;
 
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "init");
 		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "init", &db->lock, flags);
 		debug_object_fixup(descr->fixup_init, addr, state);
 		return allocated;
 
 	case ODEBUG_STATE_DESTROYED:
-		debug_print_object(obj, "init");
-		break;
+		debug_print_object(obj, "init", &db->lock, flags);
+		return allocated;
 	default:
 		break;
 	}
@@ -485,16 +492,14 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 
 		case ODEBUG_STATE_ACTIVE:
-			debug_print_object(obj, "activate");
 			state = obj->state;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
+			debug_print_object(obj, "activate", &db->lock, flags);
 			ret = debug_object_fixup(descr->fixup_activate, addr, state);
 			return ret ? 0 : -EINVAL;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "activate");
-			ret = -EINVAL;
-			break;
+			debug_print_object(obj, "activate", &db->lock, flags);
+			return -EINVAL;
 		default:
 			ret = 0;
 			break;
@@ -516,7 +521,7 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 		debug_object_init(addr, descr);
 		debug_object_activate(addr, descr);
 	} else {
-		debug_print_object(&o, "activate");
+		__debug_print_object(&o, "activate");
 		ret = debug_object_fixup(descr->fixup_activate, addr,
 					ODEBUG_STATE_NOTAVAILABLE);
 		return ret ? 0 : -EINVAL;
@@ -549,27 +554,27 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
-			if (!obj->astate)
+			if (!obj->astate) {
 				obj->state = ODEBUG_STATE_INACTIVE;
-			else
-				debug_print_object(obj, "deactivate");
-			break;
-
+				break;
+			}
+			/* fallthrough */
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "deactivate");
-			break;
+			debug_print_object(obj, "deactivate", &db->lock, flags);
+			return;
 		default:
 			break;
 		}
-	} else {
+	}
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
-		debug_print_object(&o, "deactivate");
+		__debug_print_object(&o, "deactivate");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -603,15 +608,14 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		break;
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "destroy");
 		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "destroy", &db->lock, flags);
 		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
-		debug_print_object(obj, "destroy");
-		break;
+		debug_print_object(obj, "destroy", &db->lock, flags);
+		return;
 	default:
 		break;
 	}
@@ -645,9 +649,8 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "free");
 		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "free", &db->lock, flags);
 		debug_object_fixup(descr->fixup_free, addr, state);
 		return;
 	default:
@@ -695,7 +698,7 @@ void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
 			/* Track this static object */
 			debug_object_init(addr, descr);
 		} else {
-			debug_print_object(&o, "assert_init");
+			__debug_print_object(&o, "assert_init");
 			debug_object_fixup(descr->fixup_assert_init, addr,
 					   ODEBUG_STATE_NOTAVAILABLE);
 		}
@@ -732,25 +735,27 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
-			if (obj->astate == expect)
+			if (obj->astate == expect) {
 				obj->astate = next;
-			else
-				debug_print_object(obj, "active_state");
-			break;
-
+				raw_spin_unlock_irqrestore(&db->lock, flags);
+				return;
+			}
+			/* fallthrough */
 		default:
-			debug_print_object(obj, "active_state");
-			break;
+			debug_print_object(obj, "active_state",
+					   &db->lock, flags);
+			return;
 		}
-	} else {
+	}
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
-		debug_print_object(&o, "active_state");
+		__debug_print_object(&o, "active_state");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -786,10 +791,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				debug_print_object(obj, "free");
 				descr = obj->descr;
 				state = obj->state;
-				raw_spin_unlock_irqrestore(&db->lock, flags);
+				debug_print_object(obj, "free",
+						   &db->lock, flags);
 				debug_object_fixup(descr->fixup_free,
 						   (void *) oaddr, state);
 				goto repeat;
-- 
2.20.0

