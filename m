Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A1DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abWD5YAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629C520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeG3LHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:07:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeG3LHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:07:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so4275656pfn.8;
        Mon, 30 Jul 2018 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C0qdcMQ4xD0ood1tgWz95bY+LNq+sNtaiH+ZmrcF3Io=;
        b=abWD5YAg1HWjw9UJ4GtFiFNWgpXVwT2qp37azHW86k9zu9IrQjlZ+GKtTKOdiuXCcj
         K1gH471u3gkIGYWI2vVGRDhlWoPEGJLlCIiOCHHTYyoYGPco/sqjbv2pUQtp5fS6BRsj
         S4ur9QlWL2x+bimT+iEJjFt88RhsZ6dl2S666zSwJ1SONoi3CPgcYnkgDf811qi3Jyin
         jAA+umWsehFfB6Tctnq8kWuat7iyjyT4rRLgHZrqjHWR8sfZcgVKcmubulRWHLKW5YC5
         2AimQhF1VDRd7DbkX9bkncGU+qkxMclL47CsYfKTd4/ZvpApLyqgkl/F1F7LGx8SY4zv
         +yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C0qdcMQ4xD0ood1tgWz95bY+LNq+sNtaiH+ZmrcF3Io=;
        b=Lv3XXVIMbMRuGCesEpTrfcUNeb/ptFRgIFgqBhfdnjynPPwF8mColF4Qct/QFFUdOt
         MSe6U1DK65Hv7oRlbz5/T0hs+jaZhn25e9s6XUEjx5QioJ+K/DsE6Hx9GZDZzHrtyZhR
         Hm+4Y3CMwVKCNOU11oiSuWlM4OcjdY3O7Ex1wOtEyVl9qMqUUAIYWWv5ve8fK+A4zrFj
         DIU/qILP2eQ9QG7oRkIcFzBobCuRWGoJTwQpFLZ81V3SpDXf76DyrwrRDPEtX+eBUh0O
         655ZeA6qrmuBCLWU8l9UR9nIUj7e8nI0iUAHraMxZ4uHPvXOyygYXlgSpeFHU50VDYis
         g7FQ==
X-Gm-Message-State: AOUpUlE/N30W8nJL8l1CV8+ZaLOnOaUcBJuTOoMVCNIsQgdmR/SWtwca
        LJl0tvmh4p9bnxvgFZAr8mI=
X-Google-Smtp-Source: AAOMgpdnWWd4PClpJ0QpfXiRzvVWzvxYpO8GXxH1UqXq3N0D9QQTx9MUVlhqCZ9gUX0d3qZpzxJ80w==
X-Received: by 2002:a62:1756:: with SMTP id 83-v6mr1089883pfx.217.1532943210759;
        Mon, 30 Jul 2018 02:33:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id v22-v6sm27419868pfi.60.2018.07.30.02.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:33:30 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: usb: hackrf: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Mon, 30 Jul 2018 17:33:20 +0800
Message-Id: <20180730093320.8007-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hackrf_submit_urbs(), hackrf_alloc_stream_bufs() and hackrf_alloc_urbs() 
are never called in atomic context.
They call usb_submit_urb(), usb_alloc_coherent() and usb_alloc_urb() 
with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/usb/hackrf/hackrf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
index 7eb53517a82f..520a3c6dee43 100644
--- a/drivers/media/usb/hackrf/hackrf.c
+++ b/drivers/media/usb/hackrf/hackrf.c
@@ -597,7 +597,7 @@ static int hackrf_submit_urbs(struct hackrf_dev *dev)
 
 	for (i = 0; i < dev->urbs_initialized; i++) {
 		dev_dbg(dev->dev, "submit urb=%d\n", i);
-		ret = usb_submit_urb(dev->urb_list[i], GFP_ATOMIC);
+		ret = usb_submit_urb(dev->urb_list[i], GFP_KERNEL);
 		if (ret) {
 			dev_err(dev->dev, "Could not submit URB no. %d - get them all back\n",
 					i);
@@ -636,7 +636,7 @@ static int hackrf_alloc_stream_bufs(struct hackrf_dev *dev)
 
 	for (dev->buf_num = 0; dev->buf_num < MAX_BULK_BUFS; dev->buf_num++) {
 		dev->buf_list[dev->buf_num] = usb_alloc_coherent(dev->udev,
-				BULK_BUFFER_SIZE, GFP_ATOMIC,
+				BULK_BUFFER_SIZE, GFP_KERNEL,
 				&dev->dma_addr[dev->buf_num]);
 		if (!dev->buf_list[dev->buf_num]) {
 			dev_dbg(dev->dev, "alloc buf=%d failed\n",
@@ -689,7 +689,7 @@ static int hackrf_alloc_urbs(struct hackrf_dev *dev, bool rcv)
 	/* allocate the URBs */
 	for (i = 0; i < MAX_BULK_BUFS; i++) {
 		dev_dbg(dev->dev, "alloc urb=%d\n", i);
-		dev->urb_list[i] = usb_alloc_urb(0, GFP_ATOMIC);
+		dev->urb_list[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!dev->urb_list[i]) {
 			for (j = 0; j < i; j++)
 				usb_free_urb(dev->urb_list[j]);
-- 
2.17.0

