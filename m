Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3DEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E092238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MazHHn/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E092238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeHIUhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43612 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeHIUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id f135-v6so4745549lfg.10;
        Thu, 09 Aug 2018 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=to8uY8hbfuZ+yD+ZvU37tf7XlezIuz6xFDBYGQhmSaE=;
        b=MazHHn/q9JyO8s5ii30IdWhONbmuyN6nMQih7Wr61fh1eLNpbTzAxFnosIJkCdIl6w
         NRwedEnkWPtsImmsGg9hwGgb2XnEddAlMidooA4l7ZEUq3jsn2p9gAlZDU2NyE7KEhWi
         UMMOxPFoqqNQKk3MkVYMAC7/G6OiUHmCbjFROVEtKCJ1A3oawytaXZ+k8oh7C0IBL5TJ
         2hJSa58pr7b/bux+gl00bcl+cKop29nBa5BKvzVO/kr6P88n0Q2m//zKd6FXohC0yvD7
         JYbHcfBbDFgoggiz4K2P1hIFGKmAQmUJbAsFIG7kzFbi0dAsVb3dmbhTKVNjUFAt1jcD
         x9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=to8uY8hbfuZ+yD+ZvU37tf7XlezIuz6xFDBYGQhmSaE=;
        b=P0hy+uZ4VmFL4EtrlOyzbKO08fFYiSUg3AW9ZBKJvumYsaAUjkioK43J2B0T81GFaV
         EGTk028qZ1Sma5AcqUJmcT77ujgqkW2vjipIuddXsj7q8sHJEO8izMn/svrmkQmvzvsO
         4ZKTYSOF/dOYij+umw2TFkqNO8bE6C8n9qNDdx7X4Z94t3NSEWaGOiLwZs87lfajcyLa
         9G+J1f9h0CHkJBoomIgbM2vz1NhJGB110gLMZQ+eCSlLtGwGmDdJU+RxmF0+N8mr5Ddk
         9TRzs7H1G+9ll9PN3z/DMIz3eZUuRWUBSQgLAxgYtfRS5ERJ7quGkMZc8B9ttES3JvfC
         3XBA==
X-Gm-Message-State: AOUpUlEMrgXP1Q8JlVoAze7dpJ3nGV6suGNNoVam4mJwrXc3B2IoruPg
        K2x4leEOgbBbowY3rTEuNu6wW4Mbk7Q=
X-Google-Smtp-Source: AA+uWPzqQM3//u0Q5DN1H8GmkLNBk1qX07dgvRtyTRVD4RdMSxVshRch4E+Y2ZY4DgHrCgf2W3DuEA==
X-Received: by 2002:a19:5911:: with SMTP id n17-v6mr2397323lfb.102.1533838299776;
        Thu, 09 Aug 2018 11:11:39 -0700 (PDT)
Received: from localhost.localdomain ([213.87.133.10])
        by smtp.gmail.com with ESMTPSA id n7-v6sm1432211lfe.87.2018.08.09.11.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:39 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: [PATCH v4 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Thu,  9 Aug 2018 21:11:03 +0300
Message-Id: <20180809181103.15437-3-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809181103.15437-1-matwey@sai.msu.ru>
References: <20180809181103.15437-1-matwey@sai.msu.ru>
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
So theoretically predicted performance downgrade cannot be reliably
measured here.

armv7l based system (TI AM335x BeagleBone Black @ 300MHz). This platform
has no hardware coherent DMA support. DMA coherence is implemented via
disabled page caching that slows down memcpy() due to memory controller
behaviour.

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
 drivers/media/usb/pwc/pwc-if.c | 56 +++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 72d2897a4b9f..e9c826be1ba6 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -159,6 +159,32 @@ static const struct video_device pwc_template = {
 /***************************************************************************/
 /* Private functions */
 
+static void *pwc_alloc_urb_buffer(struct device *dev,
+				  size_t size, dma_addr_t *dma_handle)
+{
+	void *buffer = kmalloc(size, GFP_KERNEL);
+
+	if (!buffer)
+		return NULL;
+
+	*dma_handle = dma_map_single(dev, buffer, size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, *dma_handle)) {
+		kfree(buffer);
+		return NULL;
+	}
+
+	return buffer;
+}
+
+static void pwc_free_urb_buffer(struct device *dev,
+				size_t size,
+				void *buffer,
+				dma_addr_t dma_handle)
+{
+	dma_unmap_single(dev, dma_handle, size, DMA_FROM_DEVICE);
+	kfree(buffer);
+}
+
 static struct pwc_frame_buf *pwc_get_next_fill_buf(struct pwc_device *pdev)
 {
 	unsigned long flags = 0;
@@ -306,6 +332,11 @@ static void pwc_isoc_handler(struct urb *urb)
 	/* Reset ISOC error counter. We did get here, after all. */
 	pdev->visoc_errors = 0;
 
+	dma_sync_single_for_cpu(&urb->dev->dev,
+				urb->transfer_dma,
+				urb->transfer_buffer_length,
+				DMA_FROM_DEVICE);
+
 	/* vsync: 0 = don't copy data
 		  1 = sync-hunt
 		  2 = synched
@@ -428,16 +459,15 @@ static int pwc_isoc_init(struct pwc_device *pdev)
 		urb->dev = udev;
 		urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
 		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
-		urb->transfer_buffer = usb_alloc_coherent(udev,
-							  ISO_BUFFER_SIZE,
-							  GFP_KERNEL,
-							  &urb->transfer_dma);
+		urb->transfer_buffer_length = ISO_BUFFER_SIZE;
+		urb->transfer_buffer = pwc_alloc_urb_buffer(&udev->dev,
+							    urb->transfer_buffer_length,
+							    &urb->transfer_dma);
 		if (urb->transfer_buffer == NULL) {
 			PWC_ERROR("Failed to allocate urb buffer %d\n", i);
 			pwc_isoc_cleanup(pdev);
 			return -ENOMEM;
 		}
-		urb->transfer_buffer_length = ISO_BUFFER_SIZE;
 		urb->complete = pwc_isoc_handler;
 		urb->context = pdev;
 		urb->start_frame = 0;
@@ -488,15 +518,17 @@ static void pwc_iso_free(struct pwc_device *pdev)
 
 	/* Freeing ISOC buffers one by one */
 	for (i = 0; i < MAX_ISO_BUFS; i++) {
-		if (pdev->urbs[i]) {
+		struct urb *urb = pdev->urbs[i];
+
+		if (urb) {
 			PWC_DEBUG_MEMORY("Freeing URB\n");
-			if (pdev->urbs[i]->transfer_buffer) {
-				usb_free_coherent(pdev->udev,
-					pdev->urbs[i]->transfer_buffer_length,
-					pdev->urbs[i]->transfer_buffer,
-					pdev->urbs[i]->transfer_dma);
+			if (urb->transfer_buffer) {
+				pwc_free_urb_buffer(&urb->dev->dev,
+						    urb->transfer_buffer_length,
+						    urb->transfer_buffer,
+						    urb->transfer_dma);
 			}
-			usb_free_urb(pdev->urbs[i]);
+			usb_free_urb(urb);
 			pdev->urbs[i] = NULL;
 		}
 	}
-- 
2.16.4

