Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3981C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BAA21A74
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKszakGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BAA21A74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeHIMdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:33:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46518 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:33:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so8804833oie.13;
        Thu, 09 Aug 2018 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xOq1l3EzOFY8iaHOqkQZ92za2Gff8OkNBVlZyyaLtOI=;
        b=nKszakGbPGO0u2dbI0c4iK7XUSMRBIfpuRTQnG9T0cQ5nMVHlu6//E1vZI5Y8zXcqI
         3tip8+TXK/Q0IZN6BAFiPl2wiLhsDebZuZ4brfLgzCoMEm6H+ookgTDx8rVT5QXTO1/K
         wHWK8sn4ow9Ckc2bd6n5qE3+9Zaa3Yu/OibIVX6OQHJesWIu2+nPd7vYTz0EcjFea5b4
         urlbgd+eCvW4LdNGOuUXlYTQqNLCRD7buCsUws2ijnFq0PHZ83F9AiYbQTgFcbigHfbE
         KEFtRkSkFLasJQ1a39s/eKobf7I64pNpvsPgYm8tmE8t4o/VRF3vBJ4p5/VfTAoeGwBe
         jMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xOq1l3EzOFY8iaHOqkQZ92za2Gff8OkNBVlZyyaLtOI=;
        b=eaKVLIooCnK+Db1jSuPsjeGTsW9T1A0/g9iTNLno/Dcp0ArBy73Mst6CiwdwUXKSYb
         F20GApwZ5lhr6giWS9Xls2e6PVFDCsqijfHXnwrGd9xPv/eVGe/N1+vhiua9KJwb8yG8
         6mhlC0pixKQTHEUJl87yDQZf4S0scDfhD6RvA9ekfnkztLKdkzvbIeyEScsXq7j3SEd4
         PYD1SuuB+w2j7FvCSjVe/qn/gVdQ7M5XEZAdFlVkqoa83Q4AN/RJPpnUFv7unAPy/OWG
         HS9uPGzZ+w+iynEx19xKV+N4a/QDZ3rDagthZiASkaaqMsGN/nqWPBAwQs1XyMl9TIIq
         HVxw==
X-Gm-Message-State: AOUpUlGRwU14qQsOyjyDL3O02BUZQSagrWSD2qf82jG3vdamzobKMLpz
        1u5AuG1ImkKsbFimYiGn9rmFdnrEymtA16IpAUM=
X-Google-Smtp-Source: AA+uWPwfh5qW1+zXrMnTm+6i4awD6+FZGgF8KHlDbo5ZxeqVY4eXTbrmO/TXpIN5d6HWOAagk8Uh7UbfiWA5CBfNvKk=
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr1536868oig.98.1533809348925;
 Thu, 09 Aug 2018 03:09:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 03:08:48 -0700 (PDT)
In-Reply-To: <1999611.3qB5YXmi7D@avalon>
References: <20180809093307.6001-1-matwey@sai.msu.ru> <20180809093307.6001-3-matwey@sai.msu.ru>
 <1999611.3qB5YXmi7D@avalon>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Thu, 9 Aug 2018 13:08:48 +0300
