Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17D92089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQtZmy+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17D92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeGMQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:27:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34543 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbeGMQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:27:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so63190482ois.1;
        Fri, 13 Jul 2018 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eelG9iYJJv+66k6Bki84DNMMVvKoUSpQKhQJutGFxt0=;
        b=qQtZmy+uA3Xcl7tFVV3rB2d84asZgevXZaVAZfC2ttyJXL+yDNuaEUWJP73OlrEZDs
         EL8zkrVbbhWis+s67CyvigS7tz8QgKpWfnc3ctU/eZhXqF0LlbCyCZ8egqeVtuLqsv8Z
         VQ3c8n+jtMlD7ajzL1xuATqIk1nNCGdf/AoeJpeGcW4s8TTtozfSG/4gRuGm4np1a+pl
         6foV8SU6K01yoSyouvEf4eBgUoWzHNlVUTWsLiUwAS2Bey3F2q5yNUUPjoWHHT2B9Idm
         Dmhd85s/vZ7zcX7DbCCp6f1mCbJf7jLWHgAje6A6ezRnwc8HDOhiJ6WABUMhBWDVwKLl
         iQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eelG9iYJJv+66k6Bki84DNMMVvKoUSpQKhQJutGFxt0=;
        b=grolVdc+2eFF0kIAPuoA7PV4SXo/kLnNjRiH0sOsSpLDQnaprmeekKv6Lwp3RsXTpR
         3+EVNoDyVLPTpVGU77bvGTXHtrj4LSVZS2JZBuWYbc3ycDdN1lFvLFuTW+wwzMPbsAXi
         OK3hO2cib0cY4gFuIxBrPE+YiUsdOxQ58nVx3PpQk6cht0vPWZE5z3K0JFLX+40Cz+GF
         yc4WzXfBXVPzmy6HJ6zR6FZNQSj+YmcWTmibuGY55OL2Mou2Q7oL6H4aGWvC9rKcoH8S
         EgXR7PqvTONkea2gIBkSYFyNKsUKsJJD68A9HzLUxYGJv2fcB747yWkEvuWWiy8uxBxF
         SRdw==
X-Gm-Message-State: AOUpUlENVKdqlCdu2RAocdcArV4N4NHNOxD7mlcdBkj481mOpPCuKxZu
        JYx9ofGhDpv5RBqyDe4wnIsrGFoQoa7o96Fgw+8=
X-Google-Smtp-Source: AAOMgpfpiRqZB+kuBCu7RlqBGX4On5T5BQS8iWbWgTEK0X3UX0BnDoudsxUlE1Fulumj18aYibd/qn7FB3ZRfOVK2AE=
X-Received: by 2002:aca:578b:: with SMTP id l133-v6mr7931490oib.329.1531498325950;
 Fri, 13 Jul 2018 09:12:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 09:11:45 -0700 (PDT)
In-Reply-To: <20180622120419.7675-3-matwey@sai.msu.ru>
References: <20180622120419.7675-1-matwey@sai.msu.ru> <20180622120419.7675-3-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Fri, 13 Jul 2018 19:11:45 +0300
X-Google-Sender-Auth: XaoVtY-KnAbEzpWnHATXC-6oajk
Message-ID: <CAJs94EbjUMRQSz+nnuUOX3TuQoGqUDo=-VQrXEbCgsZLZboniQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-22 15:04 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
> DMA cocherency slows the transfer down on systems without hardware
> coherent DMA.
>

Ping.

> Based on previous commit the following performance benchmarks have been
> carried out. Average memcpy() data transfer rate (rate) and handler
> completion time (time) have been measured when running video stream at
> 640x480 resolution at 10fps.
>
> x86_64 based system (Intel Core i5-3470). This platform has hardware
> coherent DMA support and proposed change doesn't make big difference here.
>
>  * kmalloc:            rate = (4.4 +- 1.0) GBps
>                        time = (2.4 +- 1.2) usec
>  * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
>                        time = (2.5 +- 1.0) usec
>
> We see that the measurements agree well within error ranges in this case.
> So no performance downgrade is introduced.
>
> armv7l based system (TI AM335x BeagleBone Black). This platform has no
> hardware coherent DMA support. DMA coherence is implemented via disabled
> page caching that slows down memcpy() due to memory controller behaviour.
>
>  * kmalloc:            rate =  (190 +-  30) MBps
>                        time =   (50 +-  10) usec
>  * usb_alloc_coherent: rate =   (33 +-   4) MBps
>                        time = (3000 +- 400) usec
>
> Note, that quantative difference leads (this commit leads to 5 times
> acceleration) to qualitative behavior change in this case. As it was
> stated before, the video stream can not be successfully received at AM335x
> platforms with MUSB based USB host controller due to performance issues
> [1].
>
> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/media/usb/pwc/pwc-if.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
> index 72d2897a4b9f..339a285600d1 100644
> --- a/drivers/media/usb/pwc/pwc-if.c
> +++ b/drivers/media/usb/pwc/pwc-if.c
> @@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
>                 urb->interval = 1; // devik
>                 urb->dev = udev;
>                 urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
> -               urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
> -               urb->transfer_buffer = usb_alloc_coherent(udev,
> -                                                         ISO_BUFFER_SIZE,
> -                                                         GFP_KERNEL,
> -                                                         &urb->transfer_dma);
> +               urb->transfer_flags = URB_ISO_ASAP;
> +               urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE, GFP_KERNEL);
>                 if (urb->transfer_buffer == NULL) {
>                         PWC_ERROR("Failed to allocate urb buffer %d\n", i);
>                         pwc_isoc_cleanup(pdev);
> @@ -491,10 +488,7 @@ static void pwc_iso_free(struct pwc_device *pdev)
>                 if (pdev->urbs[i]) {
>                         PWC_DEBUG_MEMORY("Freeing URB\n");
>                         if (pdev->urbs[i]->transfer_buffer) {
> -                               usb_free_coherent(pdev->udev,
> -                                       pdev->urbs[i]->transfer_buffer_length,
> -                                       pdev->urbs[i]->transfer_buffer,
> -                                       pdev->urbs[i]->transfer_dma);
> +                               kfree(pdev->urbs[i]->transfer_buffer);
>                         }
>                         usb_free_urb(pdev->urbs[i]);
>                         pdev->urbs[i] = NULL;
> --
> 2.16.4
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
