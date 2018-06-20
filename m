Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EAB20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojqxStBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EAB20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754464AbeFTDzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:55:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37662 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeFTDzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:55:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so897920pfn.4;
        Tue, 19 Jun 2018 20:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X9sDWrASE6x8WS0QY/DzosVA5CbOCMPpj4fZPLr4gEU=;
        b=ojqxStBgFTPDpkCFR3SAtHZkefMRGAT39w0pvBiADQF80kGXYNV70ZujATHgf2Z4zy
         ruR9v8xXwN1BrzRLbCK2mvyOG/ZHAAezTax2XMCGwL88jRVRNr3eQ+ir7fYcwldyo2S/
         6a1UEh5zkDUsq+QaKl1x4x0C3UKTgrJuuJDq2mzvDPfFVaThm6Cz/aqA5Fp8rEBuOyLl
         ef3+eyvegJ5rw16UKTK7mn4OQn/ePhHbx3Df8xw+d3Jh6CuVRCPYGfro5syFN0vo0PsJ
         VTdlFXlm+5gVtfN4Ge95vvmt2HsC27h5mug1JZxIw/pVjsXrC7MJJiuDq9tH292UDcII
         Wvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X9sDWrASE6x8WS0QY/DzosVA5CbOCMPpj4fZPLr4gEU=;
        b=BGh1F9eTm2dpxiVE2mFfJb+1n0plK4I+ZorXimKKtELon/YzR4KXuH26+sCg7FcLzw
         D7Vc8DjfB8+J75LgokM0dpIhdmm3t+EoGrnHsDdGRvuSX0J6XqgtywQEOMm/Li8qaMzi
         oaWIREe8WrXyCzkdHRdyLAiGiAY0O6dYwAY33Iw4T4ahw3R11AIP+16kMo9B4aJbmrMO
         BOaqBdks571peLtbC+bFAxHVX4MvcxM08aMTrOV5GJTAqBlieA4yJK8roOBQUub0Mb68
         3vrIKo5+mheY2i/92ZlJehsg3g0w4r5m1Xd7NzTd6Kk2j95SqQmpBQuRKPMBTPVYstrP
         DEqw==
X-Gm-Message-State: APt69E3JylH7LQdH5jTai5qu/EGqdJPnS8B9X3Rf8BQghGPdoatNLI+6
        N0Ooq8Uf+GGkcclfAUSTRwA=
X-Google-Smtp-Source: ADUXVKIFoZZsa4UTyJqY9ClQEQIBqpvwy07XSdJRpYfNeGKeA5DCuSUymiFYiYSEqZEWuCKKAOMN+g==
X-Received: by 2002:a63:3807:: with SMTP id f7-v6mr17243450pga.446.1529466918963;
        Tue, 19 Jun 2018 20:55:18 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:d85e:ce7f:5f7a:fdfe])
        by smtp.gmail.com with ESMTPSA id q82-v6sm1627439pfg.170.2018.06.19.20.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 20:55:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, leoyang.li@nxp.com,
        allen.lkml@gmail.com, johan@kernel.org, keescook@chromium.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in r8a66597_queue()
Date:   Wed, 20 Jun 2018 11:55:08 +0800
Message-Id: <20180620035509.7775-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in Linux-4.16.7 is:

[FUNC] r8a66597_queue(GFP_KERNEL)
drivers/usb/gadget/udc/r8a66597-udc.c, 1193: 
		r8a66597_queue in get_status
drivers/usb/gadget/udc/r8a66597-udc.c, 1301: 
		get_status in setup_packet
drivers/usb/gadget/udc/r8a66597-udc.c, 1381: 
		setup_packet in irq_control_stage
drivers/usb/gadget/udc/r8a66597-udc.c, 1508: 
		irq_control_stage in r8a66597_irq (interrupt handler)

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index a3ecce62662b..e1292c280a0b 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1190,7 +1190,7 @@ __acquires(r8a66597->lock)
 	r8a66597->ep0_req->length = 2;
 	/* AV: what happens if we get called again before that gets through? */
 	spin_unlock(&r8a66597->lock);
-	r8a66597_queue(r8a66597->gadget.ep0, r8a66597->ep0_req, GFP_KERNEL);
+	r8a66597_queue(r8a66597->gadget.ep0, r8a66597->ep0_req, GFP_ATOMIC);
 	spin_lock(&r8a66597->lock);
 }
 
-- 
2.17.0