X-Google-Sender-Auth: pbsr9tZGwMj3Z-qSQSmv_mfpPdI
Message-ID: <CAJs94EaDGKTk_LpZaLpbLDMfBrHULx3yeXBK9ZCEg-hBmXv9dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-09 12:51 GMT+03:00 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Matwey,
>
> Thank you for the patch.
>
> On Thursday, 9 August 2018 12:33:07 EEST Matwey V. Kornilov wrote:
>> DMA cocherency slows the transfer down on systems without hardware
>> coherent DMA. Instead we use noncocherent DMA memory and explicit sync at
>> data receive handler.
>>
>> Based on previous commit the following performance benchmarks have been
>> carried out. Average memcpy() data transfer rate (rate) and handler
>> completion time (time) have been measured when running video stream at
>> 640x480 resolution at 10fps.
>>
>> x86_64 based system (Intel Core i5-3470). This platform has hardware
>> coherent DMA support and proposed change doesn't make big difference here.
>>
>>  * kmalloc:            rate = (2.0 +- 0.4) GBps
>>                        time = (5.0 +- 3.0) usec
>>  * usb_alloc_coherent: rate = (3.4 +- 1.2) GBps
>>                        time = (3.5 +- 3.0) usec
>>
>> We see that the measurements agree within error ranges in this case.
>> So theoretically predicted performance downgrade cannot be reliably measured
>> here.
>>
>> armv7l based system (TI AM335x BeagleBone Black @ 300MHz). This platform has
>> no hardware coherent DMA support. DMA coherence is implemented via disabled
>> page caching that slows down memcpy() due to memory controller behaviour.
>>
>>  * kmalloc:            rate =  (114 +- 5) MBps
>>                        time =   (84 +- 4) usec
>>  * usb_alloc_coherent: rate = (28.1 +- 0.1) MBps
>>                        time =  (341 +- 2) usec
>>
>> Note, that quantative difference leads (this commit leads to 4 times
>> acceleration) to qualitative behavior change in this case. As it was
>> stated before, the video stream cannot be successfully received at AM335x
>> platforms with MUSB based USB host controller due to performance issues
>> [1].
>>
>> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  drivers/media/usb/pwc/pwc-if.c | 47 ++++++++++++++++++++++++++++-----------
>>  1 file changed, 35 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
>> index 72d2897a4b9f..17f2015a75bb 100644
>> --- a/drivers/media/usb/pwc/pwc-if.c
>> +++ b/drivers/media/usb/pwc/pwc-if.c
>> @@ -159,6 +159,31 @@ static const struct video_device pwc_template = {
>>  /**************************************************************************
>> */ /* Private functions */
>>
>> +static void* pwc_alloc_urb_buffer(struct device *dev, size_t size,
>> dma_addr_t *dma_handle) {
>
> There are several violations of the Linux coding style here, could you please
> run your patch through checkpatch.pl to fix them ?

Thanks. I'll fix them. I really need to configure git hooks with checkpatch.

>
>> +     void* buffer = kmalloc(size, GFP_KERNEL);
>> +
>> +     if (buffer == NULL) {
>> +             goto fail_kmalloc;
>> +     }
>
> No need for a goto, you can just return NULL here.
>
>> +     *dma_handle = dma_map_single(dev, buffer, size, DMA_FROM_DEVICE);
>> +     if (dma_mapping_error(dev, *dma_handle)) {
>> +             goto fail_dma_map_single;
>
> And you can inline the error handling code here as it's used from a single
> location.
>
>> +     }
>> +
>> +     return buffer;
>> +
>> +fail_dma_map_single:
>> +     kfree(buffer);
>> +fail_kmalloc:
>> +     return NULL;
>> +}
>> +
>> +static void pwc_free_urb_buffer(struct device *dev, size_t size, void*
>> buffer, dma_addr_t dma_handle) {
>> +     dma_unmap_single(dev, dma_handle, size, DMA_FROM_DEVICE);
>> +     kfree(buffer);
>> +}
>> +
>>  static struct pwc_frame_buf *pwc_get_next_fill_buf(struct pwc_device *pdev)
>> {
>>       unsigned long flags = 0;
>> @@ -306,6 +331,8 @@ static void pwc_isoc_handler(struct urb *urb)
>>       /* Reset ISOC error counter. We did get here, after all. */
>>       pdev->visoc_errors = 0;
>>
>> +     dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
>> urb->transfer_buffer_length, DMA_FROM_DEVICE);
>> +
>>       /* vsync: 0 = don't copy data
>>                 1 = sync-hunt
>>                 2 = synched
>> @@ -428,16 +455,13 @@ static int pwc_isoc_init(struct pwc_device *pdev)
>>               urb->dev = udev;
>>               urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
>>               urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
>> -             urb->transfer_buffer = usb_alloc_coherent(udev,
>> -                                                       ISO_BUFFER_SIZE,
>> -                                                       GFP_KERNEL,
>> -                                                       &urb->transfer_dma);
>> +             urb->transfer_buffer_length = ISO_BUFFER_SIZE;
>> +             urb->transfer_buffer = pwc_alloc_urb_buffer(&udev->dev,
>> urb->transfer_buffer_length, &urb->transfer_dma);
>>               if (urb->transfer_buffer == NULL) {
>>                       PWC_ERROR("Failed to allocate urb buffer %d\n", i);
>>                       pwc_isoc_cleanup(pdev);
>>                       return -ENOMEM;
>>               }
>> -             urb->transfer_buffer_length = ISO_BUFFER_SIZE;
>>               urb->complete = pwc_isoc_handler;
>>               urb->context = pdev;
>>               urb->start_frame = 0;
>> @@ -488,15 +512,14 @@ static void pwc_iso_free(struct pwc_device *pdev)
>>
>>       /* Freeing ISOC buffers one by one */
>>       for (i = 0; i < MAX_ISO_BUFS; i++) {
>> -             if (pdev->urbs[i]) {
>> +             struct urb* urb = pdev->urbs[i];
>> +
>> +             if (urb) {
>>                       PWC_DEBUG_MEMORY("Freeing URB\n");
>> -                     if (pdev->urbs[i]->transfer_buffer) {
>> -                             usb_free_coherent(pdev->udev,
>> -                                     pdev->urbs[i]->transfer_buffer_length,
>> -                                     pdev->urbs[i]->transfer_buffer,
>> -                                     pdev->urbs[i]->transfer_dma);
>> +                     if (urb->transfer_buffer) {
>> +                             pwc_free_urb_buffer(&urb->dev->dev, urb->transfer_buffer_length,
>> urb->transfer_buffer, urb->transfer_dma); }
>> -                     usb_free_urb(pdev->urbs[i]);
>> +                     usb_free_urb(urb);
>>                       pdev->urbs[i] = NULL;
>>               }
>>       }
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
