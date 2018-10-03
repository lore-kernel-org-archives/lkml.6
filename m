Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2D2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C702920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy3zCZvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C702920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCM0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44654 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCM0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so1007490pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=HwbaBmhMCO9zbgdM3F9gJvEL8ROVvU5Xwc7IC8JbJkw=;
        b=Qy3zCZvFFzmj8bqpT1pdstKGLgQzxfnbMn23l459BAnXK+mwah2c3fWaZ/epF6+gYr
         s0sNIpe4BINFiWoF31i+Aq7RAuaiexiyAH+sG3W3bzT2Xetmc13tejLvgoYJAA6sflIN
         cFxBRDp9V+AjmwZgvB2rkKVi9a88WWFJegUZIfEMM/EVltng7WdHoI7MZ8KCBksnsNT8
         KKouekXEMOTNdv4Wrd4bcWr7MVpNi4RWJ62yqlH3O+tzrryiSRpFYCIJMEIMgTUvd50n
         8g4LrgX7FEDLmontB6PPrTy4xQ+xWNwx6cETTK7R3UJp9WvLNqY/7wm/k2jNFxNAO4UV
         tftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=HwbaBmhMCO9zbgdM3F9gJvEL8ROVvU5Xwc7IC8JbJkw=;
        b=fqNpBKZxsYVRjSSbaQZ5bXbXbtg56G8+qy/87pMEKC2OfKBz3HpKSk4cprYQxN9EHl
         xRSPPzObbjuK6TwtyXbzknUCC5qF7cQeMPHxwMau370225TsrNNYLjZhkkLSd1eEI+Nd
         8nHFp9F9Rjr2RHGwz7jDFOOUtxiQEif3iMZYfm4KZvb3JvZqpgYKjgEz+FKUCn3lKT4c
         XOurvc5tMT5hvXf0+UjSMqFoQA6ftJTkb1aqX+iYIEvfQWacx1c0MLiv0RVqcLhlDrFN
         Y8iRdEX7uoOHhQERTx2wVII+kXvorwY0VLdIEC1WA4Lfq9k07ICbOVER2r918BKK76zF
         8GWA==
X-Gm-Message-State: ABuFfoiDY6AxfzbaU6B6MFjSDlSag9Duim9hpBgaKfY433ytPAJG0Irq
        bW2mFOOTNpyWA/D1zoUdFm0=
X-Google-Smtp-Source: ACcGV61Om97Ln0y/fnDvE3ehW3mMZ4LXLMWqx8ZH2CXpL50LTe0+HVMVyT/hwt8P719lYJsDkX476w==
X-Received: by 2002:a63:e05:: with SMTP id d5-v6mr17102318pgl.272.1538545188761;
        Tue, 02 Oct 2018 22:39:48 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id i25-v6sm425815pgi.31.2018.10.02.22.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:48 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 832271643D0; Tue,  2 Oct 2018 22:39:47 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>, Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/16] sgi-xp: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:49 -0700
Message-Id: <20181003053902.6910-4-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Cliff Whickman <cpw@sgi.com>
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/sgi-xp/xpc_channel.c | 6 +++---
 drivers/misc/sgi-xp/xpc_sn2.c     | 2 +-
 drivers/misc/sgi-xp/xpc_uv.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_channel.c b/drivers/misc/sgi-xp/xpc_channel.c
index 05a890ce2ab8..8e6607fc8a67 100644
--- a/drivers/misc/sgi-xp/xpc_channel.c
+++ b/drivers/misc/sgi-xp/xpc_channel.c
@@ -28,7 +28,7 @@ xpc_process_connect(struct xpc_channel *ch, unsigned long *irq_flags)
 {
 	enum xp_retval ret;
 
-	DBUG_ON(!spin_is_locked(&ch->lock));
+	lockdep_assert_held(&ch->lock);
 
 	if (!(ch->flags & XPC_C_OPENREQUEST) ||
 	    !(ch->flags & XPC_C_ROPENREQUEST)) {
@@ -82,7 +82,7 @@ xpc_process_disconnect(struct xpc_channel *ch, unsigned long *irq_flags)
 	struct xpc_partition *part = &xpc_partitions[ch->partid];
 	u32 channel_was_connected = (ch->flags & XPC_C_WASCONNECTED);
 
-	DBUG_ON(!spin_is_locked(&ch->lock));
+	lockdep_assert_held(&ch->lock);
 
 	if (!(ch->flags & XPC_C_DISCONNECTING))
 		return;
@@ -755,7 +755,7 @@ xpc_disconnect_channel(const int line, struct xpc_channel *ch,
 {
 	u32 channel_was_connected = (ch->flags & XPC_C_CONNECTED);
 
-	DBUG_ON(!spin_is_locked(&ch->lock));
+	lockdep_assert_held(&ch->lock);
 
 	if (ch->flags & (XPC_C_DISCONNECTING | XPC_C_DISCONNECTED))
 		return;
diff --git a/drivers/misc/sgi-xp/xpc_sn2.c b/drivers/misc/sgi-xp/xpc_sn2.c
index 5a12d2a54049..0ae69b9390ce 100644
--- a/drivers/misc/sgi-xp/xpc_sn2.c
+++ b/drivers/misc/sgi-xp/xpc_sn2.c
@@ -1671,7 +1671,7 @@ xpc_teardown_msg_structures_sn2(struct xpc_channel *ch)
 {
 	struct xpc_channel_sn2 *ch_sn2 = &ch->sn.sn2;
 
-	DBUG_ON(!spin_is_locked(&ch->lock));
+	lockdep_assert_held(&ch->lock);
 
 	ch_sn2->remote_msgqueue_pa = 0;
 
diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 340b44d9e8cf..0441abe87880 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -1183,7 +1183,7 @@ xpc_teardown_msg_structures_uv(struct xpc_channel *ch)
 {
 	struct xpc_channel_uv *ch_uv = &ch->sn.uv;
 
-	DBUG_ON(!spin_is_locked(&ch->lock));
+	lockdep_assert_held(&ch->lock);
 
 	kfree(ch_uv->cached_notify_gru_mq_desc);
 	ch_uv->cached_notify_gru_mq_desc = NULL;
-- 
2.19.0

