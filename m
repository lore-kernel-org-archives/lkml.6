Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA97C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0906220857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6LF+DU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0906220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbeG2WkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35717 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeG2WkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so10594436wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pl9HSYgdiQZ88VBPFN10ZXvWILJUcjWus5G8A3/Q/fw=;
        b=t6LF+DU58eMR5OjVSfa/me27V7joetpPLSdtqCz5JIA59Q/Aae8wyLNCTczNTEKLzq
         uMjRbYirq3tvuYi024YIkr6IGaN/vqLdAEwJM2Dgf1hLboDaEYM2w/pnib+yclY0+Cv3
         LiYporhSVmUCW92c3pjSk6cyWLJOBcvIBHaBjfBThI4e7THmxxwQ4nqhMOGLcCBa928+
         gjF7PJ+NKbdgCL9NlK1zAj5FcrARhWqQFfeppw2n/EGEqmw0tv9PPnm+HZwKP5srDeX5
         hrDV4mq3VNt8NQMOLmZFDBWK5rkSAgUWFEytGRAYKbtblGfH6aas8PHvN13u2TDWWtX9
         UD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pl9HSYgdiQZ88VBPFN10ZXvWILJUcjWus5G8A3/Q/fw=;
        b=KBB/qKi52nK5tSM4R9flq3cSZ0xhY0UVBkCOhaw0hIq3bN342AR88oAgDX9ZUiZl+j
         sM4cjgrU9ujX/y0TPXYJeLG27aMc7gORrIaSGRK2AbYBjfUuGlTbBmWnw0rmmfxPJN/F
         7adHN1COjsPcDj0td9EynYBqxJWNRY23hI+/7arHVC0dYEs7p4kdnFtv4q3V9bgsl1Mr
         fwXso06XxRKpSGmpRxPNsWtSwSKReTq/Hnh45RA4ZXHtEcv4t6R7WBhSg0knAFEqXLW9
         Sjlm8VEpvLdVa/e/AcwE70SyIAX+PlnE9DZe9Vy8PKogAJ+iuMb0VrVbBfKgI8uGGbIQ
         2ruQ==
X-Gm-Message-State: AOUpUlEQlIL19Lk4di+g87qtRbWoJIti+xoN6db45mEIWkKFkEy0+69j
        2dqDx6dZb6D4v6FeIlfNkcrcuH4SJOs=
X-Google-Smtp-Source: AAOMgpe9FQIfXCn3CSDRWHSC9i2FYYPmJlkho3m2/+oqwJ84iQXO3c7lKGlA9LTR5w7UnTDaNbF2Lg==
X-Received: by 2002:adf:ad45:: with SMTP id p63-v6mr14344716wrc.222.1532898510029;
        Sun, 29 Jul 2018 14:08:30 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:29 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 06/15] staging:rtl8192u: Remove typedef of cmpk_set_cfg_t - Style
Date:   Sun, 29 Jul 2018 22:07:38 +0100
Message-Id: <20180729210747.10803-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef from cmpk_set_cfg_t, leaving the structure as
struct cmd_pkt_set_configuration. This change clears the checkpatch
issue with defining new types. The change is purely a coding
style change which should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 2 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index c71fda0f13b2..d2293a335ed1 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -288,7 +288,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
  */
 static void cmpk_handle_query_config_rx(struct net_device *dev, u8 *pmsg)
 {
-	cmpk_query_cfg_t	rx_query_cfg;
+	struct cmpk_query_cfg	rx_query_cfg;
 
 	/* 1. Extract TX feedback info from RFD to temp structure buffer. */
 	/* It seems that FW use big endian(MIPS) and DRV use little endian in
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index d2590b00fe98..be45cd609d67 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -3,7 +3,7 @@
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmd_pkt_tx_feedback)	/* 20 */
-#define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
+#define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(struct cmd_pkt_set_configuration)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
 #define		CMPK_TX_RAHIS_SIZE		sizeof(cmpk_tx_rahis_t)
 
@@ -63,7 +63,7 @@ struct cmd_pkt_interrupt_status {
 };
 
 /* 3. TX side: Set configuration packet. */
-typedef struct tag_cmd_pkt_set_configuration {
+struct cmd_pkt_set_configuration {
 	u8	element_id;			/* Command packet type. */
 	u8	length;				/* Command packet length. */
 	u16	reserve1;
@@ -78,12 +78,12 @@ typedef struct tag_cmd_pkt_set_configuration {
 	u8	cfg_offset;
 	u32	value;
 	u32	mask;
-} cmpk_set_cfg_t;
+};
 
 /* 4. Both side : TX/RX query configuration packet. The query structure is the
  *    same as set configuration.
  */
-#define		cmpk_query_cfg_t	cmpk_set_cfg_t
+#define		cmpk_query_cfg	cmd_pkt_set_configuration
 
 /* 5. Multi packet feedback status. */
 typedef struct tag_tx_stats_feedback {
-- 
2.18.0

