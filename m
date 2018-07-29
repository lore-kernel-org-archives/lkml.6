Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B8B113C627
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BBD20892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFRX8bEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BBD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeG2U02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33769 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2U02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so10393180wrp.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cJc7raYZKv0/c7u+3muWGJF0dUl6AOxIrUUw1oI0sag=;
        b=KFRX8bEpMqZITNSu6q9t1a9P9Y4nN7zYM8/+4squjUugGkkjoigJpTVJIYpZUUq1Ut
         m1vQrgAswaT9ftDo+r/vOlaqA2NqWisbQ01IHCaPz44Xqdfn72TteTb4X4Cgydr0aVVj
         QeHyTQruo1UqQLOwO027FxCVvc9DVbpky9l10weLAX+r1VZCWQUPV8g0b45HxCxHIffr
         iUgxXCAQra4SekH4/MXEq/irPGtO2THw8Td0ONVGN4xbWH5mOnI+UaLCj7FeuToaYlga
         w5A3xGeS5yVUc4LZYYax+h0smycinKwT1njOQuU8ebCkwBVJ9EF5vdPaC94UyAoO/ZjG
         5XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cJc7raYZKv0/c7u+3muWGJF0dUl6AOxIrUUw1oI0sag=;
        b=gvE5sQu9ih3lZaaOeOQ07s4XtD+qZ41wDRzXozOqWIrdz3ekB6lxES1LIC05xDl6sK
         /PepY8MXlI0KE3amb4HJnrIMs5tM/043sBVX3IykNH75Z4Oc3PvctVX95tgpgBkDYaAp
         v2H/5d4funSqjoUZsahXO0QvrRmsMWRDJUW447E1Hj8sd4FMdQBqbhNdgn+8KoG0ruAv
         P5ze4iV/9hY5DQg4rySLAQrURAYmBPbRG+0vE1Gr+qC4IcwLKwsANvtONMLJqpZ2WneG
         lger9vLiz3s8xR/zJmXKtJ5/ppHQWFDrGZJMcKxMC578/vH9CvpFHh+SZwAwIOTvdU/s
         feHg==
X-Gm-Message-State: AOUpUlG04P2mtywlDUsI9XHhOR4jo6TfLJsOeXc0QRtx83JBxOC5F70V
        jqxBlgBgCCyE8NepSx4M9lU=
X-Google-Smtp-Source: AAOMgpf0BTqBKKXhxGuTtC91y0+SzNFnx2M6FWHA1rfekD7/qbPU1LoGXWL9Rd6hJZzklRokRxFHsQ==
X-Received: by 2002:adf:b60a:: with SMTP id f10-v6mr13661571wre.54.1532890503444;
        Sun, 29 Jul 2018 11:55:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/7] staging: rtl8188eu: remove unused dump_txrpt_ccx_88e()
Date:   Sun, 29 Jul 2018 20:54:41 +0200
Message-Id: <20180729185447.19903-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dump_txrpt_ccx_88e() is nerver used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: removed last patch (8/8) from the series

 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c | 22 -------------------
 .../staging/rtl8188eu/include/rtl8188e_xmit.h |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
index 6883746f3b8b..9b8a284544ac 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
@@ -10,28 +10,6 @@
 #include <drv_types.h>
 #include <rtl8188e_hal.h>
 
-void dump_txrpt_ccx_88e(void *buf)
-{
-	struct txrpt_ccx_88e *txrpt_ccx = buf;
-
-	DBG_88E("%s:\n"
-		"tag1:%u, pkt_num:%u, txdma_underflow:%u, int_bt:%u, int_tri:%u, int_ccx:%u\n"
-		"mac_id:%u, pkt_ok:%u, bmc:%u\n"
-		"retry_cnt:%u, lifetime_over:%u, retry_over:%u\n"
-		"ccx_qtime:%u\n"
-		"final_data_rate:0x%02x\n"
-		"qsel:%u, sw:0x%03x\n",
-		__func__, txrpt_ccx->tag1, txrpt_ccx->pkt_num,
-		txrpt_ccx->txdma_underflow, txrpt_ccx->int_bt,
-		txrpt_ccx->int_tri, txrpt_ccx->int_ccx,
-		txrpt_ccx->mac_id, txrpt_ccx->pkt_ok, txrpt_ccx->bmc,
-		txrpt_ccx->retry_cnt, txrpt_ccx->lifetime_over,
-		txrpt_ccx->retry_over, txrpt_ccx_qtime_88e(txrpt_ccx),
-		txrpt_ccx->final_data_rate, txrpt_ccx->qsel,
-		txrpt_ccx_sw_88e(txrpt_ccx)
-	);
-}
-
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
 {
 	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
index 17e7b3016674..20d35480dab8 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
@@ -152,7 +152,6 @@ void rtl8188eu_xmit_tasklet(void *priv);
 s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
 				 struct xmit_priv *pxmitpriv);
 
-void dump_txrpt_ccx_88e(void *buf);
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
 
 void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
-- 
2.18.0

