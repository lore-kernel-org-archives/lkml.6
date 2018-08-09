Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C547C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D738720839
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfVwkLIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D738720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbeHIL5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:57:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41699 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeHIL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:57:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so3946944ljy.8;
        Thu, 09 Aug 2018 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ex+HFER0R5pxYKFl51UGbkJdyFEE7hcnnZH4uOL6KSU=;
        b=vfVwkLIk6IIziLlpEauxyybRWtT/YTWIi8nacWXj4Yw569LSa4a2HUtavYxxh87nMR
         Gu213GfccS9LAx5PikaApxCxMh1ShGDYPv6N+Kl4iqEhTgal+OPOpEt4eDNXgSORo6Iz
         B1u9dMM7CG09Ya0HO0zQTRoIx5krJN8NRY4CvnZN63LJGbzcX9w4z5jU+NYX9qpzN+i8
         PkOAPXhLVzy+PRy2QuVh2NtyOx/tsB/XIGTgdmd3dkoHcb6f24hzgETDf9QiKbtvzyMy
         HimBJ51mliJY97d94XnYsnEouIZlZbv7pz6Af/FIiK5Av/rO6/xfhEmW9+XsP5HjT7OC
         A/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ex+HFER0R5pxYKFl51UGbkJdyFEE7hcnnZH4uOL6KSU=;
        b=a6I9QWM3kzaCHuJomB8+WRKGpLcdrbx2Ioj8i/6iZSNqEkTl827vSqm02LgUVdwHfP
         LctCHjs9YvF9Jv/ZO85+lE5eKNLmBnVi1Mh/IwzzQbzrtO84JFhNzCSL1X2AEpDSHnWs
         MeudQMYsG1ULvpQKAgJDb1zPuISh+EpnrztJfIf+UUBcznVqPJhxFXyWsahvRrLMVarD
         bJC/VQhQU9+ZxClUUcDO1OEtKMW4CeJR+ggB+Zh7CAls0n9V9W9ODsiWa+vLaG4Bhmwl
         bcPNi6bq2OnmTtPspYiD0IeHmCYRlnA9NlzqB60Tu7LNgmgXrt012doodE7lIxlYgYwB
         ZJKA==
X-Gm-Message-State: AOUpUlGLu2M6GLbmpF3hIBQlG86Q5LRr3fUIVEWyxMhIBWpRInpbuH18
        UCfJJJf1xzjm4oFQEwk6fPKWXSO7f14=
X-Google-Smtp-Source: AA+uWPwK9N7YcdCWsZeWhL5NTUikwTdg4SZK9yFUD9CnT1Wjl8ot9ILXHnzVvNsgR9dmH3vJXGkfSw==
X-Received: by 2002:a2e:1b83:: with SMTP id c3-v6mr1094099ljf.0.1533807211195;
        Thu, 09 Aug 2018 02:33:31 -0700 (PDT)
