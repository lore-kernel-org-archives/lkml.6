Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D51CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3156B214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpLflJIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3156B214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbeKVEvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:51:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38511 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbeKVEvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:51:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so5319619oii.5;
        Wed, 21 Nov 2018 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R9nfbY/ESfvzWeB9uFr/8JCTAmiNOUw29zPfPXua1+A=;
        b=gpLflJIbeDBMNe7jbOvalUQ5zDuAtRKRKOOeu28Pius2gBHSRlIaJZeTU2EBjc0JRJ
         uLHSNGxe2bk61VLmk0+zypSaOh6teqKHchLNc8JHn74RU20YFFhsnFsIKeMGoa8Haws0
         z0f11boyZdg0O9Z6vXCSQFuYsnc3bKdowYlvlKxVOme2BdSWV6Ha2ZuFm9c0ZErslPqy
         GNMmBNDElNgc4HXIJ/KefUm7S4vPsn6w94w+BIHmGYJwTZ/HHo87DAP91x/uIYvzByE8
         zLlUmKvtYcELJGXcasc1hWyAF5Xwy0GUuNs5pOaiCq2qQxlQBKqBgV187ZxtvzMxtSVj
         B79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R9nfbY/ESfvzWeB9uFr/8JCTAmiNOUw29zPfPXua1+A=;
        b=iUDuNCU7OLzxS25jkboNTQ79D0ziyhTFl6T1Cj30JDQaW9VOwg3g2vudar5RxG2YFn
         REOxR65G6spUgillKoXxn0z32wpIwdvFUdATWdiioYyRjsq6C8OijSuzFRy4ZF5BnBzz
         i7puRAMDLxf/EjyK3365ke9LlCewxXQMDtLP7+NPuclcOjPyIJ6kTxiheXjEMkETZkub
         XZEOcvNKjJwsGtm3O3e23/xgXE+H0nuMeuG+WGZythMwcW85f9LNZwvzsoHuJrQ7rSfN
         AFhyP3pfKebH/7XzPemNd34mbDXi2nDYovEjScKIynXx6ADxyJnXBkDvrckWAo0WVeS+
         uSwg==
X-Gm-Message-State: AGRZ1gLjFXWoFxhL98NX30CstRrhkqFfx0aBOK3ijlbF4Nv7L+R7z69r
        8YjaUHDRY14HcNcSxBwb7ub4OfZNszxgHMJ852h5qA==
X-Google-Smtp-Source: AJdET5ebKZZWpn/3AOeoMCciPTFryiWIERDyAXroFA2Drsqef2ckVG3Yl0gAY0OwDWVBomkfG3SdrdY78sPC31WZdKc=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr4054138oix.246.1542824134055;
 Wed, 21 Nov 2018 10:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20181109190327.23606-1-matwey@sai.msu.ru> <20181109190327.23606-3-matwey@sai.msu.ru>
In-Reply-To: <20181109190327.23606-3-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Wed, 21 Nov 2018 21:15:21 +0300
Message-ID: <CAJs94Eb6Ev5O+Q_THYruxozSW2sTjWCrHhU8wciFNgYx7oCRuQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 9 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 22:03, Matwey=
 V. Kornilov <matwey@sai.msu.ru>:
>
> DMA cocherency slows the transfer down on systems without hardware
> coherent DMA.
> Instead we use noncocherent DMA memory and explicit sync at data receive
> handler.
>
> Based on previous commit the following performance benchmarks have been
> carried out. Average memcpy() data transfer rate (rate) and handler
> completion time (time) have been measured when running video stream at
> 640x480 resolution at 10fps.
>
> x86_64 based system (Intel Core i5-3470). This platform has hardware
> coherent DMA support and proposed change doesn't make big difference here=
.
>
>  * kmalloc:            rate =3D (2.0 +- 0.4) GBps
>                        time =3D (5.0 +- 3.0) usec
>  * usb_alloc_coherent: rate =3D (3.4 +- 1.2) GBps
>                        time =3D (3.5 +- 3.0) usec
>
> We see that the measurements agree within error ranges in this case.
> So theoretically predicted performance downgrade cannot be reliably
> measured here.
>
> armv7l based system (TI AM335x BeagleBone Black @ 300MHz). This platform
> has no hardware coherent DMA support. DMA coherence is implemented via
> disabled page caching that slows down memcpy() due to memory controller
> behaviour.
>
>  * kmalloc:            rate =3D  ( 94 +- 4) MBps
>                        time =3D  (101 +- 4) usec
>  * usb_alloc_coherent: rate =3D (28.1 +- 0.1) MBps
>                        time =3D  (341 +- 2) usec
>
> Note, that quantative difference leads (this commit leads to 3.3 times
> acceleration) to qualitative behavior change in this case. As it was
> stated before, the video stream cannot be successfully received at AM335x
> platforms with MUSB based USB host controller due to performance issues
> [1].
>
> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

Ping

