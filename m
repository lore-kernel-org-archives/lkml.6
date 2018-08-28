Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35775C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8A620851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBtZl9s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8A620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeH1LHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:07:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43322 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeH1LHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:07:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so1031748oib.10;
        Tue, 28 Aug 2018 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+GHZTFLZ6Tkfhl02hD1WVUXKSC4bLHvPQnTaG6YUto=;
        b=tBtZl9s6gwj5U2lwsWegs1dApjlJ1ueAHVaZ/nnJGqA5+H/MnpVYysmSNiv5TD06C5
         VpLQr71DbxP4LSJZcm9xtIc1yH1etnUjA9xqVNdA3Dg3Iu0YBpAUfgQZ0NHzT9heyo/E
         VllGwkt+xvGA+0VxaFGUYVyR6pv0dJs7nrHj/Zn0s1XO03njKHlQ/e4E7bn2nvehL15S
         GPw7Et8w07Zo7KfGw1H0HfnVuvUHrCRQG8OS6ayrzeAyjxI9sGAvRj1F3Q7dCglZdbgs
         A+K3Av7y/dY5PkhysOUbqiYpSBtel+v0g7X9pKttqMH8HEGVUdRorSnC1wlBCi880ngH
         TNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+GHZTFLZ6Tkfhl02hD1WVUXKSC4bLHvPQnTaG6YUto=;
        b=k1tA1wsX/qziwVyihYYEOvqp98GO/Wy6f6UhAaYu+Wd9qrrdsxhAw5QfLISIvdnSN/
         0y4K1hVDpj1peJNfGQtk4MU/zaBnbVewrsBmVdaruvW9k7SLkuZ/e8+WQxcL/sagVoKg
         EvkkHksB0gD4JCUKg/elKnl/2LwBinpyamWB7R6nuURIvqYIuZZ/KTedIRfjpI5M2k6I
         9lgwzQPbyv4u2k5Hk/eHpto+gzGgXpByvSwjBaXB74wsVUqiSdhji9JgyJGBsKW5yYrX
         3QSV3LJLt+km2c99GhiTkUKDV6q8B6Z92Euu3GJcR1g23NKsmF+maUYhzxcqQlCvDffI
         PbgA==
X-Gm-Message-State: APzg51AFkkX/e4gLz6Vbpa6qZz/gdcQCv2440MEr52TCQIsFrkW7pyd0
        sYlb4PZPLzjEWClEpr7JItjvqSyDHt3o28aRBHOIuQ==
X-Google-Smtp-Source: ANB0VdZ8SNj3PXXYfdoVRp56fgtfsBUkKIhoESeiDroqobainrgxSR/z41pu9tpD7Gsk/Ef+e2cPtAexX3pzxa2O7wU=
X-Received: by 2002:aca:3f55:: with SMTP id m82-v6mr282938oia.237.1535440649209;
 Tue, 28 Aug 2018 00:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180821170629.18408-1-matwey@sai.msu.ru> <20180821170629.18408-3-matwey@sai.msu.ru>
In-Reply-To: <20180821170629.18408-3-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Tue, 28 Aug 2018 10:17:16 +0300
Message-ID: <CAJs94EZ5Qh8q3tEABmH89NjDkA=jjzsB63yctRGdEqcvJTnASA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] media: usb: pwc: Don't use coherent DMA buffers
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

=D0=B2=D1=82, 21 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 20:06, Matwey V. K=
ornilov <matwey@sai.msu.ru>:
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
>  * kmalloc:            rate =3D  (114 +- 5) MBps
>                        time =3D   (84 +- 4) usec
>  * usb_alloc_coherent: rate =3D (28.1 +- 0.1) MBps
>                        time =3D  (341 +- 2) usec
>
> Note, that quantative difference leads (this commit leads to 4 times
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
>  drivers/media/usb/pwc/pwc-if.c | 57 ++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-i=
f.c
> index 72d2897a4b9f..1360722ab423 100644
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
> @@ -428,16 +459,15 @@ static int pwc_isoc_init(struct pwc_device *pdev)
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
> @@ -488,15 +518,16 @@ static void pwc_iso_free(struct pwc_device *pdev)
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


--
With best regards,
Matwey V. Kornilov
