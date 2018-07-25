Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA75C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B4F20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjuEs/O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B4F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeGYXas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33922 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbeGYXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id h1-v6so30973eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ykItW3hzq3ZAs5qgmAKDrRMEW0hvUueHSBEFR16f1ao=;
        b=UjuEs/O4CVv65gEzbrm9m4nJCNOn5mq1MHEtTapEa5Ls4dqR6jndvKyEclmarCHBk8
         4X1Nzp26lmusOzT80mGfnJKNZxbX5fPkd6O6RvxppYyvZVgw/2nDIciczRlmb0FZGLRO
         vUbH7CNbMWfcTSQDk6nlY12jgFgEQ+55c7w/Fav+IhWwmlJvKiUOSAPHy4AUkdlmz/+a
         PU+6YZXpb+ut0RetTU9sbQJSXI29Vd7NY6j/AT73rqwFhSgStXPuNKeeOIRBcBg2h9pl
         w+r2FO/AAHTyF7ZHPljJAeglQJhRVwZ60Fg68aN59t74M8cJBoNTn+kIPAl8pgyLWfrU
         YtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ykItW3hzq3ZAs5qgmAKDrRMEW0hvUueHSBEFR16f1ao=;
        b=bEG+1CKWQl3m4vjtYsReBno1jZ3rwLOFG29LN2NvVZuBCA69Sehb2K+jHpGN/GG32u
         fUnyuzEYPuwk2ILGdyQOwA7zSD/fKvWJgK0ZaaRFpCE5mCzmPDdvV/xGiYPavSjRnAyJ
         6BmtHLl5V/yoNxKslAbIpoyl3b/aiZN/FShtUhHoABGY/QzcfUEhEPYFVKhUHuH4pjQs
         Kh2cTCmxDrF20Y7bk/0eVjhmYN05v+3WRDOE92ftAdhQeKAr+yTBounA1KdtVMqwnTtB
         k0w+rWpWTg7URlFvvp0KoUjZOj59bTRoD0b0Pmg/zzAY27u8cqmNUAqyt8p8YusV+2pc
         MGGw==
X-Gm-Message-State: AOUpUlGm38388vSZdxLRXCYYH5ieo8XFZJN/B/J9KvsraBHji9VGWLIW
        t6+0N3oaPAF8lGGgG0JDazJvGxmg
X-Google-Smtp-Source: AAOMgpd2BFeHhWp00EtiVyHsD0mOGClEYj46V4Ntd/8/WIsRsR5YPqnyIJK2dGGvYq/sU5tbhN7CwQ==
X-Received: by 2002:a50:9084:: with SMTP id c4-v6mr25152461eda.179.1532557023653;
        Wed, 25 Jul 2018 15:17:03 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:17:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/10] staging:rtl8192u: Rename ISR_BcnTimerIntr - Style
Date:   Wed, 25 Jul 2018 23:16:26 +0100
Message-Id: <20180725221630.28595-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bit definition ISR_BcnTimerIntr to ISR_BCN_TIMER_INTR. This
change clears the checkpatch issue with CamelCase naming. The change is
purely a style change and should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 2 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index ef777fd4b99d..44709068128c 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -257,7 +257,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 			priv->stats.txbeaconerr++;
 		}
 
-		if (rx_intr_status.interrupt_status & ISR_BcnTimerIntr)
+		if (rx_intr_status.interrupt_status & ISR_BCN_TIMER_INTR)
 			cmdpkt_beacontimerinterrupt_819xusb(dev);
 	}
 
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 4a0a1c24eb34..e9e0548ce96e 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -10,7 +10,7 @@
 /* 2008/05/08 amy For USB constant. */
 #define ISR_TX_BCN_OK		BIT(27)		/* Transmit Beacon OK */
 #define ISR_TX_BCN_ERR		BIT(26)		/* Transmit Beacon Error */
-#define ISR_BcnTimerIntr	BIT(13)		/* Beacon Timer Interrupt */
+#define ISR_BCN_TIMER_INTR	BIT(13)		/* Beacon Timer Interrupt */
 
 
 /* Define element ID of command packet. */
-- 
2.18.0

