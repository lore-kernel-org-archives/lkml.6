Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991CAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5191720671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CftgWY45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5191720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeGYXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38982 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbeGYXaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so21187edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZEVvP9FvNLHPDljrPAv3+RjkEYIVdnzInedRsu7MxFI=;
        b=CftgWY45WNcz71LMqQ0ZW9fymXmDRASiJxLgksC+6qJBLvsXBIpjMEV8TgBbW4nxr0
         qwgTyFwlepJLWkhJmeD9Oh2jS/4qDCjj9UBr6bwmMRyEBZeR6cCIUoAMzWl0Z3vZcnr8
         7fzo8+frDrXmhKi+qmSTe7NQ003kGIfog0HSZYyeuu4bc3Txta5raMFg1tjs6CW4ZNdU
         hM9FEJYT1pqDu4EzH3vjn6IOGS5FwpdtKjq6GtGpVtGj2WkZi9dTFRUy8Melqb4S87sa
         LiPt6gQMBjuKdEenRADKQ26Spyn/wAAoaSLLhr8iJgI8/qBS2aWjWVsoLP/9xVZ4u8d5
         cZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZEVvP9FvNLHPDljrPAv3+RjkEYIVdnzInedRsu7MxFI=;
        b=gRontZqAU4NnXWNRytH68KJc7JWpqEfs5ECdmR6KiNsg4yfJtb1wR7KeK29rv4gw5+
         sEzNY0URNMGYMyIpVFldedZk+cA7y9a5wBjDQtCcQ9VWVvmT/iGp7xJvksjwlTNzj/0m
         Wd8PaEKui0EAZEr8Qbky3ASu/EfdNEenDs9h1fXB+BdVSZJp9xtUzbdPwBpIh8I4u0Gl
         G9gn95boqbvw4BgN7VH5bhHLsYWQmoSQ+6lrSXxl+qOyWZbyRzwMWhvmwck5H3AMlAzv
         FDEvfmGbPuRcLHZiG0CXqn8F5p605amUvAyuRwl3z1pzB0J9dNconG3AaZDhtJLu/diy
         8tVA==
X-Gm-Message-State: AOUpUlHB807lbRR6cE2ip+NOjxBjiHbmnNUo3EUNYduTDIi21L8qFXQc
        tp7Q3na35lnPOXozPmZBe9hi7v59
X-Google-Smtp-Source: AAOMgpfb3SEZeWEMwtZz/P5emT3R19gBvzNzLOt38jC7vIQjrvvouZclIUVfz4KTKWHtrgVBDGjnIg==
X-Received: by 2002:a50:c01d:: with SMTP id r29-v6mr13109908edb.202.1532557022006;
        Wed, 25 Jul 2018 15:17:02 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:17:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/10] staging:rtl8192u: Rename ISR_TxBcnErr bit definition - Style
Date:   Wed, 25 Jul 2018 23:16:25 +0100
Message-Id: <20180725221630.28595-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bit definition ISR_TxBcnErr to ISR_TX_BCN_ERR. This change
clears the checkpatch issue with CamelCase naming. The change is purely
a coding style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 2 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 96f705c85bb3..ef777fd4b99d 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -252,7 +252,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 		if (rx_intr_status.interrupt_status & ISR_TX_BCN_OK) {
 			priv->ieee80211->bibsscoordinator = true;
 			priv->stats.txbeaconokint++;
-		} else if (rx_intr_status.interrupt_status & ISR_TxBcnErr) {
+		} else if (rx_intr_status.interrupt_status & ISR_TX_BCN_ERR) {
 			priv->ieee80211->bibsscoordinator = false;
 			priv->stats.txbeaconerr++;
 		}
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index eb73b6a6d324..4a0a1c24eb34 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -9,7 +9,7 @@
 
 /* 2008/05/08 amy For USB constant. */
 #define ISR_TX_BCN_OK		BIT(27)		/* Transmit Beacon OK */
-#define ISR_TxBcnErr		BIT(26)		/* Transmit Beacon Error */
+#define ISR_TX_BCN_ERR		BIT(26)		/* Transmit Beacon Error */
 #define ISR_BcnTimerIntr	BIT(13)		/* Beacon Timer Interrupt */
 
 
-- 
2.18.0

