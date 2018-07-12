Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39AECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726F8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KP1U/2Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726F8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeGLUKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:10:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46939 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbeGLUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:10:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so11114407pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=qH5pRUYsx+cOEzUBrwHWQb20E9/DWHrppW9IxPy3Xss=;
        b=KP1U/2AhxfzSQ2OPzu5ps7jUE9kayQ8s0MMOJwvQjjtPHBy7+sHITyRveEFOZdl/bm
         CnR9HbZn127UnKFyPmpWLEUeRBHd1McapQAKkNp7MIKiHeglYtbH9bCB45CLaACQRn+x
         pqL8tRuQfcqPyT3HqAeVeFIEPmplyyWwutoN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=qH5pRUYsx+cOEzUBrwHWQb20E9/DWHrppW9IxPy3Xss=;
        b=V/2h+r9ARHN5l0ApVLItTQoDzUQM9PZlMCcT94z8uZRk2DndyRvKoY5KUEC+mjoFbS
         HpPPGGpSLzN6hBz3g4vkeoOAUQx0Ux1hQfi5latt+TKGG+8DC0QK+mfdZqPWuKrBsa+0
         ujGUW/3sqPOJqMZRqIHowVtnmB2tt3uS3Lv2fSwzTQUBzkFtGY03ae8Y2YJaOxaHtnyR
         StcsGH2k0m4Xxo6fUluB/WvUuFenhNxmNnElWViUi5cZfvoC32AoKdYwntD6m9EQ+Der
         2CEQHIW/we/V9VvUXCL3EJyNb/U6VXHNzFgBzudpd/7uSNLKfCAtQoBaHd+S2BSnLP1x
         t3xA==
X-Gm-Message-State: AOUpUlEtIi5ZW0WzufwCzGhbL7Q9E2+nWyQoxVfeXB0p5B1KW2clLjVm
        cPnCnWLxYahygUwAGfGNFTv0qg==
X-Google-Smtp-Source: AAOMgpe3k19sx6d/ecfImbNmvsCbMNGoxDvXTAX8gIqO6GUeCGXxQfMhztrz1hOPTmpTnsxqwGvosQ==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr3464276pls.18.1531425579813;
        Thu, 12 Jul 2018 12:59:39 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a17-v6sm19177455pfg.106.2018.07.12.12.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 12:59:38 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:59:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
Message-ID: <20180712195937.GA36007@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the adjusted syntax wasn't fully build tested. This fixes
failures with powerpc builds:

drivers/mmc/host/mxcmmc.c: In function ‘mxcmci_swap_buffers’:
drivers/mmc/host/mxcmmc.c:296:51: error: expected ‘)’ before ‘;’ token
   void *buf = kmap_atomic(sg_page(sg) + sg->offset;
                                                   ^
drivers/mmc/host/mxcmmc.c:299:1: error: expected ‘,’ or ‘;’ before ‘}’ token
 }
 ^

Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mmc/host/mxcmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 75f781c11e89..de4e6e5bf304 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *data)
 	int i;
 
 	for_each_sg(data->sg, sg, data->sg_len, i) {
-		void *buf = kmap_atomic(sg_page(sg) + sg->offset;
+		void *buf = kmap_atomic(sg_page(sg) + sg->offset);
 		buffer_swap32(buf, sg->length);
 		kunmap_atomic(buf);
+	}
 }
 #else
 static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
-- 
2.17.1


-- 
Kees Cook
Pixel Security
