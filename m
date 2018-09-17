Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF74C2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQf0L2HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF74C2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeIQSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:06:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36553 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeIQSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:06:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so7516508pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAIwIi6MignLxrYQE1YTceMZBx6QLimmcf+p0q7JSeo=;
        b=QQf0L2HVMovonoETcGw0Mi8bQ1CpjsRtzwr5FRDoA64Hhh2wqON/pnXmVEZa+OEsy3
         KjoxPeGk9qV4qOSZr64r6CFq3P0o1QjBpfhBWDVRgmVuzQYJ+FTw6zV1izNUpz0IHeCY
         MX+KmBqs1ghnD4yMZoux5bm8Rs2vFNVJdKXuGUXG8ZfqzeTIE8gUjvCRXinZnlro1PbU
         OIbASEIEtEr1stUmyZ1UzYeFUX5k2EVnySQ8G2+enRE16SzTukWCvIqb8zOAl0ZenZGg
         IwoiAHNI+Y8ddIFk+BYLQbh0nYK7nHem+SnfGMvZ91iQfK68/Z84mEXgcWddvUnfsaET
         XSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAIwIi6MignLxrYQE1YTceMZBx6QLimmcf+p0q7JSeo=;
        b=Llnr+2yd8bnkwC4/Sgof3WsedX2hf9HdWnCNN2g4BfWwHE5Vx0nhmxyza7NZB06KMG
         AGP6yIfCGbXmPhCXNuzj36U1IUzACsNHtZHKApVJcgw0CxkOoTX7qcqJgmTf83ZEl3Xh
         UWzscEBVFHTIxiQBu/LA2BkxLLWPxnuHVDISL7wC7i7XyzU4/bfdLKtnUp97F00BWGCC
         5e4NXRganyzctqx4NseB9q+w2w5A2F/oO2jj/fWoLGWX/f5zizKKTAYUbeWBiFTJaTOh
         2b/Bda9cYSfX5S3v8f78vpb9uI9x8/117k0Fe/n36awwnO4Vq959gm0I2AxBMZeYtjPH
         Rcxg==
X-Gm-Message-State: APzg51COUdOHWEXGwkzs3gi91ab4RSnHqFSwHzQnLy66cvEfm2kAE/5i
        NXDPCh2RSaTMPtrMub/YhYM=
X-Google-Smtp-Source: ANB0VdaNhy/WQhkE6BngjJWT6nXhaUb80/V8h2lju4mgN7l7yCdGLLtNH/sXJLfFmMiq+qcFrMg7EQ==
X-Received: by 2002:a62:c0a:: with SMTP id u10-v6mr26049136pfi.43.1537187986973;
        Mon, 17 Sep 2018 05:39:46 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:45 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/10] staging: gasket: page table: use GFP_KERNEL for dma_alloc_coherent
Date:   Mon, 17 Sep 2018 05:38:58 -0700
Message-Id: <20180917123905.213639-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Flags should be specified for dma_alloc_coherent() call.  Use
GFP_KERNEL, it's fine to sleep here.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 53492f4fad6aa..71b77da2e18ca 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1287,7 +1287,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 		return -EINVAL;
 
 	mem = dma_alloc_coherent(gasket_get_device(gasket_dev),
-				 num_pages * PAGE_SIZE, &handle, 0);
+				 num_pages * PAGE_SIZE, &handle, GFP_KERNEL);
 	if (!mem)
 		goto nomem;
 
-- 
2.19.0.397.gdd90340f6a-goog