Received: from alpha.sai.msu.ru ([93.180.21.1])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1070721ljg.62.2018.08.09.02.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:33:30 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: [PATCH v3 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Thu,  9 Aug 2018 12:33:07 +0300
Message-Id: <20180809093307.6001-3-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809093307.6001-1-matwey@sai.msu.ru>
References: <20180809093307.6001-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA cocherency slows the transfer down on systems without hardware
coherent DMA.
Instead we use noncocherent DMA memory and explicit sync at data receive
handler.

Based on previous commit the following performance benchmarks have been
carried out. Average memcpy() data transfer rate (rate) and handler
completion time (time) have been measured when running video stream at
640x480 resolution at 10fps.

x86_64 based system (Intel Core i5-3470). This platform has hardware
coherent DMA support and proposed change doesn't make big difference here.

 * kmalloc:            rate = (2.0 +- 0.4) GBps
                       time = (5.0 +- 3.0) usec
 * usb_alloc_coherent: rate = (3.4 +- 1.2) GBps
                       time = (3.5 +- 3.0) usec

We see that the measurements agree within error ranges in this case.
So theoretically predicted performance downgrade cannot be reliably measured here.

armv7l based system (TI AM335x BeagleBone Black @ 300MHz). This platform has no
hardware coherent DMA support. DMA coherence is implemented via disabled
page caching that slows down memcpy() due to memory controller behaviour.

 * kmalloc:            rate =  (114 +- 5) MBps
                       time =   (84 +- 4) usec
 * usb_alloc_coherent: rate = (28.1 +- 0.1) MBps
                       time =  (341 +- 2) usec

Note, that quantative difference leads (this commit leads to 4 times
acceleration) to qualitative behavior change in this case. As it was
stated before, the video stream cannot be successfully received at AM335x
platforms with MUSB based USB host controller due to performance issues
[1].

[1] https://www.spinics.net/lists/linux-usb/msg165735.html

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/media/usb/pwc/pwc-if.c | 47 +++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 72d2897a4b9f..17f2015a75bb 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -159,6 +159,31 @@ static const struct video_device pwc_template = {
 /***************************************************************************/
 /* Private functions */
 
+static void* pwc_alloc_urb_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle) {
+	void* buffer = kmalloc(size, GFP_KERNEL);
+
+	if (buffer == NULL) {
+		goto fail_kmalloc;
+	}
+
+	*dma_handle = dma_map_single(dev, buffer, size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, *dma_handle)) {
+		goto fail_dma_map_single;
+	}
+
+	return buffer;
+
+fail_dma_map_single:
+	kfree(buffer);
+fail_kmalloc:
+	return NULL;
+}
+
+static void pwc_free_urb_buffer(struct device *dev, size_t size, void* buffer, dma_addr_t dma_handle) {
+	dma_unmap_single(dev, dma_handle, size, DMA_FROM_DEVICE);
+	kfree(buffer);
+}
+
 static struct pwc_frame_buf *pwc_get_next_fill_buf(struct pwc_device *pdev)
 {
 	unsigned long flags = 0;
@@ -306,6 +331,8 @@ static void pwc_isoc_handler(struct urb *urb)
 	/* Reset ISOC error counter. We did get here, after all. */
 	pdev->visoc_errors = 0;
 
+	dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma, urb->transfer_buffer_length, DMA_FROM_DEVICE);
+
 	/* vsync: 0 = don't copy data
 		  1 = sync-hunt
 		  2 = synched
@@ -428,16 +455,13 @@ static int pwc_isoc_init(struct pwc_device *pdev)
 		urb->dev = udev;
 		urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
 		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
-		urb->transfer_buffer = usb_alloc_coherent(udev,
-							  ISO_BUFFER_SIZE,
-							  GFP_KERNEL,
-							  &urb->transfer_dma);
+		urb->transfer_buffer_length = ISO_BUFFER_SIZE;
+		urb->transfer_buffer = pwc_alloc_urb_buffer(&udev->dev, urb->transfer_buffer_length, &urb->transfer_dma);
 		if (urb->transfer_buffer == NULL) {
 			PWC_ERROR("Failed to allocate urb buffer %d\n", i);
 			pwc_isoc_cleanup(pdev);
 			return -ENOMEM;
 		}
-		urb->transfer_buffer_length = ISO_BUFFER_SIZE;
 		urb->complete = pwc_isoc_handler;
 		urb->context = pdev;
 		urb->start_frame = 0;
@@ -488,15 +512,14 @@ static void pwc_iso_free(struct pwc_device *pdev)
 
 	/* Freeing ISOC buffers one by one */
 	for (i = 0; i < MAX_ISO_BUFS; i++) {
-		if (pdev->urbs[i]) {
+		struct urb* urb = pdev->urbs[i];
+
+		if (urb) {
 			PWC_DEBUG_MEMORY("Freeing URB\n");
-			if (pdev->urbs[i]->transfer_buffer) {
-				usb_free_coherent(pdev->udev,
-					pdev->urbs[i]->transfer_buffer_length,
-					pdev->urbs[i]->transfer_buffer,
-					pdev->urbs[i]->transfer_dma);
+			if (urb->transfer_buffer) {
+				pwc_free_urb_buffer(&urb->dev->dev, urb->transfer_buffer_length, urb->transfer_buffer, urb->transfer_dma);
 			}
-			usb_free_urb(pdev->urbs[i]);
+			usb_free_urb(urb);
 			pdev->urbs[i] = NULL;
 		}
 	}
-- 
2.16.4

