Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CFBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8FF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiJR9uBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8FF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeG0EMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:12:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35232 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeG0EMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:12:36 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so1672134plq.2;
        Thu, 26 Jul 2018 19:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=91B6a86QVGszavNjsra5ZaWT6Vl1493aO3Bd4/ZdI8E=;
        b=EiJR9uBt0gOpqcFZLPnQsz0QVMkSDG9wg0iAoHmap5x/R5j4Qxrn5uKVKTwb3AzDgu
         pZVRl5m6DpQ3Rj00PfdrtZhqbTdrnlJ/7fSGV7ugzwilMwhBkv8TMrQUNyamvqNaTWfn
         k7734z45xy7VHQsBFa5d0oGJnTs+zMes7jvsgz5Vu/xc8x7cqXTBc3XXZXMulWJlMw3R
         owycV+1iIViSeB0U2veo04j5PuvLeqGz0mixsb8bvKsqA5A5X82flS8PFCt3QW2/vEsw
         XQ3Z+rYMoKrCk2zGb3ip3F0bzCiTOH86vO/qPN2GStBsTCme5T+hdo6cGZa1SkWiw2oZ
         iG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=91B6a86QVGszavNjsra5ZaWT6Vl1493aO3Bd4/ZdI8E=;
        b=FxV8V8BIyKdvSF0uHGfRRA9+lEjo3OFxHzShC1lxjNMFoEHRr7kM/499+XZPzmyw1n
         YCxfJpCl3y3+lAd447LUdAeJDei4uNigXQScTW88izKiYwlizuv2Nq9wNT1lBzPIoXLs
         6aOGjWP0HPzd9y9YiB9iFF5GwnPxDvejtRWQ1izCDg7cdVSatYc7p4y5IV6xv5WiveBD
         0bSGbGR6BRX0vc6kSgB4ycfV6wOhou0Cs4PEcJFYBBFd2XKVlqy3JofUazrUfc6ZLoV3
         ZYgHznBpw6OXcj/3O2e/cealkEqeYYutOcHpv72fjvmbigtFQYFVWsb/J7W4wXh7TR8Q
         0FUQ==
X-Gm-Message-State: AOUpUlGXUw65rFHJDhTaiMlpy/CSL4zB2SZe6az6CoUfE/NiW8WTy23Z
        Pou68WSRD1TzqKw6hPDuBsw=
X-Google-Smtp-Source: AAOMgpfxaEEb1fktbrSos5PWxKyO6AMGFMQ8Whhshelc/iPmY0g5lG+/Q3XBfYi/k9tVWul8WQc8jQ==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr4367094pla.60.1532659976583;
        Thu, 26 Jul 2018 19:52:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id f18-v6sm8701675pff.29.2018.07.26.19.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:52:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: dvb-frontends: rtl2832_sdr: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Fri, 27 Jul 2018 10:52:49 +0800
Message-Id: <20180727025249.2249-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl2832_sdr_submit_urbs(), rtl2832_sdr_alloc_stream_bufs(), and 
rtl2832_sdr_alloc_urbs() are never called in atomic context.
They call usb_submit_urb(), usb_alloc_coherent() and usb_alloc_urb() 
with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/dvb-frontends/rtl2832_sdr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index c6e78d870ccd..d448d9d4879c 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -301,7 +301,7 @@ static int rtl2832_sdr_submit_urbs(struct rtl2832_sdr_dev *dev)
 
 	for (i = 0; i < dev->urbs_initialized; i++) {
 		dev_dbg(&pdev->dev, "submit urb=%d\n", i);
-		ret = usb_submit_urb(dev->urb_list[i], GFP_ATOMIC);
+		ret = usb_submit_urb(dev->urb_list[i], GFP_KERNEL);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Could not submit urb no. %d - get them all back\n",
@@ -345,7 +345,7 @@ static int rtl2832_sdr_alloc_stream_bufs(struct rtl2832_sdr_dev *dev)
 
 	for (dev->buf_num = 0; dev->buf_num < MAX_BULK_BUFS; dev->buf_num++) {
 		dev->buf_list[dev->buf_num] = usb_alloc_coherent(dev->udev,
-				BULK_BUFFER_SIZE, GFP_ATOMIC,
+				BULK_BUFFER_SIZE, GFP_KERNEL,
 				&dev->dma_addr[dev->buf_num]);
 		if (!dev->buf_list[dev->buf_num]) {
 			dev_dbg(&pdev->dev, "alloc buf=%d failed\n",
@@ -390,7 +390,7 @@ static int rtl2832_sdr_alloc_urbs(struct rtl2832_sdr_dev *dev)
 	/* allocate the URBs */
 	for (i = 0; i < MAX_BULK_BUFS; i++) {
 		dev_dbg(&pdev->dev, "alloc urb=%d\n", i);
-		dev->urb_list[i] = usb_alloc_urb(0, GFP_ATOMIC);
+		dev->urb_list[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!dev->urb_list[i]) {
 			for (j = 0; j < i; j++)
 				usb_free_urb(dev->urb_list[j]);
-- 
2.17.0

