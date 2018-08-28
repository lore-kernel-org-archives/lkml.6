Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4365C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501C720897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7eCYV3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501C720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeH1FNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:13:46 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35198 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeH1FNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:13:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id 89-v6so705219qkp.2;
        Mon, 27 Aug 2018 18:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4oSDwJDeihfUA+HsgtBsTUowt1giyERk8qdXwsrphSQ=;
        b=C7eCYV3wf8XiGqBQeswOX3LQ69qJ0QmzUlmKgzi4xwmWwprv5V7oH3khOU0fNlArbO
         Mr6QY2kmh8IQ5UFnQqnG9Jju0t2pzJSm0auDj9hkNvTdwixyAyfeoZW40vl5UrCd4hhK
         xPzO4O4xmTB5cvOEmScuDcJS9ZFbVHi2hshztZjX+JRQ8a870PP/lugH0CSACBGLYyas
         n3qwpSuGmQIpM6+HGDjU/rM+nEJZt2jR77VeuY/LMKRsebAvXVAJ1f5bDpqemC0JxpAS
         wSW/1UohoZvVfM2JTXjOPcIb+ZYQoxXdb1ReaGRlalj81qDvVudXSxhojk1CwxgFN5tq
         hX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4oSDwJDeihfUA+HsgtBsTUowt1giyERk8qdXwsrphSQ=;
        b=DZl6vBDD3cI5X4l/zEWL68xJBKeW3NDyLEBz5iFUgJ2b0GwNooMz2xHgf+iIuIW8/7
         x1EKsMMIT1BOYbYgfwIzElQLEOzM1+NEvXEMtVBDkvWEU2IWHd3NQ0dxZ55STdBT7y35
         INkvqa9VdBifBMxrXBHngIpmRR3PEvYpv96hIRn5s+dJYRWq14Tby8ItaM/RHVoHFQ5T
         fniaJaA5Xej2EdJUmIQ8LIrWChG0962ZE2flNzm9AKMI8JKoKvNgWQUtxDnDBGpxeOTD
         Z2PD2d6zaR80NCvMoCo8V40c6qTcxyRzbeLd7l8zbGqLruQUQIUI+V1bmE+ICSzzPbq1
         Os0w==
X-Gm-Message-State: APzg51APDx2DiQysOH9FS6iuXRmkyHjj/JrIkFHcJDiN6KPNUWZ1qFxD
        0+wUIE7AHLR7qb11ZrBaxic=
X-Google-Smtp-Source: ANB0VdYz89VBpucMH+TXiodKsDlV9EYY++6J0x+erzCwD6dr59KAWDEqebWk4mz30n2kzYMoRs+hRA==
X-Received: by 2002:a37:1599:: with SMTP id 25-v6mr16312321qkv.245.1535419476182;
        Mon, 27 Aug 2018 18:24:36 -0700 (PDT)
Received: from Salils-Air.fios-router.home (pool-100-35-223-222.nwrknj.fios.verizon.net. [100.35.223.222])
        by smtp.gmail.com with ESMTPSA id g14-v6sm588486qtc.66.2018.08.27.18.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:24:35 -0700 (PDT)
Date:   Mon, 27 Aug 2018 21:24:34 -0400
From:   Salil Kapur <salilkapur93@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Removing NULL check for pool since dma_pool_destroy is
 safe
Message-ID: <20180828012434.GA19415@Salils-Air.fios-router.home>
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

