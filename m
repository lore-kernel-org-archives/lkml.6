Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D72C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DCC217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B82J4Qqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DCC217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHDJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:10:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40440 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHDJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:10:03 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so3511524plp.7;
        Sat, 04 Aug 2018 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=yf61xEva5q+UDmzb0Gn7V4uPpAtWDH7iwpCQV4qx7vs=;
        b=B82J4QqdDBlslu1FZ2lCm8TrEYnadCroZNsldoWSLeq2/56fyXC+DV1gnoZcA0QLIC
         /WLh9DkMDjQ+8NTqpMImDmQNy7g+BPWg8258Yxc5nLRL0pMc1QQu5qkZp56PXi5J2LTO
         EQ8LvrkO5RRRWtr07jILtJ6uqXYQ+G2K2nUJvMvaxDcxyfkkktUgc5bN4ordoOTO49fF
         ZoV+W4e5LbOeJ4DY7pPYAea75mk4Xr8YEwa2NiDVw2pDgxpWT+RBD3td26rTD/01CJ8Q
         fSDuZTpBepLmuOR4CSTW2kSijxhnhZKI5sS1TmhozynDWaLEehnJuRX8EPZ28VZwxfg+
         /SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=yf61xEva5q+UDmzb0Gn7V4uPpAtWDH7iwpCQV4qx7vs=;
        b=fNJTdz5ngNtafyFwb0BQDAkhXzDU+3Key50iEEvNRXadBYaGliUx/TuaKAtZBc4pll
         EZVKCfYnsndhN0DBdw2fD9hfeRFuqGKZXdKbZB+3S8h0q4FWF93bcLZdxx2cOPaiX8YW
         qucIWD+lXc5EvO3zTtL7k8PYSQiT+aNWLAS/qmVXvRIy+tzK8iJoxmzrfMyo6JA4Zg/x
         q3nIO2pQ/NNNd8pHti6J9TIehGpePIf0K5mcG/63fFzYkJRzEH5VZ6A9MA0TSjUGrw7G
         gNzrMwngPgm5HzQABtfOOKw3F9zotH/p78gvhCC6j9bIWFlnk+iAY3DVNLIugqKJRYWa
         4Dsw==
X-Gm-Message-State: AOUpUlGYs+/tsQ0OMO8Y087wU6ep62TB43lNwa8cBus5vrnymRnUA/WT
        rphqfkHbAE4NiBDqFU30BCGIag3s
X-Google-Smtp-Source: AAOMgpfVxBJgI+XN8cnal5cRPY+7J0YWMpygCozxqVy9/iweTS0CqCncSLaXZfiIxVUyQtHiD4jGTQ==
X-Received: by 2002:a17:902:1c8:: with SMTP id b66-v6mr6375453plb.273.1533366623700;
        Sat, 04 Aug 2018 00:10:23 -0700 (PDT)
Received: from Salils-MacBook-Air.local ([2601:600:a27f:d810:d077:b4f0:b680:ad6b])
        by smtp.gmail.com with ESMTPSA id a11-v6sm11499988pfl.66.2018.08.04.00.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 00:10:22 -0700 (PDT)
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Salil Kapur <salilkapur93@gmail.com>
Subject: [PATCH] USB: Removing NULL check for pool since dma_pool_destroy is
 safe
Message-ID: <b5db9a6d-6194-ae7c-235d-dce772cb9a4c@gmail.com>
Date:   Sat, 4 Aug 2018 00:10:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
-        struct dma_pool *pool = hcd->pool[i];
-
-        if (pool) {
-            dma_pool_destroy(pool);
-            hcd->pool[i] = NULL;
-        }
+        dma_pool_destroy(hcd->pool[i]);
+        hcd->pool[i] = NULL;
     }
 }
 
-- 
2.14.4

