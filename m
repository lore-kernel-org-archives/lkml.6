Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26092C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C953B21748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLvL3nGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C953B21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeHRWOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 18:14:03 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42455 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeHRWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 18:14:02 -0400
Received: by mail-ua1-f66.google.com with SMTP id w7-v6so7617707uan.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TOi1s1AWzj0Q1Kk2Rx2eY8eyc0z8wYNgXm4yREANSks=;
        b=HLvL3nGf1CgsD3XU7zpu5qvA6WqAkOSl2xAn/lPsNAoq/SiWB+4Quu+Hd0WZ6ONcs4
         hTiBFbyFWDjOeD7YzdaHyBENyHziALRFamoL2U3UZteNhmdhABUc4PPaSKuESNnvVMzS
         kMb2CSSuIEqyF4sxoJeFIm4HP3bJWKe/TI1nNA1OdvRVmIb0pkK/gX/mWkT46HlUcDcM
         aEOGjGLtFKI9Y9dMuJN64j4CCrbPwT+GZkuhX3WqohQoCc2pVp96SLTTy1Pmqnp2vG5z
         ahgiZBNq409INNt8ugM7/owC/rhap3Pogi0nwrKgRCmMcvKDH1CmRyWnUxMg4XjH/5BD
         v3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TOi1s1AWzj0Q1Kk2Rx2eY8eyc0z8wYNgXm4yREANSks=;
        b=bm5HcA1wKyBZnaaVPP46b2lCCoGzuRe9KyMiHgQG/OlZKEL/Gca0mhvrL+b0k0HgZ/
         uJGCaJsebMb2oPJCKdipRqW2dC2ZGXu/FJV2CjnL/mtkuYWS93/Oy8Gzt2sXD8tzbhOC
         yGYsQRmNb77v01s4urjoCvI3bYcn3xc6rFMF5TGXrHPCAn+AXWRkbAboT+p3isHcYABX
         QMOLTVmv+EHuT2dvro1xifH9O7D3ixlYkYLePwak5IuzBcMxQXQRxY1WzAd8qRkDoj7Y
         +0mkcCy26gcA8slg4qmQFa1YGINxoKXQAloRTKjrgcHa2PjjcCznwrDj5niWWhZisRZw
         dmfw==
X-Gm-Message-State: AOUpUlEqpIgj/nWIjRiIZjQ18NQVmudF+pphGT63Ojh6awhXV6YyN+4w
        McD9PlKtceB2qWCYsCRFlQ8=
X-Google-Smtp-Source: AA+uWPxyH8kgno+luk0opOLY/MaP/wxjDXxFvQpXU0T9b5mimPofSDopMWo3XyTqQBqnUFdHcGqPqw==
X-Received: by 2002:ab0:49e2:: with SMTP id f31-v6mr26456960uad.117.1534619120916;
        Sat, 18 Aug 2018 12:05:20 -0700 (PDT)
Received: from katana.americas.hpqcorp.net ([181.194.117.144])
        by smtp.gmail.com with ESMTPSA id 9-v6sm3336513uau.47.2018.08.18.12.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 12:05:20 -0700 (PDT)
From:   Esteban Zamora <estebanzacr.20@gmail.com>
To:     estebanzacr.20@gmail.com
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Fix uninitialized pointer on DMA ops
Date:   Sat, 18 Aug 2018 13:04:51 -0600
Message-Id: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmap function pointer on swiotlb_dma_ops struct is
uninitialized, which causes a random crash when calling
the dma_mmap_coherent function on platforms where no DMA
address translation hardware is available.

Set this pointer to NULL in order to fix the issue.

Signed-off-by: Esteban Zamora <estebanzacr.20@gmail.com>
---
 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6db..9a7718c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1082,5 +1082,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
 	.dma_supported		= dma_direct_supported,
+	.mmap                   = NULL,
 };
 EXPORT_SYMBOL(swiotlb_dma_ops);
-- 
2.7.4