> ---
>  drivers/media/usb/pwc/pwc-if.c | 62 +++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-i=
f.c
> index 53c111bd5a22..a81fb319b339 100644
> --- a/drivers/media/usb/pwc/pwc-if.c
> +++ b/drivers/media/usb/pwc/pwc-if.c
> @@ -159,6 +159,32 @@ static const struct video_device pwc_template =3D {
>  /***********************************************************************=
****/
>  /* Private functions */
>
> +static void *pwc_alloc_urb_buffer(struct device *dev,
> +                                 size_t size, dma_addr_t *dma_handle)
> +{
> +       void *buffer =3D kmalloc(size, GFP_KERNEL);
> +
> +       if (!buffer)
> +               return NULL;
> +
> +       *dma_handle =3D dma_map_single(dev, buffer, size, DMA_FROM_DEVICE=
);
> +       if (dma_mapping_error(dev, *dma_handle)) {
> +               kfree(buffer);
> +               return NULL;
> +       }
> +
> +       return buffer;
> +}
> +
> +static void pwc_free_urb_buffer(struct device *dev,
> +                               size_t size,
> +                               void *buffer,
> +                               dma_addr_t dma_handle)
> +{
> +       dma_unmap_single(dev, dma_handle, size, DMA_FROM_DEVICE);
> +       kfree(buffer);
> +}
> +
>  static struct pwc_frame_buf *pwc_get_next_fill_buf(struct pwc_device *pd=
ev)
>  {
>         unsigned long flags =3D 0;
> @@ -306,6 +332,11 @@ static void pwc_isoc_handler(struct urb *urb)
>         /* Reset ISOC error counter. We did get here, after all. */
>         pdev->visoc_errors =3D 0;
>
> +       dma_sync_single_for_cpu(&urb->dev->dev,
> +                               urb->transfer_dma,
> +                               urb->transfer_buffer_length,
> +                               DMA_FROM_DEVICE);
> +
>         /* vsync: 0 =3D don't copy data
>                   1 =3D sync-hunt
>                   2 =3D synched
> @@ -352,6 +383,11 @@ static void pwc_isoc_handler(struct urb *urb)
>                 pdev->vlast_packet_size =3D flen;
>         }
>
> +       dma_sync_single_for_device(&urb->dev->dev,
> +                                  urb->transfer_dma,
> +                                  urb->transfer_buffer_length,
> +                                  DMA_FROM_DEVICE);
> +
>  handler_end:
>         trace_pwc_handler_exit(urb, pdev);
>
> @@ -428,16 +464,15 @@ static int pwc_isoc_init(struct pwc_device *pdev)
>                 urb->dev =3D udev;
>                 urb->pipe =3D usb_rcvisocpipe(udev, pdev->vendpoint);
>                 urb->transfer_flags =3D URB_ISO_ASAP | URB_NO_TRANSFER_DM=
A_MAP;
> -               urb->transfer_buffer =3D usb_alloc_coherent(udev,
> -                                                         ISO_BUFFER_SIZE=
,
> -                                                         GFP_KERNEL,
> -                                                         &urb->transfer_=
dma);
> +               urb->transfer_buffer_length =3D ISO_BUFFER_SIZE;
> +               urb->transfer_buffer =3D pwc_alloc_urb_buffer(&udev->dev,
> +                                                           urb->transfer=
_buffer_length,
> +                                                           &urb->transfe=
r_dma);
>                 if (urb->transfer_buffer =3D=3D NULL) {
>                         PWC_ERROR("Failed to allocate urb buffer %d\n", i=
);
>                         pwc_isoc_cleanup(pdev);
>                         return -ENOMEM;
>                 }
> -               urb->transfer_buffer_length =3D ISO_BUFFER_SIZE;
>                 urb->complete =3D pwc_isoc_handler;
>                 urb->context =3D pdev;
>                 urb->start_frame =3D 0;
> @@ -488,15 +523,16 @@ static void pwc_iso_free(struct pwc_device *pdev)
>
>         /* Freeing ISOC buffers one by one */
>         for (i =3D 0; i < MAX_ISO_BUFS; i++) {
> -               if (pdev->urbs[i]) {
> +               struct urb *urb =3D pdev->urbs[i];
> +
> +               if (urb) {
>                         PWC_DEBUG_MEMORY("Freeing URB\n");
> -                       if (pdev->urbs[i]->transfer_buffer) {
> -                               usb_free_coherent(pdev->udev,
> -                                       pdev->urbs[i]->transfer_buffer_le=
ngth,
> -                                       pdev->urbs[i]->transfer_buffer,
> -                                       pdev->urbs[i]->transfer_dma);
> -                       }
> -                       usb_free_urb(pdev->urbs[i]);
> +                       if (urb->transfer_buffer)
> +                               pwc_free_urb_buffer(&urb->dev->dev,
> +                                                   urb->transfer_buffer_=
length,
> +                                                   urb->transfer_buffer,
> +                                                   urb->transfer_dma);
> +                       usb_free_urb(urb);
>                         pdev->urbs[i] =3D NULL;
>                 }
>         }
> --
> 2.16.4
>


--=20
With best regards,
Matwey V. Kornilov
