Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D619C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F90E2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOan0+5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F90E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeG0Dju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:39:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33220 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbeG0Dju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:39:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so2300274pgv.0;
        Thu, 26 Jul 2018 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gxkMzDrTrgnbLX3v/fz1b1mgSEVz+VFOADYn816I6ac=;
        b=YOan0+5PoIr/xe1JjsqurUo+mR8/q1EUnBSM29LFJ+cKz8QpS7UfqE9nMZvNrIaKDL
         ZIC/OAYOPrtbPt9UqaBvwVSnFvCQLApE0MjPnzoR4DOiEvkdUgHyuVFQ3/znjfrJBsSz
         RZdaQcsOIU2hqqWoZWaWEwi7Zfow6XlgvPlPOJxWdetxNxnnDg602tXl3CuoqmtAVWB1
         Ws9h36gaoi6CL0u0RbTSzI5IsZXPtmrao/PCK3Qao2S33m3PLJX+gXNw/4wK2FTcx7w+
         lEEOgkb+dAXIgnQFYqg30HH2mzXYmWAqLwkLi93rOwUJ1Y8DJuIfSy8gTPC20DmTxdG1
         DyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gxkMzDrTrgnbLX3v/fz1b1mgSEVz+VFOADYn816I6ac=;
        b=RvXojOPQxnomgo4u0DEehA/az2/MEDmBAtEU7e0MpbW++z6LIrIK6F5/6NC1igWSJm
         xaxRyltQP1qLseyev20XrP15WVlV7jCL+aOvEmRMh1IDeJ1E7uM49vT7GmlWaL94uDRH
         qC94GxLnLKvZchNgTHgw4DxHTWqo6IFv0z1u+hVnucc9ySG1dh+81iDw7vsv88bP5PRc
         Vmhs5ulC2+0knhb4ZG4p6AlVqQ06K10h5eD1ANkKWS/gEoFVbacj8Dk5M9C5SdZvAUhd
         de0hOi56/6CmB/w483BAnvXHCmUj5/x7F2azjLjQpWRQ7p66gXVpkIjfZPejghJY0uzy
         +CFQ==
X-Gm-Message-State: AOUpUlEXH9I4hA8tFQwIa6oquEmXrdZo4kSuHAyc+6UNqBMlZCSi5ZyM
        tEmzSfM0zzexZ2k6M6w6ex6zeScP
X-Google-Smtp-Source: AAOMgpfPzqzXvESRLmHcBLNN8pCISXBUKMhYq1Zte4H994RxLcrDaAZZ8MsypRNjQA58rbjrJ1BsMQ==
X-Received: by 2002:a63:951e:: with SMTP id p30-v6mr4195039pgd.318.1532658016311;
        Thu, 26 Jul 2018 19:20:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id q25-v6sm4399915pfk.96.2018.07.26.19.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:20:15 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     Henk.Vergonet@gmail.com, dmitry.torokhov@gmail.com
Cc:     usbb2k-api-dev@nongnu.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: misc: yealink: Replace GFP_ATOMIC with GFP_KERNEL in usb_probe()
Date:   Fri, 27 Jul 2018 10:20:07 +0800
Message-Id: <20180727022007.883-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_probe() is never called in atomic context.
It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/misc/yealink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index f0c9bf87b4e3..1365cd94ed9b 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -894,12 +894,12 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	/* allocate usb buffers */
 	yld->irq_data = usb_alloc_coherent(udev, USB_PKT_LEN,
-					   GFP_ATOMIC, &yld->irq_dma);
+					   GFP_KERNEL, &yld->irq_dma);
 	if (yld->irq_data == NULL)
 		return usb_cleanup(yld, -ENOMEM);
 
 	yld->ctl_data = usb_alloc_coherent(udev, USB_PKT_LEN,
-					   GFP_ATOMIC, &yld->ctl_dma);
+					   GFP_KERNEL, &yld->ctl_dma);
 	if (!yld->ctl_data)
 		return usb_cleanup(yld, -ENOMEM);
 
-- 
2.17.0

