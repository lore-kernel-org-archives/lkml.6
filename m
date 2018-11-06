Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8112083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OD7STvaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8112083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeKFOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35838 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeKFOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so5586349plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xaTIHnBx9nGQAitv4LjbDYDAae72H66pyrlVCxGapGA=;
        b=OD7STvaUmtrdPHiMWg49khmosV/1hvflHbWtgWyIxGGCqOwOHR1FSvwprNlyUMw6Bd
         5OMEUF2TO2vnT7/M2EyN+70WILkz+aginHyCei29mSHSxoq/G2vpdJHfPgTGRhSOhZiK
         GcqNhLZee0pxxmp4JoKV4kz4xv3mkLbN/o7hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xaTIHnBx9nGQAitv4LjbDYDAae72H66pyrlVCxGapGA=;
        b=guLN6SkYQQDqqcLV1kH1Wo0uuZYrCPjrfkUeYQKeX0sURK2IJq6/SdlBr23axU0b9y
         PgfAzOlJ3O3giZo7xi7gxGwAhDwTZ0hIcboeAMyWVtd/s9eFq46iOXOfUM9cdmX6/8b4
         p4Mh6xYqN56FxuHYrTbu5hEaSVclzFpYOvbRHuw557qA0iQvFVqKEIzWOJReut/fpB7t
         4MAElmqcad7EMuo54Ymsrw3YSZuk+zrRwNy79znHUASwLJV1c4FFBnad4PlYZToujrAH
         pr3dyBX8W9cC7sCFDsfC4M8Cne3aYj5eINlkYsLPldBad8uBMSiUOT05AcEQnAwZtyng
         pNDQ==
X-Gm-Message-State: AGRZ1gI7aC//tVioS4F7JjkRFVSO4TIu4U724OqRxd4slBBOiy3x5jBq
        tI2U1Ss0p+fZzd5UolSx5+qKtw==
X-Google-Smtp-Source: AJdET5fOLZPUHCaCCASm1ZlO4jxTQVF89mU2JeqLtmBaguTlg1OJhh6VaP/iGuJdTX1horqub50y9g==
X-Received: by 2002:a17:902:5a4:: with SMTP id f33-v6mr15929917plf.324.1541480519733;
        Mon, 05 Nov 2018 21:01:59 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.01.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:01:58 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/7] Add some fixes and new feature for SPRD DMA
Date:   Tue,  6 Nov 2018 13:01:30 +0800
Message-Id: <cover.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes the direction usage from struct dma_slave_config,
and add one new field to save the direction. It also fixes some issues
for link-list transfer. Moreover this patchset adds new 2-stage transfer
support for our DMA.

Baolin Wang (1):
  dmaengine: sprd: Remove direction usage from struct dma_slave_config

Eric Long (6):
  dmaengine: sprd: Get transfer residue depending on the transfer
    direction
  dmaengine: sprd: Fix the last link-list configuration
  dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma
    channel
  dmaengine: sprd: Support DMA link-list cyclic callback
  dmaengine: sprd: Support DMA 2-stage transfer mode
  dmaengine: sprd: Add me as one of the module authors

 drivers/dma/sprd-dma.c       |  152 +++++++++++++++++++++++++++++++++++++-----
 include/linux/dma/sprd-dma.h |   62 ++++++++++++++++-
 2 files changed, 194 insertions(+), 20 deletions(-)

-- 
1.7.9.5

