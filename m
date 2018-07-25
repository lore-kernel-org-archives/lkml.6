Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA7DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE720673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMV3kH/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACE720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbeGYXaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35958 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbeGYXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id k15-v6so28482edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+D1/LWgltXse19FfncCVMpwiR7LIyNjrHRDdon8VIzs=;
        b=rMV3kH/j2Jl0qRyMXvktJScbSyXiCuS8XLubqUUk7hJ3YurvYo8kHwCfnSs/Kr0WFF
         encNXuoOZmQAfErbrenAyrSaHrqIvTscnfcCvhnjnKn1QMdMjlOiJJMLcb2PoGI8mQal
         SaYjONrnhrILuRbPzkzqgwfLOpPAClQmV3jkb2cN6iBOu8waqTlr0jlu3OM+/dA2wZrI
         kX6KQ0gXZNgzZQopQUQApQvGGPHcwLhVNpMv9L2ms9u4b7sEculrAQdVJsxinJg7xpAC
         PZWbRyryI2FUbYxkdOIV2hRZWk11BMxUyoi4lk7Qd9qbO3bDNNPdCkUoaI3ukXPvekyF
         iQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+D1/LWgltXse19FfncCVMpwiR7LIyNjrHRDdon8VIzs=;
        b=Mip7PBqLfnS00b25VQstmfKteVWKsAIc6luKtF/jL+ri3mALvnWzLwbIdKpqoIpErR
         WPlyHxPGikXum0QXa1uc69XbEs/qNLElqP2xNQm4KnEdNYQM5bcNK409YKwdAbf25jqT
         whVDJcjLlca9hNGBItbMRFOa3TIwPmpQDEyMSMrb13/CbRtEHrWDyCEPJQ54E3fc/DX8
         OXfMIbA6R3OjOc70G8mipAxA63xnP++LqDJvPxV2FL1Tjg+n6KXeuZXw+6MQW5h/s59q
         A3J/Z66vtGaQukyGBat95A9s0Y2SRLCLLIwMI5nsmIIhpMppXthic9bfGR6gBv7rRiC/
         GKDw==
X-Gm-Message-State: AOUpUlEp8fy7IBei27BG3BpqAXl1tU2iopxxdBRror3LMawJIheGpqKN
        XyJEsN82PAhqUpEDbgLCZd8Cqonr
X-Google-Smtp-Source: AAOMgpdbO1r5YMEmADYQPMyCwa/s0xOQmNRF/im9FN4JddZ+Q9R+lbiAbiSMXyd58eQ5dwg6yCD/FQ==
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr23931661edl.265.1532557030635;
        Wed, 25 Jul 2018 15:17:10 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:17:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/10] staging:rtl8192u: Remove typedef from struct cmpk_set_cfg_t - Style
Date:   Wed, 25 Jul 2018 23:16:30 +0100
Message-Id: <20180725221630.28595-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef from struct cmpk_set_cfg_t. This change clears the
checkpatch issue with defining new types. The change is purely a coding
style change which should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 2 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index 1f33353bc135..490ee399169b 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -288,7 +288,7 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
  */
 static void cmpk_handle_query_config_rx(struct net_device *dev, u8 *pmsg)
 {
-	cmpk_query_cfg_t	rx_query_cfg;
+	struct cmpk_query_cfg_t	rx_query_cfg;
 
 	/* 1. Extract TX feedback info from RFD to temp structure buffer. */
 	/* It seems that FW use big endian(MIPS) and DRV use little endian in
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 7854530f4745..17d28244cb36 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -3,7 +3,7 @@
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmpk_txfb_t)	/* 20 */
-#define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
+#define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(struct cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
 #define		CMPK_TX_RAHIS_SIZE		sizeof(cmpk_tx_rahis_t)
 
@@ -63,7 +63,7 @@ struct cmpk_intr_sta_t {
 };
 
 /* 3. TX side: Set configuration packet. */
-typedef struct tag_cmd_pkt_set_configuration {
+struct cmpk_set_cfg_t {
 	u8	element_id;			/* Command packet type. */
 	u8	length;				/* Command packet length. */
 	u16	reserve1;
@@ -78,7 +78,7 @@ typedef struct tag_cmd_pkt_set_configuration {
 	u8	cfg_offset;
 	u32	value;
 	u32	mask;
-} cmpk_set_cfg_t;
+};
 
 /* 4. Both side : TX/RX query configuration packet. The query structure is the
  *    same as set configuration.
-- 
2.18.0

