Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD1B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdETgogP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD1B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeILEWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:22:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39128 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeILEWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:22:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so332165wmq.4;
        Tue, 11 Sep 2018 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6aVVkXM+6vn9mcTsd2yNMXKKGwcCS5UvdzKqBiLCW5U=;
        b=AdETgogPd2KNqJ2mU2d857Vo+fWDSiNM3h6JbJvmdwy1rLf9waeLfMPbQnsdWWvnvS
         tSPPd2oVpIUDgryF9AEz4atqlQ9M9V9jizvhb6Q5aYXB7PjwbzrsJ4yHEKSnQbNX7uc7
         KUH0VZNiYvEFw9sZCWtmQHdDPF5jlcaCIqgo8M20uzC2fLsgbn/r/dk0bdq3VnJ6znD7
         AIr4FQxhxPYi5iKxTCubq5f4EiDbLGszFQCIpFE/pM1rLM8uzjzJ04ztwx63QCOCl9Ed
         bxCEPKNHSiuM7tVWCrsL1g04NnAjCyd+0ZLiEU/PpawaOPIrADA3CckfkNU0Q0mD5UZP
         3Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6aVVkXM+6vn9mcTsd2yNMXKKGwcCS5UvdzKqBiLCW5U=;
        b=Vglq9+BbnyahguESDPFFw2SjEjo/DKl/k18ppRkRUHLYh+5g23kmt0vwG+yELf+6+r
         ziO6FDgSfZHpewh0fGAMQ63d8xjfihKgVaddE4NqMMbITK7EeHg4P9u7ZqXzBt5hHRc+
         IUGlRHD9AKfVtOgDVcvF229V7JR3fgfRgHzmGSZaJPND1MElyOIOFjABdcMfRMcNItkP
         qW5ooHnMYea4qVwBEk3qtIQW2IF5Mn6OPlv4GfH0snkhkuqdeYRj6k7TxtmL3VwNY3G9
         5zanmEn88DXSDBGcpbQfOsgAuT0O/BYrCtXSlIstGkATWu86Ci6n7eHgJGtohgqOZqwJ
         itMw==
X-Gm-Message-State: APzg51A1Wd9laKtjg/T7WVZYanfoAOXaPtqkZ3Faa6njHiLwFXPuMyEZ
        pQixZ8AIPhcfZjZXTAArs3Q=
X-Google-Smtp-Source: ANB0VdbTuisM55Dqqh5P6HYHxKQZnnEZf7e92sQ9m9MMsUTBUyLNhTYaWeftVe4pPoKHtOI5iRg/Gw==
X-Received: by 2002:a1c:2bc3:: with SMTP id r186-v6mr2859267wmr.71.1536708034215;
        Tue, 11 Sep 2018 16:20:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x24-v6sm36464594wrd.13.2018.09.11.16.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:20:33 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dmaengine: timb_dma: Use proper enum in td_prep_slave_sg
Date:   Tue, 11 Sep 2018 16:20:25 -0700
Message-Id: <20180911232025.4909-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when implicitly converting from one enumerated type to
another. Avoid this by using the equivalent value from the expected
type.

drivers/dma/timb_dma.c:548:27: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                td_desc->desc_list_len, DMA_MEM_TO_DEV);
                                        ^~~~~~~~~~~~~~
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/dma/timb_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 395c698edb4d..fc0f9c8766a8 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -545,7 +545,7 @@ static struct dma_async_tx_descriptor *td_prep_slave_sg(struct dma_chan *chan,
 	}
 
 	dma_sync_single_for_device(chan2dmadev(chan), td_desc->txd.phys,
-		td_desc->desc_list_len, DMA_MEM_TO_DEV);
+		td_desc->desc_list_len, DMA_TO_DEVICE);
 
 	return &td_desc->txd;
 }
-- 
2.18.0

