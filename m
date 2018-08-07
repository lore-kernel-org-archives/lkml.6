Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D93C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECA121763
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGOIEoSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECA121763
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeHGMHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:07:47 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44812 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388099AbeHGMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:07:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so4695640ywc.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2600SaDnSCl2xBLDeQoYH/9Eo37GW/s+rvzp56iCP1U=;
        b=vGOIEoSBqz8tGkpF3ekm/70yhKMja1mx3WSBA52ZP9W/v+bKd+EicKiqN9vo6icrGf
         trvnRuJeMt1m1answr+w+0IRvwwhUBcu7t90Mg5kr2jLJWVrasCFFLLQxZzQDNCfD1aB
         L04tb8zEr1w3BDksb+B5h5LQ6bVYDDbomkar+/w1zV5Y6nmb9TnHW5RkGebFe8DNZ7Tj
         /QGjrVhoNOW8j5C24ed6712S8ih04wIs5gLgIAQWS7IksMns1Cj7ckEsRwBDrl0ifn+t
         NGyAKl4KwstKkIUwxaxl0onQcWpVyzSe9vx+H2k/1CH3dkQ8KsoSJ3gdrLgVMX64djGh
         Ya4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2600SaDnSCl2xBLDeQoYH/9Eo37GW/s+rvzp56iCP1U=;
        b=WPV2PbtFZbljJkYwDK1qv9F7HfsjnTt9jmzZLNAYrKInQdnT4LOBr4H7cWgEMqRYCz
         Nk6x4CUilOjckuS4rkI1/gwWSHAT4zM6hbYqz/QHRINvxONa6JP1hraPEQWQ356svFrY
         iv1VzOeUk18Gu/pRGuj/AQ6pv14K+fDFWD+AGA9tZaj0CWxD9SHC5C511M3dFbEo8a7C
         qYjm/UOLbsrE8EO5MqX6uflAhnMqn4wA6vvqlzNtA2QUGP/5ZvdJcByjIEBzY4SfDN3F
         lRisWroD3fEMKU8MmN1S2f7RYDc2ncliEl25aNlr7nIVMbLJ435PYSFEskJmwpWD0VfZ
         ekSA==
X-Gm-Message-State: AOUpUlGXUAKzWICUVqx4pLfc3NH9alNYzPoduapVtf1y9UxI5m+ywK8q
        oUYxphnqADv1RfyRv/3Dp1JNIA+K9MBOk9T8/mhlww==
X-Google-Smtp-Source: AAOMgpe0WcfTy8nBOEy9jszpeMiglxtfRJJSnyT40YVtdX52cnIsmtnhTea55xO8yPu0IzFC/1Qri4QZvOxbQdc47n4=
X-Received: by 2002:a0d:e7c1:: with SMTP id q184-v6mr9365951ywe.435.1533635654023;
 Tue, 07 Aug 2018 02:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.3cb9065dabdf5d455da508fb4109201e626d5ee7.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <cae511f90085701e7093ce39dc8dabf8fc16b844.1522168131.git-series.kieran.bingham@ideasonboard.com>
In-Reply-To: <cae511f90085701e7093ce39dc8dabf8fc16b844.1522168131.git-series.kieran.bingham@ideasonboard.com>
From:   Tomasz Figa <tfiga@google.com>
Date:   Tue, 7 Aug 2018 18:54:02 +0900
Message-ID: <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Move decode processing to process context
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        g.liakhovetski@gmx.de, olivier.braun@stereolabs.com,
        troy.kisky@boundarydevices.com,
        Randy Dunlap <rdunlap@infradead.org>, philipp.zabel@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Wed, Mar 28, 2018 at 1:47 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
[snip]
> @@ -1544,25 +1594,29 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
>   */
>  static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
>  {
> -       struct urb *urb;
> -       unsigned int i;
> +       struct uvc_urb *uvc_urb;
>
>         uvc_video_stats_stop(stream);
>
> -       for (i = 0; i < UVC_URBS; ++i) {
> -               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
> +       /*
> +        * We must poison the URBs rather than kill them to ensure that even
> +        * after the completion handler returns, any asynchronous workqueues
> +        * will be prevented from resubmitting the URBs
> +        */
> +       for_each_uvc_urb(uvc_urb, stream)
> +               usb_poison_urb(uvc_urb->urb);
>
> -               urb = uvc_urb->urb;
> -               if (urb == NULL)
> -                       continue;
> +       flush_workqueue(stream->async_wq);
>
> -               usb_kill_urb(urb);
> -               usb_free_urb(urb);
> +       for_each_uvc_urb(uvc_urb, stream) {
> +               usb_free_urb(uvc_urb->urb);
>                 uvc_urb->urb = NULL;
>         }
>
>         if (free_buffers)
>                 uvc_free_urb_buffers(stream);
> +
> +       destroy_workqueue(stream->async_wq);

In our testing, this function ends up being called twice, if before
suspend the camera is streaming and if the camera disconnects between
suspend and resume. This is because uvc_video_suspend() calls this
function (with free_buffers = 0), but uvc_video_resume() wouldn't call
uvc_init_video() due to an earlier failure and uvc_v4l2_release()
would end up calling this function again, while the workqueue is
already destroyed.

The following diff seems to take care of it:

8<~~~
diff --git a/drivers/media/usb/uvc/uvc_video.c
b/drivers/media/usb/uvc/uvc_video.c
index c5e0ab564b1a..6fb890c8ba67 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1493,10 +1493,11 @@ static void uvc_uninit_video(struct
uvc_streaming *stream, int free_buffers)
               uvc_urb->urb = NULL;
       }

-       if (free_buffers)
+       if (free_buffers) {
               uvc_free_urb_buffers(stream);
-
-       destroy_workqueue(stream->async_wq);
+               destroy_workqueue(stream->async_wq);
+               stream->async_wq = NULL;
+       }
}

/*
@@ -1648,10 +1649,12 @@ static int uvc_init_video(struct uvc_streaming
*stream, gfp_t gfp_flags)

       uvc_video_stats_start(stream);

-       stream->async_wq = alloc_workqueue("uvcvideo", WQ_UNBOUND | WQ_HIGHPRI,
-                       0);
-       if (!stream->async_wq)
-               return -ENOMEM;
+       if (!stream->async_wq) {
+               stream->async_wq = alloc_workqueue("uvcvideo",
+                                                  WQ_UNBOUND | WQ_HIGHPRI, 0);
+               if (!stream->async_wq)
+                       return -ENOMEM;
+       }

       if (intf->num_altsetting > 1) {
               struct usb_host_endpoint *best_ep = NULL;
~~~>8

Best regards,
Tomasz
