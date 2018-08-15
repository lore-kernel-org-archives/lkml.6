Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3214B215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXFpTRGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3214B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeHOObh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:31:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43919 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHOObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:31:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so856580wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bttAIsX+4Dj1kpqGyBCqDZLfnZ3uy0iRTOTVcj82q+4=;
        b=PXFpTRGuxjpn2SFiTBOnsuORQz6vZyNT2Rdmiev+kEYlNDanyPoyYG6UU3Wd4p4oD7
         Mt3agNtp+zh8+a3URejpMbSnQNqowZ6jJUHCD9aadtRZw5zc0DnhFb/AArmeykXNNgpS
         Z67vgS4nWFyCTc/SuaGc+B0na2Uw3TCxRa1BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bttAIsX+4Dj1kpqGyBCqDZLfnZ3uy0iRTOTVcj82q+4=;
        b=MF4J16uivw5F8dxHyc2gzows0JeMm7YPiz+crAuq0f4lp3Qn1AHoakWx47afVpssNN
         lnCg8WmZ2flKqvmAvEpmdbi4i6XkVpc9h1A0mMr68WascokWIjVgXnMUR/GQnVy9s1P3
         78awLgThDbadj9RDgDHIwDtJvpxbwZJPe2eDol9L1vBlbMhrtipxcyCBGne67KBhqNi+
         5dOJPpe7ToBrbQChzXIzIf2Oo95T/USSwrvB3y3T7f42Ytmmt8PkcOE2tDnWwNA/WYf4
         0pUKdVWNhLnPHMK7mVFLxetvUJmFy78b1hpBiyhKTM3Cs25ts0DS/uNUsSYvEMu3ueyr
         +B7w==
X-Gm-Message-State: AOUpUlFSM99q7NwCJLOsNuEJnWVL0QUnFX8l9/mxxskSWAn7g3t5Zt2L
        nwOAyLlMhe5MTsRWBdcttd+L7Q==
X-Google-Smtp-Source: AA+uWPx0oINOt+Q5ySpEdQ2SBg7H1TYX24+R5NrcQ1PSisiQfLugRxTXm78+3tdQ7mlxYhso6B12ug==
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr16908076wru.50.1534333185824;
        Wed, 15 Aug 2018 04:39:45 -0700 (PDT)
Received: from localhost (host-176-38-103-11.la.net.ua. [176.38.103.11])
        by smtp.gmail.com with ESMTPSA id c129-v6sm3040438wmh.2.2018.08.15.04.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 04:39:45 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, tianshuliang@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 capability
Date:   Wed, 15 Aug 2018 14:39:44 +0300
Message-Id: <1534333184-25599-1-git-send-email-igor.opaniuk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable access to the RPMB on the on-board eMMC of the
Poplar board.

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index f9b333f..7a023f0 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -23,6 +23,12 @@ struct hi3798cv200_priv {
 	struct clk *drive_clk;
 };
 
+static unsigned long dw_mci_hi3798cv200_caps[] = {
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	0
+};
+
 static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct hi3798cv200_priv *priv = host->priv;
@@ -160,6 +166,8 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
 }
 
 static const struct dw_mci_drv_data hi3798cv200_data = {
+	.caps = dw_mci_hi3798cv200_caps,
+	.num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
 	.init = dw_mci_hi3798cv200_init,
 	.set_ios = dw_mci_hi3798cv200_set_ios,
 	.execute_tuning = dw_mci_hi3798cv200_execute_tuning,
-- 
2.7.4

