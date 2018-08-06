Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B00C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29BA219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXKe5wSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29BA219CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeHFGfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:35:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43977 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeHFGfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:35:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so6190835pfi.10;
        Sun, 05 Aug 2018 21:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4oSDwJDeihfUA+HsgtBsTUowt1giyERk8qdXwsrphSQ=;
        b=rXKe5wSqva5xt/umXf1YlUnTpI924FKXF5hzOVW0/CY9VL+yYPyiHEEacchlz4acYt
         qW0zBSkZNZ7uPtotDntXrva4s2pZ9pnkBu1QfOmOSKnDJO0M2LSiRTZ6h9d7VZkbz3Sp
         G4cV5fg6ADH3Da3rC4WmQPDXMqhXr91oxetJih7YESaU6ji/BF/vQSkZOJdSKC/bkupV
         23OO1JA0VVW3Hlvxc7dJQU54K210s3bbnZiz60t+jQJe4pITGzPiIsXTLUUSBwu7cxya
         uT1pYgyS7s/kdVj0X0QQnyjNKLk5hxbOaxYEEuDlRG7ieZddmAwdJsZYrGDwPk49Ont4
         LubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4oSDwJDeihfUA+HsgtBsTUowt1giyERk8qdXwsrphSQ=;
        b=tnrU3drHimH0b2GMdcTfav+GScpqa/Qygys3WO3WfC24P/KyWN8enrD2dDA6fsvyrS
         h7ov0nNRbuze7M5mSCb3EIgHI3M5zM+JVrLU/5MUILM+2Es16WGC8cI67GlY95okDyoB
         z+7gfeidU9TDeimDffucPNIE31VD3qCR5GBGMhiujT3iRQgA6p7PyTn2P+HlyQmialmU
         ft88hXyYfwdDJJ6Tb/+C9/j1H6ri2kN9fmwnHS2DwQwecJmIK75Bp3DmX1qjeNcopegA
         sTXaNUWmXOv7iukX5BnngDDyZi3mo9zO9dfcrbZESwLaW0BFuDHxsESp2wwobE7VUjmn
         Y9VA==
X-Gm-Message-State: AOUpUlFQr1pDQV/fMzBU9ODG69YW3ItI7tqSyrJI9BFhttqlNx0IO9RX
        w8SxYV4hjf+PGcZmRhRUjG6dYN/u
X-Google-Smtp-Source: AAOMgpcODcvYD18Ejcpy9SDPm+L4NHbNhUrL0PFoqBLA79ySBVnWL3/P/LmelUI6nRLcEyXGmQLYjQ==
X-Received: by 2002:a62:106:: with SMTP id 6-v6mr15524758pfb.168.1533529690683;
        Sun, 05 Aug 2018 21:28:10 -0700 (PDT)
Received: from Salils-MacBook-Air.local ([2601:600:a27f:d810:2878:20cf:5a20:da30])
        by smtp.gmail.com with ESMTPSA id 64-v6sm20568029pfi.89.2018.08.05.21.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 21:28:09 -0700 (PDT)
Date:   Sun, 5 Aug 2018 21:28:08 -0700
From:   Salil Kapur <salilkapur93@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Removing NULL check for pool since dma_pool_destroy is
 safe
Message-ID: <20180806042808.GA91892@Salils-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing NULL check for pool since dma_pool_destroy is safe

Signed-off-by: Salil Kapur <salilkapur93@gmail.com>
---
 drivers/usb/core/buffer.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 77eef8acff94..f641342cdec0 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -101,12 +101,8 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
 		return;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-		struct dma_pool *pool = hcd->pool[i];
-
-		if (pool) {
-			dma_pool_destroy(pool);
-			hcd->pool[i] = NULL;
-		}
+		dma_pool_destroy(hcd->pool[i]);
+		hcd->pool[i] = NULL;
 	}
 }
 
-- 
2.14.4

