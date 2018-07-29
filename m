Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC4CC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF59720857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8mBOqfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF59720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeG2SkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40484 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeG2SkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so11060477wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7/W48QyIR6XHID4Vjb2pO/vmCmxJiftq4xnfc/WBzHM=;
        b=W8mBOqfmUKGk+6ZSa8gk6VdZ0J++4xUZdk3XU1Z2+W61DIAt3l9bpE6L5oU4sTrXZV
         Cy715HBhBzitm2t7MBdRPgZNmpPBC/Y4Zw0VwE8ftxU3Boyeyy40su/NkeSZ3HdVqh67
         WmjgYFUpifAQS82Jsd9zX2EwrLXudAzbQT9OAy41OqMEX7ZivpTq4GgJFRHX+LtmHNL/
         pNxqhk6RcZ57snkkYg+74D6GxeKr23ALMHDvAtUr0LTaAvL9j2TMOfi5T8897/vaXMqv
         eg8HUx7DNXfBsZ4Nx9azaZhmcwHwRd3iluJlmJto/VC0UEsXrnGt3ecZILmZe520Ysur
         ZxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/W48QyIR6XHID4Vjb2pO/vmCmxJiftq4xnfc/WBzHM=;
        b=uWaxY4RARrSyAoREQ/8GPoY7Fh8b+MpvH6MgsImh2amlnmdqH3UIkMauTkUfFSuI/Z
         yLiLANtX+4c24VfdRMFtz5jftpZPmL1IsqXD9nBaFK80HvM4MfGhCXc1w6s1zmer4V49
         hXrD/wh0xVkwyXt4qd8+fv8ha5ZpZNGwW6WS1l3XosxJSel8rQLghNPXidlePR+T7lcF
         D/cFfiaT7SBPXtkJrJON+o6cJI/xC39U3vx8Jr2ad/W1gds5GjcdM6XdJnfmCGAzgit/
         TXKlXmzdmP5H2YQC0rKzX5GkyaNZuQgW0QiJBnHlfpD8u01d8KGvp20EtVeh2LCb5zAn
         5khg==
X-Gm-Message-State: AOUpUlGLD1c68F5Nj4czjrjm387dZAZ8IPdrjlK39anzl5/BzbDyNP6n
        8WkhZPqI7MkcbadYHN09WkA=
X-Google-Smtp-Source: AAOMgpcZyhAyS3tTNxtGqhju1/sDf2lqfmMEfau/g9tOdKXV4KYEPT7kU4tmBG1HG0JNHAHXKIETZg==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr12211849wmp.129.1532884155187;
        Sun, 29 Jul 2018 10:09:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: rtl8188eu: remove unused dump_txrpt_ccx_88e()
Date:   Sun, 29 Jul 2018 19:08:44 +0200
Message-Id: <20180729170851.2581-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dump_txrpt_ccx_88e() is nerver used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
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

