Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E940C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYWg0Mbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeFQOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:37:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44234 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFQOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:36:54 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so9242014lfh.11;
        Sun, 17 Jun 2018 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4HGJcUTd62dWLpX0OGv003PWyZ09geI3ZVsKo3Qqsm0=;
        b=YYWg0Mbcj6CRaemhVu7fULEBYrY89ALdV1qCquKBkHbnRCdQxGy0TUDboQMKGPGKIV
         HyeThqmm4ESZc0+ely9hzJdKGBQJPjbSfAJJ5uTzvecXpqNOTo6zlj4edRJnC8zG5hqP
         WtB+p8E0I6q6FBqskHd9g8lSJNamfri2EVuuwelEU+RGoHRVobC9LSR/TWf+z35EL9Sp
         FfTdsGGHvUCii0ZbvQg5SVRny4IDuLmAKKusxCR3Tr1NbUqc7TMV2O8k05fMdwYVQyQs
         oGBT/XRNHgEyU6NLyM2APIcyhZkHueaoq9iFH0Pyad0nIgT2yyaOgoWGYKkA8oZ1JiOr
         dyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4HGJcUTd62dWLpX0OGv003PWyZ09geI3ZVsKo3Qqsm0=;
        b=S7VLGiYp+5E60N/cwLM2F/ec41YGORmtPO5ugaJE0W7sFzFp3ELjImwWMXMgQZor6e
         PR7neTZ/WwPIWqevzhLXTkkV8QAeLhc6Q6r97n4YUMGIP8H6sVipqNyNda5tQLeR7M2x
         7uJ1W4MvSqBJa7NII3NPopBTJI11L1Otyl+74az7oIRuAHIoyXWwcIc4A4Iuc6iR9eaT
         VoLO6geYPQlsZj9eF6SRnCBQt/EYz26dI8PT7dLL1rJbDh8Wc+3SFpPAV/zrqpGf66qn
         vQrAPC8OycY6kFgWMvHUbOfq/tmI8C+r7vgXED0IupJappgc7xPgMx/LXyIFAB3HvqFA
         MHvQ==
X-Gm-Message-State: APt69E2o6cor0BFQOhT0GBE5+eb2LjNFKNomksTKUdfHSYHzRFtfnr2Z
        k1eLGknumRxYZKagnnuymsk=
X-Google-Smtp-Source: ADUXVKKwH0agsods0X5mxBW4uNcliO9ZWMaCbXSqm63tibU1Ss5mfKHCScsktXfu0SjWVriTPtYjzw==
X-Received: by 2002:a2e:1010:: with SMTP id j16-v6mr6118729lje.94.1529246212250;
        Sun, 17 Jun 2018 07:36:52 -0700 (PDT)
Received: from linux-2y6e.local ([92.243.181.209])
        by smtp.gmail.com with ESMTPSA id l19-v6sm2381120lfk.30.2018.06.17.07.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 07:36:51 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, isely@pobox.com,
        bhumirks@gmail.com, colin.king@canonical.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Sun, 17 Jun 2018 17:36:25 +0300
Message-Id: <20180617143625.32133-2-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.0-rc1
In-Reply-To: <20180617143625.32133-1-matwey@sai.msu.ru>
References: <20180617143625.32133-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA cocherency slows the transfer down on systems without hardware
coherent DMA.

Based on previous commit the following performance benchmarks have been
carried out. Average memcpy() data transfer rate (rate) and handler
completion time (time) have been measured when running video stream at
640x480 resolution at 10fps.

x86_64 based system (Intel Core i5-3470). This platform has hardware
coherent DMA support and proposed change doesn't make big difference here.

 * kmalloc:            rate = (4.4 +- 1.0) GBps
                       time = (2.4 +- 1.2) usec
 * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
                       time = (2.5 +- 1.0) usec

We see that the measurements agree well within error ranges in this case.
So no performance downgrade is introduced.

armv7l based system (TI AM335x BeagleBone Black). This platform has no
hardware coherent DMA support. DMA coherence is implemented via disabled
page caching that slows down memcpy() due to memory controller behaviour.

 * kmalloc:            rate =  (190 +-  30) MBps
                       time =   (50 +-  10) usec
 * usb_alloc_coherent: rate =   (33 +-   4) MBps
                       time = (3000 +- 400) usec

Note, that quantative difference leads (this commit leads to 5 times
acceleration) to qualitative behavior change in this case. As it was
stated before, the video stream can not be successfully received at AM335x
platforms with MUSB based USB host controller due to performance issues
[1].

[1] https://www.spinics.net/lists/linux-usb/msg165735.html

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/media/usb/pwc/pwc-if.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 5775d1f60668..6a3cd9680a7f 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
 		urb->interval = 1; // devik
 		urb->dev = udev;
 		urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
-		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
-		urb->transfer_buffer = usb_alloc_coherent(udev,
-							  ISO_BUFFER_SIZE,
-							  GFP_KERNEL,
-							  &urb->transfer_dma);
+		urb->transfer_flags = URB_ISO_ASAP;
+		urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE, GFP_KERNEL);
 		if (urb->transfer_buffer == NULL) {
 			PWC_ERROR("Failed to allocate urb buffer %d\n", i);
 			pwc_isoc_cleanup(pdev);
@@ -491,10 +488,7 @@ static void pwc_iso_free(struct pwc_device *pdev)
 		if (pdev->urbs[i]) {
 			PWC_DEBUG_MEMORY("Freeing URB\n");
 			if (pdev->urbs[i]->transfer_buffer) {
-				usb_free_coherent(pdev->udev,
-					pdev->urbs[i]->transfer_buffer_length,
-					pdev->urbs[i]->transfer_buffer,
-					pdev->urbs[i]->transfer_dma);
+				kfree(pdev->urbs[i]->transfer_buffer);
 			}
 			usb_free_urb(pdev->urbs[i]);
 			pdev->urbs[i] = NULL;
-- 
2.16.0-rc1

