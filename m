Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80624C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370CA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbaQVU5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370CA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeILEmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:42:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50658 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeILEmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:42:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so388437wmc.0;
        Tue, 11 Sep 2018 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PTcLJM8RpEW0v3/TKjoUhjG/fwUYyf0IdyjYKe7C164=;
        b=RbaQVU5SC165J5d7QT0IXxloAkCkOQyuWihNCMygtfybwMK8eMdFk07Fi19MalnKcp
         1OSGKI1y7tfuDfxHECUMkE1SZ+7ZuJFvz7d6vxO6EbeMt85Tz3CKjKVyzRT6TlMweBHi
         PUDbj+8WryUQQUm9NylfT/fkO5cvpYN1mAUFBdFA3qAer+ZMBUzs/neOA4pUjLgMixpL
         ach1v3vqNEZ7dW0MuI2EeO6+xiZRRJ2o1/FvikxeenDJIKfY7fC/bUN+Jw2gvN/ApPeG
         CbWw7b8pXygPf74ZsxrrW8WmRJPkBJSuk5oI/30NRZw6i/Dd1OGDyRvaI9UEbhAjr9t8
         utig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PTcLJM8RpEW0v3/TKjoUhjG/fwUYyf0IdyjYKe7C164=;
        b=mni1purzLT5WIf+MayIuH0l7IX1qAzQu//JeSmq3HW46PVGNw4xplmZTvudUJAm71V
         RWVADQIrM5MNCAHhDibpsmS05MsomsjTJpLoJdfqhuzTDmxvzfNbVVFR24P5qpYINGI3
         98xLWER6q3HoWA/8MQfye73E4/DjFfxVyQLWkFMU4zs+i9FSFK1ZeRVe9fZZLk/CjpTy
         fD6GO3YGIojChu1bjwGYYcfmJZy9mmZHC87Dr/BpB5AxFUVr/EXJey07jBabzqPd3Wm7
         DPXJiWP5iXI24uvvSn1BTO7OYPfn66vlnM3wQvlfJH7HEjeZb6vJAxfEZkG+f4DZRx8P
         vLig==
X-Gm-Message-State: APzg51DIJBNcfeMzYS5t8MoNei1YV/pQm0I0w4aSka2uxuWxg6DA/XE8
        th6B1oulBLORo/4EguOSCB4=
X-Google-Smtp-Source: ANB0VdYFVELaA28XmW5yrn5xnEg7+dNwLHCdNYdswoDEEbkQxnSVg7ZpmUPOM9/5jRWwk/gSCQSQKw==
X-Received: by 2002:a7b:c248:: with SMTP id b8-v6mr2967536wmj.21.1536709227953;
        Tue, 11 Sep 2018 16:40:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o3-v6sm22789676wrn.58.2018.09.11.16.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:40:27 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dmaengine: ep93xx: Return proper enum in ep93xx_dma_chan_direction
Date:   Tue, 11 Sep 2018 16:40:20 -0700
Message-Id: <20180911234020.9064-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when implicitly converting from one enumerated type to
another. Avoid this by using the equivalent value from the expected
type.

In file included from drivers/dma/ep93xx_dma.c:30:
./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                return DMA_NONE;
                ~~~~~~ ^~~~~~~~
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/linux/platform_data/dma-ep93xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
index f8f1f6b952a6..eb9805bb3fe8 100644
--- a/include/linux/platform_data/dma-ep93xx.h
+++ b/include/linux/platform_data/dma-ep93xx.h
@@ -85,7 +85,7 @@ static inline enum dma_transfer_direction
 ep93xx_dma_chan_direction(struct dma_chan *chan)
 {
 	if (!ep93xx_dma_chan_is_m2p(chan))
-		return DMA_NONE;
+		return DMA_TRANS_NONE;
 
 	/* even channels are for TX, odd for RX */
 	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-- 
2.18.0

