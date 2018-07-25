Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE69520673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy7359R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE69520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbeGYXau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42585 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbeGYXat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so16703edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8xKb5XtW11XVh6lkZBxudCzpTEFA6wlh+G+Jr9OPbs=;
        b=Cy7359R5v7Z8bsqJ8rjlROEbvKRgMCLkxQ6PpHPSioPKyLIZBdlNYiB39nTcXTPebe
         SSF9HMLrwlseevVNyzZ6les97rGrpYnhLUp9UFrk30AjdsoHLSYvMPVsUGG4idmgNlId
         FZz2NIRA/UDq4KLFH9IMD12ntb/BBu4QUZ1k3Sc/n8vsXFXrFF184gjKAHk/La+Gn8ea
         NTrN8oN2VgKhEE6bXn/mPkFZFpeZ7Cr66b0QW7OJb1d73baRjBMRY5kCgY8DXV+zC6JI
         vGOMdYScNy23rRpPCHDFWl2QdZxbNkSgNsme3H96D2q6ZUbdYQE65LTVE9iqza8O/FK9
         ORVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8xKb5XtW11XVh6lkZBxudCzpTEFA6wlh+G+Jr9OPbs=;
        b=kd/r2LR/VHAFt2dvTYodHprUhPSGEoWcTMegpkLfgmr5rwcjgfOQ8wCaoImAEylLUc
         mt3CwD1Vi4yXy3tijX9HvhIQNVJb2WsC2+IJ8eAzn/8jb/sFaJtCr5cnJrzQGj9PrWJJ
         dRT96s9or4J+3Pbwbr+Efy60Zcx1LVznnl0kLDthqlbZ/gxun2uMAsBgWWCJ39/plrBD
         looBw2fEQH4Jvo93pDPg7kHw00Y44VoVXKLx+lfm1Q21Q3eFbx/EIuqwYgqfuQGFYsgL
         9d61OEhtUZKcK1AX6KkUsmLPDr4dR06xrW+6WODi7jan/s+auFBKwyrBFZStQwfWq8aZ
         anWA==
X-Gm-Message-State: AOUpUlHu0g8l6cD9fxinMSPgonAfpUALHjvPttYtm+/ka4f6oQ/mUlQ0
        B9dCFXS8DAu21TyVrnaZS6qpS2D3
X-Google-Smtp-Source: AAOMgpc21ix9Opzv6w/GTHMG8YlYwKdTtHV/Hy6wnk3oYQp46nmPFVs1WUW6FfT0uVN7UAf1Eu/UmQ==
X-Received: by 2002:a50:cf81:: with SMTP id h1-v6mr25628855edk.35.1532557025547;
        Wed, 25 Jul 2018 15:17:05 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:17:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/10] staging:rtl8192u: Remove multiple blank lines - Style
Date:   Wed, 25 Jul 2018 23:16:27 +0100
Message-Id: <20180725221630.28595-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple blank lines, raise a checkpatch issue. This is purely
a coding style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index e9e0548ce96e..672c8db804e1 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -12,7 +12,6 @@
 #define ISR_TX_BCN_ERR		BIT(26)		/* Transmit Beacon Error */
 #define ISR_BCN_TIMER_INTR	BIT(13)		/* Beacon Timer Interrupt */
 
-
 /* Define element ID of command packet. */
 
 /*------------------------------Define structure----------------------------*/
@@ -63,7 +62,6 @@ typedef struct tag_cmd_pkt_interrupt_status {
 	u32	interrupt_status;		/* Interrupt Status. */
 } cmpk_intr_sta_t;
 
-
 /* 3. TX side: Set configuration packet. */
 typedef struct tag_cmd_pkt_set_configuration {
 	u8	element_id;			/* Command packet type. */
@@ -189,5 +187,4 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 rt_status SendTxCommandPacket(struct net_device *dev,
 			      void *pData, u32 DataLen);
 
-
 #endif
-- 
2.18.0

