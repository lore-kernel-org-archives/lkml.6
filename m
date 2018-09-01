Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EEEC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729E920843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpgWzRz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729E920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIAP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 11:56:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeIAP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 11:56:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so6669219pff.9;
        Sat, 01 Sep 2018 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TnsX4KnFScUHBBgw/co3ji6NqxZK7sOkovdN5i+egQA=;
        b=JpgWzRz9v1HEss4onWABKfKKStJcwf5Sg0Pzu6dNAnNgTJ8OJCxMCdwM/jir8E+yMY
         r3M1HARNucBMMiKDWmUas5NzHzaiVH575SAFUSPpueQjfjp/LtkDClHwp0sE2/X4jnVM
         vy578g8OPH4Km3faMfcT6msXFxbpBclgk6D/hNII6epHvEGRQ/mG3PBOUu/nUgjZkL5P
         gctwayl/QOSEEIoHo/F3ljQhyDG1FilJBJ7WzFnwPt64WQ1OYdNfCVCKrHGdvzE1zxTN
         tFk1Dnai1SelQ/rfHcj+AMVExpbVqP+TsLIEwWBBVIFrUJ2s83T27PICROby9bdWoBZU
         hTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TnsX4KnFScUHBBgw/co3ji6NqxZK7sOkovdN5i+egQA=;
        b=QIL5uJsraQshAu/YtNMHjbNDz7U6l/FZynHCz4l67mAvd84+QT9Rymulr9OJwWtUAs
         LTXDdRbp2lMnzCBOi5FMUMSQzYG2TejwI8AyXqSgutdzFhhMM7GXtqp9KAjpsftgvyxX
         Gn4rTXKuBfavHYPBrsh9lO6mVyynwNnycdOj0AGe/2UZd+Me6AvCeztgeQj8TxMUWfzt
         83O07T4GAqpTZwH14DiEfhXK9nzHApYoaDlCoxwe97ANbqtnhjPPB140OlV34Hj7oGFl
         t2DN1pVeS5XHue8ud4Gzbmayiz5hVRd1yS54wz4ZpX1y0+gccDjpins/eL7DKzwSzPnr
         i1CA==
X-Gm-Message-State: APzg51DEuKYmndtGiG07TsVPCW9gQLeE9muxQ9kNg63PwFguJ2xLJJ30
        /7xHf+mGyBi4xUk11St3tZY=
X-Google-Smtp-Source: ANB0VdalcgF/g3AHCRkzUEYhssogluf7XdORufLkrRJCIUJZLryxc7OO8skpmm98wy/xFz0k6Keg+g==
X-Received: by 2002:a62:c4da:: with SMTP id h87-v6mr20364810pfk.39.1535802256085;
        Sat, 01 Sep 2018 04:44:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id p64-v6sm22496484pfa.47.2018.09.01.04.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:44:15 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: ivtv: Fix a sleep-in-atomic-context bug in ivtv_yuv_init()
Date:   Sat,  1 Sep 2018 19:44:09 +0800
Message-Id: <20180901114409.29446-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep in a interrupt handler.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kzalloc(GFP_KERNEL)
drivers/media/pci/ivtv/ivtv-yuv.c, 938: 
	kzalloc in ivtv_yuv_init
drivers/media/pci/ivtv/ivtv-yuv.c, 960: 
	ivtv_yuv_init in ivtv_yuv_next_free
drivers/media/pci/ivtv/ivtv-yuv.c, 1126: 
	ivtv_yuv_next_free in ivtv_yuv_setup_stream_frame
drivers/media/pci/ivtv/ivtv-irq.c, 827: 
	ivtv_yuv_setup_stream_frame in ivtv_irq_dec_data_req
drivers/media/pci/ivtv/ivtv-irq.c, 1013: 
	ivtv_irq_dec_data_req in ivtv_irq_handler

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/ivtv/ivtv-yuv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index 44936d6d7c39..1380474519f2 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -935,7 +935,7 @@ static void ivtv_yuv_init(struct ivtv *itv)
 	}
 
 	/* We need a buffer for blanking when Y plane is offset - non-fatal if we can't get one */
-	yi->blanking_ptr = kzalloc(720 * 16, GFP_KERNEL|__GFP_NOWARN);
+	yi->blanking_ptr = kzalloc(720 * 16, GFP_ATOMIC|__GFP_NOWARN);
 	if (yi->blanking_ptr) {
 		yi->blanking_dmaptr = pci_map_single(itv->pdev, yi->blanking_ptr, 720*16, PCI_DMA_TODEVICE);
 	} else {
-- 
2.17.0

