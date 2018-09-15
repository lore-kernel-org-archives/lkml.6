Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A382ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E9208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 03:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZG7QAn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6E9208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIOIWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:22:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44409 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:22:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so4985513plb.11;
        Fri, 14 Sep 2018 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8ziJA4qx94zca7h+UBhv0tAT4GL60Ekts6sL7jHf+Ns=;
        b=qZG7QAn/2w/ZlUAhqwzkOYptgA39Ut/x1OdsMg1xxGGbg8170VSKPpb7ov8uBwcFa+
         hVsNiMLUg1zwqkMeIMq31cjgidXq0kF7LuaUn3aeS8wS0jFuk6St+vuwRKtKGIffimTf
         gJPH2wMLeLoONIr/MVauFfpYckgL6tQ6cTlVA3q3lzwpa3WUvSCntKWd02t6bBVXmagH
         bGibjtxSzAr1JxgmknAenMrNjARTu6luu+AnTNxDbj5DB7Gl7zBV760tlmZ+GHHnng8w
         lt5pW97bgeWtRqxvyfFPfOxI/uJSiBRQd8orqjKQY9VMEmEd9spfTRJeAnX+FF3wO1pD
         k0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ziJA4qx94zca7h+UBhv0tAT4GL60Ekts6sL7jHf+Ns=;
        b=X3Kz28wEPREy0JmITWxPy1NmUS6LwuChh8F4iuWEtrF93N1UikL/7qXyww1atB2UwB
         pxisdL3v8/hfC+IYQwG+Kd0AeEDyoaT7GQjVA8G7l58p2CwL30CrPryuFgVq6LZgFqNy
         VoCwY+8J06BUtT88HPSZQm5K6caZX+RXVKRPC9AX1po1cM/qEals5DnRxJ3N8TWUxNNn
         4qSvOrbF8mlNzVBIEeBOx96MuOA2myF5dh1AKgGKW27T00VmohADJYsvoZ3LF/90aY4q
         hRCga/HnuVxN1Wc8QZFC5fseRVBTeflwYbZpSSv12H+vqblaaXGeWt8pXtetutzWzZSC
         G7gA==
X-Gm-Message-State: APzg51DqhBbmUiqEgE2JJ3XloqhvziGfmPrtrHyNGssH+qiviysO70+z
        eWA85YXbA3MKfgJ/wB87zeE=
X-Google-Smtp-Source: ANB0VdZ0VJWgqg8+Ja4zw1lTRElNTKMjl2/JZ5CBuhDI4wtM/h7dlat/5V+HiSKVX2wXHmy6ApzUjg==
X-Received: by 2002:a17:902:4401:: with SMTP id k1-v6mr14279713pld.97.1536980691861;
        Fri, 14 Sep 2018 20:04:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id j191-v6sm12779101pfc.136.2018.09.14.20.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 20:04:51 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, leoyang.li@nxp.com,
        robert.jarzmik@free.fr
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: gadget: udc: fotg210-udc: Fix a sleep-in-atomic-context bug in fotg210_get_status()
Date:   Sat, 15 Sep 2018 11:04:40 +0800
Message-Id: <20180915030440.17646-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] fotg210_ep_queue(GFP_KERNEL)
drivers/usb/gadget/udc/fotg210-udc.c, 744: 
	fotg210_ep_queue in fotg210_get_status
drivers/usb/gadget/udc/fotg210-udc.c, 768: 
	fotg210_get_status in fotg210_setup_packet
drivers/usb/gadget/udc/fotg210-udc.c, 949: 
	fotg210_setup_packet in fotg210_irq (interrupt handler)

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
If possible, spin_unlock() and spin_lock() around fotg210_ep_queue() 
can be also removed.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index 53a48f561458..c51510803d1f 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -741,7 +741,7 @@ static void fotg210_get_status(struct fotg210_udc *fotg210,
 	fotg210->ep0_req->length = 2;
 
 	spin_unlock(&fotg210->lock);
-	fotg210_ep_queue(fotg210->gadget.ep0, fotg210->ep0_req, GFP_KERNEL);
+	fotg210_ep_queue(fotg210->gadget.ep0, fotg210->ep0_req, GFP_ATOMIC);
 	spin_lock(&fotg210->lock);
 }
 
-- 
2.17.0

