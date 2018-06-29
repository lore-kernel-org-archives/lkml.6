Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7622EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3125027D44
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhETt8bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3125027D44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936647AbeF2OB6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:01:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41698 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeF2OB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:01:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so4278281pff.8;
        Fri, 29 Jun 2018 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CwwCqRFbHEyTqMqzFXWl2I8yfslqawjsUSw9GGxjSdc=;
        b=PhETt8bnLUePWB4sJrggreiv8AX2KpntpeWWvIn9D2hGGow8FzjDbtWbmp6iRN9/uZ
         bq967hdcoQVrpL4Bo9KGA6XKcQvcG1ZYXvaqQi9FYIgA6o3836y/ByRPVQZq/ASsWJyH
         Mn9zTeETdVH3C/PS8PQIruKZx6WFXxx1uD1NHa0yga2g2TZZIpXWjtIc4k51/v4xGiSC
         A5iEnnj2FScjeGGrUcQIOG8+/6UtpTOfbX7quTOH3XOwUOkbLRjuG18x/sC1oArqWmqW
         75nDwJqfK+YP9kOdHDDXxQbHpRUC7EtKp62gIar3OKMWdwIdhkBBDvAJ5yHoTV3rrTSP
         NVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CwwCqRFbHEyTqMqzFXWl2I8yfslqawjsUSw9GGxjSdc=;
        b=m3xecRqVRdoXjlz/zLZB9jNDCxmfwcTcT024dhOK57lH4Ye9LJPNxHZN+/jxhXsW1K
         l6qO2DVnlr3TnDaKhib6FcuP/sxfbsOPuq06JUY3NBtVYqnlvlDxmHqR1h5DVcxZZHFb
         nSdrdKDLCJw+B6YhSYWR02gBugxd26BidF9qGPajQtGG1PldpZWBDek8A3lyg33NrcHZ
         8+KxY0Ss73YcoD8ldehZMY2/89mtVtuj8EvCajICUCc6L9UnTwioH+gCGGkGdhAC3s5I
         5pq2iOkL3lvxjSgrWvBb6hovLULkrg+OiT80YJFpC4QqbloFuKIXZ5dIR0CQavYuOMGM
         vLuA==
X-Gm-Message-State: APt69E1VgZsgI95GGQeNiBARHYMfVTZHwcTKBUdw8FApqD+uF2ueL5qT
        PLaqrf8vXoO3qy1NL6LrLRk=
X-Google-Smtp-Source: AAOMgpfSXAdu+lVZnAG3K1MUKmfXpA9TzITeAmi2rnlLIHCrQbb/uFIgRvrc75IVGf8r5szUgM1T8A==
X-Received: by 2002:a62:ca99:: with SMTP id y25-v6mr14502171pfk.187.1530280914730;
        Fri, 29 Jun 2018 07:01:54 -0700 (PDT)
Received: from localhost.localdomain (outboundhk.mxmail.xiaomi.com. [207.226.244.123])
        by smtp.googlemail.com with ESMTPSA id k186-v6sm24705029pgk.94.2018.06.29.07.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 07:01:53 -0700 (PDT)
From:   "Huanlin.Ke" <chgokhl@gmail.com>
X-Google-Original-From: "Huanlin.Ke" <kehuanlin@pinecone.net>
Cc:     kehuanlin@pinecone.net, zhangbo_a <zhangbo_a@xiaomi.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org (open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO
        DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: dw_mmc: fix errors to use card read/write threshold for HS400 mode
Date:   Fri, 29 Jun 2018 21:59:29 +0800
Message-Id: <1530280769-14114-1-git-send-email-kehuanlin@pinecone.net>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The card write threshold is applicable for HS400 mode only, so it should
return back except HS400 timing mode.

The card read threshold is also required for HS400 mode as the host
controller incorrectly samples the data if the card clock stops within
a block transfer.

Signed-off-by: Huanlin.Ke <kehuanlin@pinecone.net>
Signed-off-by: zhangbo_a <zhangbo_a@xiaomi.com>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 623f4d2..d4e6983 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1065,7 +1065,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 	 * It's used when HS400 mode is enabled.
 	 */
 	if (data->flags & MMC_DATA_WRITE &&
-		!(host->timing != MMC_TIMING_MMC_HS400))
+		(host->timing != MMC_TIMING_MMC_HS400))
 		return;
 
 	if (data->flags & MMC_DATA_WRITE)
@@ -1074,6 +1074,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 		enable = SDMMC_CARD_RD_THR_EN;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
+	    host->timing != MMC_TIMING_MMC_HS400 &&
 	    host->timing != MMC_TIMING_UHS_SDR104)
 		goto disable;
 
-- 
2.7.4

