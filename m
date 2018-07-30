Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF78120881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDvD11fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF78120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeG3K6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:58:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40742 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeG3K6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:58:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so4267177pff.7;
        Mon, 30 Jul 2018 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uQ9newEHcGdTfHYxexpgeCSpanVtUOSJPKQQb8/8RxI=;
        b=TDvD11fAdkYX25xKpHUvSKegyTcjKPLjd9GWx5BxusjEeciaRLkfAOh2xe4QZtfSqC
         8hmww5CQI8/mZx66bmRNCjpg9MbLbsfNhdQse8q7U8rVsOxL6Hi+FQvhgeYOtY8zMO3o
         ogk5DYRIvemXccb8+rCqzHXcD4fdNmSYeeO6itysaQQjBcKzlUFnvUPLlHJnVJOXmRJ8
         /q/cJJIqSs83wQCMYHY/BXc3tftN296YzTdRO/vtQZAQ7vWDy/mNj70ChdWRSe6G9VUJ
         ioeB6w6X69kfatxVIaxO/+AnpbTHqTIDrI6huThoP4CBEf6fHdra2FukfIwaeLw+0EPP
         sj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uQ9newEHcGdTfHYxexpgeCSpanVtUOSJPKQQb8/8RxI=;
        b=CfNJXgC22rPLCnFQ8I17mg7C91lqD2q2JqfyLehqZ0pfoWTQiMzIpM6ddlwMD/9VLe
         Vs1fM7t6Kt2W6NcrnlvdpEEN55nVA1vhGjyc6fpRnmQ6575pO8yZk5L9SU/4kp5lgzrw
         XM3YOiFKC0ncPCL5Qm9MsZprqmDlyDEk9vh9ojMJuXXWfnOq8GaCr/5Sbrx7sckYNJhJ
         GZqz5iiVsQSlrvKvlaGQIzpUoHEIiatInPmdHJWP5pUS10m1yGTb/vfR2WA5raY7ndcc
         3GPCYCPnlMbrIcWi7ED+t32lvjObMC+MMhNR0Z1EfMz+6NyYSkBal1v/XJf1wECK1Wkg
         zx+A==
X-Gm-Message-State: AOUpUlGPwFSt+sXy5T87skcUljtHFejxsZYzF/+FZhFf06OIBWW8ZbL4
        63DZhj7BftzWxOkOmDpTMDM=
X-Google-Smtp-Source: AAOMgpdKx195s4Mj9lEHfxMJlwYC4Zt5xKvXTkpfTKHyQIEifLF7hVfEyhS1/uZ6yv1MLj/EPfUwsg==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr17257532pfi.66.1532942649791;
        Mon, 30 Jul 2018 02:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id j1-v6sm29092327pfk.125.2018.07.30.02.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:24:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3] media: usb: em28xx: Replace GFP_ATOMIC with GFP_KERNEL in em28xx_audio_urb_init()
Date:   Mon, 30 Jul 2018 17:23:52 +0800
Message-Id: <20180730092352.7775-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

em28xx_audio_urb_init() is never called in atomic context.
It calls kcalloc(), usb_alloc_urb() and usb_alloc_coherent() 
with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-audio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index 8e799ae1df69..bb510cf8fbbb 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -842,11 +842,11 @@ static int em28xx_audio_urb_init(struct em28xx *dev)
 
 	dev->adev.transfer_buffer = kcalloc(num_urb,
 					    sizeof(*dev->adev.transfer_buffer),
-					    GFP_ATOMIC);
+					    GFP_KERNEL);
 	if (!dev->adev.transfer_buffer)
 		return -ENOMEM;
 
-	dev->adev.urb = kcalloc(num_urb, sizeof(*dev->adev.urb), GFP_ATOMIC);
+	dev->adev.urb = kcalloc(num_urb, sizeof(*dev->adev.urb), GFP_KERNEL);
 	if (!dev->adev.urb) {
 		kfree(dev->adev.transfer_buffer);
 		return -ENOMEM;
@@ -859,14 +859,14 @@ static int em28xx_audio_urb_init(struct em28xx *dev)
 		int j, k;
 		void *buf;
 
-		urb = usb_alloc_urb(npackets, GFP_ATOMIC);
+		urb = usb_alloc_urb(npackets, GFP_KERNEL);
 		if (!urb) {
 			em28xx_audio_free_urb(dev);
 			return -ENOMEM;
 		}
 		dev->adev.urb[i] = urb;
 
-		buf = usb_alloc_coherent(udev, npackets * ep_size, GFP_ATOMIC,
+		buf = usb_alloc_coherent(udev, npackets * ep_size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			dev_err(&dev->intf->dev,
-- 
2.17.0

