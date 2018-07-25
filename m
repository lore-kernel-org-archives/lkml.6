Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D26C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA9920882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjEDnhKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA9920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbeGYXao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33091 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbeGYXan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so31466edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HKmww9RZAqS7RCIsNTMGNaz6L2k7G4FxD8rhu5lfJGA=;
        b=bjEDnhKGwcmA1L4P4j0ComDpt2eZ75VxK7LSeMURcb2MFRcMeTxgHuEvt1GpCFUQWG
         LSKkLon777lycWOz+wZoQhg/zA83iz699TjObNBPPUWuw9hWjXIoseHci7eFPmvqrYGA
         c5MS8vOlz5srphpeGT8SemuGuNkMmw8RaFDfddv6C6TdU/b8n7Yk34fmx404shIbfS8Z
         ufEkeF/83DpkPXsyZ1lhHxDQlEEJuolEm62CpKNRtqhXiTAH7m1xSG8pHh7bA+Gk5XeJ
         cYDJaM56gka/XnQz1MTV3VqUGXL0Hoki2VXpYbFGH4Ix9iAjl1Km/3G5N6+z4sBSVRQU
         apvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HKmww9RZAqS7RCIsNTMGNaz6L2k7G4FxD8rhu5lfJGA=;
        b=bgBLCwSlkDlaV/Q8v+l/sZheiBCuAJDxeMBlcbyOIc3uTPpBiGDB/46/bJ765i4f6E
         OWrcg+OGdRGX0Z+gQVUzA6N+lQoNPDz8kJcTzKKxsduiUkjJQYpmdigFjrWBuUkBjnCZ
         +5ILwCZl2fPu65Zfo/Mcyv/y/4XzEYKPjpLKeOaRRRxTuVzp1EihEoO/ygHzjrnwT5di
         EDBFB7J2uNnl6MCZ14AEwyWSVd/CoXgXwiU5lGthE7kD4lNv5dqpzxqp48qMawxPeCC0
         4Ck1RMAYHfTQRAGiWWL2oUBkztqaRV3C4TXdpzdFBuk0wGkak/CslIfN/VxjYEVMzRLp
         5qJw==
X-Gm-Message-State: AOUpUlEX6VfSpNEXYOqCI66rUpB4ACZmHwb0nwRdC/Ix585bJepooWOB
        sX176P/8AGpdznPOZfe/OzooIBCL
X-Google-Smtp-Source: AAOMgpegKaTsd6RiyPmIz/2AXGCSEL89uuFXKo8b+AkYlXyL/nAS7wKvnomxyo3co73Ksp6i0jwQ2A==
X-Received: by 2002:a50:cc4d:: with SMTP id n13-v6mr24916128edi.171.1532557018735;
        Wed, 25 Jul 2018 15:16:58 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:16:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/10] staging:rtl8192u: Rename bit definition ISR_TxBcnOk - Style
Date:   Wed, 25 Jul 2018 23:16:23 +0100
Message-Id: <20180725221630.28595-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bit definition ISR_TxBcnOk to ISR_TX_BCN_OK. This change
clears the checkpatch issue with CamelCase naming. The change is a
coding style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 2 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 0e3fccd4a55c..96f705c85bb3 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -249,7 +249,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 		DMESG("interrupt status = 0x%x\n",
 		      rx_intr_status.interrupt_status);
 
-		if (rx_intr_status.interrupt_status & ISR_TxBcnOk) {
+		if (rx_intr_status.interrupt_status & ISR_TX_BCN_OK) {
 			priv->ieee80211->bibsscoordinator = true;
 			priv->stats.txbeaconokint++;
 		} else if (rx_intr_status.interrupt_status & ISR_TxBcnErr) {
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 095664a086e1..198bbcf3ba30 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -9,7 +9,7 @@
 #define		CMPK_TX_RAHIS_SIZE		sizeof(cmpk_tx_rahis_t)
 
 /* 2008/05/08 amy For USB constant. */
-#define ISR_TxBcnOk		BIT(27)		/* Transmit Beacon OK */
+#define ISR_TX_BCN_OK		BIT(27)		/* Transmit Beacon OK */
 #define ISR_TxBcnErr		BIT(26)		/* Transmit Beacon Error */
 #define ISR_BcnTimerIntr	BIT(13)		/* Beacon Timer Interrupt */
 
-- 
2.18.0

