Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9320CA9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsbLqo9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C9320CA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbeGKT2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44157 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390199AbeGKT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id d17-v6so7924763eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Co0BXNQukNkvbnsHzB0g1f6+X4dZg1c4RYb3fO6ByPQ=;
        b=nsbLqo9expUkyBW2jvi8AYz1jjFI2HeTcZO+mYxVQkfbbMZoLhqLQqBsUWaIdCULpJ
         5Fbs5eRvcx48WsISetCTehLTR7CjYgUW3naF3Lt/GTUiXuknSeO12oKfwQAo0ULxjJbw
         7jWPaa+Z0fUNRtuq1NXbdJEmEmUxNYUNDsN+MLPZ7Wt0xNLISsg6w8w+thO1QIbHlhUO
         wEeoDMJVnPHzgZpoK0jnuNZtMHGixCwisbbz6V097EWIqYm+0faI2850wK101zECkgr7
         R/RYk+YY6rhhtU+4ECSSIW5A9QPtJXKp0bWBd0ThXSUtAVUKt4C7ddxbPesxL90FekXm
         y8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Co0BXNQukNkvbnsHzB0g1f6+X4dZg1c4RYb3fO6ByPQ=;
        b=WPtasSH+TQQEpUwJbWmJdhhJycFTkFrDRqdssCw9nfZceAvrA9oTHpH16RC8VaRv9z
         f5rBxKxVRKV2bKKJXYzfAocTshAn8m9vahvXAjeaYhXOiXb7v0mgAlqfjCpwmku7zpWV
         Y0FOV5GBWEPAskPzrRSULHo8OuxdSno9dtWqT6/z//QVjH/c7gEbzlhjpZcY4rbh/9+m
         Ul63IaREJwRR3MwxZMC1fRbvY63vzF7pPh8qYXx+L5G/5/Lz9JsnUyYANBMHbTc3aaQV
         vBAsrgzhM+nTWxSWroNyVaf1joNlDrfmReV7MdWCnQ3wsNsZlx6DdB64zffOIX16EUmo
         IA3A==
X-Gm-Message-State: APt69E2p7di1j3CPUJ0btTISGCMQItmS/H6u2Gz6Rk1LtQGCA8WJ13zB
        pPvIbnnwcMCR+o/T56ZfOhew0Uvk
X-Google-Smtp-Source: AAOMgpc9HQTKi1IUHQOufqPimd3+FLHUMwe8cSYSEE2XDxqutOxSg354dnzgbZ9dB028HaZ4wVm7bg==
X-Received: by 2002:a50:9aa4:: with SMTP id p33-v6mr33179415edb.218.1531336950171;
        Wed, 11 Jul 2018 12:22:30 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:29 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/10] staging:rtl8192u: typedef struct tx_desc_cmd_819x_usb remove typedef
Date:   Wed, 11 Jul 2018 20:21:44 +0100
Message-Id: <20180711192149.21621-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change structure tx_desc_cmd_819x_usb from being typedef to being a simple
structure, without the typedef.

checkpatch warns about defining new types in the code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 4 ++--
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 86cf3ef3a970..7dd99612620a 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -213,7 +213,7 @@ struct tx_desc_819x_usb {
 	u32	Reserved7;
 };
 
-typedef struct _tx_desc_cmd_819x_usb {
+struct tx_desc_cmd_819x_usb {
 	/* DWORD 0 */
 	u16	Reserved0;
 	u8	Reserved1;
@@ -238,7 +238,7 @@ typedef struct _tx_desc_cmd_819x_usb {
 	u32	Reserved6;
 	u32	Reserved7;
 	u32	Reserved8;
-} tx_desc_cmd_819x_usb, *ptx_desc_cmd_819x_usb;
+};
 
 typedef struct _tx_fwinfo_819x_usb {
 	/* DOWRD 0 */
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index a2a107521450..d7fa7ece62fb 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1242,7 +1242,7 @@ short rtl819xU_tx_cmd(struct net_device *dev, struct sk_buff *skb)
 	int			status;
 	struct urb		*tx_urb;
 	unsigned int		idx_pipe;
-	tx_desc_cmd_819x_usb *pdesc = (tx_desc_cmd_819x_usb *)skb->data;
+	struct tx_desc_cmd_819x_usb *pdesc = (struct tx_desc_cmd_819x_usb *)skb->data;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
 
-- 
2.18.0

