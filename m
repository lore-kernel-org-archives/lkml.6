Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813DECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF1720673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR7GV8J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF1720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbeGYXap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38575 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbeGYXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so23843edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yXlLcG4b2Fx2i5YYOY0cl5zvfhMYtDOV0U+P/ijeMBo=;
        b=KR7GV8J+p8eLMOnqGPchD8qYEJ3dl17/+/FQCDqVp21V41hVBj0rVRo2sE2wTF1u0j
         H8m7ktw1pOUylJLaNp9DpOnR1/zBfE/E0O9iqd8kEBuF0lBE+wBQNwaDeuIZddT+73Q6
         iP8yxCu/3tEoKE3H3Plea58rQXBQ8o0JL1AS45T49AbPzBsIM1aZ+v8rZ3pFLMmZxnxZ
         +cjIhMR8RrC6MsJSzMHBK2JceVhxgkMJptvD1PsxPcHPJx9IKjfLDTBiGSY8Uvv9UeHg
         VnCgxQfFehpfDyoQPRodAWQ9Kan8Xv9kA1rV/3STsHrem4t+30cbp2OGEmKaKptiDCH3
         kW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yXlLcG4b2Fx2i5YYOY0cl5zvfhMYtDOV0U+P/ijeMBo=;
        b=gFAs+DQPMUVXF1rhjMaqWWAUaHW0k4q2Ay2mlq1GhkA1vpQVMVND/culysbb2SVzyQ
         QQQE0XiwpyPRoPnQiwdUc2K5/KiJ+STSPz8Bcel6Z6VH/d0F15wlW+p/jgcPYD39PVA9
         yLLcEZD5mKcVvczvTwdbmcb5VVielcg0icm3LVrH0aXMSk4pSoKtyH4o46B3huVA6TTz
         e5YWPwm2Nx7cc7VCiA0T2DXfaNgANJ6EXJn/jdo4bewnpHfgnu/F8Q3WXl37X3HFu2VL
         AWADhcfDz8o/hBIyciVOVmVf8/VOgmTyfkA6aNZ8jwXCcVkeH7lrRH9Gp5EqqQVmQ60Y
         uCqA==
X-Gm-Message-State: AOUpUlFbT78JRko13EAOVxQ41i9C4LaMBWOgYVJohLzJaAJh10febRhf
        yhKH2yS2fo6sBREJdFTGv5SyqzMV
X-Google-Smtp-Source: AAOMgpfs9Cuy9wDkfsKs2VLlTJaId+8F9O6V+egpjco1KElczIDZz615ir5eNW9CC6jNJv1CQ+B5ug==
X-Received: by 2002:a50:8f84:: with SMTP id y4-v6mr25564586edy.71.1532557020350;
        Wed, 25 Jul 2018 15:17:00 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:16:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/10] staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
Date:   Wed, 25 Jul 2018 23:16:24 +0100
Message-Id: <20180725221630.28595-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused macro definition CMPK_RX_DBG_MSG_SIZE. This is a
coding style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 198bbcf3ba30..eb73b6a6d324 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -5,7 +5,6 @@
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmpk_txfb_t)	/* 20 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
-#define		CMPK_RX_DBG_MSG_SIZE		sizeof(cmpk_rx_dbginfo_t)
 #define		CMPK_TX_RAHIS_SIZE		sizeof(cmpk_tx_rahis_t)
 
 /* 2008/05/08 amy For USB constant. */
-- 
2.18.0

