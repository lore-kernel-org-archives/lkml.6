Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A869C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5177621581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwwRIWmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5177621581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeHTQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:20:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41335 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeHTQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:20:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id v22-v6so10840284lfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xfcQGYQBphhbtmAEqjD6gaA64mislqgTZk4XZ7mkbcE=;
        b=jwwRIWmo5p308CPdoOS+DxwxmbCrde+vIxsBPV/0uukMgqQPzA3KzM/IV1tiQAu8N/
         u4+Nv3u/Mv5j+0J1lFXCkIGMNpZvUorwWuSoCNaLN0x/t47eOoM3Pu2n8he+KUuqhSep
         CShGRsX+g90QeK4lQnsRGrZhVbAahYbl5uW4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xfcQGYQBphhbtmAEqjD6gaA64mislqgTZk4XZ7mkbcE=;
        b=JJzWS7qfcRALtulgZL87gN3Pkszh6YPIx6l+jYNP/iKyDecw5zTZ+cjs0blBMOlJvj
         dji2WwEhv5LthqNP55PKGBTHND2JsG64fK+frjNv5Au20LNtjXqDtB5zDSWjMviLjCyP
         JvHtU7Nf9WKIR8DRiF8KLoZNNIridTdxTvf+/1hn9Wrk0qcPbfs3pdAG/I6JP8x4l33v
         pT2xB5Q3HdBqxgHfdtSBFiNkf/hF9zm5emsq5gPq2VfYKiiv5LFeb5U73JGSDItLfOME
         N8qUly4ng3FjUDXyGvDnuqkFEu2fObsLbQBGlgmPmJpSLLrkqweqUEZKXwLl2UffZMFG
         WUcQ==
X-Gm-Message-State: AOUpUlEUqMXkk5UZwHXFYjBxQaLcUwS2ArkgAfHUQJpGyAFL+7AVqVIg
        adcMxghqY25zcM6QENaxseqS/g==
X-Google-Smtp-Source: AA+uWPwJl49/kEAftkdBylCAKL6oeFOPwPeRimXbOpTIa4mXnRckBliYfeZjRt1RHLz8lJHWyJLjaw==
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr28680039lfi.126.1534770299211;
        Mon, 20 Aug 2018 06:04:59 -0700 (PDT)
Received: from localhost (host-176-38-103-11.la.net.ua. [176.38.103.11])
        by smtp.gmail.com with ESMTPSA id g133-v6sm1749443lfg.81.2018.08.20.06.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 06:04:58 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, tianshuliang@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 cap
Date:   Mon, 20 Aug 2018 16:04:57 +0300
Message-Id: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable access to the RPMB on the on-board eMMC of the
Poplar board.

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---

v2:
- as there are three dwmmc blocks integrated on Hi3798CV200 SoC with
identical CMD23 support, provide MMC_CAP_CMD23 capability instead of 0 for 
the third block also.

 drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index f9b333f..bc51cef 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -23,6 +23,12 @@ struct hi3798cv200_priv {
 	struct clk *drive_clk;
 };
 
+static unsigned long dw_mci_hi3798cv200_caps[] = {
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23
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

