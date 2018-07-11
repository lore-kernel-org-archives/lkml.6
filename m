Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1762120843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lZDqIgAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1762120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeGKIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:35:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37963 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeGKIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:35:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so1590894wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=myz9PZz0JU4DyqQI42pxLu5+BUUW+GEdx5B8gXjLFPQ=;
        b=lZDqIgACMmpwyYU+uFxP0K/PZPFxYGVAElN9DPr0kdNPnUkPXmc0QtqS7h8azaC+UO
         I6TsHyqRLWUhGyBb5FoqaeYF1kQdk9/vbYpAfqAYvEDmm1SeJrX6boV1JZJVudLxM5HZ
         yfduOsHNS1ARO4XpUHdLizC1wwYDw5E3AckySxbqErVEEYCg8X8HNLcULI+68507O1X6
         cHa5ZQgEU64IJ4Ul3hTFMU4BN7jnoRlvGbRGRXsKwu+4cBB+5qrt0lpyvV2jNTXh/G3p
         5A6v+SnoBi2ezItTRA25s7AIQvM6344iF6mEHXTgsZ3Z+7IBCGCeBbDxjkkT6sZbpet6
         O7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myz9PZz0JU4DyqQI42pxLu5+BUUW+GEdx5B8gXjLFPQ=;
        b=Zsk3QSeKMpWd0FEeDoYEeEYOYKYjsmSeD8jBQUtsATBZq3E5XfgUsKjkoWd9OFiYD1
         PbkkzJw4ACYEzPc0Logc2e4L0ddffdg2o1WNYepfnnnNkTVNeCCebtGFHWOeePutcg7/
         LtwZO1XVWm46gitsh2PH/6GedJvZHE1CiqEDDU9pNTdPJzlPijgSomeY7dM3rmwBAUIN
         f48jhGHLRN2mhRkdMQjcMjYC70SQ6LR2Maw+gyA4JC/0Px6QbbnjNsypVcwW6qUytWd1
         QXYS7RP3KotjbawJ15JwVsGy5Gzcgs780i4+zWdpmvuo7a3ecyH20EU/cKzR4uoK1oLM
         OIuQ==
X-Gm-Message-State: APt69E3PJS61zSabcygDjqexSfARih2g5460ucyOWY/t1+uQlMfMRFQ3
        fvRoIqtdW2OOaqqMsV2z+PmiYw==
X-Google-Smtp-Source: AAOMgperQcssx7kceyEKa9VbqIda93EDdnN6B3Mx0tVWOEXDsRlr9EWowya/TxdVAn+VNERIXbjy0w==
X-Received: by 2002:a1c:f009:: with SMTP id a9-v6mr17570014wmb.104.1531297932860;
        Wed, 11 Jul 2018 01:32:12 -0700 (PDT)
Received: from localhost.localdomain (141.pool85-51-114.dynamic.orange.es. [85.51.114.141])
        by smtp.gmail.com with ESMTPSA id h5-v6sm8206277wrr.19.2018.07.11.01.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 01:32:12 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jramirez@baylibre.com>
To:     jramirez@baylibre.com, jic23@kernel.org,
        lorenzo.bianconi@redhat.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: irq not handled unless data pushed to buffers
Date:   Wed, 11 Jul 2018 10:32:08 +0200
Message-Id: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently IRQ_NONE is returned only when there is no data on the fifo.

When there is no data on the fifo the driver can not push to the
buffers and therefore user space readers polling for data available
will not be awoken and continue to wait.

This commit just extends the same semantics to fifo read errors.

Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 4994f92..4959923 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -472,7 +472,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 	count = st_lsm6dsx_read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
 
-	return !count ? IRQ_NONE : IRQ_HANDLED;
+	return (!count || count < 0) ? IRQ_NONE : IRQ_HANDLED;
 }
 
 static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
-- 
2.7.4

