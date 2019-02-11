Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB688C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6888217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FxWYjJp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfBKVCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:02:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33063 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfBKVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:02:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so148863pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JI5Y98IttcamNI+3mF8DNZ8Il7eMs3IFLXm3Twofxhs=;
        b=FxWYjJp4emWdKYm+2IYONsz8T0/FcEUtf0goDdthvNUYHdPLxEX7AllFpt8qVxbAWn
         RTn3rBj7vkT0KchxNhxz3aOQwUmDZhrrOQwtn2fRpdTmDoANA5CWOKJIKYa2i6oBdH4d
         2veMCZL3eDtD7UcwZ21obgoZegvad2aRQYZs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JI5Y98IttcamNI+3mF8DNZ8Il7eMs3IFLXm3Twofxhs=;
        b=TqrPb1LI/EkB+Vw/fewRAzmJ6mXLODQPgTPm97TMzKT/v//qPS564lkBBbxIK6yodi
         v/L5NfE6oNDHgKMW+6e6f1qfZnxLKUGuOlGQI9xltAPPdlw/hqJmd14s81cwhWpnMyFP
         6ksSLeNROL5MnV/RZg5C2Aupe7KNr5jp44cBF82iEmsB4uKTRkpAeOE9kvNfw6TdEtC1
         /Q94/fX4pBvts4qSPmvaJXkFSgfmxhWFWqmYo23qMLN1LSqMbj8/UuT0vAZlpOcZoUtC
         ExlmLBq24dNI7TYVPf1nzxuFM4gsmZnc2uMiIcwa7iTaPnoBMSUp/dAIWg48boFK5s9C
         5tiA==
X-Gm-Message-State: AHQUAuYdg/pvcqieVWMfO9j8OKDOJRhum651atToxnsmVuxZDvG8F3Gb
        34fw/ESru/fgtmsxUZ84AEIDDtuCTlw=
X-Google-Smtp-Source: AHgI3IZ4wxgwkScmxfpJDjrJrnoq7MyB83zt6lwxDd5sshy0GqFMX9Z36bYGqeNz8/iVredDLZ1snQ==
X-Received: by 2002:a62:2781:: with SMTP id n123mr227515pfn.138.1549918970051;
        Mon, 11 Feb 2019 13:02:50 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id n73sm16357506pfj.148.2019.02.11.13.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:02:48 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     netdev@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH net-next] net/skbuff: fix up kernel-doc placement
Date:   Mon, 11 Feb 2019 13:02:25 -0800
Message-Id: <20190211210225.132282-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several skb_* functions where the locked and unlocked
functions are confusingly documented. For several of them, the
kernel-doc for the unlocked version is placed above the locked version,
which to the casual reader makes it seems like the locked version "takes
no locks and you must therefore hold required locks before calling it."

One can see, for example, that this link claims to document
skb_queue_head(), while instead describing __skb_queue_head().

https://www.kernel.org/doc/html/latest/networking/kapi.html#c.skb_queue_head

The correct documentation for skb_queue_head() is also included further
down the page.

This diff tested via:

  $ scripts/kernel-doc -rst include/linux/skbuff.h net/core/skbuff.c

No new warnings were seen, and the output makes a little more sense.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/linux/skbuff.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 831846617d07..a41e84f7730c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1889,12 +1889,12 @@ static inline void __skb_queue_before(struct sk_buff_head *list,
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
-void skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk);
 static inline void __skb_queue_head(struct sk_buff_head *list,
 				    struct sk_buff *newsk)
 {
 	__skb_queue_after(list, (struct sk_buff *)list, newsk);
 }
+void skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk);
 
 /**
  *	__skb_queue_tail - queue a buffer at the list tail
@@ -1906,12 +1906,12 @@ static inline void __skb_queue_head(struct sk_buff_head *list,
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
-void skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk);
 static inline void __skb_queue_tail(struct sk_buff_head *list,
 				   struct sk_buff *newsk)
 {
 	__skb_queue_before(list, (struct sk_buff *)list, newsk);
 }
+void skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk);
 
 /*
  * remove sk_buff from list. _Must_ be called atomically, and with
@@ -1938,7 +1938,6 @@ static inline void __skb_unlink(struct sk_buff *skb, struct sk_buff_head *list)
  *	so must be used with appropriate locks held only. The head item is
  *	returned or %NULL if the list is empty.
  */
-struct sk_buff *skb_dequeue(struct sk_buff_head *list);
 static inline struct sk_buff *__skb_dequeue(struct sk_buff_head *list)
 {
 	struct sk_buff *skb = skb_peek(list);
@@ -1946,6 +1945,7 @@ static inline struct sk_buff *__skb_dequeue(struct sk_buff_head *list)
 		__skb_unlink(skb, list);
 	return skb;
 }
+struct sk_buff *skb_dequeue(struct sk_buff_head *list);
 
 /**
  *	__skb_dequeue_tail - remove from the tail of the queue
@@ -1955,7 +1955,6 @@ static inline struct sk_buff *__skb_dequeue(struct sk_buff_head *list)
  *	so must be used with appropriate locks held only. The tail item is
  *	returned or %NULL if the list is empty.
  */
-struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list);
 static inline struct sk_buff *__skb_dequeue_tail(struct sk_buff_head *list)
 {
 	struct sk_buff *skb = skb_peek_tail(list);
@@ -1963,6 +1962,7 @@ static inline struct sk_buff *__skb_dequeue_tail(struct sk_buff_head *list)
 		__skb_unlink(skb, list);
 	return skb;
 }
+struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list);
 
 
 static inline bool skb_is_nonlinear(const struct sk_buff *skb)
@@ -2653,13 +2653,13 @@ static inline int skb_orphan_frags_rx(struct sk_buff *skb, gfp_t gfp_mask)
  *	the list and one reference dropped. This function does not take the
  *	list lock and the caller must hold the relevant locks to use it.
  */
-void skb_queue_purge(struct sk_buff_head *list);
 static inline void __skb_queue_purge(struct sk_buff_head *list)
 {
 	struct sk_buff *skb;
 	while ((skb = __skb_dequeue(list)) != NULL)
 		kfree_skb(skb);
 }
+void skb_queue_purge(struct sk_buff_head *list);
 
 unsigned int skb_rbtree_purge(struct rb_root *root);
 
@@ -3028,7 +3028,7 @@ static inline int skb_padto(struct sk_buff *skb, unsigned int len)
 }
 
 /**
- *	skb_put_padto - increase size and pad an skbuff up to a minimal size
+ *	__skb_put_padto - increase size and pad an skbuff up to a minimal size
  *	@skb: buffer to pad
  *	@len: minimal length
  *	@free_on_error: free buffer on error
-- 
2.20.1.791

