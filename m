Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F562206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYffC48+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F562206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeIKX7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:59:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41236 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeIKX7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:59:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so49275892oiw.8;
        Tue, 11 Sep 2018 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hUQn5vOmzGOHiAMb10EY1lQHRxc7vFgzMt51Bf/T/6o=;
        b=sYffC48+31POrwxD2EhwCsQMuZNvV1CbqTgwSyBmnJ4OmBY8mTUhXs3w9FH4OGmr5x
         Bj2a4i5QxnOg5GIyQZyq/p/kqCRrg/2byA51R69zaOyXmraR+92FAeCsly/Bcob0TZck
         PZMZHrqiMA2jFVsuyYaO/hqePQx9gqdKSvW1uqpKAdgVp3eD0xa9MeLZDlX0TVh4O9qm
         vS6UD/j7JOfuJnZEEUhzT7ZOawjxB/E45T7akXJCXdaV+QnOBAAvmOx1AZ9MrmF/C6e1
         NAT9zwZQcD9H+eq43OiXR7saZgtAS7Q33SfHDDgehzeeWrhtmn0AyJPfMwUVRaZ1kabm
         SyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hUQn5vOmzGOHiAMb10EY1lQHRxc7vFgzMt51Bf/T/6o=;
        b=QdDcePoZ+3GSh1y9Y9b/U47lGNgawjbQjcjNS3slXdeEeik+v6UTd8teyr1ag6n/7l
         sT9Cck9kwtnLkfTA0qyk9Xgrpg5f7zVtQTJpd2UabFSeXCDyQp/piw7Q0prPZwOtcElo
         bH8up0Dvd0l+RNlyab/VoJh+h4dfdCL6tMK0VMkB9n+gbcsZmuJAqdZ/LCLlhpfefaRF
         6cEWx7F2FTUcZLN/fXdLLMX+KjeMTWQHums8rfR5wfYjkhzXmElEo0+4CqXS/B9FODxq
         W8+FkWhThiyHOAZJZYi/ufh/b/pRe75ITZUWQe8ixEXt40h5nKxPl0lva15Fc1p0EuKe
         Qi/A==
X-Gm-Message-State: APzg51DDhFbjkH7H5g8RAOGeLajCwUXHElVTUHClxyT34ERe94dcwrZO
        aglQYXkdhshG3+NVOYEtj0NtYv6X/Uz8jgv5/+QOBA==
X-Google-Smtp-Source: ANB0VdaQFYf0UHAx7VDKnBRcZc0/alS3D2StefEquRhWwTBmdtL8HLG9iuPyvwt96Ogv/b/+riLIJhO1DpklRkBngug=
X-Received: by 2002:aca:56d1:: with SMTP id k200-v6mr30303236oib.319.1536692336322;
 Tue, 11 Sep 2018 11:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180821170629.18408-1-matwey@sai.msu.ru> <20180821170629.18408-3-matwey@sai.msu.ru>
 <CAJs94EZ5Qh8q3tEABmH89NjDkA=jjzsB63yctRGdEqcvJTnASA@mail.gmail.com>
In-Reply-To: <CAJs94EZ5Qh8q3tEABmH89NjDkA=jjzsB63yctRGdEqcvJTnASA@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Tue, 11 Sep 2018 21:58:43 +0300
Message-ID: <CAJs94EZBpUmRXnYRiSHJex+UdLX5tUfW-nxm1bWjy1oQW6vuFQ@mail.gmail.com>
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

=D0=B2=D1=82, 28 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 10:17, Matwey V. K=
ornilov <matwey.kornilov@gmail.com>:
>
> =D0=B2=D1=82, 21 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 20:06, Matwey V.=
 Kornilov <matwey@sai.msu.ru>:
