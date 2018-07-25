Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708DAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2709C20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZZAQHvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2709C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGYXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44684 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbeGYXax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so13510edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=devW3vBVqXX6Ei50pqInz/QS9cfQOYko6kuu5tGBnOo=;
        b=tZZAQHvPfzlPNgxG6tPEEb+NvVGDC27oUv7MAf6+RpdJgNfmXmlCyeHgEhhf7rzg49
         NhWiA5ZzS+LSa+xsiN2TT3CRowtA24N6g7iLKlC1PP1VA8/lkNyUIN98yW10Z9AtUC8j
         8Eu/Ah1ocZZXQRuLGROxwLfQoEuhsPnQ86KWcpYhbFWbiwyNt31QPs+cmuYWP8bu7XG4
         h8RBP5S/dh0S4hzS05n4cmNCmflUUztmpweMmWGjd+hvIjNtT0IdpkhYEwS3QhZwczdQ
         HTP79+yp/ec+OBT3v+OUfVaIJxn6A74ST/CuU8BclhFOFrha9932B/AQxEF3ZF80RvoB
         N8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=devW3vBVqXX6Ei50pqInz/QS9cfQOYko6kuu5tGBnOo=;
        b=F+VFJGSt37MT1gk1Nc1y22J5zz+ubeGjvhBLF4cBfacpJoYYIdcX9etQkS88l3XxaO
         uXHTK3dPpMj21x+lvqsY2caTyC0wTaJP0Q1AVhLcBD5Y3Uk1Ld3WIKZsKKlB/u20d7SU
         RJxQ0dWCPu82jnQhMKpK9TCIcKXfOrFBJAgw86FMHuhTRJrcOGU6O5FoUb9NzMrJ2WFA
         OuSbm1mk4ABSwvc3nDQsDDzzRYxQ/W+UllTyWBVKi7Vflt/uZVOGj6IUBleys/V+sfvz
         fYFyh6vHEfIQXYyzhsy+jYQeKbjSr7SYLCH8zMOwDPu+j+M6Dpe8htTZk+Ezh5ylGMyo
         abmA==
X-Gm-Message-State: AOUpUlEcR26OEIlEvxGxRmaKWGrm1T+4+11sjW5lcBo7aVtzmtcIaupw
        LZSW37pblTSvbg5cq56G+1kndMmI
X-Google-Smtp-Source: AAOMgpeXFrdXN1qQ+iAzwcjgKN9vBjReBgdEVTU5dC6VC5hffwkZ6f32VAal2jHuhjWC2g7cBjsrog==
X-Received: by 2002:a50:c19a:: with SMTP id m26-v6mr24068169edf.151.1532557028785;
        Wed, 25 Jul 2018 15:17:08 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:17:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/10] staging:rtl8192u: Remove typedef of struct cmpk_intr_sta_t - Style
Date:   Wed, 25 Jul 2018 23:16:29 +0100
Message-Id: <20180725221630.28595-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef of struct cmpk_intr_sta_t. This clears the checkpatch
issue with creating new types in code. The change is purely a coding
style change and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 44709068128c..1f33353bc135 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -225,7 +225,7 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct net_device *dev)
  */
 static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 {
-	cmpk_intr_sta_t		rx_intr_status;	/* */
+	struct cmpk_intr_sta_t		rx_intr_status;	/* */
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	DMESG("---> cmpk_Handle_Interrupt_Status()\n");
@@ -236,7 +236,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 	 * endian type before copy the message copy.
 	 */
 	rx_intr_status.length = pmsg[1];
-	if (rx_intr_status.length != (sizeof(cmpk_intr_sta_t) - 2)) {
+	if (rx_intr_status.length != (sizeof(struct cmpk_intr_sta_t) - 2)) {
 		DMESG("cmpk_Handle_Interrupt_Status: wrong length!\n");
 		return;
 	}
@@ -528,7 +528,7 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 
 		case RX_INTERRUPT_STATUS:
 			cmpk_handle_interrupt_status(dev, pcmd_buff);
-			cmd_length = sizeof(cmpk_intr_sta_t);
+			cmd_length = sizeof(struct cmpk_intr_sta_t);
 			break;
 
 		case BOTH_QUERY_CONFIG:
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 40edf96451e3..7854530f4745 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -55,12 +55,12 @@ struct cmpk_txfb_t {
 /* 2. RX side: Interrupt status packet. It includes Beacon State,
  * Beacon Timer Interrupt and other useful information in MAC ISR Reg.
  */
-typedef struct tag_cmd_pkt_interrupt_status {
+struct cmpk_intr_sta_t {
 	u8	element_id;			/* Command packet type. */
 	u8	length;				/* Command packet length. */
 	u16	reserve;
 	u32	interrupt_status;		/* Interrupt Status. */
-} cmpk_intr_sta_t;
+};
 
 /* 3. TX side: Set configuration packet. */
 typedef struct tag_cmd_pkt_set_configuration {
-- 
2.18.0