> >
> > DMA cocherency slows the transfer down on systems without hardware
> > coherent DMA.
> > Instead we use noncocherent DMA memory and explicit sync at data receiv=
e
> > handler.
> >
> > Based on previous commit the following performance benchmarks have been
> > carried out. Average memcpy() data transfer rate (rate) and handler
> > completion time (time) have been measured when running video stream at
> > 640x480 resolution at 10fps.
> >
> > x86_64 based system (Intel Core i5-3470). This platform has hardware
> > coherent DMA support and proposed change doesn't make big difference he=
re.
> >
> >  * kmalloc:            rate =3D (2.0 +- 0.4) GBps
> >                        time =3D (5.0 +- 3.0) usec
> >  * usb_alloc_coherent: rate =3D (3.4 +- 1.2) GBps
> >                        time =3D (3.5 +- 3.0) usec
> >
> > We see that the measurements agree within error ranges in this case.
> > So theoretically predicted performance downgrade cannot be reliably
> > measured here.
> >
> > armv7l based system (TI AM335x BeagleBone Black @ 300MHz). This platfor=
m
> > has no hardware coherent DMA support. DMA coherence is implemented via
> > disabled page caching that slows down memcpy() due to memory controller
> > behaviour.
> >
> >  * kmalloc:            rate =3D  (114 +- 5) MBps
> >                        time =3D   (84 +- 4) usec
> >  * usb_alloc_coherent: rate =3D (28.1 +- 0.1) MBps
> >                        time =3D  (341 +- 2) usec
> >
> > Note, that quantative difference leads (this commit leads to 4 times
> > acceleration) to qualitative behavior change in this case. As it was
> > stated before, the video stream cannot be successfully received at AM33=
5x
> > platforms with MUSB based USB host controller due to performance issues
> > [1].
> >
> > [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> >
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>
> Ping
>

Ping

> > ---
> >  drivers/media/usb/pwc/pwc-if.c | 57 ++++++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 44 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc=
-if.c
> > index 72d2897a4b9f..1360722ab423 100644
> > --- a/drivers/media/usb/pwc/pwc-if.c
> > +++ b/drivers/media/usb/pwc/pwc-if.c
> > @@ -159,6 +159,32 @@ static const struct video_device pwc_template =3D =
{
> >  /*********************************************************************=
******/
> >  /* Private functions */
> >
> > +static void *pwc_alloc_urb_buffer(struct device *dev,
> > +                                 size_t size, dma_addr_t *dma_handle)
> > +{
> > +       void *buffer =3D kmalloc(size, GFP_KERNEL);
> > +
> > +       if (!buffer)
> > +               return NULL;
> > +
> > +       *dma_handle =3D dma_map_single(dev, buffer, size, DMA_FROM_DEVI=
CE);
> > +       if (dma_mapping_error(dev, *dma_handle)) {
> > +               kfree(buffer);
> > +               return NULL;
> > +       }
> > +
> > +       return buffer;
> > +}
> > +
> > +static void pwc_free_urb_buffer(struct device *dev,
> > +                               size_t size,
> > +                               void *buffer,
> > +                               dma_addr_t dma_handle)
> > +{
> > +       dma_unmap_single(dev, dma_handle, size, DMA_FROM_DEVICE);
> > +       kfree(buffer);
> > +}
> > +
> >  static struct pwc_frame_buf *pwc_get_next_fill_buf(struct pwc_device *=
pdev)
> >  {
> >         unsigned long flags =3D 0;
> > @@ -306,6 +332,11 @@ static void pwc_isoc_handler(struct urb *urb)
> >         /* Reset ISOC error counter. We did get here, after all. */
> >         pdev->visoc_errors =3D 0;
> >
> > +       dma_sync_single_for_cpu(&urb->dev->dev,
> > +                               urb->transfer_dma,
> > +                               urb->transfer_buffer_length,
> > +                               DMA_FROM_DEVICE);
> > +
> >         /* vsync: 0 =3D don't copy data
> >                   1 =3D sync-hunt
> >                   2 =3D synched
> > @@ -428,16 +459,15 @@ static int pwc_isoc_init(struct pwc_device *pdev)
> >                 urb->dev =3D udev;
> >                 urb->pipe =3D usb_rcvisocpipe(udev, pdev->vendpoint);
> >                 urb->transfer_flags =3D URB_ISO_ASAP | URB_NO_TRANSFER_=
DMA_MAP;
> > -               urb->transfer_buffer =3D usb_alloc_coherent(udev,
> > -                                                         ISO_BUFFER_SI=
ZE,
> > -                                                         GFP_KERNEL,
> > -                                                         &urb->transfe=
r_dma);
> > +               urb->transfer_buffer_length =3D ISO_BUFFER_SIZE;
> > +               urb->transfer_buffer =3D pwc_alloc_urb_buffer(&udev->de=
v,
> > +                                                           urb->transf=
er_buffer_length,
> > +                                                           &urb->trans=
fer_dma);
> >                 if (urb->transfer_buffer =3D=3D NULL) {
> >                         PWC_ERROR("Failed to allocate urb buffer %d\n",=
 i);
> >                         pwc_isoc_cleanup(pdev);
> >                         return -ENOMEM;
> >                 }
> > -               urb->transfer_buffer_length =3D ISO_BUFFER_SIZE;
> >                 urb->complete =3D pwc_isoc_handler;
> >                 urb->context =3D pdev;
> >                 urb->start_frame =3D 0;
> > @@ -488,15 +518,16 @@ static void pwc_iso_free(struct pwc_device *pdev)
> >
> >         /* Freeing ISOC buffers one by one */
> >         for (i =3D 0; i < MAX_ISO_BUFS; i++) {
> > -               if (pdev->urbs[i]) {
> > +               struct urb *urb =3D pdev->urbs[i];
> > +
> > +               if (urb) {
> >                         PWC_DEBUG_MEMORY("Freeing URB\n");
> > -                       if (pdev->urbs[i]->transfer_buffer) {
> > -                               usb_free_coherent(pdev->udev,
> > -                                       pdev->urbs[i]->transfer_buffer_=
length,
> > -                                       pdev->urbs[i]->transfer_buffer,
> > -                                       pdev->urbs[i]->transfer_dma);
> > -                       }
> > -                       usb_free_urb(pdev->urbs[i]);
> > +                       if (urb->transfer_buffer)
> > +                               pwc_free_urb_buffer(&urb->dev->dev,
> > +                                                   urb->transfer_buffe=
r_length,
> > +                                                   urb->transfer_buffe=
r,
> > +                                                   urb->transfer_dma);
> > +                       usb_free_urb(urb);
> >                         pdev->urbs[i] =3D NULL;
> >                 }
> >         }
> > --
> > 2.16.4
> >
>
>
> --
> With best regards,
> Matwey V. Kornilov



--=20
With best regards,
Matwey V. Kornilov
